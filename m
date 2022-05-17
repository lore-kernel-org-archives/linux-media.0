Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4F5C433EF
	for <linux-media@archiver.kernel.org>; Tue, 17 May 2022 00:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiEQAd1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 16 May 2022 20:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiEQAdZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 16 May 2022 20:33:25 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BFE2715E;
        Mon, 16 May 2022 17:33:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VDPIy.u_1652747598;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VDPIy.u_1652747598)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 May 2022 08:33:19 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     eugen.hristev@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: atmel: atmel-isc-base: remove unneeded semicolon
Date:   Tue, 17 May 2022 08:33:17 +0800
Message-Id: <20220517003317.122054-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/media/platform/atmel/atmel-isc-base.c:1469:2-3: Unneeded
semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 2f07a50035c8..88308bb9c079 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1466,7 +1466,7 @@ static void isc_awb_work(struct work_struct *w)
 	if (isc->stop) {
 		mutex_unlock(&isc->awb_mutex);
 		return;
-	};
+	}
 
 	isc_update_profile(isc);
 
-- 
2.20.1.7.g153144c

