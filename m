Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27435C433DB
	for <linux-media@archiver.kernel.org>; Sat,  2 Jan 2021 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCEE224D4
	for <linux-media@archiver.kernel.org>; Sat,  2 Jan 2021 13:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbhABNab (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 2 Jan 2021 08:30:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbhABNaa (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 2 Jan 2021 08:30:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5E1341F41682
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH] media: mt9v111: Remove unneeded device-managed puts
Date:   Sat,  2 Jan 2021 10:29:39 -0300
Message-Id: <20210102132939.148108-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Drivers don't need to explicitly call devm_{}_put on driver
removal, as it's automatically called by the device driver
resource management code.

Fixes: aab7ed1c3927 ("media: i2c: Add driver for Aptina MT9V111")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/i2c/mt9v111.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index 61ae6a0d5679..97c7527b74ed 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -1253,12 +1253,6 @@ static int mt9v111_remove(struct i2c_client *client)
 	mutex_destroy(&mt9v111->pwr_mutex);
 	mutex_destroy(&mt9v111->stream_mutex);
 
-	devm_gpiod_put(mt9v111->dev, mt9v111->oe);
-	devm_gpiod_put(mt9v111->dev, mt9v111->standby);
-	devm_gpiod_put(mt9v111->dev, mt9v111->reset);
-
-	devm_clk_put(mt9v111->dev, mt9v111->clk);
-
 	return 0;
 }
 
-- 
2.29.2

