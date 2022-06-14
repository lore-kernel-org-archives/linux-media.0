Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D70CC43334
	for <linux-media@archiver.kernel.org>; Tue, 14 Jun 2022 19:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbiFNTL6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbiFNTL5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Jun 2022 15:11:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085620BE3
        for <linux-media@vger.kernel.org>; Tue, 14 Jun 2022 12:11:56 -0700 (PDT)
Received: from pyrite.rasen.tech (softbank036240126034.bbtec.net [36.240.126.34])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99047D96;
        Tue, 14 Jun 2022 21:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655233915;
        bh=8Hn75V1y68nA6PNjFyCUT/vHLq089MhAP7Ng3rcz9GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+LNyxOyTQmXenvtvb6txcxZWdDiv0RfDhvaULhowwRffUDMMZbLaP1MNczsJsPY0
         dIU+pspfCe3x4vPN0tGCvLQjtMfoE6Fh/ypHPsUXE+ea6fDcYSkyCtm5JhzdSEMgSO
         RgyxBMIdHymU9qw/ODDi6qtn6cwMTO7qXWBh6N3w=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dafna@fastmail.com, heiko@sntech.de,
        jeanmichel.hautbois@ideasonboard.com, jacopo@jmondi.org,
        djrscally@gmail.com, helen.koike@collabora.com,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 02/55] media: rkisp1: Enable compilation on ARCH_MXC
Date:   Wed, 15 Jun 2022 04:10:34 +0900
Message-Id: <20220614191127.3420492-3-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614191127.3420492-1-paul.elder@ideasonboard.com>
References: <20220614191127.3420492-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The ISP used by the Rockchip RK3399 is also found in the NXP i.MX8MP.
Enable compilation of the driver for the MXC architecture in addition to
ARCH_ROCKCHIP.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/Kconfig b/drivers/media/platform/rockchip/rkisp1/Kconfig
index dabd7e42c193..731c9acbf6ef 100644
--- a/drivers/media/platform/rockchip/rkisp1/Kconfig
+++ b/drivers/media/platform/rockchip/rkisp1/Kconfig
@@ -3,7 +3,7 @@ config VIDEO_ROCKCHIP_ISP1
 	tristate "Rockchip Image Signal Processing v1 Unit driver"
 	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV && OF
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on ARCH_ROCKCHIP || ARCH_MXC || COMPILE_TEST
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_DMA_CONTIG
-- 
2.30.2

