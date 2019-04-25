Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F8C282E1
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 07:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72C6217D7
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 07:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbfDYHNA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:13:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60390 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389188AbfDYHM5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 03:12:57 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A2859282F3F;
        Thu, 25 Apr 2019 08:12:55 +0100 (BST)
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
Subject: [PATCH v4 17/21] rockchip/vpu: Add decoder boilerplate
Date:   Thu, 25 Apr 2019 09:12:38 +0200
Message-Id: <20190425071242.18315-18-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425071242.18315-1-boris.brezillon@collabora.com>
References: <20190425071242.18315-1-boris.brezillon@collabora.com>
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
Changes from v3:
* Update things according to changes done in the patch introducing
  custom media controller support (Boris)
* Move the rk3399 vdpu irq definition in the commit introducing
  MPGEG2 support on rk3399
* Fix media controller deregistration code (Jonas)

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
 drivers/staging/media/rockchip/vpu/Kconfig    |   1 +
 .../staging/media/rockchip/vpu/rockchip_vpu.h |  42 ++++-
 .../media/rockchip/vpu/rockchip_vpu_common.h  |  46 +++++
 .../media/rockchip/vpu/rockchip_vpu_drv.c     | 172 ++++++++++++++----
 .../media/rockchip/vpu/rockchip_vpu_v4l2.c    |   9 +-
 5 files changed, 232 insertions(+), 38 deletions(-)
 create mode 100644 drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h

diff --git a/drivers/staging/media/rockchip/vpu/Kconfig b/drivers/staging/media/rockchip/vpu/Kconfig
index 9a6fc1378242..f645c19f10d1 100644
--- a/drivers/staging/media/rockchip/vpu/Kconfig
+++ b/drivers/staging/media/rockchip/vpu/Kconfig
@@ -2,6 +2,7 @@ config VIDEO_ROCKCHIP_VPU
 	tristate "Rockchip VPU driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2 && MEDIA_CONTROLLER
+	depends on MEDIA_CONTROLLER_REQUEST_API
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_VMALLOC
 	select V4L2_MEM2MEM_DEV
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
index 0d24fd257a2b..3d64f3e95c9b 100644
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
@@ -112,12 +120,14 @@ rockchip_vpu_vdev_to_func(struct video_device *vdev)
  * @m2m_dev:		mem2mem device associated to this device.
  * @mdev:		media device associated to this device.
  * @encoder:		encoder functionality.
+ * @decoder:		decoder functionality.
  * @pdev:		Pointer to VPU platform device.
  * @dev:		Pointer to device for convenient logging using
  *			dev_ macros.
  * @clocks:		Array of clock handles.
  * @base:		Mapped address of VPU registers.
  * @enc_base:		Mapped address of VPU encoder register for convenience.
+ * @dec_base:		Mapped address of VPU decoder register for convenience.
  * @vpu_mutex:		Mutex to synchronize V4L2 calls.
  * @irqlock:		Spinlock to synchronize access to data structures
  *			shared with interrupt handlers.
@@ -129,11 +139,13 @@ struct rockchip_vpu_dev {
 	struct v4l2_m2m_dev *m2m_dev;
 	struct media_device mdev;
 	struct rockchip_vpu_func *encoder;
+	struct rockchip_vpu_func *decoder;
 	struct platform_device *pdev;
 	struct device *dev;
 	struct clk_bulk_data clocks[ROCKCHIP_VPU_MAX_CLOCKS];
 	void __iomem *base;
 	void __iomem *enc_base;
+	void __iomem *dec_base;
 
 	struct mutex vpu_mutex;	/* video_device lock */
 	spinlock_t irqlock;
@@ -158,6 +170,9 @@ struct rockchip_vpu_dev {
  * @ctrl_handler:	Control handler used to register controls.
  * @jpeg_quality:	User-specified JPEG compression quality.
  *
+ * @buf_finish:		Buffer finish. This depends on encoder or decoder
+ *			context, and it's called right before
+ *			calling v4l2_m2m_job_finish.
  * @codec_ops:		Set of operations related to codec mode.
  * @jpeg_enc:		JPEG-encoding context.
  */
@@ -176,6 +191,10 @@ struct rockchip_vpu_ctx {
 	struct v4l2_ctrl_handler ctrl_handler;
 	int jpeg_quality;
 
+	int (*buf_finish)(struct rockchip_vpu_ctx *ctx,
+			  struct vb2_buffer *buf,
+			  unsigned int bytesused);
+
 	const struct rockchip_vpu_codec_ops *codec_ops;
 
 	/* Specific for particular codec modes. */
@@ -262,10 +281,27 @@ static inline u32 vepu_read(struct rockchip_vpu_dev *vpu, u32 reg)
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
index d85b88067b03..cb42d5a983ee 100644
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
@@ -258,11 +293,17 @@ static int rockchip_vpu_open(struct file *filp)
 		return -ENOMEM;
 
 	ctx->dev = vpu;
-	if (func->id == MEDIA_ENT_F_PROC_VIDEO_ENCODER)
+	if (func->id == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
+		ctx->buf_finish = rockchip_vpu_enc_buf_finish;
 		ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(vpu->m2m_dev, ctx,
 						    queue_init);
-	else
+	} else if (func->id == MEDIA_ENT_F_PROC_VIDEO_DECODER) {
+		ctx->buf_finish = rockchip_vpu_dec_buf_finish;
+		ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(vpu->m2m_dev, ctx,
+						    queue_init);
+	} else {
 		ctx->fh.m2m_ctx = ERR_PTR(-ENODEV);
+	}
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
 		ret = PTR_ERR(ctx->fh.m2m_ctx);
 		kfree(ctx);
@@ -463,7 +504,8 @@ static void rockchip_detach_func(struct rockchip_vpu_func *func)
 	media_device_unregister_entity(&func->vdev.entity);
 }
 
-static int rockchip_vpu_add_enc_func(struct rockchip_vpu_dev *vpu)
+static int rockchip_vpu_add_func(struct rockchip_vpu_dev *vpu,
+				 unsigned int funcid)
 {
 	const struct of_device_id *match;
 	struct rockchip_vpu_func *func;
@@ -477,7 +519,7 @@ static int rockchip_vpu_add_enc_func(struct rockchip_vpu_dev *vpu)
 		return -ENOMEM;
 	}
 
-	func->id = MEDIA_ENT_F_PROC_VIDEO_ENCODER;
+	func->id = funcid;
 
 	vfd = &func->vdev;
 	vfd->fops = &rockchip_vpu_fops;
@@ -487,9 +529,14 @@ static int rockchip_vpu_add_enc_func(struct rockchip_vpu_dev *vpu)
 	vfd->vfl_dir = VFL_DIR_M2M;
 	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
 	vfd->ioctl_ops = &rockchip_vpu_ioctl_ops;
-	snprintf(vfd->name, sizeof(vfd->name), "%s-enc", match->compatible);
+	snprintf(vfd->name, sizeof(vfd->name), "%s-%s", match->compatible,
+		 funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ? "enc" : "dec");
+
+	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER)
+		vpu->encoder = func;
+	else
+		vpu->decoder = func;
 
-	vpu->encoder = func;
 	video_set_drvdata(vfd, vpu);
 
 	ret = video_register_device(vfd, VFL_TYPE_GRABBER, -1);
@@ -514,9 +561,31 @@ static int rockchip_vpu_add_enc_func(struct rockchip_vpu_dev *vpu)
 	return ret;
 }
 
-static void rockchip_vpu_remove_enc_func(struct rockchip_vpu_dev *vpu)
+static int rockchip_vpu_add_enc_func(struct rockchip_vpu_dev *vpu)
 {
-	struct rockchip_vpu_func *func = vpu->encoder;
+	if (!vpu->variant->enc_fmts)
+		return 0;
+
+	return rockchip_vpu_add_func(vpu, MEDIA_ENT_F_PROC_VIDEO_ENCODER);
+}
+
+static int rockchip_vpu_add_dec_func(struct rockchip_vpu_dev *vpu)
+{
+	if (!vpu->variant->dec_fmts)
+		return 0;
+
+	return rockchip_vpu_add_func(vpu, MEDIA_ENT_F_PROC_VIDEO_DECODER);
+}
+
+static void rockchip_vpu_remove_func(struct rockchip_vpu_dev *vpu,
+				     unsigned int funcid)
+{
+	struct rockchip_vpu_func *func;
+
+	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER)
+		func = vpu->encoder;
+	else
+		func = vpu->decoder;
 
 	if (!func)
 		return;
@@ -525,6 +594,16 @@ static void rockchip_vpu_remove_enc_func(struct rockchip_vpu_dev *vpu)
 	video_unregister_device(&func->vdev);
 }
 
+static void rockchip_vpu_remove_enc_func(struct rockchip_vpu_dev *vpu)
+{
+	rockchip_vpu_remove_func(vpu, MEDIA_ENT_F_PROC_VIDEO_ENCODER);
+}
+
+static void rockchip_vpu_remove_dec_func(struct rockchip_vpu_dev *vpu)
+{
+	rockchip_vpu_remove_func(vpu, MEDIA_ENT_F_PROC_VIDEO_DECODER);
+}
+
 static const struct media_device_ops rockchip_m2m_media_ops = {
 	.req_validate = vb2_request_validate,
 	.req_queue = v4l2_m2m_request_queue,
@@ -563,6 +642,7 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
 	if (IS_ERR(vpu->base))
 		return PTR_ERR(vpu->base);
 	vpu->enc_base = vpu->base + vpu->variant->enc_offset;
+	vpu->dec_base = vpu->base + vpu->variant->dec_offset;
 
 	ret = dma_set_coherent_mask(vpu->dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -570,6 +650,23 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
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
 
@@ -631,14 +728,22 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
 		goto err_m2m_rel;
 	}
 
+	ret = rockchip_vpu_add_dec_func(vpu);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register decoder\n");
+		goto err_rm_enc_func;
+	}
+
 	ret = media_device_register(&vpu->mdev);
 	if (ret) {
 		v4l2_err(&vpu->v4l2_dev, "Failed to register mem2mem media device\n");
-		goto err_rm_enc_func;
+		goto err_rm_dec_func;
 	}
 
 	return 0;
 
+err_rm_dec_func:
+	rockchip_vpu_remove_dec_func(vpu);
 err_rm_enc_func:
 	rockchip_vpu_remove_enc_func(vpu);
 err_m2m_rel:
@@ -660,6 +765,7 @@ static int rockchip_vpu_remove(struct platform_device *pdev)
 	v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
 
 	media_device_unregister(&vpu->mdev);
+	rockchip_vpu_remove_dec_func(vpu);
 	rockchip_vpu_remove_enc_func(vpu);
 	media_device_cleanup(&vpu->mdev);
 	v4l2_m2m_release(vpu->m2m_dev);
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
index 66b79408dad3..20c4cc77a01b 100644
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

