Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93342C43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABFB206A3
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfDZBYb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:24:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDZBYa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 21:24:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 45F9328196E
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v4 06/14] media: vimc: cap: Add handler for multiplanar fmt ioctls
Date:   Thu, 25 Apr 2019 22:22:15 -0300
Message-Id: <20190426012223.17826-7-andrealmeid@collabora.com>
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

Add functions to handle multiplanar format ioctls, calling
the generic format ioctls functions when possible.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Change in v4:
- Split from multiplanar parameter commit
- Use `IS_MULTIPLANAR` instead of `multiplanar`
- Move "Functions to handle..." to commit 5

Change in v3:
- Remove functions that only did the `IS_MULTIPLANAR(vcap)` check
- Squash with multiplanar parameter commit

Change in v2:
- Fix alignment

 drivers/media/platform/vimc/vimc-capture.c | 63 +++++++++++++++++++---
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index fa0d75eb06e8..652d3d08bc50 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -211,6 +211,44 @@ static int vimc_cap_s_fmt_vid_cap_sp(struct file *file, void *priv,
 	return 0;
 }
 
+/*
+ * VIDIOC handlers for multi-planar formats
+ */
+static int vimc_cap_s_fmt_vid_cap_mp(struct file *file, void *priv,
+				     struct v4l2_format *f)
+{
+	struct vimc_cap_device *vcap = video_drvdata(file);
+	int ret;
+
+	/* Do not change the format while stream is on */
+	if (vb2_is_busy(&vcap->queue))
+		return -EBUSY;
+
+	ret = vimc_cap_try_fmt_vid_cap_mp(file, priv, f);
+	if (ret)
+		return ret;
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
@@ -251,13 +289,9 @@ static const struct v4l2_file_operations vimc_cap_fops = {
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
@@ -455,6 +489,7 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
 {
 	struct v4l2_device *v4l2_dev = master_data;
 	struct vimc_platform_data *pdata = comp->platform_data;
+	struct v4l2_ioctl_ops *ioctl_ops = &vimc_cap_ioctl_ops;
 	struct vimc_cap_device *vcap;
 	struct video_device *vdev;
 	struct vb2_queue *q;
@@ -527,7 +562,23 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
 	vdev->entity.ops = &vimc_cap_mops;
 	vdev->release = vimc_cap_release;
 	vdev->fops = &vimc_cap_fops;
-	vdev->ioctl_ops = &vimc_cap_ioctl_ops;
+
+	if (IS_MULTIPLANAR(vcap)) {
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

