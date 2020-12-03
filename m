Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3A1C4361A
	for <linux-media@archiver.kernel.org>; Thu,  3 Dec 2020 22:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714592231F
	for <linux-media@archiver.kernel.org>; Thu,  3 Dec 2020 22:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLCW3N (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:29:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgLCW3N (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 3 Dec 2020 17:29:13 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: smiapp: avoid printing an uninitialized variable
Date:   Thu,  3 Dec 2020 23:28:16 +0100
Message-Id: <20201203222828.1029943-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is no intialization for the 'reg' variable, so printing
it produces undefined behavior as well as a compile-time warning:

drivers/media/i2c/ccs/ccs-core.c:314:49: error: variable 'reg' is uninitialized when used here [-Werror,-Wuninitialized]
                        "0x%8.8x %s pixels: %d %s (pixelcode %u)\n", reg,

Remove the variable and stop printing it.

Fixes: b24cc2a18c50 ("media: smiapp: Rename as "ccs"")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/ccs/ccs-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 69e7990c65f3..58a42459109d 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -257,7 +257,6 @@ static int ccs_read_frame_fmt(struct ccs_sensor *sensor)
 		u32 pixels;
 		char *which;
 		char *what;
-		u32 reg;
 
 		if (fmt_model_type == CCS_FRAME_FORMAT_MODEL_TYPE_2_BYTE) {
 			desc = CCS_LIM_AT(sensor, FRAME_FORMAT_DESCRIPTOR, i);
@@ -311,7 +310,7 @@ static int ccs_read_frame_fmt(struct ccs_sensor *sensor)
 		}
 
 		dev_dbg(&client->dev,
-			"0x%8.8x %s pixels: %d %s (pixelcode %u)\n", reg,
+			"%s pixels: %d %s (pixelcode %u)\n",
 			what, pixels, which, pixelcode);
 
 		if (i < ncol_desc) {
-- 
2.27.0

