Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE56EC433ED
	for <linux-media@archiver.kernel.org>; Fri,  9 Apr 2021 06:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87078610CF
	for <linux-media@archiver.kernel.org>; Fri,  9 Apr 2021 06:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhDIGrN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 9 Apr 2021 02:47:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16495 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhDIGrN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 9 Apr 2021 02:47:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGpWb08XQzPp1b;
        Fri,  9 Apr 2021 14:44:11 +0800 (CST)
Received: from ubuntu1604.huawei.com (10.67.174.160) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 14:46:53 +0800
From:   Xiang Yang <xiangyang3@huawei.com>
To:     <xiangyang3@huawei.com>, Jernej Skrabec <jernej.skrabec@siol.net>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] media: sunxi: sun8i-rotate: fix PM reference leak in rotate_start_streaming()
Date:   Fri, 9 Apr 2021 14:46:58 +0800
Message-ID: <20210409064658.90493-1-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.67.174.160]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 .../platform/sunxi/sun8i-rotate/sun8i_rotate.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c b/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
index 3f81dd17755c..fbcca59a0517 100644
--- a/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
+++ b/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
@@ -494,7 +494,7 @@ static int rotate_start_streaming(struct vb2_queue *vq, unsigned int count)
 		struct device *dev = ctx->dev->dev;
 		int ret;
 
-		ret = pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0) {
 			dev_err(dev, "Failed to enable module\n");
 

