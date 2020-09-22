Return-Path: <SRS0=5+7B=C7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE593C2D0E2
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 07:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9847239A1
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 07:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgIVHqD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Sep 2020 03:46:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729751AbgIVHqD (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Sep 2020 03:46:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0169698CB3418CF2C0F;
        Tue, 22 Sep 2020 15:46:00 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 15:45:53 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <sumit.semwal@linaro.org>, <afd@ti.com>,
        <benjamin.gaignard@linaro.org>, <lmark@codeaurora.org>,
        <labbott@redhat.com>, <Brian.Starkey@arm.com>,
        <john.stultz@linaro.org>, <christian.koenig@amd.com>
CC:     <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] dma-buf: heaps: Remove unused variable ret
Date:   Tue, 22 Sep 2020 15:53:28 +0800
Message-ID: <1600761208-45229-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch fixes below warnings reported by coccicheck

./drivers/dma-buf/heaps/heap-helpers.c:202:5-8: Unneeded variable: "ret". Return "0" on line 215

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/dma-buf/heaps/heap-helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
index d0696cf..7969510 100644
--- a/drivers/dma-buf/heaps/heap-helpers.c
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -199,7 +199,6 @@ static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 {
 	struct heap_helper_buffer *buffer = dmabuf->priv;
 	struct dma_heaps_attachment *a;
-	int ret = 0;
 
 	mutex_lock(&buffer->lock);
 
@@ -212,7 +211,7 @@ static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	}
 	mutex_unlock(&buffer->lock);
 
-	return ret;
+	return 0;
 }
 
 static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
-- 
2.6.2

