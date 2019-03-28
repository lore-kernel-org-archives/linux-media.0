Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3531EC43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E07A217D9
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 09:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfC1J5f (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:57:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24883 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726094AbfC1J5e (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 05:57:34 -0400
X-UUID: 5c5b25c8eff34c37ac25d8f81d5c263d-20190328
X-UUID: 5c5b25c8eff34c37ac25d8f81d5c263d-20190328
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <jungo.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 676310336; Thu, 28 Mar 2019 17:57:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 17:57:25 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 17:57:24 +0800
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
Subject: [RFC V1 06/12] media: platform: Add Mediatek ISP Pass 1 driver Kconfig
Date:   Thu, 28 Mar 2019 17:56:41 +0800
Message-ID: <1553767007-11909-7-git-send-email-jungo.lin@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553767007-11909-1-git-send-email-jungo.lin@mediatek.com>
References: <jungo.lin@mediatek.com>
 <1553767007-11909-1-git-send-email-jungo.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch adds Kconfig for Pass 1 (P1) unit driver of Mediatek's
camera ISP system. ISP P1 unit is embedded in Mediatek SoCs. It
provides RAW processing which includes optical black correction,
defect pixel correction, W/IR imbalance correction and lens
shading correction.

Signed-off-by: Jungo Lin <jungo.lin@mediatek.com>
---
 drivers/media/platform/Kconfig         |  2 ++
 drivers/media/platform/mtk-isp/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 drivers/media/platform/mtk-isp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 4acbed1..7be62e0 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -32,6 +32,8 @@ source "drivers/media/platform/davinci/Kconfig"
 
 source "drivers/media/platform/omap/Kconfig"
 
+source "drivers/media/platform/mtk-isp/Kconfig"
+
 config VIDEO_ASPEED
 	tristate "Aspeed AST2400 and AST2500 Video Engine driver"
 	depends on VIDEO_V4L2
diff --git a/drivers/media/platform/mtk-isp/Kconfig b/drivers/media/platform/mtk-isp/Kconfig
new file mode 100644
index 0000000..9932563
--- /dev/null
+++ b/drivers/media/platform/mtk-isp/Kconfig
@@ -0,0 +1,21 @@
+config VIDEO_MEDIATEK_ISP_PASS1_SUPPORT
+	bool "Mediatek pass 1 image processing function"
+
+	select DMA_SHARED_BUFFER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_CORE
+	select VIDEOBUF2_V4L2
+	select VIDEOBUF2_MEMOPS
+	select VIDEOBUF2_VMALLOC
+	select MEDIA_CONTROLLER
+
+	default n
+	help
+		Pass 1 driver controls 3A (autofocus, exposure,
+		and white balance) with tuning parameters and outputs
+		the capture image buffers in Mediatek's camera system.
+
+		Choose y if you want to use Mediatek SoCs to create image
+		capture application such as video recording and still image
+		capture.
-- 
1.9.1

