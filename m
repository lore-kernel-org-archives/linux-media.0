Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E40C46467
	for <linux-media@archiver.kernel.org>; Wed,  4 Jan 2023 09:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbjADJWd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 4 Jan 2023 04:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbjADJVN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 4 Jan 2023 04:21:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A312AE6
        for <linux-media@vger.kernel.org>; Wed,  4 Jan 2023 01:20:54 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nn3vf2m7xznTV0;
        Wed,  4 Jan 2023 17:19:26 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 17:20:52 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-media@vger.kernel.org>
CC:     <laurent.pinchart@ideasonboard.com>, <rmfrfs@gmail.com>,
        <hverkuil-cisco@xs4all.nl>, <mchehab@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH] media: imx: imx7-media-csi: fix missing clk_disable_unprepare() in imx7_csi_init()
Date:   Wed, 4 Jan 2023 17:39:21 +0800
Message-ID: <20230104093921.2570431-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add missing clk_disable_unprepare(), if imx7_csi_dma_setup() fails
in imx7_csi_init().

Fixes: ff43ca911978 ("media: imx: imx7-media-csi: Move CSI configuration before source start")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/media/platform/nxp/imx7-media-csi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
index 886374d3a6ff..1ef92c8c0098 100644
--- a/drivers/media/platform/nxp/imx7-media-csi.c
+++ b/drivers/media/platform/nxp/imx7-media-csi.c
@@ -638,8 +638,10 @@ static int imx7_csi_init(struct imx7_csi *csi)
 	imx7_csi_configure(csi);
 
 	ret = imx7_csi_dma_setup(csi);
-	if (ret < 0)
+	if (ret < 0) {
+		clk_disable_unprepare(csi->mclk);
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.25.1

