Return-Path: <SRS0=uFep=T4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D58C04AB6
	for <linux-media@archiver.kernel.org>; Tue, 28 May 2019 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728E521726
	for <linux-media@archiver.kernel.org>; Tue, 28 May 2019 17:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfE1RLX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 May 2019 13:11:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39477 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfE1RLX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 May 2019 13:11:23 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mtr@pengutronix.de>)
        id 1hVfdB-0000hL-P9; Tue, 28 May 2019 19:11:21 +0200
Received: from mtr by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mtr@pengutronix.de>)
        id 1hVfdB-0001r6-Cv; Tue, 28 May 2019 19:11:21 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kernel@pengutronix.de, robh+dt@kernel.org, mchehab@kernel.org,
        tfiga@chromium.org, hverkuil@xs4all.nl,
        Michael Tretter <m.tretter@pengutronix.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 3/5] media: dt-bindings: media: Add vendor prefix for allegro
Date:   Tue, 28 May 2019 19:11:18 +0200
Message-Id: <20190528171120.7076-4-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528171120.7076-1-m.tretter@pengutronix.de>
References: <20190528171120.7076-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add vendor prefix for Allegro DVT, a provider of H.264/AVC, H.265/HEVC,
AVS2, VP9 and AV1 compliance test suites and H.264/AVC, H.265/HEVC, and
VP9 encoder, codec and decoder hardware (RTL) IPs.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v7 -> v8:
none

v6 -> v7:
- convert to json format for vendor-prefixes.yaml

v5 -> v6:
none

v5:
- new patch
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 33a65a45e319..7da11464991a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -49,6 +49,8 @@ patternProperties:
     description: Aeroflex Gaisler AB
   "^al,.*":
     description: Annapurna Labs
+  "^allegro,.*"
+    description: Allegro DVT
   "^allo,.*":
     description: Allo.com
   "^allwinner,.*":
-- 
2.20.1

