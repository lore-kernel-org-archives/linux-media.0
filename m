Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3CFC43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA7120675
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfDZTwk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:52:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40748 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDZTwj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 15:52:39 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:9080:61b7:f4a4:2020:fc95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8F6EC2725B1;
        Fri, 26 Apr 2019 20:52:34 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 12/14] media: vimc: sca: Add support for multiplanar formats
Date:   Fri, 26 Apr 2019 16:51:12 -0300
Message-Id: <20190426195114.5002-13-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426195114.5002-1-andrealmeid@collabora.com>
References: <20190426195114.5002-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Change the scaling functions in order to scale planes. This change makes
easier to support multiplanar pixel formats.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes in v5:
- Remove bpp from vimc_sca_device
- Changes where bpp var is declared at `vimc_sca_scale_pix`

Changes in v4:
- Rename `frame_size` to `plane_size`
- Correct `unsigned int ret` to `int ret`
- Remove label `free_planes` from else scope
- Change type of `width` and `heigth` to `unsigned int`
- Rename and move var declarations on `vimc_sca_fill_src_frame`
- Change `comp_planes` to `mem_planes` 
- Remove `v4l2_format_info()` unnecessary call

Change in v3:
- Adapt to new vimc_frame

Changes in v2:
- Move the TODO comment to vimc-capture
- Reuse and share the code to free the memory of planes with a goto
- Fix comment block style 
 drivers/media/platform/vimc/vimc-scaler.c | 113 +++++++++++++---------
 1 file changed, 69 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-scaler.c b/drivers/media/platform/vimc/vimc-scaler.c
index f655b8312dc9..71b16ad80bc8 100644
--- a/drivers/media/platform/vimc/vimc-scaler.c
+++ b/drivers/media/platform/vimc/vimc-scaler.c
@@ -39,6 +39,9 @@ static const u32 vimc_sca_supported_pixfmt[] = {
 	V4L2_PIX_FMT_BGR24,
 	V4L2_PIX_FMT_RGB24,
 	V4L2_PIX_FMT_ARGB32,
+	V4L2_PIX_FMT_YUV420,
+	V4L2_PIX_FMT_YUV420M,
+	V4L2_PIX_FMT_NV12M,
 };
 
 struct vimc_sca_device {
@@ -51,8 +54,7 @@ struct vimc_sca_device {
 	struct v4l2_mbus_framefmt sink_fmt;
 	/* Values calculated when the stream starts */
 	struct vimc_frame src_frame;
-	unsigned int src_line_size;
-	unsigned int bpp;
+	unsigned int src_line_size[TPG_MAX_PLANES];
 };
 
 static const struct v4l2_mbus_framefmt sink_fmt_default = {
@@ -207,11 +209,12 @@ static const struct v4l2_subdev_pad_ops vimc_sca_pad_ops = {
 static int vimc_sca_s_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct vimc_sca_device *vsca = v4l2_get_subdevdata(sd);
+	unsigned int i;
+	int ret = 0;
 
 	if (enable) {
 		u32 pixelformat = vsca->ved.stream->producer_pixfmt;
-		const struct v4l2_format_info *pix_info;
-		unsigned int frame_size;
+		unsigned int plane_size;
 
 		if (!vimc_sca_is_pixfmt_supported(pixelformat)) {
 			dev_err(vsca->dev, "pixfmt (0x%08x) is not supported\n",
@@ -219,34 +222,44 @@ static int vimc_sca_s_stream(struct v4l2_subdev *sd, int enable)
 			return -EINVAL;
 		}
 
-		/* Save the bytes per pixel of the sink */
-		pix_info = v4l2_format_info(pixelformat);
-		vsca->bpp = pix_info->bpp[0];
-
-		/* Calculate the width in bytes of the src frame */
-		vsca->src_line_size = vsca->sink_fmt.width *
-				      sca_mult * vsca->bpp;
-
-		/* Calculate the frame size of the source pad */
-		frame_size = vsca->src_line_size * vsca->sink_fmt.height *
-			     sca_mult;
+		vimc_fill_frame(&vsca->src_frame, pixelformat,
+				vsca->sink_fmt.width, vsca->sink_fmt.height);
+
+		for (i = 0; i < vsca->src_frame.fmt.num_planes; i++) {
+			/* Calculate the width in bytes of the src frame */
+			vsca->src_line_size[i] =
+				vsca->src_frame.fmt.plane_fmt[i].bytesperline *
+				sca_mult;
+
+			/* Calculate the size of the nth-plane of source pad */
+			plane_size = vsca->src_frame.fmt.plane_fmt[i].sizeimage
+				* sca_mult * sca_mult;
+
+			/**
+			 * Allocate the frame buffer. Use vmalloc to be able to
+			 * allocate a large amount of memory
+			 */
+			vsca->src_frame.plane_addr[i] = vmalloc(plane_size);
+			if (!vsca->src_frame.plane_addr[i]) {
+				ret = -ENOMEM;
+				goto free_planes;
+			}
+			vsca->src_frame.fmt.plane_fmt[i].sizeimage = plane_size;
+		}
 
-		/* Allocate the frame buffer. Use vmalloc to be able to
-		 * allocate a large amount of memory
-		 */
-		vsca->src_frame.plane_addr[0] = vmalloc(frame_size);
-		if (!vsca->src_frame.plane_addr[0])
-			return -ENOMEM;
+		return 0;
+	}
 
-	} else {
-		if (!vsca->src_frame.plane_addr[0])
-			return 0;
+	if (!vsca->src_frame.plane_addr[0])
+		return 0;
 
-		vfree(vsca->src_frame.plane_addr[0]);
-		vsca->src_frame.plane_addr[0] = NULL;
+free_planes:
+	for (i = 0; i < vsca->src_frame.fmt.num_planes; i++) {
+		vfree(vsca->src_frame.plane_addr[i]);
+		vsca->src_frame.plane_addr[i] = NULL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static const struct v4l2_subdev_video_ops vimc_sca_video_ops = {
@@ -269,18 +282,19 @@ static void vimc_sca_fill_pix(u8 *const ptr,
 		ptr[i] = pixel[i];
 }
 
+/* TODO: parallelize this function */
 static void vimc_sca_scale_pix(const struct vimc_sca_device *const vsca,
 			       const unsigned int lin, const unsigned int col,
-			       const u8 *const sink_frame)
+			       const struct vimc_frame *sink_frame,
+			       unsigned int num_plane, unsigned int width)
+
 {
-	unsigned int i, j, index;
+	unsigned int i, j, index, bpp = sink_frame->fmt_info->bpp[num_plane];
 	const u8 *pixel;
 
 	/* Point to the pixel value in position (lin, col) in the sink frame */
-	index = VIMC_FRAME_INDEX(lin, col,
-				 vsca->sink_fmt.width,
-				 vsca->bpp);
-	pixel = &sink_frame[index];
+	index = VIMC_FRAME_INDEX(lin, col, width, bpp);
+	pixel = &sink_frame->plane_addr[num_plane][index];
 
 	dev_dbg(vsca->dev,
 		"sca: %s: --- scale_pix sink pos %dx%d, index %d ---\n",
@@ -290,7 +304,7 @@ static void vimc_sca_scale_pix(const struct vimc_sca_device *const vsca,
 	 * in the scaled src frame
 	 */
 	index = VIMC_FRAME_INDEX(lin * sca_mult, col * sca_mult,
-				 vsca->sink_fmt.width * sca_mult, vsca->bpp);
+				 width * sca_mult, bpp);
 
 	dev_dbg(vsca->dev, "sca: %s: scale_pix src pos %dx%d, index %d\n",
 		vsca->sd.name, lin * sca_mult, col * sca_mult, index);
@@ -300,32 +314,43 @@ static void vimc_sca_scale_pix(const struct vimc_sca_device *const vsca,
 		/* Iterate through each beginning of a
 		 * pixel repetition in a line
 		 */
-		for (j = 0; j < sca_mult * vsca->bpp; j += vsca->bpp) {
+		for (j = 0; j < sca_mult * bpp; j += bpp) {
 			dev_dbg(vsca->dev,
 				"sca: %s: sca: scale_pix src pos %d\n",
 				vsca->sd.name, index + j);
 
 			/* copy the pixel to the position index + j */
 			vimc_sca_fill_pix(
-				&vsca->src_frame.plane_addr[0][index + j],
-				pixel, vsca->bpp);
+				&vsca->src_frame.plane_addr[num_plane][index+j],
+				pixel, bpp);
 		}
 
 		/* move the index to the next line */
-		index += vsca->src_line_size;
+		index += vsca->src_line_size[num_plane];
 	}
 }
 
 static void vimc_sca_fill_src_frame(const struct vimc_sca_device *const vsca,
-				    const u8 *const sink_frame)
+				    const struct vimc_frame *sink_frame)
 {
-	unsigned int i, j;
+	unsigned int i, j, num_plane;
+	const struct v4l2_format_info *info;
+
+	info = sink_frame->fmt_info;
 
 	/* Scale each pixel from the original sink frame */
 	/* TODO: implement scale down, only scale up is supported for now */
-	for (i = 0; i < vsca->sink_fmt.height; i++)
-		for (j = 0; j < vsca->sink_fmt.width; j++)
-			vimc_sca_scale_pix(vsca, i, j, sink_frame);
+	for (num_plane = 0; num_plane < info->mem_planes; num_plane++) {
+		unsigned int plane_width = vsca->sink_fmt.width /
+					((num_plane == 0) ? 1 : info->vdiv);
+		unsigned int plane_height = vsca->sink_fmt.height /
+					((num_plane == 0) ? 1 : info->hdiv);
+
+		for (i = 0; i < plane_height; i++)
+			for (j = 0; j < plane_width; j++)
+				vimc_sca_scale_pix(vsca, i, j, sink_frame,
+						     num_plane, plane_width);
+	}
 }
 
 static struct vimc_frame *vimc_sca_process_frame(struct vimc_ent_device *ved,
@@ -338,7 +363,7 @@ static struct vimc_frame *vimc_sca_process_frame(struct vimc_ent_device *ved,
 	if (!ved->stream)
 		return ERR_PTR(-EINVAL);
 
-	vimc_sca_fill_src_frame(vsca, sink_frame->plane_addr[0]);
+	vimc_sca_fill_src_frame(vsca, sink_frame);
 
 	return &vsca->src_frame;
 };
-- 
2.21.0

