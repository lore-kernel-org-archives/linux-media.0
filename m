Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390CBC4361B
	for <linux-media@archiver.kernel.org>; Tue, 15 Dec 2020 02:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF280207A2
	for <linux-media@archiver.kernel.org>; Tue, 15 Dec 2020 02:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgLOCj3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:39:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9529 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgLOCjO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Dec 2020 21:39:14 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cw2VT2Dh3zhrph;
        Tue, 15 Dec 2020 10:37:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 15 Dec 2020 10:38:25 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <sumit.semwal@linaro.org>, <benjamin.gaignard@linaro.org>,
        <lmark@codeaurora.org>, <labbott@redhat.com>,
        <Brian.Starkey@arm.com>, <john.stultz@linaro.org>,
        <christian.koenig@amd.com>
CC:     <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dma-buf: system_heap: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Tue, 15 Dec 2020 10:38:35 +0800
Message-ID: <1607999915-53034-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes coccicheck warning:
drivers/dma-buf/heaps/system_heap.c:437:1-3: WARNING: PTR_ERR_OR_ZERO
can be used

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/dma-buf/heaps/system_heap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 17e0e9a..c5d8a40 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -434,10 +434,8 @@ static int system_heap_create(void)
 	exp_info.priv = NULL;
 
 	sys_heap = dma_heap_add(&exp_info);
-	if (IS_ERR(sys_heap))
-		return PTR_ERR(sys_heap);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(sys_heap);
 }
 module_init(system_heap_create);
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

