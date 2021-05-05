Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733ADC433ED
	for <linux-media@archiver.kernel.org>; Wed,  5 May 2021 20:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF95613C9
	for <linux-media@archiver.kernel.org>; Wed,  5 May 2021 20:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhEEUFB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 5 May 2021 16:05:01 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:46403 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhEEUFA (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 5 May 2021 16:05:00 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d16 with ME
        id 18402500S21Fzsu03841H6; Wed, 05 May 2021 22:04:02 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 05 May 2021 22:04:02 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     prabhakar.csengg@gmail.com, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, bparrot@ti.com,
        hans.verkuil@cisco.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] media: i2c: ov2659: Fix an error message
Date:   Wed,  5 May 2021 22:03:59 +0200
Message-Id: <1ed22753cd773e68e56c78eca01713d781097ffb.1620244953.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

'ret' is known to be 0 here and printing -ENODEV wouldn't be really
helpful.
So, print something that may be helpful instead.

Fixes: c4c0283ab3cd ("[media] media: i2c: add support for omnivision's ov2659 sensor")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/i2c/ov2659.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index 42f64175a6df..96bda172b334 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1368,8 +1368,8 @@ static int ov2659_detect(struct v4l2_subdev *sd)
 		id = OV265X_ID(pid, ver);
 		if (id != OV2659_ID) {
 			dev_err(&client->dev,
-				"Sensor detection failed (%04X, %d)\n",
-				id, ret);
+				"Sensor detection failed (id=%04X, pid=%X, ver=%X)\n",
+				id, (int)pid, (int)ver);
 			ret = -ENODEV;
 		} else {
 			dev_info(&client->dev, "Found OV%04X sensor\n", id);
-- 
2.30.2

