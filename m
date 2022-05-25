Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B50C433FE
	for <linux-media@archiver.kernel.org>; Wed, 25 May 2022 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbiEYTMj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 May 2022 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344452AbiEYTMc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 May 2022 15:12:32 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6DC6E7C;
        Wed, 25 May 2022 12:10:43 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D63AFF808;
        Wed, 25 May 2022 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIgZtkvccsLXsMN8UO3+9DFmHNkKzDJVDrinkhB+3Tw=;
        b=B5VZZkU6EgqpmHCi3F4QkuyU+Azm1IxmCKGZbwIRarSZjQSv7lX554CyFMq4srCZl+lpqa
        +GQfyw3l38uv9e9AmGZAmj9VUu2EaxfeLoLyhW0W8ILh8Fs2j6fee/EjRQRRJxHOiqbFBy
        BLq4Iot2QwU42JvYaJxz45nTC39IQTWoIBwOEymySKimFLF2T86ihHG13TAHAI3SoR2LgX
        p2SUjLkWX220pTPkb4gb5HcAVvAhzSdIMuAhS4Ji4Ph6PnuJ0RaC8Wzf0xrlk6rAt0AtNd
        dHlyA/1DE4xLlu7/dBjSP65LvXo2GV2mHS6HLDJoLMkLs8cN7TQy0tTTe+K+qA==
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
Subject: [PATCH v4 2/6] dt-bindings: media: sun6i-a31-csi: Add ISP output port
Date:   Wed, 25 May 2022 21:10:22 +0200
Message-Id: <20220525191026.696636-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525191026.696636-1-paul.kocialkowski@bootlin.com>
References: <20220525191026.696636-1-paul.kocialkowski@bootlin.com>
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
 .../devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
index 8551c4a711dc..54eb80e517e3 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
@@ -73,6 +73,10 @@ properties:
         $ref: /schemas/graph.yaml#/properties/port
         description: MIPI CSI-2 bridge input port
 
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: ISP output port
+
     anyOf:
       - required:
           - port@0
-- 
2.36.1

