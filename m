Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A374C10F12
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A78420821
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfDQKpq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:45:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5063 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731819AbfDQKpq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 06:45:46 -0400
X-UUID: 324cdf1961034db88244632470603343-20190417
X-UUID: 324cdf1961034db88244632470603343-20190417
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <frederic.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1915188953; Wed, 17 Apr 2019 18:45:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 18:45:32 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 18:45:32 +0800
From:   Frederic Chen <frederic.chen@mediatek.com>
To:     <hans.verkuil@cisco.com>,
        <laurent.pinchart+renesas@ideasonboard.com>, <tfiga@chromium.org>,
        <matthias.bgg@gmail.com>, <mchehab@kernel.org>
CC:     <yuzhao@chromium.org>, <zwisler@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <Sean.Cheng@mediatek.com>,
        <sj.huang@mediatek.com>, <christie.yu@mediatek.com>,
        <holmes.chiou@mediatek.com>, <frederic.chen@mediatek.com>,
        <Jerry-ch.Chen@mediatek.com>, <jungo.lin@mediatek.com>,
        <Rynn.Wu@mediatek.com>, <linux-media@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <shik@chromium.org>, <suleiman@chromium.org>
Subject: [RFC PATCH V1 4/6] dts: arm64: mt8183: Add DIP nodes
Date:   Wed, 17 Apr 2019 18:45:09 +0800
Message-ID: <20190417104511.21514-5-frederic.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190417104511.21514-1-frederic.chen@mediatek.com>
References: <20190417104511.21514-1-frederic.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch adds nodes for Digital Image Processing (DIP). DIP is
embedded in Mediatek SoCs and works with the co-processor to
adjust image content according to tuning input data. It also
provides image format conversion, resizing, and rotation
features.

Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index aec68c6b4571..263f79092b74 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -445,6 +445,22 @@
 			#clock-cells = <1>;
 		};
 
+		dip: dip@15022000 {
+			compatible = "mediatek,mt8183-dip";
+			mediatek,larb = <&larb5>;
+			mediatek,mdp3 = <&mdp_rdma0>;
+			mediatek,vpu = <&vpu>;
+			iommus = <&iommu M4U_PORT_CAM_IMGI>;
+			reg = <0 0x15022000 0 0x6000>;
+			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_LOW>;
+			clocks =
+					<&imgsys CLK_IMG_LARB5>,
+					<&imgsys CLK_IMG_DIP>;
+			clock-names =
+					"DIP_CG_IMG_LARB5",
+					"DIP_CG_IMG_DIP";
+		};
+
 		vdecsys: syscon@16000000 {
 			compatible = "mediatek,mt8183-vdecsys", "syscon";
 			reg = <0 0x16000000 0 0x1000>;
-- 
2.18.0

