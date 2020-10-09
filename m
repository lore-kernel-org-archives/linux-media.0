Return-Path: <SRS0=wJZ5=DQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A010C433DF
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 12:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0A222B8
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 12:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbgJIMdy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 9 Oct 2020 08:33:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbgJIMdy (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 9 Oct 2020 08:33:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 57F12A2B7E1770942A4B;
        Fri,  9 Oct 2020 20:33:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 20:33:44 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <rick.chang@mediatek.com>, <bin.liu@mediatek.com>,
        <mchehab@kernel.org>, <matthias.bgg@gmail.com>,
        <tiffany.lin@mediatek.com>, <andrew-ct.chen@mediatek.com>,
        <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <hverkuil-cisco@xs4all.nl>, <jcliang@chromium.org>,
        <minghsiu.tsai@mediatek.com>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 3/7] media: platform: add missing put_device() call in mtk_jpeg_remove()
Date:   Fri, 9 Oct 2020 20:38:00 +0800
Message-ID: <20201009123804.3977562-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201009123804.3977562-1-yukuai3@huawei.com>
References: <20201009123804.3977562-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

of_find_device_by_node() is called in mtk_jpeg_clk_init() from
mtk_jpeg_probe(), and mtk_jpeg_remove() doesn't have a corresponding
put_device().

Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index f0c412f96d61..87535f5142fa 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -1454,6 +1454,7 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
 	video_device_release(jpeg->vdev);
 	v4l2_m2m_release(jpeg->m2m_dev);
 	v4l2_device_unregister(&jpeg->v4l2_dev);
+	put_device(jpeg->larb);
 
 	return 0;
 }
-- 
2.25.4

