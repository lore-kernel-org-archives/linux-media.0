Return-Path: <SRS0=pkrO=5Q=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B737AC43331
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 07:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BBD20748
	for <linux-media@archiver.kernel.org>; Tue, 31 Mar 2020 07:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRfKyd16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgCaH5R (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:57:17 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33954 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgCaH5R (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Mar 2020 03:57:17 -0400
Received: by mail-vk1-f195.google.com with SMTP id p123so5464819vkg.1
        for <linux-media@vger.kernel.org>; Tue, 31 Mar 2020 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YxByS9x69a2lizrLMXtDD6SrVkWtI4fIU2NtmhLAs4w=;
        b=cRfKyd1670hMn9KOmS8R3ScqPt1kv/lrvgbzLkjcvn9HNvJ4CCqkPYK8ps7L3YSoGE
         yaVOFLurTc6JxgxbzDdpvv1hM5vfazIXZB2rFyGAj4E8oaC07Fxv0aQ1O8LC5ON7P4oD
         zypZtIwcBnwSNr/DTqIzenAGTegph3WHD3MyXXuhNBTUBChZwpHjQ+js93uug+es6RP8
         vH1EFghBcQWp6aHap4KvcHwDOAfkvwVTAU6JObqPLqg2PkDPstZys4FrguHnazHeuV2V
         v5Lk0zKfBXyZ6IFC+/L3/oYVlZJ5UL1BvWLVNpIf1WuYFHa50aq8p2uFHad8KO1x1sic
         3kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YxByS9x69a2lizrLMXtDD6SrVkWtI4fIU2NtmhLAs4w=;
        b=EtX+TzOhETDs20WgiAXmyhblejScamUI1Wr/0tcCZoW4Goa6MVKCf49Yf5CuBRYbmT
         j8aBEf1izJGmxqe62yraH01TYzbVs8SUX1cX8WurtXmlsefhUrnnAYnxvpZMEiy964xL
         t2FuLVazaZ22yOlJe8xhTzP41AAa7FeChORDu86fxIGBzpTNwbFHDyCaN+gMdA3SBjL+
         GJzZCeUGUelIv+OexICNfgGALwwRcdKeois1RF04gCj72CnUbdK0sxIistm0+adRk/n3
         DFryd6qePR7dp7kO9qhER4y4tjGPfbnV3FqBrBVRtsLbehL9X5wvU1PuImUtJUNj8dpW
         9J3g==
X-Gm-Message-State: AGi0PuYoLgLTBgIyGfpfWYPkGabQzDIwp9QbUlCOq9VVBq0uXV8O5MpA
        sBypVbtuiNPdwZKssYzjbqd2aXXw8W5ZXvmtKQCJ+CUr
X-Google-Smtp-Source: APiQypIXzqBPy/RWI8u67/BepL+hPk2FrWOXVFAwTzyCEP++UUmPNUhcZwPZtiBiSgDAWAHTSCgiQ8NbO9MuZvqBdYY=
X-Received: by 2002:a1f:1255:: with SMTP id 82mr10851433vks.80.1585641436448;
 Tue, 31 Mar 2020 00:57:16 -0700 (PDT)
MIME-Version: 1.0
From:   karthik poduval <karthik.poduval@gmail.com>
Date:   Tue, 31 Mar 2020 00:57:05 -0700
Message-ID: <CAFP0Ok_3yTv9QWAykvBk3yLgbThycVPdx0taU9F1Wo_WTnVjyA@mail.gmail.com>
Subject: [PATCH 4/4] ARM: dts: rockchip: add ov5647 camera module support to tinkerboard
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

ov5647 is one of the two camera modules as described in
https://tinkerboarding.co.uk/wiki/index.php/CSI-camera

changes ported over from https://github.com/TinkerBoard/debian_kernel.git

Reported-by: Karthik Poduval <karthik.poduval@gmail.com>
Signed-off-by: Karthik Poduval <karthik.poduval@gmail.com>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi
b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 312582c1bd37..720dd80ea3aa 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -107,6 +107,13 @@
         startup-delay-us = <100000>;
         vin-supply = <&vcc_io>;
     };
+
+    ext_cam_clk: external-camera-clock {
+        compatible = "fixed-clock";
+        clock-frequency = <25000000>;
+        clock-output-names = "CLK_CAMERA_25MHZ";
+        #clock-cells = <0>;
+    };
 };

 &cpu0 {
@@ -345,12 +352,42 @@

 &i2c2 {
     status = "okay";
+    camera0: ov5647@36 {
+        compatible = "ovti,ov5647";
+        reg = <0x36>;
+        clocks = <&ext_cam_clk>;
+        status = "okay";
+        enable-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+        port {
+            ov5647_out: endpoint {
+                remote-endpoint = <&isp_mipi_in>;
+                data-lanes = <1 2>;
+            };
+        };
+    };
 };

 &i2c5 {
     status = "okay";
 };

+&isp {
+    status = "okay";
+    phys = <&mipi_phy_rx0>;
+    phy-names = "dphy";
+
+    port {
+        isp_mipi_in: endpoint {
+            remote-endpoint = <&ov5647_out>;
+            data-lanes = <1 2>;
+        };
+    };
+};
+
+&mipi_phy_rx0 {
+    status = "okay";
+};
+
 &i2s {
     #sound-dai-cells = <0>;
     status = "okay";
-- 
2.17.1
