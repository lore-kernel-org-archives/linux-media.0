Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D7EB64DC
	for <linux-media@archiver.kernel.org>; Tue, 18 Jul 2023 01:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGRBCC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Jul 2023 21:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGRBCA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Jul 2023 21:02:00 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F31B5;
        Mon, 17 Jul 2023 18:01:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnfOa4c_1689642114;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VnfOa4c_1689642114)
          by smtp.aliyun-inc.com;
          Tue, 18 Jul 2023 09:01:55 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tomi.valkeinen@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: i2c: No need to set device_driver owner
Date:   Tue, 18 Jul 2023 09:01:54 +0800
Message-Id: <20230718010154.36550-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove .owner field if calls are used which set it automatically.

to silence the warning:
./drivers/media/i2c/ds90ub953.c:1390:3-8: No need to set .owner here.  The core will do it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5902
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/i2c/ds90ub953.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index 1e3827a60029..ce1c6f8b656e 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -1387,7 +1387,6 @@ static struct i2c_driver ds90ub953_driver = {
 	.id_table	= ub953_id,
 	.driver = {
 		.name	= "ds90ub953",
-		.owner = THIS_MODULE,
 		.of_match_table = ub953_dt_ids,
 	},
 };
-- 
2.20.1.7.g153144c

