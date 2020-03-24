Return-Path: <SRS0=HLWw=5J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C04FC54FCF
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 14:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E7020789
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585059993;
	bh=siNRHVsZSzIvazHmR1WEv2+cQMZrL0G006nOx0Nkxo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pxxraq+xRIcN1l3ZebZPBdsSt8bDPOX9M1nOKPYHwN9UtRecdlNCSGCrBrjXH7/ny
	 I5qslSlE2rZ4yJhZMx0XLKd08dCCbBEXBnQIm0J3dRaScNcDeRvhitthGgG8DPEnEF
	 mard1uU6aGMbLFakqNVRFAIj+Q01kPIuGBdNjKxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgCXO0c (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgCXO00 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Mar 2020 10:26:26 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF19D218AC;
        Tue, 24 Mar 2020 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585059986;
        bh=siNRHVsZSzIvazHmR1WEv2+cQMZrL0G006nOx0Nkxo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8tKfJ1A6co6Qh1YEAA3jDwoogMKcUN8vf2mma/c3wzMnyzgOVheRkO+lO7GTpaae
         9hJ8xqLCDJDGBZdM36xRI5BMi5cdKtmryy6UtFSCStQl8K5DVimyowQzXPUPWBqsjU
         hiITxwMGnKG/nwYwucJH9/Qhj8+kxvEdG789iK3w=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGkVc-00267h-5A; Tue, 24 Mar 2020 15:26:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH v2 17/20] media: Kconfig: mode firewire comment to firewire/Kconfig
Date:   Tue, 24 Mar 2020 15:26:18 +0100
Message-Id: <3ffedfd6d10ff653ebcb5c8c6f72e27e627e446e.1585059897.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585059896.git.mchehab+huawei@kernel.org>
References: <cover.1585059896.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This comment should only be visible if the DVB_FIREDTV
config will show.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig          | 2 --
 drivers/media/firewire/Kconfig | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 7d4088cfe3ef..026a1151273c 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -186,8 +186,6 @@ source "drivers/media/mmc/Kconfig"
 
 endif # MEDIA_EMBEDDED_SUPPORT
 
-comment "FireWire (IEEE 1394) Adapters"
-	depends on DVB_CORE && FIREWIRE
 source "drivers/media/firewire/Kconfig"
 
 comment "Media ancillary drivers (tuners, sensors, i2c, spi, frontends)"
diff --git a/drivers/media/firewire/Kconfig b/drivers/media/firewire/Kconfig
index e7837da5905b..0c1f326f581f 100644
--- a/drivers/media/firewire/Kconfig
+++ b/drivers/media/firewire/Kconfig
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
+if DVB_CORE && FIREWIRE
+comment "FireWire (IEEE 1394) Adapters"
+
 config DVB_FIREDTV
 	tristate "FireDTV and FloppyDTV"
-	depends on DVB_CORE && FIREWIRE
 	help
 	  Support for DVB receivers from Digital Everywhere
 	  which are connected via IEEE 1394 (FireWire).
@@ -18,3 +20,4 @@ config DVB_FIREDTV_INPUT
 	def_bool INPUT = y || (INPUT = m && DVB_FIREDTV = m)
 
 endif # DVB_FIREDTV
+endif # DVB_CORE && FIREWIRE
-- 
2.24.1

