Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9519AC636C9
	for <linux-media@archiver.kernel.org>; Mon, 19 Jul 2021 05:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7974161184
	for <linux-media@archiver.kernel.org>; Mon, 19 Jul 2021 05:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhGSFz5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Jul 2021 01:55:57 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:52153 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhGSFz5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Jul 2021 01:55:57 -0400
Received: (Authenticated sender: vrzh@vrzh.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 35BCF240006;
        Mon, 19 Jul 2021 05:52:54 +0000 (UTC)
From:   Martiros Shakhzadyan <vrzh@vrzh.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, Martiros Shakhzadyan <vrzh@vrzh.net>
Subject: [PATCH] media: atomisp: i2c: Remove a superfluous else clause in atomisp-mt9m114.c
Date:   Mon, 19 Jul 2021 01:52:16 -0400
Message-Id: <20210719055216.28508-1-vrzh@vrzh.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove a superfluous clause in mt9m114_s_power()

Signed-off-by: Martiros Shakhzadyan <vrzh@vrzh.net>
---
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
index 11196180a206..a80f1550618b 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
@@ -570,14 +570,13 @@ static int power_down(struct v4l2_subdev *sd)
 
 static int mt9m114_s_power(struct v4l2_subdev *sd, int power)
 {
-	if (power == 0) {
+	if (power == 0)
 		return power_down(sd);
-	} else {
-		if (power_up(sd))
-			return -EINVAL;
 
-		return mt9m114_init_common(sd);
-	}
+	if (power_up(sd))
+		return -EINVAL;
+
+	return mt9m114_init_common(sd);
 }
 
 /*
-- 
2.32.0

