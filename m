Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407E3C10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7C621900
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfDXN7N (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:59:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57114 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfDXN7N (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 09:59:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 36CF4282C1B
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 14/14] media: vimc: Create multiplanar parameter and ioctls
Date:   Wed, 24 Apr 2019 10:56:42 -0300
Message-Id: <20190424135642.31973-15-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424135642.31973-1-andrealmeid@collabora.com>
References: <20190424135642.31973-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Create multiplanar kernel module parameter to define if the driver is
running in single planar or in multiplanar mode. Define the device
capabilities and format ioctls according to the multiplanar kernel
parameter. A device can't support both CAP_VIDEO_CAPTURE and
CAP_VIDEO_CAPTURE_MPLANAR at the same time. Add functions to handle
multiplanar format ioctls, calling the generic format ioctls functions
when possible.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Change in v3:
- Squash commit with "Add handler for multiplanar fmt ioctls" 
- Remove functions that only did the `IS_MULTIPLANAR(vcap)` check
- Assign ioctls according to device capabilities

Changes in v2:
- Squash commits to create multiplanar module parameter and to define
the device capabilities
- Move the creation of the multiplanar parameter to the end of
history, so it's only added when all required changes are applied

 drivers/media/platform/vimc/vimc-capture.c | 78 +++++++++++++++++++---
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index 2592ea982ff8..27caf14ddf43 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -28,6 +28,10 @@
 
 #define VIMC_CAP_DRV_NAME "vimc-capture"
 
+static unsigned int multiplanar;
+module_param(multiplanar, uint, 0000);
+MODULE_PARM_DESC(multiplanar, "0 (default) creates a single planar device, 1 creates a multiplanar device.");
+
 /* Checks if the device supports multiplanar capture */
 #define IS_MULTIPLANAR(vcap) \
 	(vcap->vdev.device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE)
@@ -144,6 +148,10 @@ static void vimc_cap_get_format(struct vimc_ent_device *ved,
 	*fmt = vcap->format.fmt.pix;
 }
 
+/*
+ * Functions to handle both single- and multi-planar VIDIOC FMT
+ */
+
 static int vimc_cap_g_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
@@ -247,6 +255,41 @@ static int vimc_cap_s_fmt_vid_cap_sp(struct file *file, void *priv,
 	return 0;
 }
 
+/*
+ * VIDIOC handlers for multi-planar formats
+ */
+static int vimc_cap_s_fmt_vid_cap_mp(struct file *file, void *priv,
+				     struct v4l2_format *f)
+{
+	struct vimc_cap_device *vcap = video_drvdata(file);
+
+	/* Do not change the format while stream is on */
+	if (vb2_is_busy(&vcap->queue))
+		return -EBUSY;
+
+	vimc_cap_try_fmt_vid_cap_mp(file, priv, f);
+
+	dev_dbg(vcap->dev, "%s: format update: "
+		"old:%dx%d (0x%x, %d, %d, %d, %d) "
+		"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vcap->vdev.name,
+		/* old */
+		vcap->format.fmt.pix_mp.width, vcap->format.fmt.pix_mp.height,
+		vcap->format.fmt.pix_mp.pixelformat,
+		vcap->format.fmt.pix_mp.colorspace,
+		vcap->format.fmt.pix_mp.quantization,
+		vcap->format.fmt.pix_mp.xfer_func,
+		vcap->format.fmt.pix_mp.ycbcr_enc,
+		/* new */
+		f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.colorspace,
+		f->fmt.pix_mp.quantization, f->fmt.pix_mp.xfer_func,
+		f->fmt.pix_mp.ycbcr_enc);
+
+	vcap->format = *f;
+
+	return 0;
+}
+
 static bool vimc_cap_is_pixfmt_supported(u32 pixelformat)
 {
 	unsigned int i;
@@ -257,6 +300,7 @@ static bool vimc_cap_is_pixfmt_supported(u32 pixelformat)
 	return false;
 }
 
+
 static int vimc_cap_enum_framesizes(struct file *file, void *fh,
 				    struct v4l2_frmsizeenum *fsize)
 {
@@ -287,13 +331,9 @@ static const struct v4l2_file_operations vimc_cap_fops = {
 	.mmap           = vb2_fop_mmap,
 };
 
-static const struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
+static struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
 	.vidioc_querycap = vimc_cap_querycap,
 
-	.vidioc_g_fmt_vid_cap = vimc_cap_g_fmt_vid_cap,
-	.vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap_sp,
-	.vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap_sp,
-	.vidioc_enum_fmt_vid_cap = vimc_cap_enum_fmt_vid_cap,
 	.vidioc_enum_framesizes = vimc_cap_enum_framesizes,
 
 	.vidioc_reqbufs = vb2_ioctl_reqbufs,
@@ -529,6 +569,7 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
 {
 	struct v4l2_device *v4l2_dev = master_data;
 	struct vimc_platform_data *pdata = comp->platform_data;
+	struct v4l2_ioctl_ops *ioctl_ops = &vimc_cap_ioctl_ops;
 	struct vimc_cap_device *vcap;
 	struct video_device *vdev;
 	struct vb2_queue *q;
@@ -560,7 +601,9 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
 
 	/* Initialize the vb2 queue */
 	q = &vcap->queue;
-	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	q->type = multiplanar ?
+		V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
+		V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_USERPTR;
 	q->drv_priv = vcap;
 	q->buf_struct_size = sizeof(struct vimc_cap_buffer);
@@ -588,13 +631,32 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
 	dev_set_drvdata(comp, &vcap->ved);
 	vcap->dev = comp;
 
+
 	/* Initialize the video_device struct */
 	vdev = &vcap->vdev;
-	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	vdev->device_caps = (multiplanar ?
+			V4L2_CAP_VIDEO_CAPTURE_MPLANE :
+			V4L2_CAP_VIDEO_CAPTURE) | V4L2_CAP_STREAMING;
 	vdev->entity.ops = &vimc_cap_mops;
 	vdev->release = vimc_cap_release;
 	vdev->fops = &vimc_cap_fops;
-	vdev->ioctl_ops = &vimc_cap_ioctl_ops;
+
+	if (multiplanar) {
+		ioctl_ops->vidioc_g_fmt_vid_cap_mplane = vimc_cap_g_fmt_vid_cap;
+		ioctl_ops->vidioc_s_fmt_vid_cap_mplane =
+						vimc_cap_s_fmt_vid_cap_mp;
+		ioctl_ops->vidioc_try_fmt_vid_cap_mplane =
+						vimc_cap_try_fmt_vid_cap_mp;
+		ioctl_ops->vidioc_enum_fmt_vid_cap_mplane =
+						vimc_cap_enum_fmt_vid_cap;
+	} else {
+		ioctl_ops->vidioc_g_fmt_vid_cap = vimc_cap_g_fmt_vid_cap;
+		ioctl_ops->vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap_sp;
+		ioctl_ops->vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap_sp;
+		ioctl_ops->vidioc_enum_fmt_vid_cap = vimc_cap_enum_fmt_vid_cap;
+	}
+
+	vdev->ioctl_ops = ioctl_ops;
 	vdev->lock = &vcap->lock;
 	vdev->queue = q;
 	vdev->v4l2_dev = v4l2_dev;
-- 
2.21.0

