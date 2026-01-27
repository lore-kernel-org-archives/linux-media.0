Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125E362121
	for <linux-media@vger.kernel.org>; Tue, 27 Jan 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524834; cv=none; b=CJq3E2WFI+DytA3MTdxHoMyJi8aD7V0kJoFQGxNhprIfZnnlR9sZMRMhQUPNf4al3kOz3WjBBMTgJ6aZdu/OpTgDP+qr/LxjL5fSuSuPHsJ13GJEOdWF6/WuW3ipr/5EsZiQhyGk42giqFFZ8UkxM5UuaPmqR7QUpuuFUZ0hErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524834; c=relaxed/simple;
	bh=iDSo3xKVQDr0j+iq/VfyVGqXilMDTdQkkmmxSDyozRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNRiLY7s4NUMYkiSbeJDZ3tlsHtuYztvin19DRsWAgZgVqiE8ej14AxL/96jyeJ4E2iZwcKsjhsFsgse8+DwxM9XvQC8Tnfdy4mnkJaOrZkogH7rfg+rqbRlffHAbtpBYPwYCbpjemclvbvLidGXbd3eRDg0JZOw3guJ9r5T2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=peter.mobile.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1vkkF0-0007YT-38; Tue, 27 Jan 2026 15:40:26 +0100
From: =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
Date: Tue, 27 Jan 2026 15:39:24 +0100
Subject: [PATCH v3 15/27] media: rockchip: rga: prepare cmdbuf on streamon
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260127-spu-rga3-v3-15-77b273067beb@pengutronix.de>
References: <20260127-spu-rga3-v3-0-77b273067beb@pengutronix.de>
In-Reply-To: <20260127-spu-rga3-v3-0-77b273067beb@pengutronix.de>
To: Jacob Chen <jacob-chen@iotwrt.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org

Prepare the command buffer on streamon to reuse it's contents instead of
completely writing it for every frame. Due to the stream settings being
fixed after a streamon we only need to replace the source and destination
addresses for each frame. This reduces the amount of CPU and memory
operations done in each frame.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
---
 drivers/media/platform/rockchip/rga/rga-hw.c | 13 +++++++++----
 drivers/media/platform/rockchip/rga/rga.c    | 13 ++++++++++++-
 drivers/media/platform/rockchip/rga/rga.h    |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga-hw.c b/drivers/media/platform/rockchip/rga/rga-hw.c
index 16380be598e4a..dcd540ed3fd5b 100644
--- a/drivers/media/platform/rockchip/rga/rga-hw.c
+++ b/drivers/media/platform/rockchip/rga/rga-hw.c
@@ -417,8 +417,6 @@ static void rga_cmd_set(struct rga_ctx *ctx,
 {
 	struct rockchip_rga *rga = ctx->rga;
 
-	memset(ctx->cmdbuf_virt, 0, RGA_CMDBUF_SIZE * 4);
-
 	rga_cmd_set_src_addr(ctx, src->dma_desc_pa);
 	/*
 	 * Due to hardware bug,
@@ -427,11 +425,9 @@ static void rga_cmd_set(struct rga_ctx *ctx,
 	rga_cmd_set_src1_addr(ctx, dst->dma_desc_pa);
 
 	rga_cmd_set_dst_addr(ctx, dst->dma_desc_pa);
-	rga_cmd_set_mode(ctx);
 
 	rga_cmd_set_src_info(ctx, &src->offset);
 	rga_cmd_set_dst_info(ctx, &dst->offset);
-	rga_cmd_set_trans_info(ctx);
 
 	rga_write(rga, RGA_CMD_BASE, ctx->cmdbuf_phy);
 
@@ -440,6 +436,14 @@ static void rga_cmd_set(struct rga_ctx *ctx,
 				   PAGE_SIZE, DMA_BIDIRECTIONAL);
 }
 
+static void rga_hw_setup_cmdbuf(struct rga_ctx *ctx)
+{
+	memset(ctx->cmdbuf_virt, 0, RGA_CMDBUF_SIZE * 4);
+
+	rga_cmd_set_mode(ctx);
+	rga_cmd_set_trans_info(ctx);
+}
+
 static void rga_hw_start(struct rockchip_rga *rga,
 			 struct rga_vb_buffer *src,  struct rga_vb_buffer *dst)
 {
@@ -582,6 +586,7 @@ const struct rga_hw rga2_hw = {
 	.max_height = MAX_HEIGHT,
 	.stride_alignment = 4,
 
+	.setup_cmdbuf = rga_hw_setup_cmdbuf,
 	.start = rga_hw_start,
 	.handle_irq = rga_handle_irq,
 	.get_version = rga_get_version,
diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 2920efe65082a..6947c472a8b01 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -568,6 +568,17 @@ static int vidioc_s_selection(struct file *file, void *priv,
 	return ret;
 }
 
+static int vidioc_streamon(struct file *file, void *priv,
+			   enum v4l2_buf_type type)
+{
+	struct rga_ctx *ctx = file_to_rga_ctx(file);
+	const struct rga_hw *hw = ctx->rga->hw;
+
+	hw->setup_cmdbuf(ctx);
+
+	return v4l2_m2m_streamon(file, ctx->fh.m2m_ctx, type);
+}
+
 static const struct v4l2_ioctl_ops rga_ioctl_ops = {
 	.vidioc_querycap = vidioc_querycap,
 
@@ -592,7 +603,7 @@ static const struct v4l2_ioctl_ops rga_ioctl_ops = {
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
 
-	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
+	.vidioc_streamon = vidioc_streamon,
 	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
 
 	.vidioc_g_selection = vidioc_g_selection,
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index 38518146910a6..c741213710b32 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -152,6 +152,7 @@ struct rga_hw {
 	u32 max_width, max_height;
 	u8 stride_alignment;
 
+	void (*setup_cmdbuf)(struct rga_ctx *ctx);
 	void (*start)(struct rockchip_rga *rga,
 		      struct rga_vb_buffer *src, struct rga_vb_buffer *dst);
 	bool (*handle_irq)(struct rockchip_rga *rga);

-- 
2.52.0

