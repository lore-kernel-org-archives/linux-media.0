Return-Path: <SRS0=pkrO=5Q=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6007C2D0EF
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B30720838
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585653158;
	bh=jKk8NJkL8qKsao2SH+PCcYFQbx6OBkK9bW1uRkwhuSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lh9KIpyebgV5h7OWcZl/ANdG/x+yjkpYU19ZFOM69fguRi6d9+UqUJmQWkIrMXzQL
	 J5Slgn1xE4w4KpcgOZ4MpTCw9txYO1JT1ZxTGDqnvvE4AqNn7/O/ziQsUUBE3XiDKP
	 fjT+NGRjg+UoJTCjFRgvZ/qQZygUX+eKev3uLhN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgCaLMO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbgCaLMO (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Mar 2020 07:12:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437A5208E4;
        Tue, 31 Mar 2020 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585653133;
        bh=jKk8NJkL8qKsao2SH+PCcYFQbx6OBkK9bW1uRkwhuSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RX9v4K6s8O3bPf1SnsimzgV/aIk0Q92xTlk+IdgCZb10Ogfj34DGUE4q7gFESVTls
         zTPIRNGhpQIMxHCXOQUAjezzztbBthmo3sMRVDlKMHl3fJaP81aPWnuz1UgLyxkdkc
         rhfEbzZu2zlKrgtdfROzZq3EsDMFsqcZC34c904o=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jJEoV-002bps-0c; Tue, 31 Mar 2020 13:12:11 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v4 01/33] media: dvb-usb: auto-select CYPRESS_FIRMWARE
Date:   Tue, 31 Mar 2020 13:11:37 +0200
Message-Id: <1e1307005abb206a2f0eaa4c593c9810ecf812cf.1585651678.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585651678.git.mchehab+huawei@kernel.org>
References: <cover.1585651678.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

At least some of the supported boards by dvb-usb
driver need to load the cypress firmware, so select
it, as otherwise missing dependencies may popup.

Also, as the cypress firmware load routines are needed
only by the dvb-usb, dvb-usb-v2 and go7007 drivers, and
those all (now) select it, there's no need to ask the
user for manually select it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/common/Kconfig      | 2 +-
 drivers/media/usb/dvb-usb/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/Kconfig b/drivers/media/common/Kconfig
index 1990b7f09454..4ea03b7899a8 100644
--- a/drivers/media/common/Kconfig
+++ b/drivers/media/common/Kconfig
@@ -14,7 +14,7 @@ config VIDEO_TVEEPROM
 	depends on I2C
 
 config CYPRESS_FIRMWARE
-	tristate "Cypress firmware helper routines"
+	tristate
 	depends on USB
 
 source "drivers/media/common/videobuf2/Kconfig"
diff --git a/drivers/media/usb/dvb-usb/Kconfig b/drivers/media/usb/dvb-usb/Kconfig
index 1a3e5f965ae4..42334a02cdce 100644
--- a/drivers/media/usb/dvb-usb/Kconfig
+++ b/drivers/media/usb/dvb-usb/Kconfig
@@ -2,6 +2,7 @@
 config DVB_USB
 	tristate "Support for various USB DVB devices"
 	depends on DVB_CORE && USB && I2C && RC_CORE
+	select CYPRESS_FIRMWARE
 	help
 	  By enabling this you will be able to choose the various supported
 	  USB1.1 and USB2.0 DVB devices.
-- 
2.25.1

