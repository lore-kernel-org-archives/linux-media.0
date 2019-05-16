Return-Path: <SRS0=hQl8=TQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15105C04E53
	for <linux-media@archiver.kernel.org>; Thu, 16 May 2019 01:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF7920843
	for <linux-media@archiver.kernel.org>; Thu, 16 May 2019 01:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfEPBq1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:27 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:47942 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfEPAiK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 15 May 2019 20:38:10 -0400
X-Halon-ID: dc7a3216-7772-11e9-8601-0050569116f7
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [89.233.230.99])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id dc7a3216-7772-11e9-8601-0050569116f7;
        Thu, 16 May 2019 02:38:05 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] dt-bindings: rcar-{csi2,vin}: Rename bindings documentation files
Date:   Thu, 16 May 2019 02:38:03 +0200
Message-Id: <20190516003803.808-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Renesas media binding documentation files uses a naming schema of
'renesas,<module>.txt'. Rename VIN and CSI-2 files to match this
pattern.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 .../media/{renesas,rcar-csi2.txt => renesas,csi2.txt}         | 0
 .../bindings/media/{rcar_vin.txt => renesas,vin.txt}          | 0
 MAINTAINERS                                                   | 4 ++--
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/media/{renesas,rcar-csi2.txt => renesas,csi2.txt} (100%)
 rename Documentation/devicetree/bindings/media/{rcar_vin.txt => renesas,vin.txt} (100%)

diff --git a/Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt b/Documentation/devicetree/bindings/media/renesas,csi2.txt
similarity index 100%
rename from Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt
rename to Documentation/devicetree/bindings/media/renesas,csi2.txt
diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/renesas,vin.txt
similarity index 100%
rename from Documentation/devicetree/bindings/media/rcar_vin.txt
rename to Documentation/devicetree/bindings/media/renesas,vin.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 878588cfb453d83c..c3a23726472d7d4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9629,8 +9629,8 @@ L:	linux-media@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 S:	Supported
-F:	Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt
-F:	Documentation/devicetree/bindings/media/rcar_vin.txt
+F:	Documentation/devicetree/bindings/media/renesas,csi2.txt
+F:	Documentation/devicetree/bindings/media/renesas,vin.txt
 F:	drivers/media/platform/rcar-vin/
 
 MEDIA DRIVERS FOR RENESAS - VSP1
-- 
2.21.0

