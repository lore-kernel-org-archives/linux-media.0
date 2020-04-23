Return-Path: <SRS0=iMag=6H=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A245C54FCB
	for <linux-media@archiver.kernel.org>; Thu, 23 Apr 2020 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C3A20767
	for <linux-media@archiver.kernel.org>; Thu, 23 Apr 2020 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587657825;
	bh=FqIAIjHEHsQ7xRBsV2Y5JCufTJA27s9HlVEIGpXCSmQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ATc7dWSlqyX2ox4PPgs1c4PXtzgMiU8NuONX08b7nyDuGc038e9gbwmIkkYWq2Bkn
	 dLXue32/vX4cMPVAlrY24f6/Q5MrFCyeG2WYzcPVuMk+3n8/lbJSCFWb3MGV6kIDm2
	 w3welLeWT+FFnrkUAzWPv5Vyy3K+OFK9UeLjVXYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgDWQDp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbgDWQDo (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 23 Apr 2020 12:03:44 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A352420724;
        Thu, 23 Apr 2020 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587657823;
        bh=FqIAIjHEHsQ7xRBsV2Y5JCufTJA27s9HlVEIGpXCSmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pmRxV4/U7UlqgYLq6vAPjLL6w+JCxNeTbY/qkugmGFzlMmfyWv2R4gqIatDT44/Qw
         Lpi+ARwUTucJLtGLmXqO7g6AOBgtDvfzyGTiF8jGdRfn+/6OxJJx4x3/uaYT8rg/fZ
         EkHqbjkoRC7dngGklY5QXu7KSlb7eccYllhjBcdg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jReKD-00Eb5S-G8; Thu, 23 Apr 2020 18:03:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] media: Kconfig: fix some dvb-usb-v2 dependencies
Date:   Thu, 23 Apr 2020 18:03:40 +0200
Message-Id: <4e5552b23f9fdfdca008a1ab05725daa471f5a83.1587657818.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There are some tuners used by a few pure DVB boards that use
internally V4L2 function calls. Due to that, such drivers now
depends on v4l2 core support, and can't be auto-selected
if !VIDEO_V4L2:

	WARNING: unmet direct dependencies detected for DVB_RTL2832_SDR
	  Depends on [n]: MEDIA_SUPPORT [=y] && MEDIA_DIGITAL_TV_SUPPORT [=y] && DVB_CORE [=y] && I2C [=y] && I2C_MUX [=y] && VIDEO_V4L2 [=n] && MEDIA_SDR_SUPPORT [=y] && USB [=y]
	  Selected by [y]:
	  - DVB_USB_RTL28XXU [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && I2C [=y] && MEDIA_DIGITAL_TV_SUPPORT [=y] && DVB_USB_V2 [=y] && I2C_MUX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_SDR_SUPPORT [=y]

	WARNING: unmet direct dependencies detected for MEDIA_TUNER_E4000
	  Depends on [n]: (MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y] || MEDIA_RADIO_SUPPORT [=y] || MEDIA_SDR_SUPPORT [=y]) && MEDIA_SUPPORT [=y] && I2C [=y] && VIDEO_V4L2 [=n]
	  Selected by [y]:
	  - DVB_USB_RTL28XXU [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && I2C [=y] && MEDIA_DIGITAL_TV_SUPPORT [=y] && DVB_USB_V2 [=y] && I2C_MUX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y]

	WARNING: unmet direct dependencies detected for MEDIA_TUNER_FC2580
	  Depends on [n]: (MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y] || MEDIA_RADIO_SUPPORT [=y] || MEDIA_SDR_SUPPORT [=y]) && MEDIA_SUPPORT [=y] && I2C [=y] && VIDEO_V4L2 [=n]
	  Selected by [y]:
	  - DVB_USB_RTL28XXU [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && I2C [=y] && MEDIA_DIGITAL_TV_SUPPORT [=y] && DVB_USB_V2 [=y] && I2C_MUX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y]

Detected via randconfig builds.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/Kconfig b/drivers/media/usb/dvb-usb-v2/Kconfig
index ff0ae64424c4..5c75303fba9d 100644
--- a/drivers/media/usb/dvb-usb-v2/Kconfig
+++ b/drivers/media/usb/dvb-usb-v2/Kconfig
@@ -38,7 +38,7 @@ config DVB_USB_AF9035
 	select MEDIA_TUNER_FC0011 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_MXL5007T if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_TDA18218 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_FC2580 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_FC2580 if (MEDIA_SUBDRV_AUTOSELECT && VIDEO_V4L2)
 	select MEDIA_TUNER_IT913X if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Say Y here to support the Afatech AF9035 based DVB USB receiver.
@@ -137,12 +137,12 @@ config DVB_USB_RTL28XXU
 	select DVB_CXD2841ER if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_RTL2830
 	select DVB_RTL2832
-	select DVB_RTL2832_SDR if (MEDIA_SUBDRV_AUTOSELECT && MEDIA_SDR_SUPPORT)
+	select DVB_RTL2832_SDR if (MEDIA_SUBDRV_AUTOSELECT && MEDIA_SDR_SUPPORT && VIDEO_V4L2)
 	select DVB_SI2168 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_E4000 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_E4000 if (MEDIA_SUBDRV_AUTOSELECT && VIDEO_V4L2)
 	select MEDIA_TUNER_FC0012 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_FC0013 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_FC2580 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_FC2580 if (MEDIA_SUBDRV_AUTOSELECT && VIDEO_V4L2)
 	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_MXL5005S if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_QT1010 if MEDIA_SUBDRV_AUTOSELECT
-- 
2.25.2

