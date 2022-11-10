Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A967C43217
	for <linux-media@archiver.kernel.org>; Thu, 10 Nov 2022 01:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiKJBg7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Nov 2022 20:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiKJBgz (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 9 Nov 2022 20:36:55 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF231FFBA;
        Wed,  9 Nov 2022 17:36:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VUQ8oH5_1668044209;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VUQ8oH5_1668044209)
          by smtp.aliyun-inc.com;
          Thu, 10 Nov 2022 09:36:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: tc358746: Remove unneeded semicolon
Date:   Thu, 10 Nov 2022 09:36:48 +0800
Message-Id: <20221110013648.85915-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

./drivers/media/i2c/tc358746.c:857:3-4: Unneeded semicolon
./drivers/media/i2c/tc358746.c:861:2-3: Unneeded semicolon

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2832
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/i2c/tc358746.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
index 171309c62bb8..d25a1f2d9ba9 100644
--- a/drivers/media/i2c/tc358746.c
+++ b/drivers/media/i2c/tc358746.c
@@ -854,11 +854,11 @@ static unsigned long tc358746_find_pll_settings(struct tc358746 *tc358746,
 			m_best = mul;
 			min_delta = delta;
 			best_freq = tmp;
-		};
+		}
 
 		if (delta == 0)
 			break;
-	};
+	}
 
 	if (!best_freq) {
 		dev_err(dev, "Failed find PLL frequency\n");
-- 
2.20.1.7.g153144c

