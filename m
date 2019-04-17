Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF794C282DC
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A852A20821
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfDQKpw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:45:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57705 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731833AbfDQKpw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 06:45:52 -0400
X-UUID: cb31a070c1c041c391a0f8e7108c15f9-20190417
X-UUID: cb31a070c1c041c391a0f8e7108c15f9-20190417
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <frederic.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1159871142; Wed, 17 Apr 2019 18:45:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 18:45:34 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 18:45:34 +0800
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
Subject: [RFC PATCH V1 5/6] media: platform: Add Mediatek DIP driver KConfig
Date:   Wed, 17 Apr 2019 18:45:10 +0800
Message-ID: <20190417104511.21514-6-frederic.chen@mediatek.com>
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

This patch adds KConfig for Mediatek Digital Image Processing
driver(DIP). DIP is embedded in Mediatek SoCs. It provides
image format conversion, resizing, and rotation function.

Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 drivers/media/platform/Kconfig         |  2 ++
 drivers/media/platform/mtk-isp/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 drivers/media/platform/mtk-isp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index a505e9f5a1e2..ef08d48589a4 100644
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
index 000000000000..e5f36d1070ee
--- /dev/null
+++ b/drivers/media/platform/mtk-isp/Kconfig
@@ -0,0 +1,21 @@
+config VIDEO_MEDIATEK_ISP_DIP_SUPPORT
+	bool "Mediatek Digital Image Processing function"
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
+	    Support the basic Digital Image Processing (DIP) driver.
+
+	    DIP driver provides image format conversion, resizing,
+	    and rotation function through the low power hardware.
+	    DIP also supports multiple output feature. It can
+	    generate two or more output image with different effect
+	    based on a single input image at the same time.
+
-- 
2.18.0

