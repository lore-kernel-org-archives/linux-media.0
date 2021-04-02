Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E9C433ED
	for <linux-media@archiver.kernel.org>; Fri,  2 Apr 2021 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CDA61105
	for <linux-media@archiver.kernel.org>; Fri,  2 Apr 2021 09:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhDBJ3v (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:29:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16333 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBJ3v (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 2 Apr 2021 05:29:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBZTS4x0mz9vvD;
        Fri,  2 Apr 2021 17:27:40 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:29:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-media@vger.kernel.org>
CC:     <robert.foss@linaro.org>
Subject: [PATCH -next] media: camss: csid: Remove redundant dev_err call in msm_csid_subdev_init()
Date:   Fri, 2 Apr 2021 17:32:55 +0800
Message-ID: <20210402093255.2457184-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 463760c29294..cc11fbfdae13 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -568,10 +568,8 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
 	csid->base = devm_ioremap_resource(dev, r);
-	if (IS_ERR(csid->base)) {
-		dev_err(dev, "could not map memory\n");
+	if (IS_ERR(csid->base))
 		return PTR_ERR(csid->base);
-	}
 
 	/* Interrupt */
 
-- 
2.25.1

