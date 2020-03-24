Return-Path: <SRS0=HLWw=5J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF6C54FCE
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 14:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A3820789
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585059997;
	bh=ck4OjCQbq8LRXFZxql73LnIMALqdecyTNuiDYT5obuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cl+EQwDvNWQOQVeyRxE2zlnN2bInTf0vzsbsqnyK/KV1FRJw322XhgAc5tmbrx2d+
	 NiffbiKq6pKq3TyJ5gEV8viza3fB87x2kEE7kKuHRyoENVgNPR77U32QNC+57e/LRY
	 GzrWhHDNoAqfAc/3cli1gtMpDOnhrv0E9VoZu6+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgCXO0g (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgCXO00 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Mar 2020 10:26:26 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BF1E214D8;
        Tue, 24 Mar 2020 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585059985;
        bh=ck4OjCQbq8LRXFZxql73LnIMALqdecyTNuiDYT5obuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtiEa/pogUigQ/t5Ov2VnFpA/Hc3TUzGt1UwQlDVvRIFKuRKZfDJ+QecYabgXzela
         +ZKYUDlyiavSbyR9dhcmURTJ6NYpDmdgUORhhrdV6CE4OV+nQvMJ6jDP79uTHljcjB
         CRKELxjYybw6z4n24soKAe4twfSfb9UroKHUY0mw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGkVb-002678-Sc; Tue, 24 Mar 2020 15:26:23 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 10/20] media: Kconfig: move CEC-specific options to cec/Kconfig
Date:   Tue, 24 Mar 2020 15:26:11 +0100
Message-Id: <1a8216c3ab6a58cd22b71a55b7ee4221ba4eba91.1585059897.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585059896.git.mchehab+huawei@kernel.org>
References: <cover.1585059896.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There's no need to have the CEC definitions inside the
media Kconfig, as the Kconfig parser doesn't require
symbols to be declared before their usages.

With that, the main Kconfig menu becomes cleaner.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig     |  9 ---------
 drivers/media/cec/Kconfig | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index e372029ac41f..2f4360faed03 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -3,15 +3,6 @@
 # Multimedia device configuration
 #
 
-config CEC_CORE
-	tristate
-
-config CEC_NOTIFIER
-	bool
-
-config CEC_PIN
-	bool
-
 source "drivers/media/rc/Kconfig"
 
 menuconfig MEDIA_SUPPORT
diff --git a/drivers/media/cec/Kconfig b/drivers/media/cec/Kconfig
index c01919713ab9..31417feaa213 100644
--- a/drivers/media/cec/Kconfig
+++ b/drivers/media/cec/Kconfig
@@ -1,4 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config CEC_CORE
+	tristate
+
+config CEC_NOTIFIER
+	bool
+
+config CEC_PIN
+	bool
+
 config MEDIA_CEC_RC
 	bool "HDMI CEC RC integration"
 	depends on CEC_CORE && RC_CORE
-- 
2.24.1

