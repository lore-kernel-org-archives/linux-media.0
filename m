Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31B7C282E3
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 10:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870CF218C3
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 10:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfDWKp1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:45:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28888 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727408AbfDWKp1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 06:45:27 -0400
X-UUID: 387cfebc9cef46faa2dba196587f9b7e-20190423
X-UUID: 387cfebc9cef46faa2dba196587f9b7e-20190423
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <jerry-ch.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 215853013; Tue, 23 Apr 2019 18:45:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 23 Apr 2019 18:45:10 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 23 Apr 2019 18:45:10 +0800
From:   Jerry-ch Chen <Jerry-Ch.chen@mediatek.com>
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
        <shik@chromium.org>, <suleiman@chromium.org>,
        Jerry-ch Chen <jerry-ch.chen@mediatek.com>
Subject: [RFC PATCH V1 1/6] dt-bindings: mt8183: Add binding for FD shared memory
Date:   Tue, 23 Apr 2019 18:45:00 +0800
Message-ID: <20190423104505.38778-2-Jerry-Ch.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190423104505.38778-1-Jerry-Ch.chen@mediatek.com>
References: <20190423104505.38778-1-Jerry-Ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 65022E1EA85BCE5838E1923516950899A236E39117C10850EA9D034392EDF8EC2000:8
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Jerry-ch Chen <jerry-ch.chen@mediatek.com>

This patch adds the binding for describing the shared memory
used to exchange meta data between the co-processor and Face
Detection (FD) unit of the camera system on Mediatek SoCs.

Signed-off-by: Jerry-ch Chen <jerry-ch.chen@mediatek.com>
---
 .../mediatek,reserve-memory-fd_smem.txt       | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt
new file mode 100644
index 000000000000..52ae5071e238
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt
@@ -0,0 +1,44 @@
+Mediatek FD Shared Memory binding
+
+This binding describes the shared memory, which serves the purpose of
+describing the shared memory region used to exchange data between Face
+Detection hardware (FD) and co-processor in Mediatek SoCs.
+
+The co-processor doesn't have the iommu so we need to use the physical
+address to access the shared buffer in the firmware.
+
+The Face Detection hardware (FD) can access memory through mt8183 IOMMU so
+it can use dma address to access the memory region.
+(See iommu/mediatek,iommu.txt for the detailed description of Mediatek IOMMU)
+
+
+Required properties:
+
+- compatible: must be "mediatek,reserve-memory-fd_smem"
+
+- reg: required for static allocation (see reserved-memory.txt for
+  the detailed usage)
+
+- alloc-range: required for dynamic allocation. The range must
+  between 0x00000400 and 0x100000000 due to the co-processer's
+  addressing limitation
+
+- size: required for dynamic allocation. The unit is bytes.
+  for Face Detection Unit, you need 1 MB at least.
+
+
+Example:
+
+The following example shows the FD shared memory setup for MT8183.
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		reserve-memory-fd_smem {
+			compatible = "mediatek,reserve-memory-fd_smem";
+			size = <0 0x00100000>;
+			alignment = <0 0x1000>;
+			alloc-ranges = <0 0x40000000 0 0x100000000>;
+		};
+	};
\ No newline at end of file
-- 
2.18.0

