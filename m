Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C97C43334
	for <linux-media@archiver.kernel.org>; Thu, 23 Jun 2022 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiFWHf1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFWHfY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 23 Jun 2022 03:35:24 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C3C46668;
        Thu, 23 Jun 2022 00:35:19 -0700 (PDT)
X-QQ-mid: bizesmtp62t1655969709tyjqs33h
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 15:35:05 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: TfsPcirwf8/sEVhuvLRJZeklJvmdv2Gjplh+PRm9N+zQ1nDnw5+XWBdzG6KUt
        YYTVy9DCLQ+j8HnVpdTWqOWM701y7cmU6MH7D/ErU5ng8s0//XSv2TdBYs/9V8rx4B4OaCS
        ojOsDO2uHcG1zcEbcojBVotgkfYGwv7pRsZqC2l6269ddt0rcZaL/GBnA2OjBpOifC6K9ZC
        YzAd7AvLB0j1hqQRlYvI+cg7WPRM4uACCcH+S0Swg9lWEH32FvLSMc3kkQECkA5RJBoNX/U
        BTfvQ08LbfTxQx+L+nZzP9xhl3IGPEuLv/z7LvvP9OLDJIDkApT0BahcOtNGoKwZXYYSRet
        I2h2c3n1SGe7LaqTZ3+Qt3NVfy2xA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     bparrot@ti.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] media: ti: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 15:35:04 +0800
Message-Id: <20220623073504.17708-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

there is an unexpected word 'a' in the comments that need to be dropped

file - drivers/media/platform/ti/cal/cal-camerarx.c
line - 308

 * DRA80xM TRMs have a a slightly simplified sequence.

changed to:

 * DRA80xM TRMs have a slightly simplified sequence.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/media/platform/ti/cal/cal-camerarx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/cal/cal-camerarx.c b/drivers/media/platform/ti/cal/cal-camerarx.c
index e69fed117fea..a0880f0091f7 100644
--- a/drivers/media/platform/ti/cal/cal-camerarx.c
+++ b/drivers/media/platform/ti/cal/cal-camerarx.c
@@ -305,7 +305,7 @@ static int cal_camerarx_start(struct cal_camerarx *phy)
 	/*
 	 * CSI-2 PHY Link Initialization Sequence, according to the DRA74xP /
 	 * DRA75xP / DRA76xP / DRA77xP TRM. The DRA71x / DRA72x and the AM65x /
-	 * DRA80xM TRMs have a a slightly simplified sequence.
+	 * DRA80xM TRMs have a slightly simplified sequence.
 	 */
 
 	/*
-- 
2.17.1

