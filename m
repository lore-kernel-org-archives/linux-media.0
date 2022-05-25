Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E44CC433F5
	for <linux-media@archiver.kernel.org>; Wed, 25 May 2022 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbiEYTDX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 May 2022 15:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbiEYTDW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 May 2022 15:03:22 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55867DEAA;
        Wed, 25 May 2022 12:03:19 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0264A1C0005;
        Wed, 25 May 2022 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5Ivzqdo/JBA4o+eUAqBDzhn7mSLI4fwx2yKDCnGEbI=;
        b=M+4qOrGs8YMSh+RsBPzKlPlPaH5omGTAsB2WiM+PEgI6vI9mQTRf1WpnFhdJAXlQRdLoL2
        jh6LUn2f5Xd46OGOQdDpBIQu80yKhUs4a45eQWxwO+S/l/LnfBQoH6/DwK4vNl/E8r1ZK9
        m/4jzKoik6V4qLBZ+dcqDWQKCEABp2i8FNFm7YzhZNzft94WU8CIJEDnnNzYi9K9ZlnXF7
        xJCg7/87mftq/36TMuZDQyJcC0c98FU3lrYcMNm6e6S5TgyEtUmJlXCvp+R2pRLvtsXM5g
        QmdVFXbwlFYrmqRuPDpceIy3i/IANB539xy59e6NfD1pdMnRzRZ99Z1Y9Ghofw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 4/6] MAINTAINERS: Add entry for the Allwinner A31 MIPI CSI-2 bridge driver
Date:   Wed, 25 May 2022 21:02:58 +0200
Message-Id: <20220525190300.696269-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190300.696269-1-paul.kocialkowski@bootlin.com>
References: <20220525190300.696269-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add myself as maintainer of the Allwinner A31 MIPI CSI-2 bridge media
driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e22a79ffa4d0..484f47690ea2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -762,6 +762,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
 F:	drivers/media/platform/sunxi/sun4i-csi/
 
+ALLWINNER A31 MIPI CSI-2 BRIDGE DRIVER
+M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml
+F:	drivers/media/platform/sunxi/sun6i-mipi-csi2/
+
 ALLWINNER CPUFREQ DRIVER
 M:	Yangtao Li <tiny.windzz@gmail.com>
 L:	linux-pm@vger.kernel.org
-- 
2.36.1

