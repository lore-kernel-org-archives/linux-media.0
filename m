Return-Path: <SRS0=rgoD=BB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C3C433DF
	for <linux-media@archiver.kernel.org>; Wed, 22 Jul 2020 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043E2206F5
	for <linux-media@archiver.kernel.org>; Wed, 22 Jul 2020 15:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgGVPqM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:46:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8353 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbgGVPqM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 22 Jul 2020 11:46:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 74EFBD4A09AB97755BCC;
        Wed, 22 Jul 2020 23:46:07 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Jul 2020 23:45:56 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>
Subject: [PATCH -next] dma-fence: Make symbol 'dma_fence_lockdep_map' static
Date:   Wed, 22 Jul 2020 23:55:52 +0800
Message-ID: <20200722155552.1698-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The sparse tool complains as follows:

drivers/dma-buf/dma-fence.c:249:25: warning:
 symbol 'dma_fence_lockdep_map' was not declared. Should it be static?

This variable is not used outside of dma-fence.c, so this commit
marks it static.

Fixes: 5fbff813a4a3 ("dma-fence: basic lockdep annotations")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index af1d8ea926b3..43624b4ee13d 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -246,7 +246,7 @@ EXPORT_SYMBOL(dma_fence_context_alloc);
  *   concerned.
  */
 #ifdef CONFIG_LOCKDEP
-struct lockdep_map	dma_fence_lockdep_map = {
+static struct lockdep_map dma_fence_lockdep_map = {
 	.name = "dma_fence_map"
 };
 

