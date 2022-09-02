Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7AEECAAD5
	for <linux-media@archiver.kernel.org>; Fri,  2 Sep 2022 08:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiIBIrv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 2 Sep 2022 04:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbiIBIrR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 2 Sep 2022 04:47:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15653C2EB8;
        Fri,  2 Sep 2022 01:47:15 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJrzj6pwczlWYX;
        Fri,  2 Sep 2022 16:43:45 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 16:47:13 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 2 Sep
 2022 16:47:12 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <mchehab@kernel.org>, <matthias.bgg@gmail.com>,
        <hverkuil-cisco@xs4all.nl>, <ping-hsun.wu@mediatek.com>,
        <daoyuan.huang@mediatek.com>, <moudy.ho@mediatek.com>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH 3/3] media: platform: mtk-mdp3: fix error return code in mdp_vpu_dev_init()
Date:   Fri, 2 Sep 2022 16:58:20 +0800
Message-ID: <20220902085820.3777360-4-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902085820.3777360-1-sunke32@huawei.com>
References: <20220902085820.3777360-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If mdp_vpu_shared_mem_alloc failed, mdp_vpu_dev_init should return -ENOMEM.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
index 9f5844385c8f..078040b7f65e 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
@@ -175,6 +175,7 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 	mem_size = vpu_alloc_size;
 	if (mdp_vpu_shared_mem_alloc(vpu)) {
 		dev_err(&mdp->pdev->dev, "VPU memory alloc fail!");
+		err = -ENOMEM;
 		goto err_mem_alloc;
 	}
 
-- 
2.31.1

