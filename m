Return-Path: <SRS0=HLWw=5J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918C8C54FCF
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 14:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FAA20789
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585059997;
	bh=Iudx1SaPuA77OwushIhw/636atSAbLZx+o4BpBYw51M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3Bv0iyjxMOLSBVTWVbTN0s2iLKaxWaH15u6XXDxZg19RvCnzexDt6q1gQJEOM4xV
	 H2/AdNSjhcaj9EZe4ObWyTccA7oJzRhgWqMO18eDkyTeJbNYy01noeVcJSMkHesa+W
	 FXBi3xgxRkFO5Srknv0N/calOKwvkvD11HEApfDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgCXO0g (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgCXO00 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Mar 2020 10:26:26 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E8021707;
        Tue, 24 Mar 2020 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585059985;
        bh=Iudx1SaPuA77OwushIhw/636atSAbLZx+o4BpBYw51M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjMeGcPx0IEajHJHjjOfA/FlMpSZcIVAs0BNM96Cl0X+19rG0tHIkuPKHzU2LgTh6
         ulBDQyE87Wpat36uLgS0DDnuGoHNGT/9MmTSHMBYf3mawiQujo7a/TW1WbwfkKIASE
         sUgm6DCVM5pMXHRZ9++xplmC0F2wlOMBf7vJyzrU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGkVc-00267S-1c; Tue, 24 Mar 2020 15:26:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 14/20] media: Kconfig: move drivers-specific TTPCI_EEPROM Kconfig var
Date:   Tue, 24 Mar 2020 15:26:15 +0100
Message-Id: <a28d152444549befcd2ec215caf69ffe844ea21d.1585059897.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585059896.git.mchehab+huawei@kernel.org>
References: <cover.1585059896.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This option is used only by av7110 and by an USB driver. As
the av7110 is the first DVB hardware, hardly found those
days, let's opt to place it at usb/Kconfig, as the driver
with needs it might have a longer lifetime.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig     | 8 --------
 drivers/media/usb/Kconfig | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index d6fb8411a8de..54daeba339b7 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -157,14 +157,6 @@ config DVB_CORE
 
 	help
 
-
-
-
-# This Kconfig option is used by both PCI and USB drivers
-config TTPCI_EEPROM
-	tristate
-	depends on I2C
-
 source "drivers/media/dvb-core/Kconfig"
 
 comment "Media drivers"
diff --git a/drivers/media/usb/Kconfig b/drivers/media/usb/Kconfig
index e678d3d11467..bf08393e38d1 100644
--- a/drivers/media/usb/Kconfig
+++ b/drivers/media/usb/Kconfig
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# This Kconfig option is also used by the legacy av7110 driver
+config TTPCI_EEPROM
+	tristate
+	depends on I2C
+
 if USB && MEDIA_SUPPORT
 
 menuconfig MEDIA_USB_SUPPORT
-- 
2.24.1

