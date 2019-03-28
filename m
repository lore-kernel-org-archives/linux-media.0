Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0C0C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 09:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B91217D9
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 09:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfC1J5h (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:57:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45886 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726210AbfC1J5g (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 05:57:36 -0400
X-UUID: 58a253aee72548aeb76cdae1657cfca2-20190328
X-UUID: 58a253aee72548aeb76cdae1657cfca2-20190328
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jungo.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1846363850; Thu, 28 Mar 2019 17:57:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 17:57:21 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 17:57:21 +0800
From:   Jungo Lin <jungo.lin@mediatek.com>
To:     <tfiga@chromium.org>, <hans.verkuil@cisco.com>,
        <laurent.pinchart+renesas@ideasonboard.com>,
        <matthias.bgg@gmail.com>, <mchehab@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <Sean.Cheng@mediatek.com>,
        <sj.huang@mediatek.com>, <christie.yu@mediatek.com>,
        <holmes.chiou@mediatek.com>, <frederic.chen@mediatek.com>,
        <Jerry-ch.Chen@mediatek.com>, <jungo.lin@mediatek.com>,
        <frankie.chiu@mediatek.com>, <seraph.huang@mediatek.com>,
        <ryan.yu@mediatek.com>, <Rynn.Wu@mediatek.com>,
        <yuzhao@chromium.org>, <zwisler@chromium.org>,
        <srv_heupstream@mediatek.com>
Subject: [RFC V1 03/12] dt-bindings: mt8183: Added cam-smem dt-bindings
Date:   Thu, 28 Mar 2019 17:56:38 +0800
Message-ID: <1553767007-11909-4-git-send-email-jungo.lin@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553767007-11909-1-git-send-email-jungo.lin@mediatek.com>
References: <jungo.lin@mediatek.com>
 <1553767007-11909-1-git-send-email-jungo.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BEC59B0276CE335AF77C20BAD8CBBCB2DFA11482ACAD23E545822F55CDBAA9A12000:8
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch adds the DT binding documentation for the shared memory
between Pass 1 unit of the camera ISP system and the co-processor
in Mediatek SoCs.

Signed-off-by: Jungo Lin <jungo.lin@mediatek.com>
---
 .../bindings/media/mediatek,cam_smem.txt           | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,cam_smem.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek,cam_smem.txt b/Documentation/devicetree/bindings/media/mediatek,cam_smem.txt
new file mode 100644
index 0000000..d34006a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,cam_smem.txt
@@ -0,0 +1,32 @@
+Mediatek Camera ISP Pass 1 Shared Memory Device
+
+Mediatek Camera ISP Pass 1 Shared Memory Device is used to manage shared
+memory among CPU, Camera ISP Pass 1 hardware and coprocessor. The Camera
+ISP Pass 1 is a hardware unit for processing image signal from the image
+sensor. Camera ISP Pass 1 is responsible for RAW processing and 3A statistics.
+
+It is associated with a reserved memory region
+(Please see Documentation/devicetree/bindings/reserved-memory/mediatek,
+reserve-memory-cam_smem.txt) and and provides the context to
+allocate memory with dma addresses.
+
+Required properties:
+- compatible: must be "mediatek,mt8183-cam_smem" for MT8183.
+
+- iommus: shall point to the respective IOMMU block with master port
+  as argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+  for details.
+
+- mediatek,larb: must contain the local arbiters in the current SoCs, see
+  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+  for details.
+
+Example:
+	cam_smem: cam_smem {
+		compatible = "mediatek,mt8183-cam_smem";
+		mediatek,larb = <&larb3>,
+				<&larb6>;
+		iommus = <&iommu M4U_PORT_CAM_LSCI0>,
+			 <&iommu M4U_PORT_CAM_LSCI1>,
+			 <&iommu M4U_PORT_CAM_BPCI>;
+	};
-- 
1.9.1

