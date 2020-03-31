Return-Path: <SRS0=pkrO=5Q=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D3CC2BA80
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BFF214D8
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585653158;
	bh=zg6rBd91deaVKuBg20dIpD31vHBCT3WC5qRTg87Lsc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dx/8Qoxm+Uqg3fq6f3MYRbnpSe/gDFzrsN+QcaEqtfkAkh60GZadEN1vIO6eyyXiD
	 4xJZ120GL8JR8vvvvtXmMqR93Wu4s5dW+kBe8aaLvjcRExqif3Bw6prDpUZsu1lXkB
	 bAfZBx2p4xuac5Nk8xyklC4AjE22jMnQEMn4DZdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgCaLMi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730595AbgCaLMO (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Mar 2020 07:12:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A302166E;
        Tue, 31 Mar 2020 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585653133;
        bh=zg6rBd91deaVKuBg20dIpD31vHBCT3WC5qRTg87Lsc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3ORYg4H0nbEtybN/SBuBcjeivKgZNlZUK/sxN2eQvvt2KmftP3Xce4y8E6LFh1HR
         FNGWrw0dDZhM1+bDvc+EVSZhyQLt8Cc+fSc7DK8vAgO4Q0Vw4wBMfwoGD8TJksKmHu
         qMXiA46KVEEndjR98aVu5jdqLmtDcp9M7aNeqaHs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jJEoV-002bpw-1Q; Tue, 31 Mar 2020 13:12:11 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v4 02/33] media: Kconfig: add an option to filter in/out platform drivers
Date:   Tue, 31 Mar 2020 13:11:38 +0200
Message-Id: <b08314fa734f681e7f808e5b487ec8ba186dd2a0.1585651678.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585651678.git.mchehab+huawei@kernel.org>
References: <cover.1585651678.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Most systems don't need support for those, while others only
need those, instead of the others.

So, add an option to filter in/out platform drivers.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 9dfea5c4b6ab..2b6ea8beb919 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -87,6 +87,18 @@ config MEDIA_CEC_SUPPORT
 	  Say Y when you have an HDMI receiver, transmitter or a USB CEC
 	  adapter that supports HDMI CEC.
 
+config MEDIA_PLATFORM_SUPPORT
+	bool "Platform-specific devices support"
+	help
+	  Enable support for complex cameras, codecs, and other hardware
+	  that are integrated at the CPU, GPU or on Image Signalling Processor
+	  and don't use PCI, USB or Firewire buses.
+
+	  This is found on Embedded hardware (SoC), on V4L2 codecs and
+	  on some GPU and newer CPU chipsets.
+
+	  Say Y when you want to be able so see such devices.
+
 source "drivers/media/cec/Kconfig"
 
 source "drivers/media/mc/Kconfig"
@@ -161,15 +173,14 @@ source "drivers/media/dvb-core/Kconfig"
 
 comment "Media drivers"
 
-#
-# V4L platform/mem2mem drivers
-#
-
 source "drivers/media/usb/Kconfig"
 source "drivers/media/pci/Kconfig"
+source "drivers/media/radio/Kconfig"
+
+if MEDIA_PLATFORM_SUPPORT
 source "drivers/media/platform/Kconfig"
 source "drivers/media/mmc/Kconfig"
-source "drivers/media/radio/Kconfig"
+endif
 
 comment "Supported FireWire (IEEE 1394) Adapters"
 	depends on DVB_CORE && FIREWIRE
-- 
2.25.1

