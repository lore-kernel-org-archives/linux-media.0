Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B9C00528
	for <linux-media@archiver.kernel.org>; Thu, 27 Jul 2023 02:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjG0CKt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 Jul 2023 22:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG0CKs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 Jul 2023 22:10:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7059A19A0;
        Wed, 26 Jul 2023 19:10:47 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RBDgs3YptzLntD;
        Thu, 27 Jul 2023 10:08:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 10:10:44 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <mikhail.ulyanov@cogentembedded.com>, <mchehab@kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] media: rcar_jpu: Remove redundant dev_err()
Date:   Thu, 27 Jul 2023 10:11:28 +0000
Message-ID: <20230727101128.2752153-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There is no need to call the dev_err() function directly to print a custom
message when handling an error from platform_get_irq() function as
it is going to display an appropriate error message in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/media/platform/renesas/rcar_jpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_jpu.c b/drivers/media/platform/renesas/rcar_jpu.c
index 2b8cb50f54de..2c01bf14ccb4 100644
--- a/drivers/media/platform/renesas/rcar_jpu.c
+++ b/drivers/media/platform/renesas/rcar_jpu.c
@@ -1601,10 +1601,8 @@ static int jpu_probe(struct platform_device *pdev)
 
 	/* interrupt service routine registration */
 	jpu->irq = ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot find IRQ\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_request_irq(&pdev->dev, jpu->irq, jpu_irq_handler, 0,
 			       dev_name(&pdev->dev), jpu);
-- 
2.34.1

