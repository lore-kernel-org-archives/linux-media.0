Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D17C2B9F4
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB67961166
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhFNLgP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:36:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58264 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhFNLeM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Jun 2021 07:34:12 -0400
Received: from deskari.lan (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BC8B05E97;
        Mon, 14 Jun 2021 13:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623669847;
        bh=fwLtsJQfwJpQBDhu1KyhjRFM6N2uSRaymgL3+7cLt1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDL8WEvTaH0B68nGDws6VBNrDREztwiGGZ/0Z3E9A/NANk56Tf7PSGS6Wb646mNPm
         SeZv3fv4ZA6kkVLB8p2isSHXaXGxHWcIuefEg3vRw37ffudsTwbXcx4rMhSZBdO4uv
         Pf6TWCioQLJ9ta24sclRrD/GU6kRIO94g14tzIdI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 12/35] media: ti-vpe: cal: rename CAL_HL_IRQ_MASK
Date:   Mon, 14 Jun 2021 14:23:22 +0300
Message-Id: <20210614112345.2032435-13-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
References: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

CAL_HL_IRQ_MASK macro is used for both WDMA start and end status bits.
For clarity, rename CAL_HL_IRQ_MASK macro to CAL_HL_IRQ_WDMA_END_MASK
and CAL_HL_IRQ_WDMA_START_MASK.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c      | 12 ++++++------
 drivers/media/platform/ti-vpe/cal_regs.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 22aa266ffdc6..964dc602f5af 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -453,9 +453,9 @@ void cal_ctx_start(struct cal_ctx *ctx)
 
 	/* Enable IRQ_WDMA_END and IRQ_WDMA_START. */
 	cal_write(ctx->cal, CAL_HL_IRQENABLE_SET(1),
-		  CAL_HL_IRQ_MASK(ctx->dma_ctx));
+		  CAL_HL_IRQ_WDMA_END_MASK(ctx->dma_ctx));
 	cal_write(ctx->cal, CAL_HL_IRQENABLE_SET(2),
-		  CAL_HL_IRQ_MASK(ctx->dma_ctx));
+		  CAL_HL_IRQ_WDMA_START_MASK(ctx->dma_ctx));
 }
 
 void cal_ctx_stop(struct cal_ctx *ctx)
@@ -479,9 +479,9 @@ void cal_ctx_stop(struct cal_ctx *ctx)
 
 	/* Disable IRQ_WDMA_END and IRQ_WDMA_START. */
 	cal_write(ctx->cal, CAL_HL_IRQENABLE_CLR(1),
-		  CAL_HL_IRQ_MASK(ctx->dma_ctx));
+		  CAL_HL_IRQ_WDMA_END_MASK(ctx->dma_ctx));
 	cal_write(ctx->cal, CAL_HL_IRQENABLE_CLR(2),
-		  CAL_HL_IRQ_MASK(ctx->dma_ctx));
+		  CAL_HL_IRQ_WDMA_START_MASK(ctx->dma_ctx));
 
 	ctx->dma.state = CAL_DMA_STOPPED;
 }
@@ -589,7 +589,7 @@ static irqreturn_t cal_irq(int irq_cal, void *data)
 		cal_write(cal, CAL_HL_IRQSTATUS(1), status);
 
 		for (i = 0; i < ARRAY_SIZE(cal->ctx); ++i) {
-			if (status & CAL_HL_IRQ_MASK(i))
+			if (status & CAL_HL_IRQ_WDMA_END_MASK(i))
 				cal_irq_wdma_end(cal->ctx[i]);
 		}
 	}
@@ -603,7 +603,7 @@ static irqreturn_t cal_irq(int irq_cal, void *data)
 		cal_write(cal, CAL_HL_IRQSTATUS(2), status);
 
 		for (i = 0; i < ARRAY_SIZE(cal->ctx); ++i) {
-			if (status & CAL_HL_IRQ_MASK(i))
+			if (status & CAL_HL_IRQ_WDMA_START_MASK(i))
 				cal_irq_wdma_start(cal->ctx[i]);
 		}
 	}
diff --git a/drivers/media/platform/ti-vpe/cal_regs.h b/drivers/media/platform/ti-vpe/cal_regs.h
index bf937919a1e9..94cb4f329cf3 100644
--- a/drivers/media/platform/ti-vpe/cal_regs.h
+++ b/drivers/media/platform/ti-vpe/cal_regs.h
@@ -125,7 +125,8 @@
 #define CAL_HL_IRQ_EOI_LINE_NUMBER_READ0		0
 #define CAL_HL_IRQ_EOI_LINE_NUMBER_EOI0			0
 
-#define CAL_HL_IRQ_MASK(m)			BIT(m)
+#define CAL_HL_IRQ_WDMA_END_MASK(m)		BIT(m)
+#define CAL_HL_IRQ_WDMA_START_MASK(m)		BIT(m)
 
 #define CAL_HL_IRQ_OCPO_ERR_MASK		BIT(6)
 
-- 
2.25.1

