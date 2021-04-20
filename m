Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07DBC43460
	for <linux-media@archiver.kernel.org>; Tue, 20 Apr 2021 12:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE87613BF
	for <linux-media@archiver.kernel.org>; Tue, 20 Apr 2021 12:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhDTMGB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:06:01 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57972 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhDTMF6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 20 Apr 2021 08:05:58 -0400
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDB7E144E;
        Tue, 20 Apr 2021 14:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618920325;
        bh=2ciUNMtWfij4SwRjHgGOhoFPqAz1upnmyC2Vc8DAXYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWM0lFKppzSsJpIRO2mLWGZGzQjcJi4JDeMn2dFUihV7ylIQ/WTtgW2UV+NLss+yB
         aLGT7Y6axVpnC/yojS0W3K/Rw8PQupFPXrd8/rTqxAgKoYNFMMvAjvAhbGqpu7WSB2
         MByTqnA2fCiQpGnA8u8QlI/RVZfeIxt4Oi3qGOj4=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 20/35] media: ti-vpe: cal: add vc and datatype fields to cal_ctx
Date:   Tue, 20 Apr 2021 15:04:18 +0300
Message-Id: <20210420120433.902394-21-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420120433.902394-1-tomi.valkeinen@ideasonboard.com>
References: <20210420120433.902394-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In preparation for supporting multiple virtual channels and datatypes,
add vc and datatype fields to cal_ctx, initialize them to the currently
used values, and use those fields when writing to the register.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c      | 6 ++++--
 drivers/media/platform/ti-vpe/cal.h      | 2 ++
 drivers/media/platform/ti-vpe/cal_regs.h | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 778bef9bbdc4..ba8821a3b262 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -335,8 +335,8 @@ static void cal_ctx_csi2_config(struct cal_ctx *ctx)
 	 *  0x2A: RAW8   1 pixel  = 1 byte
 	 *  0x1E: YUV422 2 pixels = 4 bytes
 	 */
-	cal_set_field(&val, 0x1, CAL_CSI2_CTX_DT_MASK);
-	cal_set_field(&val, 0, CAL_CSI2_CTX_VC_MASK);
+	cal_set_field(&val, ctx->datatype, CAL_CSI2_CTX_DT_MASK);
+	cal_set_field(&val, ctx->vc, CAL_CSI2_CTX_VC_MASK);
 	cal_set_field(&val, ctx->v_fmt.fmt.pix.height, CAL_CSI2_CTX_LINES_MASK);
 	cal_set_field(&val, CAL_CSI2_CTX_ATT_PIX, CAL_CSI2_CTX_ATT_MASK);
 	cal_set_field(&val, CAL_CSI2_CTX_PACK_MODE_LINE,
@@ -927,6 +927,8 @@ static struct cal_ctx *cal_ctx_create(struct cal_dev *cal, int inst)
 	ctx->dma_ctx = inst;
 	ctx->csi2_ctx = inst;
 	ctx->cport = inst;
+	ctx->vc = 0;
+	ctx->datatype = CAL_CSI2_CTX_DT_ANY;
 
 	ret = cal_ctx_v4l2_init(ctx);
 	if (ret)
diff --git a/drivers/media/platform/ti-vpe/cal.h b/drivers/media/platform/ti-vpe/cal.h
index d7cc399f47da..def0c9a3657d 100644
--- a/drivers/media/platform/ti-vpe/cal.h
+++ b/drivers/media/platform/ti-vpe/cal.h
@@ -223,6 +223,8 @@ struct cal_ctx {
 	u8			cport;
 	u8			csi2_ctx;
 	u8			pix_proc;
+	u8			vc;
+	u8			datatype;
 
 	bool			use_pix_proc;
 };
diff --git a/drivers/media/platform/ti-vpe/cal_regs.h b/drivers/media/platform/ti-vpe/cal_regs.h
index 7eeceeeb303e..40e4f972fcb7 100644
--- a/drivers/media/platform/ti-vpe/cal_regs.h
+++ b/drivers/media/platform/ti-vpe/cal_regs.h
@@ -414,6 +414,8 @@
 #define CAL_CSI2_VC_IRQ_ECC_CORRECTION_IRQ_MASK(n)	BIT(5 + ((n) * 8))
 
 #define CAL_CSI2_CTX_DT_MASK		GENMASK(5, 0)
+#define CAL_CSI2_CTX_DT_DISABLED	0
+#define CAL_CSI2_CTX_DT_ANY		1
 #define CAL_CSI2_CTX_VC_MASK		GENMASK(7, 6)
 #define CAL_CSI2_CTX_CPORT_MASK		GENMASK(12, 8)
 #define CAL_CSI2_CTX_ATT_MASK		BIT(13)
-- 
2.25.1

