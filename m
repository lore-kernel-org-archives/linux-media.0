Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A05C10DC2
	for <linux-media@archiver.kernel.org>; Fri, 22 Jan 2021 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAE623358
	for <linux-media@archiver.kernel.org>; Fri, 22 Jan 2021 10:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbhAVJ1I (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:27:08 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57302 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbhAVJYn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 22 Jan 2021 04:24:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UMW2N.v_1611307426;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMW2N.v_1611307426)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jan 2021 17:23:56 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] scsi: megaraid_sas: remove redundant NULL check
Date:   Fri, 22 Jan 2021 17:23:44 +0800
Message-Id: <1611307424-109090-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/scsi/megaraid/megaraid_sas_fusion.c:3924:3-8: WARNING: NULL
check before some freeing functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index fd60728..38fc946 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3920,8 +3920,7 @@ static irqreturn_t megasas_isr_fusion(int irq, void *devp)
 {
 	unsigned int i;
 	for (i = 0; i < instance->drv_buf_alloc; i++) {
-		if (instance->crash_buf[i])
-			vfree(instance->crash_buf[i]);
+		vfree(instance->crash_buf[i]);
 	}
 	instance->drv_buf_index = 0;
 	instance->drv_buf_alloc = 0;
-- 
1.8.3.1

