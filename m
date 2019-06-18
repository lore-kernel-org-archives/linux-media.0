Return-Path: <SRS0=dfwv=UR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7BCC31E51
	for <linux-media@archiver.kernel.org>; Tue, 18 Jun 2019 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63102085A
	for <linux-media@archiver.kernel.org>; Tue, 18 Jun 2019 11:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfFRL7Q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:59:16 -0400
Received: from retiisi.org.uk ([95.216.213.190]:36902 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbfFRL7P (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Jun 2019 07:59:15 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id C02F1634C83;
        Tue, 18 Jun 2019 14:58:49 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 2/2] mt9m111: Fix error handling in mt9m111_power_on
Date:   Tue, 18 Jun 2019 14:59:10 +0300
Message-Id: <20190618115910.17272-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618115910.17272-1-sakari.ailus@linux.intel.com>
References: <20190618115910.17272-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The mt9m111_power_on function did not properly clean up whenever it
encountered an error. Do that now.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/mt9m111.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
index bb19f8c346cb..593ebe5e2cb6 100644
--- a/drivers/media/i2c/mt9m111.c
+++ b/drivers/media/i2c/mt9m111.c
@@ -986,13 +986,21 @@ static int mt9m111_power_on(struct mt9m111 *mt9m111)
 
 	ret = regulator_enable(mt9m111->regulator);
 	if (ret < 0)
-		return ret;
+		goto out_clk_disable;
 
 	ret = mt9m111_resume(mt9m111);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to resume the sensor: %d\n", ret);
-		v4l2_clk_disable(mt9m111->clk);
-	}
+	if (ret < 0)
+		goto out_regulator_disable;
+
+	return 0;
+
+out_regulator_disable:
+	regulator_disable(mt9m111->regulator);
+
+out_clk_disable:
+	v4l2_clk_disable(mt9m111->clk);
+
+	dev_err(&client->dev, "Failed to resume the sensor: %d\n", ret);
 
 	return ret;
 }
-- 
2.11.0

