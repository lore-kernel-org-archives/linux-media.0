Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C381C433ED
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 02:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0060161207
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 02:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhDLCiF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 11 Apr 2021 22:38:05 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36947 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbhDLCiF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 11 Apr 2021 22:38:05 -0400
Received: from coplandos.local (cpe-24-194-32-49.nycap.res.rr.com [24.194.32.49])
        (Authenticated sender: vrzh@vrzh.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4B3AA200003;
        Mon, 12 Apr 2021 02:37:46 +0000 (UTC)
From:   Martiros Shakhzadyan <vrzh@vrzh.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Martiros Shakhzadyan <vrzh@vrzh.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] staging: media: atomisp: Minor code style changes
Date:   Sun, 11 Apr 2021 22:35:58 -0400
Message-Id: <20210412023558.360103-4-vrzh@vrzh.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412023558.360103-1-vrzh@vrzh.net>
References: <20210412023558.360103-1-vrzh@vrzh.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixed line continuation and parenthesis alignment issues.

Signed-off-by: Martiros Shakhzadyan <vrzh@vrzh.net>

squashme
---
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
index 912eadaffc44..90a985ee25fa 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
@@ -49,8 +49,8 @@ static int ov2722_read_reg(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	if (data_length != OV2722_8BIT && data_length != OV2722_16BIT
-	    && data_length != OV2722_32BIT) {
+	if (data_length != OV2722_8BIT && data_length != OV2722_16BIT &&
+	    data_length != OV2722_32BIT) {
 		dev_err(&client->dev, "%s error, invalid data length\n",
 			__func__);
 		return -EINVAL;
@@ -212,8 +212,8 @@ static int __ov2722_buf_reg_array(struct i2c_client *client,
 }
 
 static int __ov2722_write_reg_is_consecutive(struct i2c_client *client,
-	struct ov2722_write_ctrl *ctrl,
-	const struct ov2722_reg *next)
+					     struct ov2722_write_ctrl *ctrl,
+					     const struct ov2722_reg *next)
 {
 	if (ctrl->index == 0)
 		return 1;
-- 
2.31.1

