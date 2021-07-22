Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561FEC6377D
	for <linux-media@archiver.kernel.org>; Thu, 22 Jul 2021 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F686128E
	for <linux-media@archiver.kernel.org>; Thu, 22 Jul 2021 09:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhGVIby (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:31:54 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50751 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhGVIbi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 22 Jul 2021 04:31:38 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id ED93B200017;
        Thu, 22 Jul 2021 09:12:10 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] DNI: arm64: dts: renesas: eagle: Include eagle-gmsl
Date:   Thu, 22 Jul 2021 11:12:39 +0200
Message-Id: <20210722091239.26451-9-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722091239.26451-1-jacopo+renesas@jmondi.org>
References: <20210722091239.26451-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

Include the eagle-gmsl.dtsi to enable GMSL camera support on the
Eagle-V3M platform.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index 05e66467bc0a..542797288e9d 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -376,3 +376,11 @@ &scif0 {
 
 	status = "okay";
 };
+
+/* FAKRA Overlay */
+#define GMSL_CAMERA_RDACM20
+#define GMSL_CAMERA_0
+#define GMSL_CAMERA_1
+#define GMSL_CAMERA_2
+#define GMSL_CAMERA_3
+#include "gmsl-cameras.dtsi"
-- 
2.32.0

