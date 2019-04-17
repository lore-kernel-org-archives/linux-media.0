Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E8AC282DA
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808AA217D7
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfDQKpr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:45:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5063 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731833AbfDQKpr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 06:45:47 -0400
X-UUID: ed78bb1a2223441f88a5fbc4a7b00dcf-20190417
X-UUID: ed78bb1a2223441f88a5fbc4a7b00dcf-20190417
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <frederic.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 912188842; Wed, 17 Apr 2019 18:45:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 18:45:30 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 18:45:30 +0800
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
Subject: [RFC PATCH V1 3/6] dt-bindings: mt8183: Added DIP dt-bindings
Date:   Wed, 17 Apr 2019 18:45:08 +0800
Message-ID: <20190417104511.21514-4-frederic.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190417104511.21514-1-frederic.chen@mediatek.com>
References: <20190417104511.21514-1-frederic.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 302D79E21E62CEB51D6FEDD02C8F4DBE7035FDD63513144105294D1DF1FB5E262000:8
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch adds DT binding documentation for the Digital Image
Processing (DIP) unit of camera ISP system on Mediatek's SoCs.

Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 .../bindings/media/mediatek,mt8183-dip.txt    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8183-dip.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8183-dip.txt b/Documentation/devicetree/bindings/media/mediatek,mt8183-dip.txt
new file mode 100644
index 000000000000..0e1994bf82f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8183-dip.txt
@@ -0,0 +1,35 @@
+* Mediatek Digital Image Processor (DIP)
+
+Digital Image Processor (DIP) unit in Mediatek ISP system is responsible for
+image content adjustment according to the tuning parameters. DIP can process
+the image form memory buffer and output the processed image to multiple output
+buffers. Furthermore, it can support demosaicing and noise reduction on the
+images.
+
+Required properties:
+- compatible: "mediatek,mt8183-dip"
+- reg: Physical base address and length of the function block register space
+- interrupts: interrupt number to the cpu
+- iommus: should point to the respective IOMMU block with master port as
+  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+  for details.
+- mediatek,larb: must contain the local arbiters in the current Socs, see
+  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+  for details.
+- clocks: must contain the local arbiters 5 (LARB5) and DIP clock
+- clock-names: must contain DIP_CG_IMG_LARB5 and DIP_CG_IMG_DIP
+
+Example:
+	dip: dip@15022000 {
+		compatible = "mediatek,mt8183-dip";
+		mediatek,larb = <&larb5>;
+		mediatek,mdp3 = <&mdp_rdma0>;
+		mediatek,vpu = <&vpu>;
+		iommus = <&iommu M4U_PORT_CAM_IMGI>;
+		reg = <0 0x15022000 0 0x6000>;
+		interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&imgsys CLK_IMG_LARB5>,
+			 <&imgsys CLK_IMG_DIP>;
+		clock-names = "DIP_CG_IMG_LARB5",
+			      "DIP_CG_IMG_DIP";
+	};
-- 
2.18.0

