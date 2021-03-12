Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD407C433E0
	for <linux-media@archiver.kernel.org>; Fri, 12 Mar 2021 13:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D4A64FFE
	for <linux-media@archiver.kernel.org>; Fri, 12 Mar 2021 13:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhCLNEJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Mar 2021 08:04:09 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:9495 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231781AbhCLNDl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Mar 2021 08:03:41 -0500
X-Halon-ID: 596dffc3-8333-11eb-a542-005056917a89
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p54ac5521.dip0.t-ipconnect.de [84.172.85.33])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 596dffc3-8333-11eb-a542-005056917a89;
        Fri, 12 Mar 2021 14:03:36 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] dt-bindings: media: renesas,vin: Add r8a77961 support
Date:   Fri, 12 Mar 2021 14:03:30 +0100
Message-Id: <20210312130330.1742445-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add the compatible string for M3-W+ (r8a77961) to the list of supported
SoCs.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 Documentation/devicetree/bindings/media/renesas,vin.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,vin.yaml b/Documentation/devicetree/bindings/media/renesas,vin.yaml
index fe7c4cbfe4ba960c..48e061a9ca4e5ee8 100644
--- a/Documentation/devicetree/bindings/media/renesas,vin.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,vin.yaml
@@ -46,6 +46,7 @@ properties:
               - renesas,vin-r8a7779  # R-Car H1
               - renesas,vin-r8a7795  # R-Car H3
               - renesas,vin-r8a7796  # R-Car M3-W
+              - renesas,vin-r8a77961 # R-Car M3-W+
               - renesas,vin-r8a77965 # R-Car M3-N
               - renesas,vin-r8a77970 # R-Car V3M
               - renesas,vin-r8a77980 # R-Car V3H
-- 
2.30.1

