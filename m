Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4EC28D13
	for <linux-media@archiver.kernel.org>; Thu, 25 Aug 2022 10:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbiHYKVK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiHYKU6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Aug 2022 06:20:58 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1B14B0CB;
        Thu, 25 Aug 2022 03:20:55 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5D842FF80C;
        Thu, 25 Aug 2022 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661422854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCCDEzVwTVLtlf8o0a9/64+Fmuo4aKGTefSUM+dGm4U=;
        b=EK/EVpMCJyxbuQzGfxLcMXkr63cSaM7tEAbUDfv7fZcmEnwyrPA4xQyci+0duWUT+se7Zr
        YZfwBkQPoZRwreX1Qrn4hm+qlMbb/Ju4cyn5Xo8SkRdqzqj85/qsLS2wiV++v0/DHad/Yi
        uKJTuAKKOx1gwBuiLxYAkj4Bmin9gW562cYFWw2XohGuHHXtXTGSo9VFkla/HlKS5Ujx+w
        4OOZrg3ELWRMLuIHNj9/RAmQ36lHIaUHS8xB77ugHgk1GiMoFbOYHA+Kh4npuwJBA/+PjF
        IcAGp5UxErtbjUAMkzg6hr1+padjGSc8RxRRNpBfm3Kf5BDoKQnk2xKT6JA4LQ==
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
Subject: [PATCH v2 4/7] media: sun4i-csi: Add a Kconfig dependency on RESET_CONTROLLER
Date:   Thu, 25 Aug 2022 12:20:32 +0200
Message-Id: <20220825102035.419087-5-paul.kocialkowski@bootlin.com>
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

Fixes: 577bbf23b758 ("media: sunxi: Add A10 CSI driver")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun4i-csi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun4i-csi/Kconfig b/drivers/media/platform/sunxi/sun4i-csi/Kconfig
index 7960e6836f41..60610c04d6a7 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun4i-csi/Kconfig
@@ -3,7 +3,7 @@
 config VIDEO_SUN4I_CSI
 	tristate "Allwinner A10 CMOS Sensor Interface Support"
 	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && COMMON_CLK  && HAS_DMA
+	depends on VIDEO_DEV && COMMON_CLK && RESET_CONTROLLER && HAS_DMA
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
-- 
2.37.1

