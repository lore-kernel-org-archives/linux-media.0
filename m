Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FF9C28D13
	for <linux-media@archiver.kernel.org>; Thu, 25 Aug 2022 10:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiHYKVY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiHYKVD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Aug 2022 06:21:03 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BBB265F;
        Thu, 25 Aug 2022 03:21:01 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9BBF6FF80E;
        Thu, 25 Aug 2022 10:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661422857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1UOoDEy5ZDDQPj336ZKimMS4BKTdmwc0Nwv/Ux2JaE=;
        b=UnQ36WN7zkebxVJkAdG/u+5h9xp7dA+ESrKFrM1qOcxKcdMjN+zfVzeHSuYPwtYswrPSQE
        cW72gyMyg5gX5dCvjcpJvfDyKx7wUGzI2E/HFN5d80Pd8ki7dAqqGW67o8QWwwbiZAKgOr
        SKS2eysS4oz2LARayqm7x2EXC5KgZLBp+MyVkCCnX0VT2+2Jp/Oi227ErHXihXUgy2fOGk
        7m4qPayoyRjyRbo4eY/IkKVOwm4n4KskO2VmJrPzra2UMEAl6yU5CPPwalVpYCjenGmmnL
        R9JdpLhjgQFpu74if56arghxNgCstQetu91xFd1aY0RtMhi3109ht5JrSZtrLA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 7/7] media: cedrus: Add a Kconfig dependency on RESET_CONTROLLER
Date:   Thu, 25 Aug 2022 12:20:35 +0200
Message-Id: <20220825102035.419087-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220825102035.419087-1-paul.kocialkowski@bootlin.com>
References: <20220825102035.419087-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The driver relies on the reset controller API to work, so add
RESET_CONTROLLER as one of its Kconfig dependencies.

Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/cedrus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/sunxi/cedrus/Kconfig b/drivers/staging/media/sunxi/cedrus/Kconfig
index 21c13f9b6e33..621944f9907a 100644
--- a/drivers/staging/media/sunxi/cedrus/Kconfig
+++ b/drivers/staging/media/sunxi/cedrus/Kconfig
@@ -2,6 +2,7 @@
 config VIDEO_SUNXI_CEDRUS
 	tristate "Allwinner Cedrus VPU driver"
 	depends on VIDEO_DEV
+	depends on RESET_CONTROLLER
 	depends on HAS_DMA
 	depends on OF
 	select MEDIA_CONTROLLER
-- 
2.37.1

