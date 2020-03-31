Return-Path: <SRS0=pkrO=5Q=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACC8C2BA19
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DDE208E4
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585653151;
	bh=UhsHnF2jJLtYQf0kdmp6bSHVJHIP0kxTN77zI7ADI3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O54JOOO41uNn7mLA8hczn+f2M5bS6RNxs0ANz6BRBsrw3zWdX6m6qElkAEoF5shPB
	 WZTPeNqwNLp2EhhBd1fnii+Ij61MwPMTi9SqXybD8koQ+ZnvBBeUCek/CeUUQE4Qq+
	 PQvDg9PjDWsE2AQOzV1ODJbcOyGWeHjifz6poDGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgCaLMP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730582AbgCaLMO (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Mar 2020 07:12:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E58C214DB;
        Tue, 31 Mar 2020 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585653133;
        bh=UhsHnF2jJLtYQf0kdmp6bSHVJHIP0kxTN77zI7ADI3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q86CZz0/7VTaBUV67MKbDKZEdImZYuPdf+DIr5Y3Tum1tEBE//a+fAT1ZqapHxoFb
         sYQSeY6GxKya0Npzr9/J/UWhSxSoWGKKuA7XVoiTddw4ag54o5deHYAEiy6xC6AhJd
         B9g3s5oqgU3MrJ824CkU+vs31pjOMVRMtjqyhhfk=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jJEoV-002bqR-8e; Tue, 31 Mar 2020 13:12:11 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v4 08/33] media: Kconfig: move drivers-specific TTPCI_EEPROM Kconfig var
Date:   Tue, 31 Mar 2020 13:11:44 +0200
Message-Id: <9497a2f33f27b96c0f8cc2322f5cc0d019efc4f6.1585651678.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585651678.git.mchehab+huawei@kernel.org>
References: <cover.1585651678.git.mchehab+huawei@kernel.org>
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
 drivers/media/Kconfig     | 5 -----
 drivers/media/usb/Kconfig | 6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index b35c980dcf56..f37c0c26fa65 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -178,11 +178,6 @@ config DVB_NET
 	  You may want to disable the network support on embedded devices. If
 	  unsure say Y.
 
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
2.25.1

