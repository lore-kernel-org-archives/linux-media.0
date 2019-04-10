Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D7C10F14
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB642133D
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfDJMnQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:43:16 -0400
Received: from kozue.soulik.info ([108.61.200.231]:44094 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbfDJMnP (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:43:15 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:401])
        by kozue.soulik.info (Postfix) with ESMTPA id 1500C1014F7;
        Wed, 10 Apr 2019 21:44:00 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     Randy Li <ayaka@soulik.info>, randy.li@rock-chips.com,
        hverkuil@xs4all.nl, maxime.ripard@bootlin.com, joro@8bytes.org,
        nicolas@ndufresne.ca, jernej.skrabec@gmail.com,
        paul.kocialkowski@bootlin.com, thomas.petazzoni@bootlin.com,
        mchehab@kernel.org, ezequiel@collabora.com, posciak@chromium.org,
        groeck@chromium.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v3 9/9] arm64: dts: rockchip: add video codec for rk3328
Date:   Wed, 10 Apr 2019 20:42:26 +0800
Message-Id: <20190410124226.8612-10-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410124226.8612-1-ayaka@soulik.info>
References: <20190410124226.8612-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Randy Li <ayaka@soulik.info>

Having problem with vepu2

The sclk_vdec_core for RKVDEC is in gpll at vendor kernel.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts   |  32 ++++++
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts |  32 ++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      | 108 +++++++++++++++++-
 3 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 8302d86d35c4..c89714f79f93 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -213,6 +213,18 @@
 	};
 };
 
+&rkvdec {
+	status = "okay";
+};
+
+&rkvdec_mmu {
+	status = "okay";
+};
+
+&rkvdec_srv {
+	status = "okay";
+};
+
 &sdio {
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -269,3 +281,23 @@
 &usb_host0_ohci {
 	status = "okay";
 };
+
+&vdpu {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vpu_mmu {
+	status = "okay";
+};
+
+&vpu_service{
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 2157a528276b..520e444806cc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -256,6 +256,14 @@
 	};
 };
 
+&h265e {
+	status = "okay";
+};
+
+&h265e_mmu {
+	status = "okay";
+};
+
 &i2s1 {
 	status = "okay";
 
@@ -300,6 +308,18 @@
 	};
 };
 
+&rkvdec {
+	status = "okay";
+};
+
+&rkvdec_mmu {
+	status = "okay";
+};
+
+&rkvdec_srv {
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -370,6 +390,10 @@
 	status = "okay";
 };
 
+&vdpu {
+	status = "okay";
+};
+
 &vop {
 	status = "okay";
 };
@@ -377,3 +401,11 @@
 &vop_mmu {
 	status = "okay";
 };
+
+&vpu_mmu {
+	status = "okay";
+};
+
+&vpu_service{
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 55a72abed6e7..9b3f8d22b60a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -573,6 +573,27 @@
 		resets = <&cru SRST_GPU_A>;
 	};
 
+	venc_srv: venc-srv {
+		compatible = "rockchip,mpp-service";
+		status = "disabled";
+	};
+
+	h265e: h265e@ff330000 {
+		compatible = "rockchip,hevc-encoder-v1";
+		reg = <0x0 0xff330000 0 0x200>;
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_H265>, <&cru PCLK_H265>,
+			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
+			<&cru ACLK_RKVENC>, <&cru ACLK_AXISRAM>;
+		clock-names = "aclk_h265", "pclk_h265", "clk_core",
+			"clk_dsp", "aclk_venc", "aclk_axi2sram";
+		iommus = <&h265e_mmu>;
+		rockchip,srv = <&venc_srv>;
+		syscon = <&grf 0x040c 0x8000800 0x80000>;
+		power-domains = <&power RK3328_PD_HEVC>;
+		status = "disabled";
+	};
+
 	h265e_mmu: iommu@ff330200 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff330200 0 0x100>;
@@ -584,6 +605,25 @@
 		status = "disabled";
 	};
 
+	vepu: vepu@ff340000 {
+		compatible = "rockchip,vpu-encoder-v2";
+		reg = <0x0 0xff340000 0x0 0x400>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_H264>, <&cru HCLK_H264>,
+			<&cru SCLK_VENC_CORE>;
+		clock-names = "aclk_vcodec", "hclk_vcodec",
+			"clk_core";
+		resets = <&cru SRST_RKVENC_H264_A>,
+			<&cru SRST_RKVENC_H264_H>;
+		reset-names = "video_a", "video_h";
+		iommus = <&vepu_mmu>;
+		rockchip,srv = <&venc_srv>;
+		syscon = <&grf 0x040c 0x8000800 0x80000>;
+		power-domains = <&power RK3328_PD_HEVC>;
+		status = "disabled";
+	};
+
+
 	vepu_mmu: iommu@ff340800 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff340800 0x0 0x40>;
@@ -595,6 +635,42 @@
 		status = "disabled";
 	};
 
+
+	vpu_service: vdpu-srv {
+		compatible = "rockchip,mpp-service";
+		status = "disabled";
+	};
+
+	vdpu: vpu-decoder@ff350000 {
+		compatible = "rockchip,vpu-decoder-v2";
+		reg = <0x0 0xff350400 0x0 0x400>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "irq_dec";
+		resets = <&cru SRST_VCODEC_A>, <&cru SRST_VCODEC_H>;
+		reset-names = "video_a", "video_h";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk_vcodec", "hclk_vcodec";
+		iommus = <&vpu_mmu>;
+		power-domains = <&power RK3328_PD_VPU>;
+		rockchip,srv = <&vpu_service>;
+		status = "disabled";
+	};
+
+	avsd: avs-decoder@ff351000 {
+		compatible = "rockchip,avs-decoder-v1";
+		reg = <0x0 0xff351000 0x0 0x200>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "irq_dec";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk_vcodec", "hclk_vcodec";
+		resets = <&cru SRST_VCODEC_A>, <&cru SRST_VCODEC_H>;
+		reset-names = "video_a", "video_h";
+		power-domains = <&power RK3328_PD_VPU>;
+		iommus = <&vpu_mmu>;
+		rockchip,srv = <&vpu_service>;
+		status = "disabled";
+	};
+
 	vpu_mmu: iommu@ff350800 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff350800 0x0 0x40>;
@@ -606,6 +682,34 @@
 		status = "disabled";
 	};
 
+	rkvdec_srv: rkvdec-srv {
+		compatible = "rockchip,mpp-service";
+		status = "disabled";
+	};
+
+	rkvdec: rkvdec@ff36000 {
+		compatible = "rockchip,video-decoder-v1";
+		reg = <0x0 0xff360000 0x0 0x400>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "irq_dec";
+		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>,
+			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>;
+		clock-names = "aclk_vcodec", "hclk_vcodec", "clk_cabac",
+			"clk_core";
+		assigned-clocks = <&cru ACLK_RKVDEC_PRE>, <&cru SCLK_VDEC_CORE>;
+		assigned-clock-parents = <&cru PLL_GPLL>, <&cru PLL_GPLL>;
+		assigned-clock-rates = <500000000>, <245760000>;
+		resets = <&cru SRST_VDEC_A>, <&cru SRST_VDEC_H>,
+			<&cru SRST_VDEC_NIU_A>, <&cru SRST_VDEC_NIU_H>,
+			<&cru SRST_VDEC_CABAC>, <&cru SRST_VDEC_CORE>;
+		reset-names = "video_a", "video_h", "niu_a", "niu_h",
+			"video_cabac", "video_core";
+		iommus = <&rkvdec_mmu>;
+		power-domains = <&power RK3328_PD_VIDEO>;
+		rockchip,srv = <&rkvdec_srv>;
+		status = "disabled";
+	};
+
 	rkvdec_mmu: iommu@ff360480 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
@@ -740,8 +844,8 @@
 			<15000000>, <15000000>,
 			<300000000>, <100000000>,
 			<400000000>, <100000000>,
-			<50000000>, <100000000>,
-			<100000000>, <100000000>,
+			<50000000>, <300000000>,
+			<300000000>, <300000000>,
 			<50000000>, <50000000>,
 			<50000000>, <50000000>,
 			<24000000>, <600000000>,
-- 
2.20.1

