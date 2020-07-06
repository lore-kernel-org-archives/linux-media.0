Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA66C433E1
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B799120771
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MYRD1QbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgGFSiY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:38:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45198 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgGFSiX (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:38:23 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5479D6E;
        Mon,  6 Jul 2020 20:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060682;
        bh=42//LZgZHof3s4cKjEUf8LcAlyBYq6+lifz1eG3FG30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYRD1QbVgLXv5e+O6kG3xoobVnnHiElV204twL7XX7btdoUmGLvR/eALwKD5bgOhn
         yhu4rIdSqwxePtN6x9bDKp+4rs3jitCzzizhhzccMFUMdoz57HEn/HIhwxfQ5Cy+Br
         Qry5IZls+7ndug2DbhIYgEpVgTGsqNIWLjy47F78=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 055/108] media: ti-vpe: cal: Add context V4L2 cleanup and unregister functions
Date:   Mon,  6 Jul 2020 21:36:16 +0300
Message-Id: <20200706183709.12238-56-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Create cal_ctx_v4l2_unregister() and cal_ctx_v4l2_cleanup() functions to
unregister and cleanup the V4L2-related objects from the context, and
call them in cal_remove() and in the error path of cal_probe().

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 447ba33c4337..5f218ac5fb60 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1895,6 +1895,11 @@ static int cal_ctx_v4l2_register(struct cal_ctx *ctx)
 	return 0;
 }
 
+static void cal_ctx_v4l2_unregister(struct cal_ctx *ctx)
+{
+	video_unregister_device(&ctx->vdev);
+}
+
 static int cal_ctx_v4l2_init(struct cal_ctx *ctx)
 {
 	struct v4l2_ctrl_handler *hdl = &ctx->ctrl_handler;
@@ -1948,6 +1953,11 @@ static int cal_ctx_v4l2_init(struct cal_ctx *ctx)
 	return 0;
 }
 
+static void cal_ctx_v4l2_cleanup(struct cal_ctx *ctx)
+{
+	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
+}
+
 /* ------------------------------------------------------------------
  *	Initialization and module stuff
  * ------------------------------------------------------------------
@@ -2286,7 +2296,7 @@ static int cal_probe(struct platform_device *pdev)
 		if (ctx) {
 			v4l2_async_notifier_unregister(&ctx->notifier);
 			v4l2_async_notifier_cleanup(&ctx->notifier);
-			v4l2_ctrl_handler_free(&ctx->ctrl_handler);
+			cal_ctx_v4l2_cleanup(ctx);
 		}
 	}
 
@@ -2313,8 +2323,8 @@ static int cal_remove(struct platform_device *pdev)
 			cal_camerarx_disable(ctx->phy);
 			v4l2_async_notifier_unregister(&ctx->notifier);
 			v4l2_async_notifier_cleanup(&ctx->notifier);
-			v4l2_ctrl_handler_free(&ctx->ctrl_handler);
-			video_unregister_device(&ctx->vdev);
+			cal_ctx_v4l2_cleanup(ctx);
+			cal_ctx_v4l2_unregister(ctx);
 		}
 	}
 
-- 
Regards,

Laurent Pinchart

