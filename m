Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ADDC388F7
	for <linux-media@archiver.kernel.org>; Mon,  9 Nov 2020 15:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D80B20789
	for <linux-media@archiver.kernel.org>; Mon,  9 Nov 2020 15:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="qUWzzoU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgKIP3e (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 Nov 2020 10:29:34 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:14087 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgKIP3e (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 Nov 2020 10:29:34 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 10:29:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604935772;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=SrG7REyckMurQlHgTAHgDZfFeapRGEC/Xh1qebbvEeA=;
        b=qUWzzoU/2T6iyQULMJY7w1uR9ADQ1kXJXFwQTUPrH/xdm6t9/xqjkVOi1qfo2sLAkb
        ZDWy3IaJI+y4oJoMsUQP+1shtngWHEH88gfpXg29T/WLP3n+8ybfqFMQ0Br4EzwilGqO
        SHweC7j6UprA0f9txd/ZvDbYFxj7DX8rKAqIxCYoZWNqN23RBXGFip1yO+6oIJ26QSen
        FKRLcJfjPFhZmyK2sRgcNqg4LIzADEtpDCS+2KZUhRKH3xCgb3VU6Ivd8f52zOCNT67D
        sZ+1F1+V60z0ILBoRygjfRwXSehtKkg+H3BpvVRpjXQ2J5p5enU7PWNfEMQ6ylAn20R/
        zT0Q==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.3 AUTH)
        with ESMTPSA id Y03aecwA9FNSCIL
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 9 Nov 2020 16:23:28 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kc90t-0008Ow-Ud; Mon, 09 Nov 2020 16:23:23 +0100
Received: (nullmailer pid 3164312 invoked by uid 502);
        Mon, 09 Nov 2020 15:23:23 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: [PATCH RESEND v2 2/2] media: bindings: media: gpio-ir-receiver: add linux,timeout-us property
Date:   Mon,  9 Nov 2020 16:23:11 +0100
Message-ID: <b61c78925e89c239c3f6e7d7aa8a4c83e263515f.1604589023.git.michael@fossekall.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604589023.git.michael@fossekall.de>
References: <cover.1604589023.git.michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org
Message-ID: <20201109152311.vYzQyw6zq2ey30vNURZHEl5xIZ38oEDeIHeSMv6aXHw@z>

Add linux,timeout-us for gpio ir receiver.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 .../devicetree/bindings/media/gpio-ir-receiver.txt          | 3 +++
 Documentation/devicetree/bindings/media/rc.yaml             | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/gpio-ir-receiver.txt b/Documentation/devicetree/bindings/media/gpio-ir-receiver.txt
index 108bf435b933..7aef3fe78322 100644
--- a/Documentation/devicetree/bindings/media/gpio-ir-receiver.txt
+++ b/Documentation/devicetree/bindings/media/gpio-ir-receiver.txt
@@ -9,6 +9,8 @@ Optional properties:
 	  directory.
 	- linux,autosuspend-period: autosuspend delay time,
 	  the unit is milisecond.
+	- linux,timeout-us: set the length of a space at which
+	  the recorder goes idle, specified in microseconds.
 
 Example node:
 
@@ -17,4 +19,5 @@ Example node:
 		gpios = <&gpio0 19 1>;
 		linux,rc-map-name = "rc-rc6-mce";
 		linux,autosuspend-period = <125>;
+		linux,timeout-us = <125000>;
 	};
diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
index 8ad2cba5f61f..1f3e208a50a1 100644
--- a/Documentation/devicetree/bindings/media/rc.yaml
+++ b/Documentation/devicetree/bindings/media/rc.yaml
@@ -151,4 +151,10 @@ properties:
       - rc-xbox-dvd
       - rc-zx-irdec
 
+  linux,timeout-us:
+    description:
+      Set the length of a space at which the recorder goes idle, specified in
+      microseconds.
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+
 additionalProperties: true
-- 
2.28.0

