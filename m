Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B944C43460
	for <linux-media@archiver.kernel.org>; Thu,  1 Apr 2021 10:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01007610CB
	for <linux-media@archiver.kernel.org>; Thu,  1 Apr 2021 10:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhDAKpD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:45:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15066 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbhDAKo6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 1 Apr 2021 06:44:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9zhg3rMVzNrWR;
        Thu,  1 Apr 2021 18:20:19 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 18:22:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mchehab@kernel.org>, <p.zabel@pengutronix.de>
Subject: [PATCH -next] media: imx-pxp: remove redundant dev_err call in pxp_probe()
Date:   Thu, 1 Apr 2021 18:26:07 +0800
Message-ID: <20210401102607.1554006-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There is an error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/media/platform/imx-pxp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/imx-pxp.c b/drivers/media/platform/imx-pxp.c
index 08d76eb05ed1..13bc88e9358e 100644
--- a/drivers/media/platform/imx-pxp.c
+++ b/drivers/media/platform/imx-pxp.c
@@ -1654,11 +1654,8 @@ static int pxp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dev->mmio = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dev->mmio)) {
-		ret = PTR_ERR(dev->mmio);
-		dev_err(&pdev->dev, "Failed to map register space: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dev->mmio))
+		return PTR_ERR(dev->mmio);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.25.1

