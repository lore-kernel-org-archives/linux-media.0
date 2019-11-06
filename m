Return-Path: <SRS0=Kl5h=Y6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05751C5DF62
	for <linux-media@archiver.kernel.org>; Wed,  6 Nov 2019 11:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5532077C
	for <linux-media@archiver.kernel.org>; Wed,  6 Nov 2019 11:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfKFLis (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:38:48 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41541 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFLis (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 6 Nov 2019 06:38:48 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iSJeB-000300-09; Wed, 06 Nov 2019 12:38:47 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH] media: coda: drop unused irqlock
Date:   Wed,  6 Nov 2019 12:38:36 +0100
Message-Id: <20191106113836.20518-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The irqlock spinlock has been unused from the start. Remove it.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 2 --
 drivers/media/platform/coda/coda.h        | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 287dc1692286..5a38808c8695 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -2960,8 +2960,6 @@ static int coda_probe(struct platform_device *pdev)
 	else
 		return -EINVAL;
 
-	spin_lock_init(&dev->irqlock);
-
 	dev->dev = &pdev->dev;
 	dev->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(dev->clk_per)) {
diff --git a/drivers/media/platform/coda/coda.h b/drivers/media/platform/coda/coda.h
index 848bf1da401e..9f226140b486 100644
--- a/drivers/media/platform/coda/coda.h
+++ b/drivers/media/platform/coda/coda.h
@@ -86,7 +86,6 @@ struct coda_dev {
 	struct gen_pool		*iram_pool;
 	struct coda_aux_buf	iram;
 
-	spinlock_t		irqlock;
 	struct mutex		dev_mutex;
 	struct mutex		coda_mutex;
 	struct workqueue_struct	*workqueue;
-- 
2.20.1

