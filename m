Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B02C48BCF
	for <linux-media@archiver.kernel.org>; Sat, 12 Jun 2021 09:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2A261249
	for <linux-media@archiver.kernel.org>; Sat, 12 Jun 2021 09:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhFLJQI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 12 Jun 2021 05:16:08 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:43900 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFLJQH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 12 Jun 2021 05:16:07 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 97BD0BC9B1D; Sat, 12 Jun 2021 11:14:03 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>, Sean Young <sean@mess.org>,
        Gon Solo <gonsolo@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-media@vger.kernel.org
Subject: [PATCH 2/2] media: usb: dvb-usb-v2: af9035: let subdrv autoselect enable si2168 and si2157
Date:   Sat, 12 Jun 2021 11:13:51 +0200
Message-Id: <20210612091351.7169-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210612091351.7169-1-uwe@kleine-koenig.org>
References: <20210612091351.7169-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The Logilink VG0022A DVB-T2 stick has these three devices. So to enable
support for this stick in the presence of MEDIA_SUBDRV_AUTOSELECT,
let DVB_USB_AF9035 select the two other drivers.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/media/usb/dvb-usb-v2/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/Kconfig b/drivers/media/usb/dvb-usb-v2/Kconfig
index 5c75303fba9d..60ca8b9d070b 100644
--- a/drivers/media/usb/dvb-usb-v2/Kconfig
+++ b/drivers/media/usb/dvb-usb-v2/Kconfig
@@ -34,6 +34,8 @@ config DVB_USB_AF9035
 	tristate "Afatech AF9035 DVB-T USB2.0 support"
 	depends on DVB_USB_V2
 	select DVB_AF9033
+	select DVB_SI2168 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_SI2157 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_TUA9001 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_FC0011 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_MXL5007T if MEDIA_SUBDRV_AUTOSELECT
-- 
2.30.2

