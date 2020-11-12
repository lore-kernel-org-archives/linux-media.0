Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374FC56202
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CC8216C4
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 16:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgKLQ2D (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:28:03 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:54519 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgKLQ2D (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Nov 2020 11:28:03 -0500
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A828110000F;
        Thu, 12 Nov 2020 16:27:59 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hyun Kwon <hyunk@xilinx.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 7/8] [DNI] arm64: dts: renesas: salvator-x-max9286: Specify channel amplitude
Date:   Thu, 12 Nov 2020 17:27:28 +0100
Message-Id: <20201112162729.101384-8-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112162729.101384-1-jacopo+renesas@jmondi.org>
References: <20201112162729.101384-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use the newly introduced 'maxim,maxim,initial-reverse-channel-mV'
property to specify the initial reverse channel amplitude when
the remote serializers are pre-programmed with noise immunity threshold
enabled.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/salvator-x-max9286.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-x-max9286.dtsi b/arch/arm64/boot/dts/renesas/salvator-x-max9286.dtsi
index 6f4798859542..f14a133b7302 100644
--- a/arch/arm64/boot/dts/renesas/salvator-x-max9286.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-x-max9286.dtsi
@@ -128,6 +128,7 @@ gmsl-deserializer@4c {
 		compatible = "maxim,max9286";
 		reg = <0x4c>;
 		poc-supply = <&poc_12v>;
+		maxim,initial-reverse-channel-mV = <170>;
 
 		ports {
 			#address-cells = <1>;
@@ -263,6 +264,7 @@ gmsl-deserializer@6c {
 		compatible = "maxim,max9286";
 		reg = <0x6c>;
 		poc-supply = <&poc_12v>;
+		maxim,initial-reverse-channel-mV = <170>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.29.1

