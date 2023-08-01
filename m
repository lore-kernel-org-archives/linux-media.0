Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41E9C001DE
	for <linux-media@archiver.kernel.org>; Tue,  1 Aug 2023 00:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjHAAzG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 31 Jul 2023 20:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHAAzF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 31 Jul 2023 20:55:05 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D06EE;
        Mon, 31 Jul 2023 17:55:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VoiHKO._1690851300;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VoiHKO._1690851300)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 08:55:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     p.zabel@pengutronix.de, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: coda: Remove duplicated include in coda-common.c
Date:   Tue,  1 Aug 2023 08:54:52 +0800
Message-Id: <20230801005452.79707-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

./drivers/media/platform/chips-media/coda-common.c: linux/of.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6040
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/chips-media/coda-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index 4c7608f1b98d..cc4892129aaf 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -25,7 +25,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/videodev2.h>
-#include <linux/of.h>
 #include <linux/ratelimit.h>
 #include <linux/reset.h>
 
-- 
2.20.1.7.g153144c

