Return-Path: <SRS0=alUM=D4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADC7C56202
	for <linux-media@archiver.kernel.org>; Wed, 21 Oct 2020 21:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BF124180
	for <linux-media@archiver.kernel.org>; Wed, 21 Oct 2020 21:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTycqJWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506104AbgJUVZ6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441532AbgJUVZ5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 21 Oct 2020 17:25:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56261C0613CE;
        Wed, 21 Oct 2020 14:25:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so3578303wmf.0;
        Wed, 21 Oct 2020 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grGm9RnPrgjuYxcel2QgBtgp0qVpOagR72abqGZuq0s=;
        b=BTycqJWFwwf6F9sIqRWFgKNPeAg8+tw7F7MqGMKzzKKstEwiUoG+CXUtIgGhTNt6Ya
         hCFLu8mr52FPa10/kZ/q/cSwfZ6fOTHCAwn19yIf3XXnrEy8r0YpbGOE//T7Hb4fKL3Z
         8JbUNH4Ugm0PaoaPOMy1e72LBkHG5VmgnxhTdAPqqZdg6TmnU9YqSwOGf84jPDFmTKQH
         e16k3ENwlddUrS7jDciopUcpLzuVvIeLZGrcceIRlkhJUyUrIKtdUZ2BepKkZfo1Pleq
         v8rrLIBVGh1XeKy5H6wiK4IWYDE8R8OZ4Wps1s6Vr7hduZiutlBf0/0x7WlLoaC9hC+z
         qNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grGm9RnPrgjuYxcel2QgBtgp0qVpOagR72abqGZuq0s=;
        b=oLaItqftU6DvYFJ6YYef+V6t1VefdcceoxEUcB0lJecMGUhvxVejsCI38ILM9ComIF
         PZNGW2gaHaoiknzD+OmJwSG/Fg9oOujdrYBPU9ANgci/bCzSxVvr6R0Rn3WErz5alOlS
         MAi8llaH31vjjKHLr//BN6oH4g2S//bw6AwUOZ6UtzEBRCIC+cB3WqnZsS1EBO+un9Rn
         Mjhefagga0ltcFbXunx/WPxaK2Upzv4c1viFVBf8BYs1UtKfyFVVuZ56M6A99YB4pHu6
         MxyMKWL3ulMelS57kcgJmx4WYmnQ/PpD/rk3sH4gTpavqLV20wM85KON6JbQPtNVOyAS
         8/AQ==
X-Gm-Message-State: AOAM533aJFaEi6Wuv+AzRF7hhwHlz6TVADzGhNM3jRF+Ff/d4CF4Ljdw
        YG2yEpqRxss4kaLoLtGn5mQ=
X-Google-Smtp-Source: ABdhPJxLJrVmxLGANadY3RC44YFLKsoPNhI2rSI01Azbl7abI52Yfw1ziefwQRpvHplNwnWGy964Gg==
X-Received: by 2002:a05:600c:2ccb:: with SMTP id l11mr5105523wmc.94.1603315555123;
        Wed, 21 Oct 2020 14:25:55 -0700 (PDT)
Received: from arch-thunder.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id c18sm5877220wrq.5.2020.10.21.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 14:25:54 -0700 (PDT)
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, sakari.ailus@linux.intel.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v6 2/3] dt-bindings: imx7-csi: convert bindings to yaml
Date:   Wed, 21 Oct 2020 22:25:42 +0100
Message-Id: <20201021212543.1920793-3-rmfrfs@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021212543.1920793-1-rmfrfs@gmail.com>
References: <20201021212543.1920793-1-rmfrfs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Convert imx7-csi bindings documentation to yaml schema, remove the
textual bindings document and update MAINTAINERS entry.

Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../devicetree/bindings/media/imx7-csi.txt    | 42 -----------
 .../bindings/media/nxp,imx7-csi.yaml          | 71 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 72 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/imx7-csi.txt
 create mode 100644 Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml

diff --git a/Documentation/devicetree/bindings/media/imx7-csi.txt b/Documentation/devicetree/bindings/media/imx7-csi.txt
deleted file mode 100644
index d80ceefa0c00..000000000000
--- a/Documentation/devicetree/bindings/media/imx7-csi.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Freescale i.MX7 CMOS Sensor Interface
-=====================================
-
-csi node
---------
-
-This is device node for the CMOS Sensor Interface (CSI) which enables the chip
-to connect directly to external CMOS image sensors.
-
-Required properties:
-
-- compatible    : "fsl,imx7-csi" or "fsl,imx6ul-csi";
-- reg           : base address and length of the register set for the device;
-- interrupts    : should contain CSI interrupt;
-- clocks        : list of clock specifiers, see
-        Documentation/devicetree/bindings/clock/clock-bindings.txt for details;
-- clock-names   : must contain "mclk";
-
-The device node shall contain one 'port' child node with one child 'endpoint'
-node, according to the bindings defined in:
-Documentation/devicetree/bindings/media/video-interfaces.txt.
-
-In the following example a remote endpoint is a video multiplexer.
-
-example:
-
-                csi: csi@30710000 {
-                        #address-cells = <1>;
-                        #size-cells = <0>;
-
-                        compatible = "fsl,imx7-csi";
-                        reg = <0x30710000 0x10000>;
-                        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-                        clocks = <&clks IMX7D_CSI_MCLK_ROOT_CLK>;
-                        clock-names = "mclk";
-
-                        port {
-                                csi_from_csi_mux: endpoint {
-                                        remote-endpoint = <&csi_mux_to_csi>;
-                                };
-                        };
-                };
diff --git a/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml b/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
new file mode 100644
index 000000000000..4e81a47e60ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/nxp,imx7-csi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX7 CMOS Sensor Interface
+
+maintainers:
+  - Rui Miguel Silva <rmfrfs@gmail.com>
+
+description: |
+  This is device node for the CMOS Sensor Interface (CSI) which enables the
+  chip to connect directly to external CMOS image sensors.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7-csi
+      - fsl,imx6ul-csi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mclk
+
+  port:
+    type: object
+    description:
+      A node containing input port nodes with endpoint definitions as documented
+      in Documentation/devicetree/bindings/media/video-interfaces.txt
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx7d-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    csi: csi@30710000 {
+            compatible = "fsl,imx7-csi";
+            reg = <0x30710000 0x10000>;
+            interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clks IMX7D_CSI_MCLK_ROOT_CLK>;
+            clock-names = "mclk";
+
+            port {
+                    csi_from_csi_mux: endpoint {
+                            remote-endpoint = <&csi_mux_to_csi>;
+                    };
+            };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2cb2a5c60a1d..557713b3ee95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10779,8 +10779,8 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/admin-guide/media/imx7.rst
-F:	Documentation/devicetree/bindings/media/imx7-csi.txt
 F:	Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt
+F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
 F:	drivers/staging/media/imx/imx7-media-csi.c
 F:	drivers/staging/media/imx/imx7-mipi-csis.c
 
-- 
2.28.0

