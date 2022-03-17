Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA3C433F5
	for <linux-media@archiver.kernel.org>; Thu, 17 Mar 2022 01:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbiCQBjG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Mar 2022 21:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbiCQBjF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Mar 2022 21:39:05 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC095B8D;
        Wed, 16 Mar 2022 18:37:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V7PI2DK_1647481060;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V7PI2DK_1647481060)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 09:37:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     patrice.chotard@foss.st.com
Cc:     mchehab@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] media: platform: Remove unused including <linux/version.h>
Date:   Thu, 17 Mar 2022 09:37:38 +0800
Message-Id: <20220317013738.122877-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Eliminate the follow versioncheck warning:

./drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h: 16
linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h
index 5ab7ca448cf9..f8d97841f366 100644
--- a/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h
+++ b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h
@@ -13,7 +13,6 @@
 #include <linux/dvb/dmx.h>
 #include <linux/dvb/frontend.h>
 #include <linux/gpio.h>
-#include <linux/version.h>
 
 #include <media/dmxdev.h>
 #include <media/dvb_demux.h>
-- 
2.20.1.7.g153144c

