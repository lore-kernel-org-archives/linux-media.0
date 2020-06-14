Return-Path: <SRS0=EymB=74=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F07C433DF
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6CE20747
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="buqZaXcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFOAAZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:00:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33340 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFOAAX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 20:00:23 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F1C4CF9;
        Mon, 15 Jun 2020 02:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592179215;
        bh=HjSGDvwY84i5xGsk9zG943CrLETOGMwEznwbV5pYqj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buqZaXcSawpmcJU4McrxOvPFhMvrTg4414H1ycLHuXe30QZkyl6Fk/zYPt/jUlHfL
         I5R6gumGmNaf3r/bXA0V/KRFAPYqKnYkdM6IwA+ktaJGTzYSZasTHYKTM876kw4fZW
         Ru+jF6Ij0U1ZpYbHVkb0G5VVJEJWJnd87vL57Sow=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v1 011/107] media: ti-vpe: cal: Remove needless casts
Date:   Mon, 15 Jun 2020 02:58:08 +0300
Message-Id: <20200614235944.17716-12-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
References: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Casting from a void pointer to a struct pointer doesn't require a cast.
Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 6728bac36f3c..34817f8d81b5 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1205,7 +1205,7 @@ static inline void cal_process_buffer_complete(struct cal_ctx *ctx)
 
 static irqreturn_t cal_irq(int irq_cal, void *data)
 {
-	struct cal_dev *dev = (struct cal_dev *)data;
+	struct cal_dev *dev = data;
 	struct cal_ctx *ctx;
 	struct cal_dmaqueue *dma_q;
 	unsigned int i;
@@ -2399,8 +2399,7 @@ static int cal_probe(struct platform_device *pdev)
 
 static int cal_remove(struct platform_device *pdev)
 {
-	struct cal_dev *dev =
-		(struct cal_dev *)platform_get_drvdata(pdev);
+	struct cal_dev *dev = platform_get_drvdata(pdev);
 	struct cal_ctx *ctx;
 	int i;
 
-- 
Regards,

Laurent Pinchart

