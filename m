Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C046C433FE
	for <linux-media@archiver.kernel.org>; Fri, 15 Apr 2022 15:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354701AbiDOPdK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Apr 2022 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355301AbiDOPbj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Apr 2022 11:31:39 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8056ED5EB7;
        Fri, 15 Apr 2022 08:28:52 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0C94DE000E;
        Fri, 15 Apr 2022 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9Ap9R8Xf7QreTWyG4D1iTf1/X33AGyrJspYSP6S+lI=;
        b=Tx9c/13XW8tHwZzqAclVW4p0LyvC+TyFcnfIJ3WpIapVq4exOqWvmm11p8nliUONdk17cO
        RUwbztmtZdDDliHHpqs8b1w3NqdREqo099YaaiUvabKDAFLVQ7ZZfnyN0UQ9FWBiPGcJBJ
        ltXRGJ4D5/jPICWP9yWo5+yD/C58NaWCihF9lfGMzckWJhB2RVAqXHQDcAcfQ61bYclJbM
        SE2h/LVoJDRq1dyKoGkORZKnGc28w0ONSBKyc8HSmzDaVevxovkja3uwLwjbpyXV2SShZS
        3Y083iYIOIKSOjnxOm+m0xuROR1XN4d5r+bmHxMSO73zPnclUgZb6ImgmoAxVw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 27/45] media: sun6i-csi: Add bridge dimensions and format helpers
Date:   Fri, 15 Apr 2022 17:27:53 +0200
Message-Id: <20220415152811.636419-28-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Introduce new helpers to ease getting information about the bridge.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 20 +++++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index bba825db8322..0c1e159537a7 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -12,6 +12,26 @@
 #include "sun6i_csi.h"
 #include "sun6i_csi_bridge.h"
 
+/* Helpers */
+
+void sun6i_csi_bridge_dimensions(struct sun6i_csi_device *csi_dev,
+				 unsigned int *width, unsigned int *height)
+{
+	if (width)
+		*width = csi_dev->bridge.mbus_format.width;
+	if (height)
+		*height = csi_dev->bridge.mbus_format.height;
+}
+
+void sun6i_csi_bridge_format(struct sun6i_csi_device *csi_dev,
+			     u32 *mbus_code, u32 *field)
+{
+	if (mbus_code)
+		*mbus_code = csi_dev->bridge.mbus_format.code;
+	if (field)
+		*field = csi_dev->bridge.mbus_format.field;
+}
+
 /* Format */
 
 static const u32 sun6i_csi_bridge_mbus_codes[] = {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
index f9bf87bf3667..5e6448aa522f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
@@ -41,6 +41,13 @@ struct sun6i_csi_bridge {
 	struct sun6i_csi_bridge_source	source_parallel;
 };
 
+/* Helpers */
+
+void sun6i_csi_bridge_dimensions(struct sun6i_csi_device *csi_dev,
+				 unsigned int *width, unsigned int *height);
+void sun6i_csi_bridge_format(struct sun6i_csi_device *csi_dev,
+			     u32 *mbus_code, u32 *field);
+
 /* Bridge */
 
 int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev);
-- 
2.35.2

