Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08033C4332B
	for <linux-media@archiver.kernel.org>; Tue, 16 Feb 2021 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB49F64E76
	for <linux-media@archiver.kernel.org>; Tue, 16 Feb 2021 17:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhBPRmU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:42:20 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:57977 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhBPRmQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Feb 2021 12:42:16 -0500
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 92D4720000C;
        Tue, 16 Feb 2021 17:41:33 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] media: i2c: rdacm20: Report camera module name
Date:   Tue, 16 Feb 2021 18:41:34 +0100
Message-Id: <20210216174146.106639-5-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216174146.106639-1-jacopo+renesas@jmondi.org>
References: <20210216174146.106639-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When the device is identified the driver currently reports the
names of the chips embedded in the camera module.

Report the name of the camera module itself instead.
Cosmetic change only.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/rdacm20.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
index 6504ed0bd3bc..56406d82b5ac 100644
--- a/drivers/media/i2c/rdacm20.c
+++ b/drivers/media/i2c/rdacm20.c
@@ -532,7 +532,7 @@ static int rdacm20_initialize(struct rdacm20_device *dev)
 	if (ret)
 		return ret;
 
-	dev_info(dev->dev, "Identified MAX9271 + OV10635 device\n");
+	dev_info(dev->dev, "Identified RDACM20 camera module\n");
 
 	/*
 	 * Set reverse channel high threshold to increase noise immunity.
-- 
2.30.0

