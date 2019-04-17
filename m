Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27766C10F12
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03C221773
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfDQKpf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:45:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55200 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725792AbfDQKpe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 06:45:34 -0400
X-UUID: bddb3e8c15c34974a05937210f6c565e-20190417
X-UUID: bddb3e8c15c34974a05937210f6c565e-20190417
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <frederic.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1343567304; Wed, 17 Apr 2019 18:45:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 18:45:28 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 18:45:27 +0800
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
Subject: [RFC PATCH V1 1/6] dt-bindings: mt8183: Add binding for DIP shared memory
Date:   Wed, 17 Apr 2019 18:45:06 +0800
Message-ID: <20190417104511.21514-2-frederic.chen@mediatek.com>
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

This patch adds the binding for describing the shared memory
used to exchange configuration and tuning data between the
co-processor and Digital Image Processing (DIP) unit of the
camera ISP system on Mediatek SoCs.

Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 .../mediatek,reserve-memory-dip_smem.txt      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-dip_smem.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-dip_smem.txt b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-dip_smem.txt
new file mode 100644
index 000000000000..64c001b476b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-dip_smem.txt
@@ -0,0 +1,45 @@
+Mediatek DIP Shared Memory binding
+
+This binding describes the shared memory, which serves the purpose of
+describing the shared memory region used to exchange data between Digital
+Image Processing (DIP) and co-processor in Mediatek SoCs.
+
+The co-processor doesn't have the iommu so we need to use the physical
+address to access the shared buffer in the firmware.
+
+The Digital Image Processing (DIP) can access memory through mt8183 IOMMU so
+it can use dma address to access the memory region.
+(See iommu/mediatek,iommu.txt for the detailed description of Mediatek IOMMU)
+
+
+Required properties:
+
+- compatible: must be "mediatek,reserve-memory-dip_smem"
+
+- reg: required for static allocation (see reserved-memory.txt for
+  the detailed usage)
+
+- alloc-range: required for dynamic allocation. The range must
+  between 0x00000400 and 0x100000000 due to the co-processer's
+  addressing limitation
+
+- size: required for dynamic allocation. The unit is bytes.
+  If you want to enable the full feature of Digital Processing Unit,
+  you need 20 MB at least.
+
+
+Example:
+
+The following example shows the DIP shared memory setup for MT8183.
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		reserve-memory-dip_smem {
+			compatible = "mediatek,reserve-memory-dip_smem";
+			size = <0 0x1400000>;
+			alignment = <0 0x1000>;
+			alloc-ranges = <0 0x40000000 0 0x50000000>;
+		};
+	};
-- 
2.18.0

