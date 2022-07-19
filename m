Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0B0C433EF
	for <linux-media@archiver.kernel.org>; Tue, 19 Jul 2022 07:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiGSHI1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 19 Jul 2022 03:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiGSHI1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 19 Jul 2022 03:08:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6230025C54;
        Tue, 19 Jul 2022 00:08:26 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ln8w26wWPzVgQ4;
        Tue, 19 Jul 2022 15:04:34 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 15:08:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:08:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
CC:     <mchehab@kernel.org>, <yunkec@google.com>,
        <kieran.bingham@ideasonboard.com>, <skhan@linuxfoundation.org>
Subject: [PATCH -next] media: vimc: fix wrong pointer passed to PTR_ERR() in vimc_create_links()
Date:   Tue, 19 Jul 2022 15:17:21 +0800
Message-ID: <20220719071721.703986-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

It should be 'ret_link' passed to PTR_ERR().

Fixes: d534b9520a12 ("media: vimc: add ancillary lens")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/media/test-drivers/vimc/vimc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
index c73f91947f44..2ae7a0f11ebf 100644
--- a/drivers/media/test-drivers/vimc/vimc-core.c
+++ b/drivers/media/test-drivers/vimc/vimc-core.c
@@ -211,7 +211,7 @@ static int vimc_create_links(struct vimc_device *vimc)
 			media_create_ancillary_link(ved_primary->ent, ved_ancillary->ent);
 
 		if (IS_ERR(ret_link)) {
-			ret = PTR_ERR(link);
+			ret = PTR_ERR(ret_link);
 			goto err_rm_links;
 		}
 	}
-- 
2.25.1

