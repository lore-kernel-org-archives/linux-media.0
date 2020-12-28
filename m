Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF72C4332B
	for <linux-media@archiver.kernel.org>; Mon, 28 Dec 2020 15:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610DE20776
	for <linux-media@archiver.kernel.org>; Mon, 28 Dec 2020 15:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391527AbgL1Pdp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 28 Dec 2020 10:33:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10084 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404961AbgL1NvS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 28 Dec 2020 08:51:18 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4JnV63rnzMBTF;
        Mon, 28 Dec 2020 21:49:34 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 21:50:26 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <prabhakar.csengg@gmail.com>, <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] media: platform: davinci: Use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 28 Dec 2020 21:51:04 +0800
Message-ID: <20201228135104.28566-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/media/platform/davinci/vpif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
index 5e67994e62cc..f1ce10828b8e 100644
--- a/drivers/media/platform/davinci/vpif.c
+++ b/drivers/media/platform/davinci/vpif.c
@@ -41,7 +41,7 @@ MODULE_ALIAS("platform:" VPIF_DRIVER_NAME);
 #define VPIF_CH2_MAX_MODES	15
 #define VPIF_CH3_MAX_MODES	2
 
-spinlock_t vpif_lock;
+DEFINE_SPINLOCK(vpif_lock);
 EXPORT_SYMBOL_GPL(vpif_lock);
 
 void __iomem *vpif_base;
@@ -437,7 +437,6 @@ static int vpif_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get(&pdev->dev);
 
-	spin_lock_init(&vpif_lock);
 	dev_info(&pdev->dev, "vpif probe success\n");
 
 	/*
-- 
2.22.0

