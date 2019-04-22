Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582CC282E3
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA47218D2
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfDVIIb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:08:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46540 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfDVIIa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 04:08:30 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A8BEB2829F8;
        Mon, 22 Apr 2019 09:08:28 +0100 (BST)
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
Subject: [PATCH v3 12/15] rockchip/vpu: Add decoder boilerplate
Date:   Mon, 22 Apr 2019 10:08:15 +0200
Message-Id: <20190422080818.29130-13-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422080818.29130-1-boris.brezillon@collabora.com>
References: <20190422080818.29130-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

This commit adds the needed boilerplate code to support the VPU
in decoding operation. Two v4l2 interfaces are exposed, one for
encoding and one for decoding, but a single m2m device is shared
by them, so jobs are properly serialized.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
--
Changes from v2:
* Use the common vb2/v4l2 implementation
* Use strscpy instead of strlcpy.
* Abstract vidioc v4l2 api implementations into generic code, creating
  helpers that can be used by the encoder and the decoder.
* Only prevent S_FMT on the coded format queue, if the peer queue has buffers allocated.
* Refactor the code, adding a buf_finish callback to rockchip_vpu_ctx.
  With this change, is_enc field is not needed.
* Separate OUTPUT and CAPTURE queue ops (vb2_ops), and create common helpers that
  can be used by both.
* Pass a no kernel mapping attribute on both ends of the decoder.
---
 .../media/rockchip/vpu/rk3399_vpu_hw.c        |  19 ++
 .../staging/media/rockchip/vpu/rockchip_vpu.h |  52 +++++-
 .../media/rockchip/vpu/rockchip_vpu_common.h  |  46 +++++
 .../media/rockchip/vpu/rockchip_vpu_drv.c     | 164 ++++++++++++++----
 .../media/rockchip/vpu/rockchip_vpu_v4l2.c    |   9 +-
 5 files changed, 251 insertions(+), 39 deletions(-)
 create mode 100644 drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h

diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
index f4effad00605..87460fe179f5 100644
--- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
+++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
@@ -74,6 +74,24 @@ static irqreturn_t rk3399_vepu_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t rk3399_vdpu_irq(int irq, void *dev_id)
+{
+	struct rockchip_vpu_dev *vpu = dev_id;
+	enum vb2_buffer_state state;
+	u32 status;
+
+	status = vdpu_read(vpu, VDPU_REG_INTERRUPT);
+	state = (status & VDPU_REG_INTERRUPT_DEC_IRQ) ?
+		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
+
+	vdpu_write(vpu, 0, VDPU_REG_INTERRUPT);
+	vdpu_write(vpu, 0, VDPU_REG_AXI_CTRL);
+
+	rockchip_vpu_irq_done(vpu, 0, state);
+
+	return IRQ_HANDLED;
+}
+
 static int rk3399_vpu_hw_init(struct rockchip_vpu_dev *vpu)
 {
 	/* Bump ACLK to max. possible freq. to improve performance. */
@@ -114,6 +132,7 @@ const struct rockchip_vpu_variant rk3399_vpu_variant = {
 	.codec = RK_VPU_CODEC_JPEG,
 	.codec_ops = rk3399_vpu_codec_ops,
 	.vepu_irq = rk3399_vepu_irq,
+	.vdpu_irq = rk3399_vdpu_irq,
 	.init = rk3399_vpu_hw_init,
 	.clk_names = {"aclk", "hclk"},
 	.num_clocks = 2
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
index ce0fb185c5f8..17bcfd302283 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
@@ -40,23 +40,31 @@ struct rockchip_vpu_codec_ops;
  * struct rockchip_vpu_variant - information about VPU hardware variant
  *
  * @enc_offset:			Offset from VPU base to encoder registers.
+ * @dec_offset:			Offset from VPU base to decoder registers.
  * @enc_fmts:			Encoder formats.
  * @num_enc_fmts:		Number of encoder formats.
+ * @dec_fmts:			Decoder formats.
+ * @num_dec_fmts:		Number of decoder formats.
  * @codec:			Supported codecs
  * @codec_ops:			Codec ops.
  * @init:			Initialize hardware.
  * @vepu_irq:			encoder interrupt handler
+ * @vdpu_irq:			decoder interrupt handler
  * @clk_names:			array of clock names
  * @num_clocks:			number of clocks in the array
  */
 struct rockchip_vpu_variant {
 	unsigned int enc_offset;
+	unsigned int dec_offset;
 	const struct rockchip_vpu_fmt *enc_fmts;
 	unsigned int num_enc_fmts;
+	const struct rockchip_vpu_fmt *dec_fmts;
+	unsigned int num_dec_fmts;
 	unsigned int codec;
 	const struct rockchip_vpu_codec_ops *codec_ops;
 	int (*init)(struct rockchip_vpu_dev *vpu);
 	irqreturn_t (*vepu_irq)(int irq, void *priv);
+	irqreturn_t (*vdpu_irq)(int irq, void *priv);
 	const char *clk_names[ROCKCHIP_VPU_MAX_CLOCKS];
 	int num_clocks;
 };
@@ -71,6 +79,16 @@ enum rockchip_vpu_codec_mode {
 	RK_VPU_MODE_JPEG_ENC,
 };
 
+/**
+ * enum rockchip_vpu_type - device type, encoder or decoder
+ * @RK_VPU_ENCODER: The device is an encoder.
+ * @RK_VPU_DECODER: The device is a decoder.
+ */
+enum rockchip_vpu_type {
+	RK_VPU_ENCODER,
+	RK_VPU_DECODER,
+};
+
 /*
  * struct rockchip_vpu_mc - media controller data
  *
@@ -99,6 +117,7 @@ struct rockchip_vpu_mc {
  * @m2m_dev:		mem2mem device associated to this device.
  * @mdev:		media device associated to this device.
  * @vfd_enc:		Video device for encoder.
+ * @vfd_dec:		Video device for decoder.
  * @pdev:		Pointer to VPU platform device.
  * @mc:			Array of media controller topology structs
  *			for encoder and decoder.
@@ -107,6 +126,7 @@ struct rockchip_vpu_mc {
  * @clocks:		Array of clock handles.
  * @base:		Mapped address of VPU registers.
  * @enc_base:		Mapped address of VPU encoder register for convenience.
+ * @dec_base:		Mapped address of VPU decoder register for convenience.
  * @vpu_mutex:		Mutex to synchronize V4L2 calls.
  * @irqlock:		Spinlock to synchronize access to data structures
  *			shared with interrupt handlers.
@@ -118,12 +138,14 @@ struct rockchip_vpu_dev {
 	struct v4l2_m2m_dev *m2m_dev;
 	struct media_device mdev;
 	struct video_device *vfd_enc;
+	struct video_device *vfd_dec;
 	struct platform_device *pdev;
 	struct rockchip_vpu_mc mc[2];
 	struct device *dev;
 	struct clk_bulk_data clocks[ROCKCHIP_VPU_MAX_CLOCKS];
 	void __iomem *base;
 	void __iomem *enc_base;
+	void __iomem *dec_base;
 
 	struct mutex vpu_mutex;	/* video_device lock */
 	spinlock_t irqlock;
@@ -148,6 +170,9 @@ struct rockchip_vpu_dev {
  * @ctrl_handler:	Control handler used to register controls.
  * @jpeg_quality:	User-specified JPEG compression quality.
  *
+ * @buf_finish:		Buffer finish. This depends on encoder or decoder
+ *			context, and it's called right before
+ *			calling v4l2_m2m_job_finish.
  * @codec_ops:		Set of operations related to codec mode.
  * @jpeg_enc:		JPEG-encoding context.
  */
@@ -166,6 +191,10 @@ struct rockchip_vpu_ctx {
 	struct v4l2_ctrl_handler ctrl_handler;
 	int jpeg_quality;
 
+	int (*buf_finish)(struct rockchip_vpu_ctx *ctx,
+			  struct vb2_buffer *buf,
+			  unsigned int bytesused);
+
 	const struct rockchip_vpu_codec_ops *codec_ops;
 
 	/* Specific for particular codec modes. */
@@ -252,10 +281,27 @@ static inline u32 vepu_read(struct rockchip_vpu_dev *vpu, u32 reg)
 	return val;
 }
 
-static inline bool
-rockchip_vpu_is_encoder_ctx(const struct rockchip_vpu_ctx *ctx)
+static inline void vdpu_write_relaxed(struct rockchip_vpu_dev *vpu,
+				      u32 val, u32 reg)
 {
-	return true;
+	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
+	writel_relaxed(val, vpu->dec_base + reg);
 }
 
+static inline void vdpu_write(struct rockchip_vpu_dev *vpu, u32 val, u32 reg)
+{
+	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
+	writel(val, vpu->dec_base + reg);
+}
+
+static inline u32 vdpu_read(struct rockchip_vpu_dev *vpu, u32 reg)
+{
+	u32 val = readl(vpu->dec_base + reg);
+
+	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
+	return val;
+}
+
+bool rockchip_vpu_is_encoder_ctx(const struct rockchip_vpu_ctx *ctx);
+
 #endif /* ROCKCHIP_VPU_H_ */
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
new file mode 100644
index 000000000000..8688721fbcac
--- /dev/null
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Rockchip VPU codec driver
+ *
+ * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
+ *	Alpha Lin <Alpha.Lin@rock-chips.com>
+ *	Jeffy Chen <jeffy.chen@rock-chips.com>
+ *
+ * Copyright 2018 Google LLC.
+ *	Tomasz Figa <tfiga@chromium.org>
+ *
+ * Based on s5p-mfc driver by Samsung Electronics Co., Ltd.
+ * Copyright (C) 2011 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef ROCKCHIP_VPU_COMMON_H_
+#define ROCKCHIP_VPU_COMMON_H_
+
+#include "rockchip_vpu.h"
+
+extern const struct v4l2_ioctl_ops rockchip_vpu_enc_ioctl_ops;
+extern const struct vb2_ops rockchip_vpu_enc_src_queue_ops;
+extern const struct vb2_ops rockchip_vpu_enc_dst_queue_ops;
+extern const struct v4l2_ioctl_ops rockchip_vpu_dec_ioctl_ops;
+extern const struct vb2_ops rockchip_vpu_dec_src_queue_ops;
+extern const struct vb2_ops rockchip_vpu_dec_dst_queue_ops;
+
+void rockchip_vpu_buf_queue(struct vb2_buffer *vb);
+int rockchip_vpu_src_queue_setup(struct vb2_queue *vq,
+				 unsigned int *num_buffers,
+				 unsigned int *num_planes,
+				 unsigned int sizes[],
+				 struct device *alloc_devs[]);
+int rockchip_vpu_dst_queue_setup(struct vb2_queue *vq,
+				 unsigned int *num_buffers,
+				 unsigned int *num_planes,
+				 unsigned int sizes[],
+				 struct device *alloc_devs[]);
+void rockchip_vpu_buf_request_complete(struct vb2_buffer *vb);
+int rockchip_vpu_buf_out_validate(struct vb2_buffer *vb);
+int rockchip_vpu_src_buf_prepare(struct vb2_buffer *vb);
+int rockchip_vpu_dst_buf_prepare(struct vb2_buffer *vb);
+int rockchip_vpu_start(struct vb2_queue *q, unsigned int count);
+void rockchip_vpu_stop(struct vb2_queue *q);
+
+#endif /* ROCKCHIP_VPU_COMMON_H_ */
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
index 8c02a7a2e65f..d344fdd88476 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
@@ -35,13 +35,48 @@ module_param_named(debug, rockchip_vpu_debug, int, 0644);
 MODULE_PARM_DESC(debug,
 		 "Debug level - higher value produces more verbose messages");
 
+static int
+rockchip_vpu_enc_buf_finish(struct rockchip_vpu_ctx *ctx,
+			    struct vb2_buffer *buf,
+			    unsigned int bytesused)
+{
+	size_t avail_size;
+
+	avail_size = vb2_plane_size(buf, 0) - ctx->vpu_dst_fmt->header_size;
+	if (bytesused > avail_size)
+		return -EINVAL;
+	/*
+	 * The bounce buffer is only for the JPEG encoder.
+	 * TODO: Rework the JPEG encoder to eliminate the need
+	 * for a bounce buffer.
+	 */
+	if (ctx->jpeg_enc.bounce_buffer.cpu) {
+		memcpy(vb2_plane_vaddr(buf, 0) +
+		       ctx->vpu_dst_fmt->header_size,
+		       ctx->jpeg_enc.bounce_buffer.cpu, bytesused);
+	}
+	buf->planes[0].bytesused =
+		ctx->vpu_dst_fmt->header_size + bytesused;
+	return 0;
+}
+
+static int
+rockchip_vpu_dec_buf_finish(struct rockchip_vpu_ctx *ctx,
+			    struct vb2_buffer *buf,
+			    unsigned int bytesused)
+{
+	/* For decoders set bytesused as per the output picture. */
+	buf->planes[0].bytesused = ctx->dst_fmt.plane_fmt[0].sizeimage;
+	return 0;
+}
+
 static void rockchip_vpu_job_finish(struct rockchip_vpu_dev *vpu,
 				    struct rockchip_vpu_ctx *ctx,
 				    unsigned int bytesused,
 				    enum vb2_buffer_state result)
 {
 	struct vb2_v4l2_buffer *src, *dst;
-	size_t avail_size;
+	int ret;
 
 	pm_runtime_mark_last_busy(vpu->dev);
 	pm_runtime_put_autosuspend(vpu->dev);
@@ -60,24 +95,9 @@ static void rockchip_vpu_job_finish(struct rockchip_vpu_dev *vpu,
 
 	v4l2_m2m_buf_copy_metadata(src, dst, true);
 
-	avail_size = vb2_plane_size(&dst->vb2_buf, 0) -
-		     ctx->vpu_dst_fmt->header_size;
-	if (bytesused <= avail_size) {
-		/*
-		 * The bounce buffer is only for the JPEG encoder.
-		 * TODO: Rework the JPEG encoder to eliminate the need
-		 * for a bounce buffer.
-		 */
-		if (ctx->jpeg_enc.bounce_buffer.cpu) {
-			memcpy(vb2_plane_vaddr(&dst->vb2_buf, 0) +
-			       ctx->vpu_dst_fmt->header_size,
-			       ctx->jpeg_enc.bounce_buffer.cpu, bytesused);
-		}
-		dst->vb2_buf.planes[0].bytesused =
-			ctx->vpu_dst_fmt->header_size + bytesused;
-	} else {
+	ret = ctx->buf_finish(ctx, &dst->vb2_buf, bytesused);
+	if (ret)
 		result = VB2_BUF_STATE_ERROR;
-	}
 
 	v4l2_m2m_buf_done(src, result);
 	v4l2_m2m_buf_done(dst, result);
@@ -135,6 +155,11 @@ static void device_run(void *priv)
 	rockchip_vpu_job_finish(ctx->dev, ctx, 0, VB2_BUF_STATE_ERROR);
 }
 
+bool rockchip_vpu_is_encoder_ctx(const struct rockchip_vpu_ctx *ctx)
+{
+	return ctx->buf_finish == rockchip_vpu_enc_buf_finish;
+}
+
 static struct v4l2_m2m_ops vpu_m2m_ops = {
 	.device_run = device_run,
 };
@@ -164,23 +189,33 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 	src_vq->dev = ctx->dev->v4l2_dev.dev;
 	src_vq->supports_requests = true;
 
+	if (!rockchip_vpu_is_encoder_ctx(ctx))
+		src_vq->requires_requests = true;
+
 	ret = vb2_queue_init(src_vq);
 	if (ret)
 		return ret;
 
 	/*
-	 * The CAPTURE queue doesn't need dma memory,
-	 * as the CPU needs to create the JPEG frames,
-	 * from the hardware-produced JPEG payload.
+	 * When encoding, the CAPTURE queue doesn't need dma memory,
+	 * as the CPU needs to create the JPEG frames, from the
+	 * hardware-produced JPEG payload.
 	 *
-	 * For the DMA destination buffer, we use
-	 * a bounce buffer.
+	 * For the DMA destination buffer, we use a bounce buffer.
 	 */
+	if (rockchip_vpu_is_encoder_ctx(ctx)) {
+		dst_vq->mem_ops = &vb2_vmalloc_memops;
+	} else {
+		dst_vq->bidirectional = true;
+		dst_vq->mem_ops = &vb2_dma_contig_memops;
+		dst_vq->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES |
+				    DMA_ATTR_NO_KERNEL_MAPPING;
+	}
+
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	dst_vq->drv_priv = ctx;
 	dst_vq->ops = &rockchip_vpu_queue_ops;
-	dst_vq->mem_ops = &vb2_vmalloc_memops;
 	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	dst_vq->lock = &ctx->dev->vpu_mutex;
@@ -257,11 +292,17 @@ static int rockchip_vpu_open(struct file *filp)
 		return -ENOMEM;
 
 	ctx->dev = vpu;
-	if (vdev == vpu->vfd_enc)
+	if (vdev == vpu->vfd_enc) {
+		ctx->buf_finish = rockchip_vpu_enc_buf_finish;
 		ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(vpu->m2m_dev, ctx,
 						    queue_init);
-	else
+	} else if (vdev == vpu->vfd_dec) {
+		ctx->buf_finish = rockchip_vpu_dec_buf_finish;
+		ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(vpu->m2m_dev, ctx,
+						    queue_init);
+	} else {
 		ctx->fh.m2m_ctx = ERR_PTR(-ENODEV);
+	}
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
 		ret = PTR_ERR(ctx->fh.m2m_ctx);
 		kfree(ctx);
@@ -329,7 +370,8 @@ static const struct media_device_ops rockchip_m2m_media_ops = {
 	.req_queue = v4l2_m2m_request_queue,
 };
 
-static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu)
+static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu,
+					      enum rockchip_vpu_type type)
 {
 	const struct of_device_id *match;
 	struct video_device *vfd;
@@ -349,8 +391,13 @@ static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu)
 	vfd->vfl_dir = VFL_DIR_M2M;
 	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
 	vfd->ioctl_ops = &rockchip_vpu_ioctl_ops;
-	snprintf(vfd->name, sizeof(vfd->name), "%s-enc", match->compatible);
-	vpu->vfd_enc = vfd;
+	snprintf(vfd->name, sizeof(vfd->name), "%s-%s", match->compatible,
+		 type == RK_VPU_ENCODER ? "enc" : "dec");
+
+	if (type == RK_VPU_ENCODER)
+		vpu->vfd_enc = vfd;
+	else
+		vpu->vfd_dec = vfd;
 	video_set_drvdata(vfd, vpu);
 
 	ret = video_register_device(vfd, VFL_TYPE_GRABBER, 0);
@@ -524,6 +571,16 @@ static int rockchip_register_media_controller(struct rockchip_vpu_dev *vpu)
 			return ret;
 	}
 
+	if (vpu->vfd_dec) {
+		ret = rockchip_register_mc(&vpu->mdev, &vpu->mc[1],
+					   vpu->vfd_dec,
+					   MEDIA_ENT_F_PROC_VIDEO_DECODER);
+		if (ret) {
+			rockchip_unregister_mc(&vpu->mc[0]);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -560,6 +617,7 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
 	if (IS_ERR(vpu->base))
 		return PTR_ERR(vpu->base);
 	vpu->enc_base = vpu->base + vpu->variant->enc_offset;
+	vpu->dec_base = vpu->base + vpu->variant->dec_offset;
 
 	ret = dma_set_coherent_mask(vpu->dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -567,6 +625,23 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (vpu->variant->vdpu_irq) {
+		int irq;
+
+		irq = platform_get_irq_byname(vpu->pdev, "vdpu");
+		if (irq <= 0) {
+			dev_err(vpu->dev, "Could not get vdpu IRQ.\n");
+			return -ENXIO;
+		}
+
+		ret = devm_request_irq(vpu->dev, irq, vpu->variant->vdpu_irq,
+				       0, dev_name(vpu->dev), vpu);
+		if (ret) {
+			dev_err(vpu->dev, "Could not request vdpu IRQ.\n");
+			return ret;
+		}
+	}
+
 	if (vpu->variant->vepu_irq) {
 		int irq;
 
@@ -620,10 +695,20 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
 	vpu->mdev.ops = &rockchip_m2m_media_ops;
 	vpu->v4l2_dev.mdev = &vpu->mdev;
 
-	ret = rockchip_vpu_video_device_register(vpu);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register encoder\n");
-		goto err_m2m_rel;
+	if (vpu->variant->enc_fmts) {
+		ret = rockchip_vpu_video_device_register(vpu, RK_VPU_ENCODER);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to register encoder\n");
+			goto err_m2m_enc_rel;
+		}
+	}
+
+	if (vpu->variant->dec_fmts) {
+		ret = rockchip_vpu_video_device_register(vpu, RK_VPU_DECODER);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to register decoder\n");
+			goto err_video_dev_unreg;
+		}
 	}
 
 	ret = rockchip_register_media_controller(vpu);
@@ -639,14 +724,20 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
 	}
 	return 0;
 err_mc_unreg:
+	if (vpu->vfd_dec)
+		rockchip_unregister_mc(&vpu->mc[1]);
 	if (vpu->vfd_enc)
 		rockchip_unregister_mc(&vpu->mc[0]);
 err_video_dev_unreg:
+	if (vpu->vfd_dec) {
+		video_unregister_device(vpu->vfd_dec);
+		video_device_release(vpu->vfd_dec);
+	}
 	if (vpu->vfd_enc) {
 		video_unregister_device(vpu->vfd_enc);
 		video_device_release(vpu->vfd_enc);
 	}
-err_m2m_rel:
+err_m2m_enc_rel:
 	v4l2_m2m_release(vpu->m2m_dev);
 err_v4l2_unreg:
 	v4l2_device_unregister(&vpu->v4l2_dev);
@@ -670,6 +761,11 @@ static int rockchip_vpu_remove(struct platform_device *pdev)
 		video_unregister_device(vpu->vfd_enc);
 		video_device_release(vpu->vfd_enc);
 	}
+	if (vpu->vfd_dec) {
+		rockchip_unregister_mc(&vpu->mc[1]);
+		video_unregister_device(vpu->vfd_dec);
+		video_device_release(vpu->vfd_dec);
+	}
 	v4l2_device_unregister(&vpu->v4l2_dev);
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
 	pm_runtime_disable(vpu->dev);
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
index f5e47babfa90..5718f8931b7f 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
@@ -36,8 +36,13 @@ rockchip_vpu_get_formats(const struct rockchip_vpu_ctx *ctx,
 {
 	const struct rockchip_vpu_fmt *formats;
 
-	formats = ctx->dev->variant->enc_fmts;
-	*num_fmts = ctx->dev->variant->num_enc_fmts;
+	if (rockchip_vpu_is_encoder_ctx(ctx)) {
+		formats = ctx->dev->variant->enc_fmts;
+		*num_fmts = ctx->dev->variant->num_enc_fmts;
+	} else {
+		formats = ctx->dev->variant->dec_fmts;
+		*num_fmts = ctx->dev->variant->num_dec_fmts;
+	}
 
 	return formats;
 }
-- 
2.20.1

