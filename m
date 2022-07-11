Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE0CCA47B
	for <linux-media@archiver.kernel.org>; Mon, 11 Jul 2022 12:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiGKMot (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiGKMoZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEB121267
        for <linux-media@vger.kernel.org>; Mon, 11 Jul 2022 05:44:20 -0700 (PDT)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32C1B1ACA;
        Mon, 11 Jul 2022 14:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657543413;
        bh=Mwkj3xI3t+j/kROPqx0pfNIcza44hw1NcvJdaI1/K6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaO7JGiIV89J60VLli5ZmyK/0cLcNbQHG+mGrTqIwcuJhDVYH1iYPuItFMeCCfVsl
         yIHWzRI5GM+0oB8IaG7WQMst2R3NfXzRnFuwJ06Hlu00qFQLpeIMkrATcHtVdARHLl
         0L9AEnj0seHYVEbwjgQgQqoBbh9xpr9bUR7oPnNM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: [PATCH v3 23/46] media: rkisp1: csi: Move start delay to rkisp1_csi_start()
Date:   Mon, 11 Jul 2022 15:42:25 +0300
Message-Id: <20220711124248.2683-24-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711124248.2683-1-laurent.pinchart@ideasonboard.com>
References: <20220711124248.2683-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The delay in rkisp1_isp_start() is related to the CSI-2 receiver and
the camera sensor. Move it where it belongs, to rkisp1_csi_start().

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Dafna Hirschfeld <dafna@fastmail.com>
---
Changes since v1:

- Fix typo in commit message
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c | 7 +++++++
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
index 102deb877aa4..749ad473b877 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-mipi-dphy.h>
@@ -121,6 +122,12 @@ int rkisp1_csi_start(struct rkisp1_csi *csi,
 
 	rkisp1_csi_enable(csi);
 
+	/*
+	 * CIF spec says to wait for sufficient time after enabling
+	 * the MIPI interface and before starting the sensor output.
+	 */
+	usleep_range(1000, 1200);
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index d2343f166f42..da895f6aa3fa 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -365,12 +365,6 @@ static void rkisp1_isp_start(struct rkisp1_device *rkisp1)
 	       RKISP1_CIF_ISP_CTRL_ISP_ENABLE |
 	       RKISP1_CIF_ISP_CTRL_ISP_INFORM_ENABLE;
 	rkisp1_write(rkisp1, RKISP1_CIF_ISP_CTRL, val);
-
-	/*
-	 * CIF spec says to wait for sufficient time after enabling
-	 * the MIPI interface and before starting the sensor output.
-	 */
-	usleep_range(1000, 1200);
 }
 
 /* ----------------------------------------------------------------------------
-- 
Regards,

Laurent Pinchart

