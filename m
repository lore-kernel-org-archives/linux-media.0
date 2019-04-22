Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB43C282E3
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C21C218D3
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfDVII3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:08:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfDVII2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 04:08:28 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E49BC2829EA;
        Mon, 22 Apr 2019 09:08:26 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 09/15] rockchip/vpu: Move encoder logic to a common place
Date:   Mon, 22 Apr 2019 10:08:12 +0200
Message-Id: <20190422080818.29130-10-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422080818.29130-1-boris.brezillon@collabora.com>
References: <20190422080818.29130-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The V4L2/VB2 implementation for the encoder and decoder logic are very
similar, so let's rename rockchip_vpu_enc.c file into
rockchip_vpu_v4l2.c and remove the _enc_ part in objects/functions
exposed in rockchip_vpu_v4l2.h. We also rename the enc_queue_init()
function (in rockchip_vpu_drv.c) queue_init() since it will be used
to initialize both type of queues.

The implementation itself will be patched to support the decoding case
when decoder support is added.

Suggested-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes from v2:
* New patch
---
 drivers/staging/media/rockchip/vpu/Makefile        |  2 +-
 .../staging/media/rockchip/vpu/rockchip_vpu_drv.c  | 14 +++++++-------
 .../{rockchip_vpu_enc.c => rockchip_vpu_v4l2.c}    | 14 +++++++-------
 .../staging/media/rockchip/vpu/rockchip_vpu_v4l2.h | 12 ++++++------
 4 files changed, 21 insertions(+), 21 deletions(-)
 rename drivers/staging/media/rockchip/vpu/{rockchip_vpu_enc.c => rockchip_vpu_v4l2.c} (97%)

diff --git a/drivers/staging/media/rockchip/vpu/Makefile b/drivers/staging/media/rockchip/vpu/Makefile
index e9d733bb7632..ae512173e7e4 100644
--- a/drivers/staging/media/rockchip/vpu/Makefile
+++ b/drivers/staging/media/rockchip/vpu/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_VIDEO_ROCKCHIP_VPU) += rockchip-vpu.o
 
 rockchip-vpu-y += \
 		rockchip_vpu_drv.o \
-		rockchip_vpu_enc.o \
+		rockchip_vpu_v4l2.o \
 		rk3288_vpu_hw.o \
 		rk3288_vpu_hw_jpeg_enc.o \
 		rk3399_vpu_hw.o \
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
index 041116855bab..d729b27c95db 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
@@ -140,7 +140,7 @@ static struct v4l2_m2m_ops vpu_m2m_ops = {
 };
 
 static int
-enc_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
+queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 {
 	struct rockchip_vpu_ctx *ctx = priv;
 	int ret;
@@ -148,7 +148,7 @@ enc_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
 	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	src_vq->drv_priv = ctx;
-	src_vq->ops = &rockchip_vpu_enc_queue_ops;
+	src_vq->ops = &rockchip_vpu_queue_ops;
 	src_vq->mem_ops = &vb2_dma_contig_memops;
 
 	/*
@@ -179,7 +179,7 @@ enc_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	dst_vq->drv_priv = ctx;
-	dst_vq->ops = &rockchip_vpu_enc_queue_ops;
+	dst_vq->ops = &rockchip_vpu_queue_ops;
 	dst_vq->mem_ops = &vb2_vmalloc_memops;
 	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
@@ -259,7 +259,7 @@ static int rockchip_vpu_open(struct file *filp)
 	ctx->dev = vpu;
 	if (vdev == vpu->vfd_enc)
 		ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(vpu->m2m_dev, ctx,
-						    &enc_queue_init);
+						    queue_init);
 	else
 		ctx->fh.m2m_ctx = ERR_PTR(-ENODEV);
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
@@ -272,8 +272,8 @@ static int rockchip_vpu_open(struct file *filp)
 	filp->private_data = &ctx->fh;
 	v4l2_fh_add(&ctx->fh);
 
-	rockchip_vpu_enc_reset_dst_fmt(vpu, ctx);
-	rockchip_vpu_enc_reset_src_fmt(vpu, ctx);
+	rockchip_vpu_reset_dst_fmt(vpu, ctx);
+	rockchip_vpu_reset_src_fmt(vpu, ctx);
 
 	ret = rockchip_vpu_ctrls_setup(vpu, ctx);
 	if (ret) {
@@ -349,7 +349,7 @@ static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu)
 	vfd->v4l2_dev = &vpu->v4l2_dev;
 	vfd->vfl_dir = VFL_DIR_M2M;
 	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
-	vfd->ioctl_ops = &rockchip_vpu_enc_ioctl_ops;
+	vfd->ioctl_ops = &rockchip_vpu_ioctl_ops;
 	snprintf(vfd->name, sizeof(vfd->name), "%s-enc", match->compatible);
 	vpu->vfd_enc = vfd;
 	video_set_drvdata(vfd, vpu);
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
similarity index 97%
rename from drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
rename to drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
index 09ebc3934389..7a03bf0a6359 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
@@ -261,8 +261,8 @@ vidioc_try_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	return 0;
 }
 
-void rockchip_vpu_enc_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
-				    struct rockchip_vpu_ctx *ctx)
+void rockchip_vpu_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
+				struct rockchip_vpu_ctx *ctx)
 {
 	struct v4l2_pix_format_mplane *fmt = &ctx->dst_fmt;
 
@@ -286,8 +286,8 @@ void rockchip_vpu_enc_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
 		fmt->width * fmt->height * ctx->vpu_dst_fmt->max_depth;
 }
 
-void rockchip_vpu_enc_reset_src_fmt(struct rockchip_vpu_dev *vpu,
-				    struct rockchip_vpu_ctx *ctx)
+void rockchip_vpu_reset_src_fmt(struct rockchip_vpu_dev *vpu,
+				struct rockchip_vpu_ctx *ctx)
 {
 	struct v4l2_pix_format_mplane *fmt = &ctx->src_fmt;
 	unsigned int width, height;
@@ -388,11 +388,11 @@ vidioc_s_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	 * the raw format again after we return, so we don't need
 	 * anything smarter.
 	 */
-	rockchip_vpu_enc_reset_src_fmt(vpu, ctx);
+	rockchip_vpu_reset_src_fmt(vpu, ctx);
 	return 0;
 }
 
-const struct v4l2_ioctl_ops rockchip_vpu_enc_ioctl_ops = {
+const struct v4l2_ioctl_ops rockchip_vpu_ioctl_ops = {
 	.vidioc_querycap = vidioc_querycap,
 	.vidioc_enum_framesizes = vidioc_enum_framesizes,
 
@@ -576,7 +576,7 @@ static int rockchip_vpu_buf_out_validate(struct vb2_buffer *vb)
 	return 0;
 }
 
-const struct vb2_ops rockchip_vpu_enc_queue_ops = {
+const struct vb2_ops rockchip_vpu_queue_ops = {
 	.queue_setup = rockchip_vpu_queue_setup,
 	.buf_prepare = rockchip_vpu_buf_prepare,
 	.buf_queue = rockchip_vpu_buf_queue,
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.h
index 50ad40dfb4f4..816bd3988218 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.h
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.h
@@ -18,12 +18,12 @@
 
 #include "rockchip_vpu.h"
 
-extern const struct v4l2_ioctl_ops rockchip_vpu_enc_ioctl_ops;
-extern const struct vb2_ops rockchip_vpu_enc_queue_ops;
+extern const struct v4l2_ioctl_ops rockchip_vpu_ioctl_ops;
+extern const struct vb2_ops rockchip_vpu_queue_ops;
 
-void rockchip_vpu_enc_reset_src_fmt(struct rockchip_vpu_dev *vpu,
-				    struct rockchip_vpu_ctx *ctx);
-void rockchip_vpu_enc_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
-				    struct rockchip_vpu_ctx *ctx);
+void rockchip_vpu_reset_src_fmt(struct rockchip_vpu_dev *vpu,
+				struct rockchip_vpu_ctx *ctx);
+void rockchip_vpu_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
+				struct rockchip_vpu_ctx *ctx);
 
 #endif /* ROCKCHIP_VPU_V4L2_H_ */
-- 
2.20.1

