Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63187C00140
	for <linux-media@archiver.kernel.org>; Sun, 21 Aug 2022 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiHUPSr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiHUPSq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 21 Aug 2022 11:18:46 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA82C1262F;
        Sun, 21 Aug 2022 08:18:43 -0700 (PDT)
X-QQ-mid: bizesmtp86t1661095069tc954e3m
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:17:47 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: izenvNSMpb3gtRz8+W5DAvZl10fG1gGBitJeiiRFwcysCI39olkCmNxFNcFss
        zK21zWomF2tDfNNk/DyVCVLXGPtGqq9BSQxA6OrVAqaORlIxBHkr3K7nXHro4eNVT04OCcl
        OAuwH9aaBBuZeYeprEnVzNgnBZGFqGMtOfYnYiEDyJrziB7Dt/3JEiH2JDqV1EKXwuAswiG
        Aok4cfvJJcYJSKZSlH34vyXpMCQG9BOkgquCUuWI8rt+0jAIh6DBRNZIY7CBdYwUufLh0IB
        00HjO0qMugdR6dMmhdbUq8V5m+OubbrvTNrq/+jPtjWQi462LR9eyqet40W5o1mbygZy6Rg
        GyaI3KyKlJoIBj6kdCIR5FO8UrSBBuGbBSZ/hzyiG5bqvaCmBs=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] pci/cx18: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:17:41 +0800
Message-Id: <20220821151741.59550-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/pci/cx18/cx18-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-firmware.c b/drivers/media/pci/cx18/cx18-firmware.c
index fdac310d7477..1b038b2802bf 100644
--- a/drivers/media/pci/cx18/cx18-firmware.c
+++ b/drivers/media/pci/cx18/cx18-firmware.c
@@ -248,7 +248,7 @@ void cx18_init_power(struct cx18 *cx, int lowpwr)
 	 *
 	 * Many thanks to Jeff Campbell and Mike Bradley for their extensive
 	 * investigation, experimentation, testing, and suggested solutions of
-	 * of audio/video sync problems with SVideo and CVBS captures.
+	 * audio/video sync problems with SVideo and CVBS captures.
 	 */
 
 	/* the fast clock is at 200/245 MHz */
-- 
2.36.1

