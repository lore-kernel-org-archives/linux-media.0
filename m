Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05CFC433FE
	for <linux-media@archiver.kernel.org>; Tue, 26 Apr 2022 02:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiDZC44 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 25 Apr 2022 22:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiDZC4y (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 25 Apr 2022 22:56:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537B03E0C5;
        Mon, 25 Apr 2022 19:53:48 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KnRGR0y1CzGpNl;
        Tue, 26 Apr 2022 10:51:11 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 10:53:46 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 10:53:46 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
CC:     <mchehab@kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <prabhakar.csengg@gmail.com>
Subject: [PATCH -next 2/3] [media] dm644x_ccdc: remove unnecessary check of res
Date:   Tue, 26 Apr 2022 11:05:43 +0800
Message-ID: <20220426030544.3537713-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426030544.3537713-1-yangyingliang@huawei.com>
References: <20220426030544.3537713-1-yangyingliang@huawei.com>
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

The resource is checked in probe function, so there is
no need do this check in remove function.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/media/platform/ti/davinci/dm644x_ccdc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti/davinci/dm644x_ccdc.c b/drivers/media/platform/ti/davinci/dm644x_ccdc.c
index c6378c4e0074..e4073e99914c 100644
--- a/drivers/media/platform/ti/davinci/dm644x_ccdc.c
+++ b/drivers/media/platform/ti/davinci/dm644x_ccdc.c
@@ -839,8 +839,7 @@ static int dm644x_ccdc_remove(struct platform_device *pdev)
 
 	iounmap(ccdc_cfg.base_addr);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
+	release_mem_region(res->start, resource_size(res));
 	vpfe_unregister_ccdc_device(&ccdc_hw_dev);
 	return 0;
 }
-- 
2.25.1

