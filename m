Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B37EC4321E
	for <linux-media@archiver.kernel.org>; Tue,  8 Feb 2022 15:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382292AbiBHPu7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382164AbiBHPup (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 8 Feb 2022 10:50:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432BC06174F;
        Tue,  8 Feb 2022 07:50:44 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:b99c:2ebe:5dcf:6513])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0378E11C1;
        Tue,  8 Feb 2022 16:50:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644335437;
        bh=rJEQX4kkWYUdd9ERAXGfu5+E3nfH4kmyCtZUraZgp2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6UA2XuLswMyxTxCoRS5/WI4wngYulbrOEIcG+oOljlZ62D+mmFIFsoO+fIbopRG2
         aqUJUdL32M+fDQYaszeX5S9L98CD9of3K1Lg6LxxqxedB5LFl+tc812d0xGUOH8Q5K
         oOOjbgfBRiZ1RA4pRi7h59zZRUfjYJC72ohLqzZU=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: [PATCH v5 06/11] ARM: dts: bcm2711: Add unicam CSI nodes
Date:   Tue,  8 Feb 2022 16:50:22 +0100
Message-Id: <20220208155027.891055-7-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add both MIPI CSI-2 nodes in the core bcm2711 tree. Use the 3-cells
interrupt declaration, corresponding clocks and default as disabled.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/bcm2711-rpi.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi     | 22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/bcm2711-rpi.dtsi
index ca266c5d9f9b..97ee494891af 100644
--- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm2835-rpi.dtsi"
 
+#include <dt-bindings/power/raspberrypi-power.h>
 #include <dt-bindings/reset/raspberrypi,firmware-reset.h>
 
 / {
@@ -18,6 +19,20 @@ aliases {
 	};
 };
 
+&csi0 {
+	clocks = <&clocks BCM2835_CLOCK_CAM0>,
+		 <&firmware_clocks 4>;
+	clock-names = "lp", "vpu";
+	power-domains = <&power RPI_POWER_DOMAIN_UNICAM0>;
+};
+
+&csi1 {
+	clocks = <&clocks BCM2835_CLOCK_CAM1>,
+		 <&firmware_clocks 4>;
+	clock-names = "lp", "vpu";
+	power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
+};
+
 &firmware {
 	firmware_clocks: clocks {
 		compatible = "raspberrypi,firmware-clocks";
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index dff18fc9a906..21eb10122e50 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -293,6 +293,28 @@ hvs: hvs@7e400000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		csi0: csi@7e800000 {
+			compatible = "brcm,bcm2835-unicam";
+			reg = <0x7e800000 0x800>,
+			      <0x7e802000 0x4>;
+			reg-names = "unicam", "cmi";
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			port {
+			};
+		};
+
+		csi1: csi@7e801000 {
+			compatible = "brcm,bcm2835-unicam";
+			reg = <0x7e801000 0x800>,
+			      <0x7e802004 0x4>;
+			reg-names = "unicam", "cmi";
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			port {
+			};
+		};
+
 		pixelvalve3: pixelvalve@7ec12000 {
 			compatible = "brcm,bcm2711-pixelvalve3";
 			reg = <0x7ec12000 0x100>;
-- 
2.32.0

