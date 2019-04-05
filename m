Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486AAC4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 06:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E8D21871
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 06:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfDEGDy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:03:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40463 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbfDEGDy (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 02:03:54 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hCHwm-00081l-Qg; Fri, 05 Apr 2019 08:03:28 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hCHwh-0003MF-6j; Fri, 05 Apr 2019 08:03:23 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v5 13/13] media: tvp5150: make debug output more readable
Date:   Fri,  5 Apr 2019 08:03:17 +0200
Message-Id: <20190405060317.11240-14-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405060317.11240-1-m.felsch@pengutronix.de>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
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

The debug output for tvp5150_selmux() isn't really intuitive. Register
values are printed decimal formatted and the input/output driver states
are printed as enum. Even more the "normal" output enum mapps to zero so
a active output will printing output=0 and a inactive output=1.

Change this by brinting the register values hex formatted and the states
as more readable string.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/media/i2c/tvp5150.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 6af04db45b7e..469dc7e24ae9 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -302,9 +302,12 @@ static void tvp5150_selmux(struct v4l2_subdev *sd)
 		break;
 	}
 
-	dev_dbg_lvl(sd->dev, 1, debug, "Selecting video route: route input=%i, output=%i => tvp5150 input=%i, opmode=%i\n",
-			decoder->input, decoder->output,
-			input, opmode);
+	dev_dbg_lvl(sd->dev, 1, debug,
+		    "Selecting video route: route input=%s, output=%s => tvp5150 input=0x%02x, opmode=0x%02x\n",
+		    decoder->input == 0 ? "aip1a" :
+		    decoder->input == 2 ? "aip1b" : "svideo",
+		    decoder->output == 0 ? "normal" : "black-frame-gen",
+		    input, opmode);
 
 	regmap_write(decoder->regmap, TVP5150_OP_MODE_CTL, opmode);
 	regmap_write(decoder->regmap, TVP5150_VD_IN_SRC_SEL_1, input);
-- 
2.20.1

