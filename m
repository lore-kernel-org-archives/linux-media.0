Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303A2FD667
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871800; cv=none; b=j2X/pqsYPnU1Q3jYvBXOvC5J3BSo7Gn6xbx1kFuRh9LtJV2PhUEhIa4e3ZSxf+G24s0A5/1eFsgB7AdqdfxNEumOKZHkkeh0ZV23HGCq6YSYy/Kamg4KqnDwt/pQ6Nl1H728GqPI3wSjeEx1AU97ClnEkO+QNB9UuX/Am0toHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871800; c=relaxed/simple;
	bh=MrA5Pm+bMe7Y1bUbUfwg73ko1PRGj7avWFqhiEsp8Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kytAU+S8TCcb1rY5EFXbuDAqtAHogK4/1F/InAQCLa0HGrRRPhsQsbi593cDja/aKC3ch1SCAvBu0+Vxo6YgrN5QSgprerFqKOnAxNagpb+XJMAtC7hg1uUhtdmrJr+9IpUsVsZUHmEBFVsDS4WohIeLjxVu47caXxdDho8LJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vIpU4-0004Ul-6V; Tue, 11 Nov 2025 15:36:36 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Tue, 11 Nov 2025 15:36:14 +0100
Subject: [PATCH 1/4] media: dt-bindings: adi,adv7180: add VPP and CSI
 register maps
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
References: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
In-Reply-To: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org

The ADV7280 and ADV7280-M have up to three register maps for the VPP and
CSI. The address of these register maps may be programmed via registers
in the main register map.

Allow to specify the addresses of the VPP and CSI in the device tree to
solve address conflicts on a board level.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 .../devicetree/bindings/media/i2c/adi,adv7180.yaml | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml b/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
index dee8ce7cb7ba..4bbdc812442b 100644
--- a/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
@@ -138,6 +138,31 @@ allOf:
       required:
         - ports
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adv7280
+              - adi,adv7280-m
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 3
+          description:
+            The ADV7280 and ADV7280-M have up to three register maps, which can be
+            accessed via the I2C port. The main register map, the VPP register map,
+            and the CSI register map. The main register map is mandatory. The other
+            register maps are optional and the default is used unless specified.
+
+        reg-names:
+          minItems: 1
+          items:
+            - const: main
+            - enum: [ csi, vpp ]
+            - enum: [ csi, vpp ]
+
 examples:
   - |
     i2c {
@@ -187,3 +212,22 @@ examples:
                     };
             };
     };
+
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            composite-in@20 {
+                    compatible = "adi,adv7280-m";
+                    reg = <0x20>, <0x42>, <0x44>;
+                    reg-names = "main", "vpp", "csi";
+
+                    port {
+                            adv7280_out: endpoint {
+                                    bus-width = <8>;
+                                    remote-endpoint = <&vin1ep>;
+                            };
+                    };
+            };
+    };

-- 
2.47.3

