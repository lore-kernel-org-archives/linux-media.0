Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A67EC433FE
	for <linux-media@archiver.kernel.org>; Sat,  1 Jan 2022 18:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiAAS2S (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 1 Jan 2022 13:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiAAS2R (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 1 Jan 2022 13:28:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44094C061574;
        Sat,  1 Jan 2022 10:28:17 -0800 (PST)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D772D1207;
        Sat,  1 Jan 2022 19:28:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641061695;
        bh=7w127SGh0OEk4TSPY7jvDZ8OZMBkHZHIdByroOfok58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpaHGhTmi83UGIdhEnndE7CXL5RSLpVO8YP9jHB55z1U7xGccpcXKPrcf3CUJ3lID
         Zhqzc9X1HZ8IA6d65MwSZ7ynouKLicF3ETOrMWK/aSL90t/v7NRFAUqm27yRhXyjdQ
         3HA3fRw9llw2RHdhW7heCADQnQgMh0CeB4Dr3+ZE=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Thomas Nizan <tnizan@witekio.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 03/11] dt-bindings: media: i2c: max9286: Add property to select bus width
Date:   Sat,  1 Jan 2022 20:27:58 +0200
Message-Id: <20220101182806.19311-4-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101182806.19311-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20220101182806.19311-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The GMSL serial data bus width is normally selected by the BWS pin, but
it can also be configured by software. Add a DT property that allows
overriding the value of the BWS-selected bus width to support systems
whose BWS pin doesn't result in the correct value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/media/i2c/maxim,max9286.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
index 5d3e99027a79..123e98cdb7b6 100644
--- a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
@@ -50,6 +50,13 @@ properties:
   '#gpio-cells':
     const: 2
 
+  maxim,bus-width:
+    enum: [ 24, 27, 32 ]
+    description: |
+      The GMSL serial data bus width. This setting is normally controlled by
+      the BWS pin, but may be overridden with this property. The value must
+      match the configuration of the remote serializers.
+
   maxim,i2c-clock-frequency:
     enum: [ 8470, 28300, 84700, 105000, 173000, 339000, 533000, 837000 ]
     default: 105000
-- 
Regards,

Laurent Pinchart

