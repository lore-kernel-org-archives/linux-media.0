Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C87DC433EF
	for <linux-media@archiver.kernel.org>; Fri, 17 Jun 2022 01:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379537AbiFQB3a (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Jun 2022 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFQB33 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Jun 2022 21:29:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C963518;
        Thu, 16 Jun 2022 18:29:28 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LPLwH3fl8zSgsn;
        Fri, 17 Jun 2022 09:26:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 09:29:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 09:29:26 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
CC:     <mchehab@kernel.org>, <djrscally@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <sakari.ailus@linux.intel.com>
Subject: [PATCH] media: ov7251: add missing clk_disable_unprepare() on error in ov7251_set_power_on()
Date:   Fri, 17 Jun 2022 09:39:43 +0800
Message-ID: <20220617013943.851327-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add the missing clk_disable_unprepare() before return
from ov7251_set_power_on() in the error handling case.

Fixes: 9e1d3012cc10 ("media: i2c: Remove .s_power() from ov7251")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/media/i2c/ov7251.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 0e7be15bc20a..40c207d1d7af 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -934,6 +934,7 @@ static int ov7251_set_power_on(struct device *dev)
 					ARRAY_SIZE(ov7251_global_init_setting));
 	if (ret < 0) {
 		dev_err(ov7251->dev, "error during global init\n");
+		clk_disable_unprepare(ov7251->xclk);
 		ov7251_regulators_disable(ov7251);
 		return ret;
 	}
-- 
2.25.1

