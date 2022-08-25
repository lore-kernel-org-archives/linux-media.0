Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759C6C3F6B0
	for <linux-media@archiver.kernel.org>; Thu, 25 Aug 2022 10:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbiHYKVA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiHYKU4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Aug 2022 06:20:56 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB4E4506E;
        Thu, 25 Aug 2022 03:20:50 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2B506FF807;
        Thu, 25 Aug 2022 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661422849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEL2BOVtRdgmcJofrdddblFhlX9Lkxqbacj6hHCHUqk=;
        b=DbCsD3sMKUhPXj+0SPm+sqKAYUtWy1ygwnDU9M+WXWKA1j7ZjpBgRrnPyBvjtJZvm/R8rC
        ILqcPGBYcH0YTMYgdsRMCCKR12b/Wz+/zofjuD6lPP60RG+IyewPFGKtJP4r4VpGRXWDQY
        sUq2HSjc2+qG4dz9V2YccV5vgMhLP47KIxKxNbLEfC670iK82E53vXJxWO0sZ+rpvv8zHh
        F7tKo/D49NwxVS4EmSH+RvQPD4Y+jLCbqvth7nAPPV6z9LJvf4fnhcU4g2EPOxac0hAgBj
        KmfvT5UOOT0tMPGbBzmzg8CIi1E+un7Czibynxn/NnIgTnwqbxw/J/cOr7l5wQ==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/7] media: sun6i-mipi-csi2: Add a Kconfig dependency on RESET_CONTROLLER
Date:   Thu, 25 Aug 2022 12:20:29 +0200
Message-Id: <20220825102035.419087-2-paul.kocialkowski@bootlin.com>
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

It also selects PHY_SUN6I_MIPI_DPHY, which depends on RESET_CONTROLLER.

Fixes: af54b4f4c17f ("media: sunxi: Add support for the A31 MIPI CSI-2 controller")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig b/drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig
index eb982466abd3..781aedbe1e30 100644
--- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig
+++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig
@@ -3,7 +3,7 @@ config VIDEO_SUN6I_MIPI_CSI2
 	tristate "Allwinner A31 MIPI CSI-2 Controller Driver"
 	depends on V4L_PLATFORM_DRIVERS && VIDEO_DEV
 	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on PM && COMMON_CLK
+	depends on PM && COMMON_CLK && RESET_CONTROLLER
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
-- 
2.37.1

