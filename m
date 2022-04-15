Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C3C433FE
	for <linux-media@archiver.kernel.org>; Fri, 15 Apr 2022 15:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355586AbiDOPkM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Apr 2022 11:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355513AbiDOPkH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Apr 2022 11:40:07 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1641982;
        Fri, 15 Apr 2022 08:37:20 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8625A240011;
        Fri, 15 Apr 2022 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650037039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QLURbieOpkkpfNq0BunWS0OopKUOZx+5e7LfvVp5TQ=;
        b=ZGlF/9OG8gidXF+Pyl9PA9TDDHGLp8Bkc1pOMohqQcpzLRAyrnrYEakLaeYzY05zX9f0Lm
        bs1kn2ocRSXMmauI1gxuNzYuGW3TEXACcI0Nnlc7aaMKqe2s+WNpOpG3aBjyI63gjyoZPv
        kb129U+I9gJFaySLQxEreryVp5yp4kWm7nlkNqnVK87NdGIay/NEPxc33gZPdmWzd59L21
        8aaQ3dj0RmesKW94CvbAYyQ28g+adkqAO3Dhr9Yc304Kq1UCFF1BS/O9zeseU3UV/2plog
        Mh5lFWwGx55J5pqR+hgNem2fMxzdA/T4IOby8U6pl9sdXlSufhe1D8vPuuWJGQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 2/4] dt-bindings: media: sun6i-a31-csi: Add ISP output port
Date:   Fri, 15 Apr 2022 17:37:06 +0200
Message-Id: <20220415153708.637804-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Some Allwinner devices come with an Image Signal Processor (ISP) that
allows processing camera data to produce good-looking images,
especially from raw bayer representations.

The ISP does not have a dedicated capture path: it is fed directly by
one of the CSI controllers, which can be selected at run-time.

Represent this possibility as a graph connection between the CSI
controller and the ISP in the device-tree bindings.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../bindings/media/allwinner,sun6i-a31-csi.yaml    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
index 53aa6dbe8e2c..1b41a6008195 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
@@ -87,6 +87,20 @@ properties:
 
         additionalProperties: false
 
+      port@2:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: ISP output port
+
+        properties:
+          reg:
+            const: 2
+
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+        additionalProperties: false
+
     anyOf:
       - required:
           - port@0
-- 
2.35.2

