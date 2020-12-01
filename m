Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC87C63777
	for <linux-media@archiver.kernel.org>; Tue,  1 Dec 2020 00:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D1207F7
	for <linux-media@archiver.kernel.org>; Tue,  1 Dec 2020 00:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgLAARB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLAARA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Nov 2020 19:17:00 -0500
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2905C0613D2
        for <linux-media@vger.kernel.org>; Mon, 30 Nov 2020 16:16:20 -0800 (PST)
Received: from mxback2g.mail.yandex.net (mxback2g.mail.yandex.net [IPv6:2a02:6b8:c03:7aa:0:640:bf5:f41a])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 98A3D50E21DC
        for <linux-media@vger.kernel.org>; Tue,  1 Dec 2020 03:15:33 +0300 (MSK)
Received: from myt5-aad1beefab42.qloud-c.yandex.net (myt5-aad1beefab42.qloud-c.yandex.net [2a02:6b8:c12:128:0:640:aad1:beef])
        by mxback2g.mail.yandex.net (mxback/Yandex) with ESMTP id ZhF32lVIqM-FX9aiPKV;
        Tue, 01 Dec 2020 03:15:33 +0300
Authentication-Results: mxback2g.mail.yandex.net; dkim=pass
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id uqSLeG448m-FXJ8ZM1k;
        Tue, 01 Dec 2020 03:15:33 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   wgh@torlan.ru
To:     linux-media@vger.kernel.org
Cc:     Maxim Plotnikov <wgh@torlan.ru>
Subject: [PATCH] Fix RTL2832 not depending on REGMAP_I2C
Date:   Tue,  1 Dec 2020 03:14:27 +0300
Message-Id: <20201201001426.552329-1-wgh@torlan.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Maxim Plotnikov <wgh@torlan.ru>

Prevents this compile time error:

ERROR: modpost: "__regmap_init_i2c" [drivers/media/dvb-frontends/rtl2832.ko] undefined!

Signed-off-by: Maxim Plotnikov <wgh@torlan.ru>
---
 drivers/media/dvb-frontends/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/Kconfig b/drivers/media/dvb-frontends/Kconfig
index 643b851a6b60..6a1ef277fea4 100644
--- a/drivers/media/dvb-frontends/Kconfig
+++ b/drivers/media/dvb-frontends/Kconfig
@@ -515,7 +515,7 @@ config DVB_RTL2830
 config DVB_RTL2832
 	tristate "Realtek RTL2832 DVB-T"
 	depends on DVB_CORE && I2C && I2C_MUX
-	select REGMAP
+	select REGMAP_I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Say Y when you want to support this frontend.
-- 
2.26.2

