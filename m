Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A46C4708C
	for <linux-media@archiver.kernel.org>; Fri, 28 May 2021 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366FF613F6
	for <linux-media@archiver.kernel.org>; Fri, 28 May 2021 08:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhE1IP5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 28 May 2021 04:15:57 -0400
Received: from comms.puri.sm ([159.203.221.185]:41206 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234715AbhE1IP5 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 28 May 2021 04:15:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D081FE3C05;
        Fri, 28 May 2021 01:14:22 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9ZXjWQ6XewNJ; Fri, 28 May 2021 01:14:17 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     devicetree@vger.kernel.org, kernel@puri.sm,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, paul.kocialkowski@bootlin.com,
        robh@kernel.org, shawnx.tu@intel.com,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 1/5] dt-bindings: vendor-prefixes: Add SK Hynix Inc.
Date:   Fri, 28 May 2021 10:13:32 +0200
Message-Id: <20210528081336.3858700-2-martin.kepplinger@puri.sm>
In-Reply-To: <20210528081336.3858700-1-martin.kepplinger@puri.sm>
References: <20210528081336.3858700-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

SK Hynix built the already supported hi556 sensor (and probably much
more). For more information, see https://www.skhynix.com/

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b868cefc7c55..a75cd3be50b9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -499,6 +499,8 @@ patternProperties:
     description: Hycon Technology Corp.
   "^hydis,.*":
     description: Hydis Technologies
+  "^hynix,.*":
+    description: SK Hynix Inc.
   "^hyundai,.*":
     description: Hyundai Technology
   "^i2se,.*":
-- 
2.30.2

