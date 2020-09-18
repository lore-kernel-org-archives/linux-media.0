Return-Path: <SRS0=ldJM=C3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F224BC43465
	for <linux-media@archiver.kernel.org>; Fri, 18 Sep 2020 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88FC21D42
	for <linux-media@archiver.kernel.org>; Fri, 18 Sep 2020 16:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIRQ3O (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:29:14 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60028 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRQ3M (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 18 Sep 2020 12:29:12 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id DA9EB3AD322;
        Fri, 18 Sep 2020 14:25:40 +0000 (UTC)
Received: from pc-2.home (lfbn-tou-1-1532-46.w90-89.abo.wanadoo.fr [90.89.95.46])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BE24E24000C;
        Fri, 18 Sep 2020 14:25:15 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add techwell vendor prefix
Date:   Fri, 18 Sep 2020 16:24:20 +0200
Message-Id: <20200918142422.1086555-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918142422.1086555-1-maxime.chevallier@bootlin.com>
References: <20200918142422.1086555-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add prefix for Techwell, Inc.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab03521..3fcf071c4467 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1033,6 +1033,8 @@ patternProperties:
     description: TechNexion
   "^technologic,.*":
     description: Technologic Systems
+  "^techwell,.*":
+    description: Techwell, Inc.
   "^tempo,.*":
     description: Tempo Semiconductor
   "^techstar,.*":
-- 
2.25.4

