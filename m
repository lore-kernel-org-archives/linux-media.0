Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D8BC32772
	for <linux-media@archiver.kernel.org>; Sun, 21 Aug 2022 14:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiHUOyz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUOyy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 21 Aug 2022 10:54:54 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003D21E0D;
        Sun, 21 Aug 2022 07:54:52 -0700 (PDT)
X-QQ-mid: bizesmtp91t1661093683tx8quu73
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 22:54:42 +0800 (CST)
X-QQ-SSF: 0100000000200010B000B00A0000000
X-QQ-FEAT: znfcQSa1hKZ0Yesz+Y0nzrTlyQIlNzPRrsb7imz5Gf0de75kiEEP0mP9xUKZF
        kP31R4e5NO1Hnz5mTMxqh13hdNlDtSP6jF2C0juv2sV6CUrC0CmedCK7o0tfSOjwTsMSuXy
        ITbsqJFbQ2Jj/GKQFrnWmZL9U6UBe2fXODjIh2jevYah+guHew0zczf1pYkD5kAZOxs2Yd2
        45P24BR4+H6w0MwQVfEy+XQY5eqfr9QbzLfhDqJAsejM8jp2RTd/KKUWiPjaUohL0yeQSPH
        6VIcrDh2gkgvTNsVPf4zekW8YOmQHMDy5zrk/STiygh67pz/vRdIoNZvm0qazRl5h9+enGu
        TacsjCVwy4RsLVdt1AjBXo4PqkIZPuRjoQ3yzqh
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jacopo@jmondi.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] platform/renesas: fix repeated words in comments
Date:   Sun, 21 Aug 2022 22:54:35 +0800
Message-Id: <20220821145435.49842-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

 Delete the redundant word 'on'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/platform/renesas/renesas-ceu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/renesas-ceu.c b/drivers/media/platform/renesas/renesas-ceu.c
index f70f91b006b7..69723b51e4dc 100644
--- a/drivers/media/platform/renesas/renesas-ceu.c
+++ b/drivers/media/platform/renesas/renesas-ceu.c
@@ -1101,7 +1101,7 @@ static int ceu_open(struct file *file)
 		return ret;
 
 	mutex_lock(&ceudev->mlock);
-	/* Causes soft-reset and sensor power on on first open */
+	/* Causes soft-reset and sensor power on first open */
 	ret = pm_runtime_resume_and_get(ceudev->dev);
 	mutex_unlock(&ceudev->mlock);
 
-- 
2.36.1

