Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF8BC432BE
	for <linux-media@archiver.kernel.org>; Fri, 23 Jul 2021 01:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E44460E74
	for <linux-media@archiver.kernel.org>; Fri, 23 Jul 2021 01:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhGWAZi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 22 Jul 2021 20:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhGWAZh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 22 Jul 2021 20:25:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B90C061575;
        Thu, 22 Jul 2021 18:06:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5C8B01F447F8
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        stable@vger.kernel.org
Subject: [PATCH] iommu/dma: Fix leak in non-contiguous API
Date:   Thu, 22 Jul 2021 22:05:52 -0300
Message-Id: <20210723010552.50969-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Currently, iommu_dma_alloc_noncontiguous() allocates a
struct dma_sgt_handle object to hold some state needed for
iommu_dma_free_noncontiguous().

However, the handle is neither freed nor returned explicitly by
the ->alloc_noncontiguous method, and therefore seems leaked.
This was found by code inspection, so please review carefully and test.

As a side note, it appears the struct dma_sgt_handle type is exposed
to users of the DMA-API by linux/dma-map-ops.h, but is has no users
or functions returning the type explicitly.

This may indicate it's a good idea to move the struct dma_sgt_handle type
to drivers/iommu/dma-iommu.c. The decision is left to maintainers :-)

Cc: stable@vger.kernel.org
Fixes: e817ee5f2f95c ("dma-iommu: implement ->alloc_noncontiguous")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/iommu/dma-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4e34e8b26579..16c06a1aab80 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -768,6 +768,7 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 	__iommu_dma_unmap(dev, sgt->sgl->dma_address, size);
 	__iommu_dma_free_pages(sh->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 	sg_free_table(&sh->sgt);
+	kfree(sh);
 }
 #endif /* CONFIG_DMA_REMAP */
 
-- 
2.32.0

