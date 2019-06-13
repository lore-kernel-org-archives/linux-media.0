Return-Path: <SRS0=gKyG=UM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0769C31E45
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7516721473
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbfFMPSj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:39 -0400
Received: from retiisi.org.uk ([95.216.213.190]:51214 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732152AbfFMNEJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 13 Jun 2019 09:04:09 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id C9F78634C7F;
        Thu, 13 Jun 2019 16:04:03 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl
Subject: [PATCH 2/2] ov9640: Don't check for NULL on devm_gpiod_get return values
Date:   Thu, 13 Jun 2019 16:04:00 +0300
Message-Id: <20190613130400.6388-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190613130400.6388-1-sakari.ailus@linux.intel.com>
References: <20190613130400.6388-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

devm_gpiod_get never returns NULL; therefore it's not necessary to check
for that. PTR_ERR(NULL) also yields zero, which is confusing to smatch.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ov9640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov9640.c b/drivers/media/i2c/ov9640.c
index d6831f28378b..482609665305 100644
--- a/drivers/media/i2c/ov9640.c
+++ b/drivers/media/i2c/ov9640.c
@@ -691,14 +691,14 @@ static int ov9640_probe(struct i2c_client *client,
 
 	priv->gpio_power = devm_gpiod_get(&client->dev, "Camera power",
 					  GPIOD_OUT_LOW);
-	if (IS_ERR_OR_NULL(priv->gpio_power)) {
+	if (IS_ERR(priv->gpio_power)) {
 		ret = PTR_ERR(priv->gpio_power);
 		return ret;
 	}
 
 	priv->gpio_reset = devm_gpiod_get(&client->dev, "Camera reset",
 					  GPIOD_OUT_HIGH);
-	if (IS_ERR_OR_NULL(priv->gpio_reset)) {
+	if (IS_ERR(priv->gpio_reset)) {
 		ret = PTR_ERR(priv->gpio_reset);
 		return ret;
 	}
-- 
2.11.0

