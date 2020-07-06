Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68017C433E0
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436EA20771
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="demZ9XC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgGFShg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:37:36 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45198 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgGFShe (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:37:34 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0E7A518E5;
        Mon,  6 Jul 2020 20:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060650;
        bh=yH5biP5AEoZqgbLoAqdzPxlCF2+N/mC792lEQ+I/4Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=demZ9XC38vZnPOy+deob7QhTgYGzAbZiIzW0BzDpb4v8i/N3BDANEPbnQctjxWYV7
         C85ayhHcD0kVRdZRmwZNwIcR9G9TsEc/+2tcT1fVJvMdkpDhciG1uiSQhoJdjaqtNu
         3bX2cM3kzcSsJvwpRU7QdGEQOYDZFL2max0NXULA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 005/108] media: ti-vpe: cal: Index IRQ registersstarting at 0
Date:   Mon,  6 Jul 2020 21:35:26 +0300
Message-Id: <20200706183709.12238-6-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The datasheet numbers the IRQ registers starting from 0. Update the
numbering scheme to match the datasheet.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c      | 38 ++++++++++++------------
 drivers/media/platform/ti-vpe/cal_regs.h |  8 ++---
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 799c25f5aafd..b04d8cb86977 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -695,22 +695,22 @@ static void enable_irqs(struct cal_ctx *ctx)
 		CAL_CSI2_COMPLEXIO_IRQ_ECC_NO_CORRECTION_MASK;
 
 	/* Enable CIO error irqs */
-	reg_write(ctx->dev, CAL_HL_IRQENABLE_SET(1),
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_SET(0),
 		  CAL_HL_IRQ_CIO_MASK(ctx->csi2_port));
 	reg_write(ctx->dev, CAL_CSI2_COMPLEXIO_IRQENABLE(ctx->csi2_port),
 		  cio_err_mask);
 
 	/* Always enable OCPO error */
-	reg_write(ctx->dev, CAL_HL_IRQENABLE_SET(1), CAL_HL_IRQ_OCPO_ERR_MASK);
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_SET(0), CAL_HL_IRQ_OCPO_ERR_MASK);
 
 	/* Enable IRQ_WDMA_END 0/1 */
 	val = 0;
 	set_field(&val, 1, CAL_HL_IRQ_MASK(ctx->csi2_port));
-	reg_write(ctx->dev, CAL_HL_IRQENABLE_SET(2), val);
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_SET(1), val);
 	/* Enable IRQ_WDMA_START 0/1 */
 	val = 0;
 	set_field(&val, 1, CAL_HL_IRQ_MASK(ctx->csi2_port));
-	reg_write(ctx->dev, CAL_HL_IRQENABLE_SET(3), val);
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_SET(2), val);
 	/* Todo: Add VC_IRQ and CSI2_COMPLEXIO_IRQ handling */
 	reg_write(ctx->dev, CAL_CSI2_VC_IRQENABLE(0), 0xFF000000);
 }
@@ -720,7 +720,7 @@ static void disable_irqs(struct cal_ctx *ctx)
 	u32 val;
 
 	/* Disable CIO error irqs */
-	reg_write(ctx->dev, CAL_HL_IRQENABLE_CLR(1),
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_CLR(0),
 		  CAL_HL_IRQ_CIO_MASK(ctx->csi2_port));
 	reg_write(ctx->dev, CAL_CSI2_COMPLEXIO_IRQENABLE(ctx->csi2_port),
 		  0);
@@ -728,11 +728,11 @@ static void disable_irqs(struct cal_ctx *ctx)
 	/* Disable IRQ_WDMA_END 0/1 */
 	val = 0;
 	set_field(&val, 1, CAL_HL_IRQ_MASK(ctx->csi2_port));
-	reg_write(ctx->dev, CAL_HL_IRQENABLE_CLR(2), val);
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_CLR(1), val);
 	/* Disable IRQ_WDMA_START 0/1 */
 	val = 0;
 	set_field(&val, 1, CAL_HL_IRQ_MASK(ctx->csi2_port));
-	reg_write(ctx->dev, CAL_HL_IRQENABLE_CLR(3), val);
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_CLR(2), val);
 	/* Todo: Add VC_IRQ and CSI2_COMPLEXIO_IRQ handling */
 	reg_write(ctx->dev, CAL_CSI2_VC_IRQENABLE(0), 0);
 }
@@ -1206,13 +1206,13 @@ static irqreturn_t cal_irq(int irq_cal, void *data)
 	struct cal_dev *dev = (struct cal_dev *)data;
 	struct cal_ctx *ctx;
 	struct cal_dmaqueue *dma_q;
-	u32 irqst1, irqst2, irqst3;
+	u32 irqst0, irqst1, irqst2;
 
-	irqst1 = reg_read(dev, CAL_HL_IRQSTATUS(1));
-	if (irqst1) {
+	irqst0 = reg_read(dev, CAL_HL_IRQSTATUS(0));
+	if (irqst0) {
 		int i;
 
-		reg_write(dev, CAL_HL_IRQSTATUS(1), irqst1);
+		reg_write(dev, CAL_HL_IRQSTATUS(0), irqst0);
 
 		if (irqst1 & CAL_HL_IRQ_OCPO_ERR_MASK)
 			dev_err_ratelimited(&dev->pdev->dev, "OCPO ERROR\n");
@@ -1232,15 +1232,15 @@ static irqreturn_t cal_irq(int irq_cal, void *data)
 	}
 
 	/* Check which DMA just finished */
-	irqst2 = reg_read(dev, CAL_HL_IRQSTATUS(2));
-	if (irqst2) {
+	irqst1 = reg_read(dev, CAL_HL_IRQSTATUS(1));
+	if (irqst1) {
 		int i;
 
 		/* Clear Interrupt status */
-		reg_write(dev, CAL_HL_IRQSTATUS(2), irqst2);
+		reg_write(dev, CAL_HL_IRQSTATUS(1), irqst1);
 
 		for (i = 0; i < 2; ++i) {
-			if (isportirqset(irqst2, i)) {
+			if (isportirqset(irqst1,  i)) {
 				ctx = dev->ctx[i];
 
 				spin_lock(&ctx->slock);
@@ -1255,15 +1255,15 @@ static irqreturn_t cal_irq(int irq_cal, void *data)
 	}
 
 	/* Check which DMA just started */
-	irqst3 = reg_read(dev, CAL_HL_IRQSTATUS(3));
-	if (irqst3) {
+	irqst2 = reg_read(dev, CAL_HL_IRQSTATUS(2));
+	if (irqst2) {
 		int i;
 
 		/* Clear Interrupt status */
-		reg_write(dev, CAL_HL_IRQSTATUS(3), irqst3);
+		reg_write(dev, CAL_HL_IRQSTATUS(2), irqst2);
 
 		for (i = 0; i < 2; ++i) {
-			if (isportirqset(irqst3, i)) {
+			if (isportirqset(irqst2, i)) {
 				ctx = dev->ctx[i];
 				dma_q = &ctx->vidq;
 
diff --git a/drivers/media/platform/ti-vpe/cal_regs.h b/drivers/media/platform/ti-vpe/cal_regs.h
index 56c8ccd0e75f..b551e67d5d41 100644
--- a/drivers/media/platform/ti-vpe/cal_regs.h
+++ b/drivers/media/platform/ti-vpe/cal_regs.h
@@ -42,10 +42,10 @@
 #define CAL_HL_HWINFO			0x0004
 #define CAL_HL_SYSCONFIG		0x0010
 #define CAL_HL_IRQ_EOI			0x001c
-#define CAL_HL_IRQSTATUS_RAW(m)		(0x20U + ((m-1) * 0x10U))
-#define CAL_HL_IRQSTATUS(m)		(0x24U + ((m-1) * 0x10U))
-#define CAL_HL_IRQENABLE_SET(m)		(0x28U + ((m-1) * 0x10U))
-#define CAL_HL_IRQENABLE_CLR(m)		(0x2cU + ((m-1) * 0x10U))
+#define CAL_HL_IRQSTATUS_RAW(m)		(0x20U + (m) * 0x10U)
+#define CAL_HL_IRQSTATUS(m)		(0x24U + (m) * 0x10U)
+#define CAL_HL_IRQENABLE_SET(m)		(0x28U + (m) * 0x10U)
+#define CAL_HL_IRQENABLE_CLR(m)		(0x2cU + (m) * 0x10U)
 #define CAL_PIX_PROC(m)			(0xc0U + (m) * 0x4U)
 #define CAL_CTRL			0x100
 #define CAL_CTRL1			0x104
-- 
Regards,

Laurent Pinchart

