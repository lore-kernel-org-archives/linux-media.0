Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD1BC433FE
	for <linux-media@archiver.kernel.org>; Sun,  6 Dec 2020 17:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7131323101
	for <linux-media@archiver.kernel.org>; Sun,  6 Dec 2020 17:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgLFRd0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 6 Dec 2020 12:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRdW (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 6 Dec 2020 12:33:22 -0500
Received: from mxf1.seznam.cz (mxf1.seznam.cz [IPv6:2a02:598:a::78:123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138EC0613D2;
        Sun,  6 Dec 2020 09:32:36 -0800 (PST)
Received: from email.seznam.cz
        by email-smtpc17a.ko.seznam.cz (email-smtpc17a.ko.seznam.cz [10.53.18.18])
        id 6a3e7310313027796b97bf4e;
        Sun, 06 Dec 2020 18:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1607275952; bh=oaf72hRe5cPmAi3mu1C9bnHaKNa77su7C6AXZDPrAHc=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=AkS52x0MtR+9dyWl448IgUHIN4nxi48XI0Y2KOmFUWP5AgP2BOhJDFPcsxc+xrVFE
         RpgqRChNKUIpWBLO7a+LJVQr90xgmjQFWz8/UtxNDW+J4+HAndsYFjzXLWrQEk8TdA
         T7Y7JxXFsg/weAoaYqa1d1ZnetzOsQWA8qKuSzw0=
Received: from localhost.localdomain (ip-228-128.dynamic.ccinternet.cz [212.69.128.228])
        by email-relay23.ko.seznam.cz (Seznam SMTPD 1.3.122) with ESMTP;
        Sun, 06 Dec 2020 18:29:47 +0100 (CET)  
From:   michael.srba@seznam.cz
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Michael Srba <Michael.Srba@seznam.cz>
Subject: [PATCH v2 3/3] arm64: dts: update device trees to specify clock-frequency in imx219 node
Date:   Sun,  6 Dec 2020 18:27:20 +0100
Message-Id: <20201206172720.9406-3-michael.srba@seznam.cz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206172720.9406-1-michael.srba@seznam.cz>
References: <20201206172720.9406-1-michael.srba@seznam.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Michael Srba <Michael.Srba@seznam.cz>

This patch adds the clock-frequency property to all device trees that use
the imx219 binding, with the value of exactly 24Mhz which was previously
implicitly assumed.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---

changes since v1: remove errorneous edit

---
 arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi b/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
index dac6ff49020f..986c6c1f7312 100644
--- a/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
+++ b/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
@@ -82,6 +82,7 @@ imx219: imx219@10 {
 		compatible = "sony,imx219";
 		reg = <0x10>;
 		clocks = <&osc25250_clk>;
+		clock-frequency = <24000000>;
 		VANA-supply = <&imx219_vana_2v8>;
 		VDIG-supply = <&imx219_vdig_1v8>;
 		VDDL-supply = <&imx219_vddl_1v2>;
-- 
2.29.2

