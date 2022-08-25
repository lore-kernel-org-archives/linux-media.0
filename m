Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91294C04AA5
	for <linux-media@archiver.kernel.org>; Thu, 25 Aug 2022 10:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbiHYKVQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbiHYKU7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Aug 2022 06:20:59 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D2E3F307;
        Thu, 25 Aug 2022 03:20:57 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6603DFF809;
        Thu, 25 Aug 2022 10:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661422856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUoVBIaJKo/ZLxancHW76QbbFMS3ZjWDd/L3u/CxKuo=;
        b=SkRXNIx2prLiOscLF2IpMi4cX05UbYplByo4EkaikesBcjcg7tSVkRmwhNwoZOWq0/4ETv
        U53Ri5H8SgTwKpnrAtvV704j/81wn6ChT1Pql17iEI4imBV8Ts02tESdaC0/pguk7PdOSQ
        +jXDZtuKQvph8imKI6duhMwnAdNzl+DglWfyNOX9K91Cf+wyTRgiv4yXg0Yv5ECFWHIuvh
        kudHV/8h6BJixEHaxeb02vXT4xfx7XUPJz8qxokBIWaQHAHJZguijl00Mrhg7BMVk/McFn
        PyTasPDefA/o9tWHjPpDvRpgl99YA9qCkom2ttc3xsjUA5QnbxNKnxEYn5umAA==
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
Subject: [PATCH v2 6/7] media: sun8i-rotate: Add a Kconfig dependency on RESET_CONTROLLER
Date:   Thu, 25 Aug 2022 12:20:34 +0200
Message-Id: <20220825102035.419087-7-paul.kocialkowski@bootlin.com>
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

Fixes: d77182ada3d4 ("media: sun8i: Add Allwinner A83T Rotate driver")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun8i-rotate/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-rotate/Kconfig b/drivers/media/platform/sunxi/sun8i-rotate/Kconfig
index cfba29072d75..ee2c1f248c64 100644
--- a/drivers/media/platform/sunxi/sun8i-rotate/Kconfig
+++ b/drivers/media/platform/sunxi/sun8i-rotate/Kconfig
@@ -5,7 +5,7 @@ config VIDEO_SUN8I_ROTATE
 	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV
 	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on COMMON_CLK && OF
+	depends on COMMON_CLK && RESET_CONTROLLER && OF
 	depends on PM
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
-- 
2.37.1

