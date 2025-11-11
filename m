Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4068369991;
	Tue, 11 Nov 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877780; cv=none; b=UI/MHuVz8Tjt3nXPIxPcq4DqUqlXTLvYx5b2gq64NijeWS+ByNt2agMza501jj4t+/uZ0OQnURoHWz1ry0uSkTefEBrfIYmsvscQUIZg3kvQNTKsxZSly5g1y7IR5RMpgEYU6oOACOCwtDMmyLz3Whxv4SUOOkiRDZOe3GLzYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877780; c=relaxed/simple;
	bh=jAJ2eu48I5oAuQiJD9svJrov/FQNTulmO0GAoCJbmq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HD4EcIn0SgJpFe4ur02PD8D1AgmzURM9iwTXI+ksNBSUu5PxwS13kawdmL+8fe5g/MSFhAFlZ8buBsUvjgkRRp674XrtgZ6Cui4AvTHC2fNuGnWbUh1m7GDq2bIWnDrP1Vegsc3jdma3siSU68HOjqEoNlB8/PN5oiEOTsQGfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jkAgw7Fd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jkAgw7Fd"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D76491E53;
	Tue, 11 Nov 2025 17:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762877650;
	bh=jAJ2eu48I5oAuQiJD9svJrov/FQNTulmO0GAoCJbmq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jkAgw7Fdgsj3ZUhFjeMlytHsJRMGIOGjgSdXZ2vNYuAjHvtjnRbLSbgNOGc9GjmD4
	 UGlAUM2nh4tr0+dJJ8QP8gkRgdHjyrTIyeYm5R59sZx1JZ0kHmZqflaahZMxrsFOHA
	 qXh7awwufa9YtifP6GfQ+/1SXIAxrep8xWrUIO7Q=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Tue, 11 Nov 2025 16:15:47 +0000
Subject: [PATCH v13 03/15] dt-bindings: media: Add bindings for ARM
 mali-c55
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-c55-v13-3-3dc581355e3a@ideasonboard.com>
References: <20251111-c55-v13-0-3dc581355e3a@ideasonboard.com>
In-Reply-To: <20251111-c55-v13-0-3dc581355e3a@ideasonboard.com>
To: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Cc: Anthony.McGivern@arm.com, jacopo.mondi@ideasonboard.com, 
 nayden.kanchev@arm.com, robh+dt@kernel.org, mchehab@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 jerome.forissier@linaro.org, kieran.bingham@ideasonboard.com, 
 laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4229;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=jAJ2eu48I5oAuQiJD9svJrov/FQNTulmO0GAoCJbmq0=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpE2FCMXKZZLHT+1MZP6qkzXHbUG1hyWVVx96ZJ
 eQRA1GH9iuJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCaRNhQgAKCRDISVd6bEV1
 MtqiEACx9FJ5S/jXroMQsTHPrhnmLYa93trCwZ8CxEjF8MEX+kRTGg4prTPqOOogv+Y0UBnBhOM
 LY8gXshlejDD7FQwycHYpipFp8I/UXWVtmGzfVUUnMJUmj+jhIGLNXUl0GiABEFB8Pmn9NtogSo
 qo7R8qNW+WGN+Y655T9buYiDEN7ww3iAgh5StTMPCNfl7xu2xxuz98R+Za/ALFlexYxoQWMcJEf
 BalzAsM41XfgKxcG2T32ZDl9qhp7/l4sjyuocznoGFNtHxUsbl3/awgJa9nDY2VM9QplIEI9JdY
 XTYORRb8MiEAC68qh3bcs4s+Ea6DhDrlK78DWoHbtEz9yLuqpnvEv/5vW5YZkwOt5XyFSwWsYv3
 T0wUf8fbw2lHGCLpnUNUZ0YWUTBIQmcxgMvKynZwHnyf1Z8CEZJJymkerua985Sv5gKYdeh/s22
 B43HvnEQbyA4ShrsASVy7AtGjOK0hcPzHwDeB+9qeY3pOz8OHJvGCfPwEs5fzVrEmDAj8SqqZLW
 1rdCxAXjN70WlrNR+a5z87PBzecJF63TQvczbCQGG5sOIBLcPw+O6ixjRu5sbpYACEtB07SRWU6
 sniPCbSJQbLjkiD6OLwJfL+jKn34ltr41fH+U6g7DLFnlhVTJC+526RVslwn785oE7mj3b8TlBn
 0lHMsEGv8AXxH7g==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

Add the yaml binding for ARM's Mali-C55 Image Signal Processor.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Nayden Kanchev <nayden.kanchev@arm.com>
Co-developed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
Changes in v13:

	- Added resets and reset-names to required properties
	- More realistic interrupts property in the binding example
	- Dropped the mali_c55 label from the node in the example

Changes in v12:

	- _Actually_ dropped the arm,inline property mode, having forgotten to
	  do so in v11.

Changes in v11:

	- Dropped in arm,inline_mode property. This is now identical to the
	  reviewed version 8, so I have kept the tags on there.

Changes in v10:

	- None

Changes in v9:

	- Added the arm,inline_mode property to differentiate between inline and
	  memory input configurations

Changes in v8:

	- Added the video clock back in. Now that we have actual hardware it's
	  clear that it's necessary.
	- Added reset lines
	- Dropped R-bs

Changes in v7:

	- None

Changes in v6:

	- None

Changes in v5:

	- None

Changes in v4:

	- Switched to port instead of ports

Changes in v3:

	- Dropped the video clock as suggested by Laurent. I didn't retain it
	for the purposes of the refcount since this driver will call .s_stream()
	for the sensor driver which will refcount the clock anyway.
	- Clarified that the port is a parallel input port rather (Sakari)

Changes in v2:

	- Added clocks information
	- Fixed the warnings raised by Rob
---
 .../devicetree/bindings/media/arm,mali-c55.yaml    | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/arm,mali-c55.yaml b/Documentation/devicetree/bindings/media/arm,mali-c55.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..fc4fcd19922aad510ac40a02a53c3c098af9f6a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/arm,mali-c55.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/arm,mali-c55.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali-C55 Image Signal Processor
+
+maintainers:
+  - Daniel Scally <dan.scally@ideasonboard.com>
+  - Jacopo Mondi <jacopo.mondi@ideasonboard.com>
+
+properties:
+  compatible:
+    const: arm,mali-c55
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ISP Video Clock
+      - description: ISP AXI clock
+      - description: ISP AHB-lite clock
+
+  clock-names:
+    items:
+      - const: vclk
+      - const: aclk
+      - const: hclk
+
+  resets:
+    items:
+      - description: vclk domain reset
+      - description: aclk domain reset
+      - description: hclk domain reset
+
+  reset-names:
+    items:
+      - const: vresetn
+      - const: aresetn
+      - const: hresetn
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: Input parallel video bus
+
+    properties:
+      endpoint:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    isp@400000 {
+      compatible = "arm,mali-c55";
+      reg = <0x400000 0x200000>;
+      clocks = <&clk 0>, <&clk 1>, <&clk 2>;
+      clock-names = "vclk", "aclk", "hclk";
+      resets = <&resets 0>, <&resets 1>, <&resets 2>;
+      reset-names = "vresetn", "aresetn", "hresetn";
+      interrupts = <GIC_SPI 861 IRQ_TYPE_EDGE_RISING>;
+
+      port {
+        isp_in: endpoint {
+            remote-endpoint = <&csi2_rx_out>;
+        };
+      };
+    };
+...

-- 
2.43.0

