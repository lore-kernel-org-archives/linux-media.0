Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A03C282DA
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF920818
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfDOMok (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:44:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39861 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfDOMoj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 08:44:39 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yM-0000RT-Kf; Mon, 15 Apr 2019 14:44:30 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yH-00025a-2V; Mon, 15 Apr 2019 14:44:25 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v6 09/13] media: tvp5150: add s_power callback
Date:   Mon, 15 Apr 2019 14:44:09 +0200
Message-Id: <20190415124413.18456-10-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415124413.18456-1-m.felsch@pengutronix.de>
References: <20190415124413.18456-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Don't en-/disable the interrupts during s_stream because someone can
disable the stream but wants to get informed if the stream is locked
again. So keep the interrupts enabled the whole time the pipeline is
opened.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/media/i2c/tvp5150.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 305a5e256b31..cd54715eb641 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -1370,11 +1370,26 @@ static const struct media_entity_operations tvp5150_sd_media_ops = {
 /****************************************************************************
 			I2C Command
  ****************************************************************************/
+static int tvp5150_s_power(struct  v4l2_subdev *sd, int on)
+{
+	struct tvp5150 *decoder = to_tvp5150(sd);
+	unsigned int val = 0;
+
+	if (on)
+		val = TVP5150_INT_A_LOCK;
+
+	if (decoder->irq)
+		/* Enable / Disable lock interrupt */
+		regmap_update_bits(decoder->regmap, TVP5150_INT_ENABLE_REG_A,
+				   TVP5150_INT_A_LOCK, val);
+
+	return 0;
+}
 
 static int tvp5150_s_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct tvp5150 *decoder = to_tvp5150(sd);
-	unsigned int mask, val = 0, int_val = 0;
+	unsigned int mask, val = 0;
 
 	mask = TVP5150_MISC_CTL_YCBCR_OE | TVP5150_MISC_CTL_SYNC_OE |
 	       TVP5150_MISC_CTL_CLOCK_OE;
@@ -1387,15 +1402,10 @@ static int tvp5150_s_stream(struct v4l2_subdev *sd, int enable)
 			val = decoder->lock ? decoder->oe : 0;
 		else
 			val = decoder->oe;
-		int_val = TVP5150_INT_A_LOCK;
 		v4l2_subdev_notify_event(&decoder->sd, &tvp5150_ev_fmt);
 	}
 
 	regmap_update_bits(decoder->regmap, TVP5150_MISC_CTL, mask, val);
-	if (decoder->irq)
-		/* Enable / Disable lock interrupt */
-		regmap_update_bits(decoder->regmap, TVP5150_INT_ENABLE_REG_A,
-				   TVP5150_INT_A_LOCK, int_val);
 
 	return 0;
 }
@@ -1586,6 +1596,7 @@ static const struct v4l2_subdev_core_ops tvp5150_core_ops = {
 	.g_register = tvp5150_g_register,
 	.s_register = tvp5150_s_register,
 #endif
+	.s_power = tvp5150_s_power,
 };
 
 static const struct v4l2_subdev_tuner_ops tvp5150_tuner_ops = {
-- 
2.20.1

