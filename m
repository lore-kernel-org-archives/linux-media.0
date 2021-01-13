Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48324C43333
	for <linux-media@archiver.kernel.org>; Wed, 13 Jan 2021 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1008E2222B
	for <linux-media@archiver.kernel.org>; Wed, 13 Jan 2021 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbhAMSzp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 13 Jan 2021 13:55:45 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44583 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbhAMSzp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 13 Jan 2021 13:55:45 -0500
X-Originating-IP: 93.61.96.190
Received: from uno.LocalDomain (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 00CBF1C0003;
        Wed, 13 Jan 2021 18:55:00 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hyun Kwon <hyunk@xilinx.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sergei.shtylyov@gmail.com
Subject: [PATCH v7 2/7] fixup! media: i2c: rdacm21: Fix GPIO handling
Date:   Wed, 13 Jan 2021 19:55:00 +0100
Message-Id: <20210113185506.119808-3-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113185506.119808-1-jacopo+renesas@jmondi.org>
References: <20210113185506.119808-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The MAX9271 GPIO line connected to the OV490 RESETB line is
GPIO1, not GPO. As the GPIO1 line is not enabled by default, first
enable it then control the OV490 reset during the MAX9271 configuration
procedure.

Before this change the embedded OV490 ISP was not actually reset.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/rdacm21.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
index f3841369768c..0428e3209463 100644
--- a/drivers/media/i2c/rdacm21.c
+++ b/drivers/media/i2c/rdacm21.c
@@ -425,27 +425,23 @@ static int rdacm21_initialize(struct rdacm21_device *dev)
 	if (ret)
 		return ret;
 
-	ret = max9271_configure_gmsl_link(&dev->serializer);
+	/* Enable GPIO1 and hold OV490 in reset during max9271 configuration. */
+	ret = max9271_enable_gpios(&dev->serializer, MAX9271_GPIO1OUT);
 	if (ret)
 		return ret;
 
-	/* Set GPO high to hold OV490 in reset. */
-	ret = max9271_set_gpios(&dev->serializer, MAX9271_GPO);
+	ret = max9271_clear_gpios(&dev->serializer, MAX9271_GPIO1OUT);
 	if (ret)
 		return ret;
 
-	ret = max9271_set_address(&dev->serializer, dev->addrs[0]);
+	ret = max9271_configure_gmsl_link(&dev->serializer);
 	if (ret)
 		return ret;
-	dev->serializer.client->addr = dev->addrs[0];
 
-	/*
-	 * Release OV490 from reset and program address translation
-	 * before performing OV490 configuration.
-	 */
-	ret = max9271_clear_gpios(&dev->serializer, MAX9271_GPO);
+	ret = max9271_set_address(&dev->serializer, dev->addrs[0]);
 	if (ret)
 		return ret;
+	dev->serializer.client->addr = dev->addrs[0];
 
 	ret = max9271_set_translation(&dev->serializer, dev->addrs[1],
 				      OV490_I2C_ADDRESS);
@@ -453,6 +449,12 @@ static int rdacm21_initialize(struct rdacm21_device *dev)
 		return ret;
 	dev->isp->addr = dev->addrs[1];
 
+	/* Release OV490 from reset and initialize it. */
+	ret = max9271_set_gpios(&dev->serializer, MAX9271_GPIO1OUT);
+	if (ret)
+		return ret;
+	usleep_range(3000, 5000);
+
 	ret = ov490_initialize(dev);
 	if (ret)
 		return ret;
-- 
2.29.2

