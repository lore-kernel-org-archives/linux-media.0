Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C2AC43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4063C206A3
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfDZBYn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:24:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36654 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDZBYn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 21:24:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 1C1092843B6
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v4 10/14] media: vimc: Add and use new struct vimc_frame
Date:   Thu, 25 Apr 2019 22:22:19 -0300
Message-Id: <20190426012223.17826-11-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426012223.17826-1-andrealmeid@collabora.com>
References: <20190426012223.17826-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Struct vimc_frame is intended to hold metadata about a frame,
such as memory address of a plane, number of planes and size
of each plane, to better integrated with the multiplanar operations.
The struct can be also used with singleplanar formats, making the
implementation of frame manipulation generic for both type of
formats.

vimc_fill_frame function fills a vimc_frame structure given a
pixelformat, height and width. This is done once to avoid recalculations
and provide enough information to subdevices work with
the frame.

Change the return and argument type of process_frame from void* to
vimc_frame*. Change the frame in subdevices structs from u8* to vimc_frame.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes in v4: 
- Remove unused parameter `bool multiplanar`

Changes in v3:
- Refactor vimc_frame struct, now it have fewer fields with the same
content
- Refactor vimc_fill_frame to be more simple

Change in v2:
- Fix alignment issues

 drivers/media/platform/vimc/vimc-capture.c  |  6 +--
 drivers/media/platform/vimc/vimc-common.c   |  8 ++++
 drivers/media/platform/vimc/vimc-common.h   | 41 +++++++++++++++++++--
 drivers/media/platform/vimc/vimc-debayer.c  | 33 +++++++++--------
 drivers/media/platform/vimc/vimc-scaler.c   | 25 +++++++------
 drivers/media/platform/vimc/vimc-sensor.c   | 18 ++++-----
 drivers/media/platform/vimc/vimc-streamer.c |  2 +-
 7 files changed, 89 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index 0439a5a008e8..d9dae5b3a0bf 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -517,8 +517,8 @@ static void vimc_cap_comp_unbind(struct device *comp, struct device *master,
 	video_unregister_device(&vcap->vdev);
 }
 
-static void *vimc_cap_process_frame(struct vimc_ent_device *ved,
-				    const void *frame)
+static struct vimc_frame *vimc_cap_process_frame(struct vimc_ent_device *ved,
+						 const struct vimc_frame *frame)
 {
 	struct vimc_cap_device *vcap = container_of(ved, struct vimc_cap_device,
 						    ved);
@@ -547,7 +547,7 @@ static void *vimc_cap_process_frame(struct vimc_ent_device *ved,
 
 	vbuf = vb2_plane_vaddr(&vimc_buf->vb2.vb2_buf, 0);
 
-	memcpy(vbuf, frame, vcap->format.fmt.pix.sizeimage);
+	memcpy(vbuf, frame->plane_addr[0], vcap->format.fmt.pix.sizeimage);
 
 	/* Set it as ready */
 	vb2_set_plane_payload(&vimc_buf->vb2.vb2_buf, 0,
diff --git a/drivers/media/platform/vimc/vimc-common.c b/drivers/media/platform/vimc/vimc-common.c
index fad7c7c6de93..9bd163ae326c 100644
--- a/drivers/media/platform/vimc/vimc-common.c
+++ b/drivers/media/platform/vimc/vimc-common.c
@@ -380,6 +380,14 @@ int vimc_ent_sd_register(struct vimc_ent_device *ved,
 }
 EXPORT_SYMBOL_GPL(vimc_ent_sd_register);
 
+void vimc_fill_frame(struct vimc_frame *frame, u32 pixelformat, u32 width,
+		     u32 height)
+{
+	frame->fmt_info = v4l2_format_info(pixelformat);
+	v4l2_fill_pixfmt_mp(&frame->fmt, pixelformat, width, height);
+}
+EXPORT_SYMBOL_GPL(vimc_fill_frame);
+
 void vimc_ent_sd_unregister(struct vimc_ent_device *ved, struct v4l2_subdev *sd)
 {
 	media_entity_cleanup(ved->ent);
diff --git a/drivers/media/platform/vimc/vimc-common.h b/drivers/media/platform/vimc/vimc-common.h
index 142ddfa69b3d..ab5eccc95af4 100644
--- a/drivers/media/platform/vimc/vimc-common.h
+++ b/drivers/media/platform/vimc/vimc-common.h
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <media/media-device.h>
 #include <media/v4l2-device.h>
+#include <media/tpg/v4l2-tpg.h>
 
 #include "vimc-streamer.h"
 
@@ -79,6 +80,25 @@ struct vimc_platform_data {
 	char entity_name[32];
 };
 
+/**
+ * struct vimc_frame - metadata about frame components
+ *
+ * @plane_addr:		pointer to kernel address of the plane
+ * @fmt:		pixel format attributes
+ * @fmt_info:		pointer to a struct with pixel format metadata
+ *
+ * This struct helps subdevices to get information about the frame on
+ * multiplanar formats. If a singleplanar format is used, only the first
+ * index of the array is used and num_planes is set to 1, so the
+ * implementation is generic and the code will work for both formats.
+ */
+
+struct vimc_frame {
+	u8 *plane_addr[TPG_MAX_PLANES];
+	struct v4l2_pix_format_mplane fmt;
+	const struct v4l2_format_info *fmt_info;
+};
+
 /**
  * struct vimc_ent_device - core struct that represents a node in the topology
  *
@@ -101,10 +121,10 @@ struct vimc_ent_device {
 	struct media_entity *ent;
 	struct media_pad *pads;
 	struct vimc_stream *stream;
-	void * (*process_frame)(struct vimc_ent_device *ved,
-				const void *frame);
+	struct vimc_frame * (*process_frame)(struct vimc_ent_device *ved,
+				const struct vimc_frame *frame);
 	void (*vdev_get_format)(struct vimc_ent_device *ved,
-			      struct v4l2_pix_format *fmt);
+				struct v4l2_pix_format *fmt);
 };
 
 /**
@@ -206,4 +226,19 @@ void vimc_ent_sd_unregister(struct vimc_ent_device *ved,
  */
 int vimc_link_validate(struct media_link *link);
 
+/**
+ * vimc_fill_frame - fills struct vimc_frame
+ *
+ * @frame: pointer to the frame to be filled
+ * @pixelformat: pixelformat fourcc code
+ * @width: width of the image
+ * @height: height of the image
+ *
+ * This function fills the fields of vimc_frame in order to subdevs have
+ * information about the frame being processed, works both for single
+ * and multiplanar pixel formats.
+ */
+void vimc_fill_frame(struct vimc_frame *frame, u32 pixelformat, u32 width,
+		     u32 height);
+
 #endif
diff --git a/drivers/media/platform/vimc/vimc-debayer.c b/drivers/media/platform/vimc/vimc-debayer.c
index b221f26e01cf..df7b39850632 100644
--- a/drivers/media/platform/vimc/vimc-debayer.c
+++ b/drivers/media/platform/vimc/vimc-debayer.c
@@ -62,7 +62,7 @@ struct vimc_deb_device {
 	void (*set_rgb_src)(struct vimc_deb_device *vdeb, unsigned int lin,
 			    unsigned int col, unsigned int rgb[3]);
 	/* Values calculated when the stream starts */
-	u8 *src_frame;
+	struct vimc_frame src_frame;
 	const struct vimc_deb_pix_map *sink_pix_map;
 	unsigned int sink_bpp;
 };
@@ -325,7 +325,7 @@ static void vimc_deb_set_rgb_pix_rgb24(struct vimc_deb_device *vdeb,
 
 	index = VIMC_FRAME_INDEX(lin, col, vdeb->sink_fmt.width, 3);
 	for (i = 0; i < 3; i++)
-		vdeb->src_frame[index + i] = rgb[i];
+		vdeb->src_frame.plane_addr[0][index + i] = rgb[i];
 }
 
 static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
@@ -335,7 +335,6 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
 	if (enable) {
 		u32 src_pixelformat = vdeb->ved.stream->producer_pixfmt;
 		const struct v4l2_format_info *pix_info;
-		unsigned int frame_size;
 
 		/* We only support translating bayer to RGB24 */
 		if (src_pixelformat != V4L2_PIX_FMT_RGB24) {
@@ -354,9 +353,8 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
 			vdeb->sink_pix_map->pixelformat;
 
 		/* Calculate frame_size of the source */
-		pix_info = v4l2_format_info(src_pixelformat);
-		frame_size = vdeb->sink_fmt.width * vdeb->sink_fmt.height *
-			     pix_info->bpp[0];
+		vimc_fill_frame(&vdeb->src_frame, src_pixelformat,
+				vdeb->sink_fmt.width, vdeb->sink_fmt.height);
 
 		/* Get bpp from the sink */
 		pix_info = v4l2_format_info(vdeb->sink_pix_map->pixelformat);
@@ -366,16 +364,18 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
 		 * Allocate the frame buffer. Use vmalloc to be able to
 		 * allocate a large amount of memory
 		 */
-		vdeb->src_frame = vmalloc(frame_size);
-		if (!vdeb->src_frame)
+		vdeb->src_frame.plane_addr[0] =
+			vmalloc(vdeb->src_frame.fmt.plane_fmt[0].sizeimage);
+		if (!vdeb->src_frame.plane_addr[0])
 			return -ENOMEM;
 
+
 	} else {
-		if (!vdeb->src_frame)
+		if (!vdeb->src_frame.plane_addr[0])
 			return 0;
 
-		vfree(vdeb->src_frame);
-		vdeb->src_frame = NULL;
+		vfree(vdeb->src_frame.plane_addr[0]);
+		vdeb->src_frame.plane_addr[0] = NULL;
 	}
 
 	return 0;
@@ -487,8 +487,8 @@ static void vimc_deb_calc_rgb_sink(struct vimc_deb_device *vdeb,
 	}
 }
 
-static void *vimc_deb_process_frame(struct vimc_ent_device *ved,
-				    const void *sink_frame)
+static struct vimc_frame *vimc_deb_process_frame(struct vimc_ent_device *ved,
+					const struct vimc_frame *sink_frame)
 {
 	struct vimc_deb_device *vdeb = container_of(ved, struct vimc_deb_device,
 						    ved);
@@ -496,16 +496,17 @@ static void *vimc_deb_process_frame(struct vimc_ent_device *ved,
 	unsigned int i, j;
 
 	/* If the stream in this node is not active, just return */
-	if (!vdeb->src_frame)
+	if (!vdeb->src_frame.plane_addr[0])
 		return ERR_PTR(-EINVAL);
 
 	for (i = 0; i < vdeb->sink_fmt.height; i++)
 		for (j = 0; j < vdeb->sink_fmt.width; j++) {
-			vimc_deb_calc_rgb_sink(vdeb, sink_frame, i, j, rgb);
+			vimc_deb_calc_rgb_sink(vdeb, sink_frame->plane_addr[0],
+					       i, j, rgb);
 			vdeb->set_rgb_src(vdeb, i, j, rgb);
 		}
 
-	return vdeb->src_frame;
+	return &vdeb->src_frame;
 
 }
 
diff --git a/drivers/media/platform/vimc/vimc-scaler.c b/drivers/media/platform/vimc/vimc-scaler.c
index 617f2920b86b..f655b8312dc9 100644
--- a/drivers/media/platform/vimc/vimc-scaler.c
+++ b/drivers/media/platform/vimc/vimc-scaler.c
@@ -50,7 +50,7 @@ struct vimc_sca_device {
 	 */
 	struct v4l2_mbus_framefmt sink_fmt;
 	/* Values calculated when the stream starts */
-	u8 *src_frame;
+	struct vimc_frame src_frame;
 	unsigned int src_line_size;
 	unsigned int bpp;
 };
@@ -234,16 +234,16 @@ static int vimc_sca_s_stream(struct v4l2_subdev *sd, int enable)
 		/* Allocate the frame buffer. Use vmalloc to be able to
 		 * allocate a large amount of memory
 		 */
-		vsca->src_frame = vmalloc(frame_size);
-		if (!vsca->src_frame)
+		vsca->src_frame.plane_addr[0] = vmalloc(frame_size);
+		if (!vsca->src_frame.plane_addr[0])
 			return -ENOMEM;
 
 	} else {
-		if (!vsca->src_frame)
+		if (!vsca->src_frame.plane_addr[0])
 			return 0;
 
-		vfree(vsca->src_frame);
-		vsca->src_frame = NULL;
+		vfree(vsca->src_frame.plane_addr[0]);
+		vsca->src_frame.plane_addr[0] = NULL;
 	}
 
 	return 0;
@@ -306,8 +306,9 @@ static void vimc_sca_scale_pix(const struct vimc_sca_device *const vsca,
 				vsca->sd.name, index + j);
 
 			/* copy the pixel to the position index + j */
-			vimc_sca_fill_pix(&vsca->src_frame[index + j],
-					  pixel, vsca->bpp);
+			vimc_sca_fill_pix(
+				&vsca->src_frame.plane_addr[0][index + j],
+				pixel, vsca->bpp);
 		}
 
 		/* move the index to the next line */
@@ -327,8 +328,8 @@ static void vimc_sca_fill_src_frame(const struct vimc_sca_device *const vsca,
 			vimc_sca_scale_pix(vsca, i, j, sink_frame);
 }
 
-static void *vimc_sca_process_frame(struct vimc_ent_device *ved,
-				    const void *sink_frame)
+static struct vimc_frame *vimc_sca_process_frame(struct vimc_ent_device *ved,
+				    const struct vimc_frame *sink_frame)
 {
 	struct vimc_sca_device *vsca = container_of(ved, struct vimc_sca_device,
 						    ved);
@@ -337,9 +338,9 @@ static void *vimc_sca_process_frame(struct vimc_ent_device *ved,
 	if (!ved->stream)
 		return ERR_PTR(-EINVAL);
 
-	vimc_sca_fill_src_frame(vsca, sink_frame);
+	vimc_sca_fill_src_frame(vsca, sink_frame->plane_addr[0]);
 
-	return vsca->src_frame;
+	return &vsca->src_frame;
 };
 
 static void vimc_sca_release(struct v4l2_subdev *sd)
diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
index 1b2b75b27952..3495a3f3dd60 100644
--- a/drivers/media/platform/vimc/vimc-sensor.c
+++ b/drivers/media/platform/vimc/vimc-sensor.c
@@ -36,7 +36,7 @@ struct vimc_sen_device {
 	struct device *dev;
 	struct tpg_data tpg;
 	struct task_struct *kthread_sen;
-	u8 *frame;
+	struct vimc_frame frame;
 	/* The active format */
 	struct v4l2_mbus_framefmt mbus_format;
 	struct v4l2_ctrl_handler hdl;
@@ -177,14 +177,14 @@ static const struct v4l2_subdev_pad_ops vimc_sen_pad_ops = {
 	.set_fmt		= vimc_sen_set_fmt,
 };
 
-static void *vimc_sen_process_frame(struct vimc_ent_device *ved,
-				    const void *sink_frame)
+static struct vimc_frame *vimc_sen_process_frame(struct vimc_ent_device *ved,
+				    const struct vimc_frame *sink_frame)
 {
 	struct vimc_sen_device *vsen = container_of(ved, struct vimc_sen_device,
 						    ved);
 
-	tpg_fill_plane_buffer(&vsen->tpg, 0, 0, vsen->frame);
-	return vsen->frame;
+	tpg_fill_plane_buffer(&vsen->tpg, 0, 0, vsen->frame.plane_addr[0]);
+	return &vsen->frame;
 }
 
 static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
@@ -206,8 +206,8 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
 		 * Allocate the frame buffer. Use vmalloc to be able to
 		 * allocate a large amount of memory
 		 */
-		vsen->frame = vmalloc(frame_size);
-		if (!vsen->frame)
+		vsen->frame.plane_addr[0] = vmalloc(frame_size);
+		if (!vsen->frame.plane_addr[0])
 			return -ENOMEM;
 
 		/* configure the test pattern generator */
@@ -215,8 +215,8 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
 
 	} else {
 
-		vfree(vsen->frame);
-		vsen->frame = NULL;
+		vfree(vsen->frame.plane_addr[0]);
+		vsen->frame.plane_addr[0] = NULL;
 		return 0;
 	}
 
diff --git a/drivers/media/platform/vimc/vimc-streamer.c b/drivers/media/platform/vimc/vimc-streamer.c
index 26b674259489..216ac8a83ba5 100644
--- a/drivers/media/platform/vimc/vimc-streamer.c
+++ b/drivers/media/platform/vimc/vimc-streamer.c
@@ -125,7 +125,7 @@ static int vimc_streamer_pipeline_init(struct vimc_stream *stream,
 static int vimc_streamer_thread(void *data)
 {
 	struct vimc_stream *stream = data;
-	u8 *frame = NULL;
+	struct vimc_frame *frame = NULL;
 	int i;
 
 	set_freezable();
-- 
2.21.0

