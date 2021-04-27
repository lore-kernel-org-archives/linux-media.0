Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B85C43460
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9EF613B0
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 13:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhD0NVS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Apr 2021 09:21:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48488 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhD0NVS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Apr 2021 09:21:18 -0400
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5EC2845E;
        Tue, 27 Apr 2021 15:20:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1619529633;
        bh=7Iz4caLNEDfByE9lqqkUHl6vWLpQfaR85UOV4GY6zBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTxp2in023vA4mvkcdp3T4fhhZZI0OpgXfGR6GTMhe6O1w7R1r4/UAk5V0kO9KziE
         1B9xbFqMR0JXM4XdssEW4O/0ZSMKuOkHnQtU17WpnzOSNNJ9/0iPNG3GWfS/ehkf6Y
         4Swk0Gk9HFKfBzx5rbH1nNc6DAu7mtPUNzBpBH2w=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     sakari.ailus@linux.intel.com,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 1/4] media: ti-vpe: cal: add embedded data support
Date:   Tue, 27 Apr 2021 16:20:25 +0300
Message-Id: <20210427132028.1005757-2-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427132028.1005757-1-tomi.valkeinen@ideasonboard.com>
References: <20210427132028.1005757-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for capturing embedded data from the sensor. The only
difference with capturing pixel data and embedded data is that we need
to ensure the PIX PROC is disabled for embedded data so that CAL doesn't
repack the data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c | 17 ++++++++++-------
 drivers/media/platform/ti-vpe/cal.h |  1 +
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 62c45add4efe..fcc81024ae18 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -473,14 +473,17 @@ int cal_ctx_prepare(struct cal_ctx *ctx)
 {
 	int ret;
 
-	ret = cal_reserve_pix_proc(ctx->cal);
-	if (ret < 0) {
-		ctx_err(ctx, "Failed to reserve pix proc: %d\n", ret);
-		return ret;
-	}
+	ctx->use_pix_proc = !ctx->fmtinfo->meta;
+
+	if (ctx->use_pix_proc) {
+		ret = cal_reserve_pix_proc(ctx->cal);
+		if (ret < 0) {
+			ctx_err(ctx, "Failed to reserve pix proc: %d\n", ret);
+			return ret;
+		}
 
-	ctx->pix_proc = ret;
-	ctx->use_pix_proc = true;
+		ctx->pix_proc = ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/media/platform/ti-vpe/cal.h b/drivers/media/platform/ti-vpe/cal.h
index 42a3f8004077..29b865d1a238 100644
--- a/drivers/media/platform/ti-vpe/cal.h
+++ b/drivers/media/platform/ti-vpe/cal.h
@@ -88,6 +88,7 @@ struct cal_format_info {
 	u32	code;
 	/* Bits per pixel */
 	u8	bpp;
+	bool	meta;
 };
 
 /* buffer for one video frame */
-- 
2.25.1

