Return-Path: <SRS0=fNsq=6B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50475C2BB1D
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 07:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EC9214D8
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587108134;
	bh=ZA93l+zYHiQ7bZgsriObhVutzGbjKcNYI8EuplXFcGk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=h6IAfFs1nft4km/BMMM2wrUWy64QIMBHJKunIf9SuznC/5jIGErIEkf5TKgs2pOEU
	 DmWoE9U6Y/L361dSs8HYCaacZRRdOxkDRwVUD7VkPN5fVBVnfQ6O1j/DHWOganO3yB
	 QChNow3a355LGKEkBKZSE2Cl9o6JICqu8XK3WK+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgDQHWN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgDQHWN (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 17 Apr 2020 03:22:13 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F872083E;
        Fri, 17 Apr 2020 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587108132;
        bh=ZA93l+zYHiQ7bZgsriObhVutzGbjKcNYI8EuplXFcGk=;
        h=From:To:Cc:Subject:Date:From;
        b=Tzx+/hFbdWXdYbs5HHtweksGxGDtb4soIFSabyfcODQmItZuZkdlIU5sDAH2BqY4x
         k7elVV1fRDBY5uWS6nrbWGMoPfPCM0nG8nm7QuGbwEjLOH2g+F5IhlAtLtJr/gWf5+
         Tj/Sy56l6Pb53SQQgBfQLEKtJH/AyTLXD1P6OG+o=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jPLKE-007nuy-KJ; Fri, 17 Apr 2020 09:22:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stefan Agner <stefan@agner.ch>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] media: dvb-frontends: DUMMY_FE should depends on DVB_CORE
Date:   Fri, 17 Apr 2020 09:22:09 +0200
Message-Id: <ceab3ac1e60d70afb4e25147d60817c513f235f7.1587108125.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Using select for DVB_CORE doesn't work, as reported by
Randy:

	CONFIG_I2C=m
	CONFIG_DVB_CORE=y

	ld: drivers/media/dvb-core/dvbdev.o: in function `dvb_module_probe':
	dvbdev.c:(.text+0xf92): undefined reference to `i2c_new_client_device'
	ld: dvbdev.c:(.text+0xffb): undefined reference to `i2c_unregister_device'
	ld: drivers/media/dvb-core/dvbdev.o: in function `dvb_module_release':
	dvbdev.c:(.text+0x107d): undefined reference to `i2c_unregister_device'

The problem is actually caused by the dummy frontend driver,
which uses select, and it is missing an I2C dependency:

	WARNING: unmet direct dependencies detected for DVB_CORE
	  Depends on [m]: MEDIA_SUPPORT [=y] && MEDIA_DIGITAL_TV_SUPPORT [=y] && (I2C [=m] || I2C [=m]=n)
	  Selected by [y]:
	  - DVB_DUMMY_FE [=y] && MEDIA_SUPPORT [=y] && MEDIA_TEST_SUPPORT [=y]

As this is the only frontend driver using "select DVB_CORE",
change it do depends on DVB_CORE.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/dvb-frontends/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/Kconfig b/drivers/media/dvb-frontends/Kconfig
index fbadba9b328e..643b851a6b60 100644
--- a/drivers/media/dvb-frontends/Kconfig
+++ b/drivers/media/dvb-frontends/Kconfig
@@ -956,7 +956,6 @@ comment "Tools to develop new frontends"
 
 config DVB_DUMMY_FE
 	tristate "Dummy frontend driver"
-	depends on MEDIA_TEST_SUPPORT
-	select DVB_CORE
+	depends on MEDIA_TEST_SUPPORT && DVB_CORE
 	help
 	  Dummy skeleton frontend driver.
-- 
2.25.2

