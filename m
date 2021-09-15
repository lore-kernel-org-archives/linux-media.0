Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A86C43217
	for <linux-media@archiver.kernel.org>; Wed, 15 Sep 2021 16:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E68361247
	for <linux-media@archiver.kernel.org>; Wed, 15 Sep 2021 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhIOQZQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:25:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42874 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhIOQZJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 15 Sep 2021 12:25:09 -0400
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:6886:1a1c:e30b:c0f1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9EDD71F43799;
        Wed, 15 Sep 2021 17:23:48 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com
Subject: [PATCH 5/6] dt-bindings: media: staging: wave5: add yaml devicetree bindings
Date:   Wed, 15 Sep 2021 18:23:23 +0200
Message-Id: <20210915162324.25513-6-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915162324.25513-1-dafna.hirschfeld@collabora.com>
References: <20210915162324.25513-1-dafna.hirschfeld@collabora.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

Add bindings for the wave5 chips&media codec driver

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 .../bindings/staging/media/cnm,wave.yaml      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/media/cnm,wave.yaml

diff --git a/Documentation/devicetree/bindings/staging/media/cnm,wave.yaml b/Documentation/devicetree/bindings/staging/media/cnm,wave.yaml
new file mode 100644
index 000000000000..e4a43633b8e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/staging/media/cnm,wave.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/staging/media/cnm,wave.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chips&Media Wave 5 Series multi-standard codec IP
+
+maintainers:
+  - Nas Chung <nas.chung@chipsnmedia.com>
+  - Robert Beckett <bob.beckett@collabora.com>
+  - Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
+
+description: |-
+  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+        - enum:
+            - cnm,cm511-vpu
+            - cnm,cm517-vpu
+            - cnm,cm521-vpu
+            - cnm,cm521c-vpu
+            - cnm,cm521c-dual-vpu
+            - cnm,cm521e1-vpu
+            - cnm,cm537-vpu
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: vcodec
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle pointing to the SRAM device node
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    vpu: video-codec@12345678 {
+        compatible = "cnm,cm521-vpu";
+        reg = <0x12345678 0x1000>;
+        interrupts = <42>;
+        clocks = <&clks 42>;
+        clock-names = "vcodec";
+        sram = <&sram>;
+    };
+
-- 
2.17.1

