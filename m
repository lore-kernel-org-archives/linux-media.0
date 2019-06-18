Return-Path: <SRS0=dfwv=UR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1534AC46477
	for <linux-media@archiver.kernel.org>; Tue, 18 Jun 2019 11:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B5A2133F
	for <linux-media@archiver.kernel.org>; Tue, 18 Jun 2019 11:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFRL7P (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:59:15 -0400
Received: from retiisi.org.uk ([95.216.213.190]:36888 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbfFRL7P (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Jun 2019 07:59:15 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 17F82634C80;
        Tue, 18 Jun 2019 14:58:49 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 1/2] mt9m111: No need to check for the regulator
Date:   Tue, 18 Jun 2019 14:59:09 +0300
Message-Id: <20190618115910.17272-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618115910.17272-1-sakari.ailus@linux.intel.com>
References: <20190618115910.17272-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The regulator_get() function returns a regulator when it succeeds. There's
no need to check whether the regulator is NULL later on.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/mt9m111.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
index 746d1345b505..bb19f8c346cb 100644
--- a/drivers/media/i2c/mt9m111.c
+++ b/drivers/media/i2c/mt9m111.c
@@ -984,11 +984,9 @@ static int mt9m111_power_on(struct mt9m111 *mt9m111)
 	if (ret < 0)
 		return ret;
 
-	if (mt9m111->regulator) {
-		ret = regulator_enable(mt9m111->regulator);
-		if (ret < 0)
-			return ret;
-	}
+	ret = regulator_enable(mt9m111->regulator);
+	if (ret < 0)
+		return ret;
 
 	ret = mt9m111_resume(mt9m111);
 	if (ret < 0) {
@@ -1002,8 +1000,7 @@ static int mt9m111_power_on(struct mt9m111 *mt9m111)
 static void mt9m111_power_off(struct mt9m111 *mt9m111)
 {
 	mt9m111_suspend(mt9m111);
-	if (mt9m111->regulator)
-		regulator_disable(mt9m111->regulator);
+	regulator_disable(mt9m111->regulator);
 	v4l2_clk_disable(mt9m111->clk);
 }
 
-- 
2.11.0

