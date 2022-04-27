Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCABC433EF
	for <linux-media@archiver.kernel.org>; Wed, 27 Apr 2022 13:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiD0Ncq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiD0Nci (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 27 Apr 2022 09:32:38 -0400
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5BDE89;
        Wed, 27 Apr 2022 06:29:23 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 23RDSqVA009238; Wed, 27 Apr 2022 22:28:53 +0900
X-Iguazu-Qid: 2wGr4Oa00fx9XzPiVd
X-Iguazu-QSIG: v=2; s=0; t=1651066132; q=2wGr4Oa00fx9XzPiVd; m=nwZjeysEFhDZNLuNwJjFM27BefwGI4Ax4ET4+IPW4ws=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 23RDSp6v026492
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 22:28:51 +0900
X-SA-MID: 36913145
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v2 1/4] dt-bindings: soc: visconti: Add Toshiba Visconti AFFINE image processing accelerator bindings
Date:   Wed, 27 Apr 2022 22:23:42 +0900
X-TSB-HOP2: ON
Message-Id: <20220427132345.27327-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427132345.27327-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220427132345.27327-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Adds the Device Tree binding documentation that allows to describe
the AFFINE image processing accelerator found in Toshiba Visconti SoCs.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../soc/visconti/toshiba,visconti-affine.yaml | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-affine.yaml

diff --git a/Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-affine.yaml b/Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-affine.yaml
new file mode 100644
index 000000000..a446e1c4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-affine.yaml
@@ -0,0 +1,53 @@
+# SPDX-LIcense-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/visconti/toshiba,visconti-affine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti AFFINE image processing accelerator
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description: |
+  Toshiba Visconti AFFINE image processing accelerator provides affine transform, lens undistortion and LUT transform.
+  Visconti5 have up to 2 AFFINE units.
+
+properties:
+  compatible:
+    items:
+      - const: toshiba,visconti-affine
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  index:
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - index
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        affine0: affine@14000000 {
+            compatible = "toshiba,visconti-affine";
+            reg = <0 0x14000000 0 0x8000>;
+            interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+            index = <0>;
+            status = "disabled";
+        };
+    };
-- 
2.17.1


