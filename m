Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891EFC63799
	for <linux-media@archiver.kernel.org>; Thu, 22 Jul 2021 09:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C30861001
	for <linux-media@archiver.kernel.org>; Thu, 22 Jul 2021 09:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhGVIbe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:31:34 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:55103 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhGVIbb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 22 Jul 2021 04:31:31 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id DE5D8200011;
        Thu, 22 Jul 2021 09:12:03 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/8] media: i2c: rdacm20: Re-program chip address earlier
Date:   Thu, 22 Jul 2021 11:12:35 +0200
Message-Id: <20210722091239.26451-5-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722091239.26451-1-jacopo+renesas@jmondi.org>
References: <20210722091239.26451-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The current implementation of the camera module initialization
re-programs the chip address during the post-registration phase, once
the reverse channel amplitude has been compensated. While this guarantees
more reliable communications, reprogramming the chip address at probe()
time guarantees that the embedded MCU cannot over-write the settings
programmed by the driver.

Re-program the chip address at probe() time, to avoid conflicts on the
i2c bus due to messages sent by the embedded MCU to the default chip
address which render capture operations unstable.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/rdacm20.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
index ba956733aa89..eb0e3dc22cc3 100644
--- a/drivers/media/i2c/rdacm20.c
+++ b/drivers/media/i2c/rdacm20.c
@@ -462,11 +462,6 @@ static int rdacm20_post_register(struct v4l2_subdev *sd)
 	if (ret < 0)
 		return ret;
 
-	ret = max9271_set_address(&dev->serializer, dev->addrs[0]);
-	if (ret < 0)
-		return ret;
-	dev->serializer.client->addr = dev->addrs[0];
-
 	/*
 	 * Release ov10635 from reset and initialize it. The image sensor
 	 * requires at least 2048 XVCLK cycles (85 micro-seconds at 24MHz)
@@ -562,6 +557,11 @@ static int rdacm20_initialize(struct rdacm20_device *dev)
 	if (ret)
 		return ret;
 
+	ret = max9271_set_address(&dev->serializer, dev->addrs[0]);
+	if (ret < 0)
+		return ret;
+	dev->serializer.client->addr = dev->addrs[0];
+
 	/*
 	 * Set reverse channel high threshold to increase noise immunity.
 	 *
-- 
2.32.0

