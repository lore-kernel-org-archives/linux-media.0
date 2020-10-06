Return-Path: <SRS0=ILh3=DN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A11C41604
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 10:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51DB20757
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 10:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJFKoV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 6 Oct 2020 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFKoV (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 6 Oct 2020 06:44:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1904C061755
        for <linux-media@vger.kernel.org>; Tue,  6 Oct 2020 03:44:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 855B829A740
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>, cphealy@gmail.com,
        Benjamin.Bara@skidata.com, l.stach@pengutronix.de,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH 4/6] coda: Clarify interrupt registered name
Date:   Tue,  6 Oct 2020 07:44:12 -0300
Message-Id: <20201006104414.67984-5-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201006104414.67984-1-ezequiel@collabora.com>
References: <20201006104414.67984-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Make interrupt naming more consistent by using a common
pattern for video and jpeg interrupts.

With this commit, interrupts are shown as:

29:          0          0       GPC  12 Level     coda-video
30:          0          0       GPC   3 Level     coda-jpeg

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/platform/coda/coda-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index a72ea4bb37d7..487dd653b24a 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -3153,7 +3153,7 @@ static int coda_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, coda_irq_handler, 0,
-			       dev_name(&pdev->dev), dev);
+			       CODA_NAME "-video", dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
 		return ret;
@@ -3167,7 +3167,7 @@ static int coda_probe(struct platform_device *pdev)
 
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						coda9_jpeg_irq_handler,
-						IRQF_ONESHOT, CODA_NAME " jpeg",
+						IRQF_ONESHOT, CODA_NAME "-jpeg",
 						dev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to request jpeg irq\n");
-- 
2.27.0

