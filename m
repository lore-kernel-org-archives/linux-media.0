Return-Path: <SRS0=fNsq=6B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F794C2D0EF
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 12:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F542137B
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 12:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgDQM6U (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:58:20 -0400
Received: from retiisi.org.uk ([95.216.213.190]:50296 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729034AbgDQM6U (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 17 Apr 2020 08:58:20 -0400
Received: from lanttu.localdomain (lanttu.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::c1:2])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 8FE3E634C8C;
        Fri, 17 Apr 2020 15:58:07 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, bingbu.cao@intel.com,
        tfiga@chromium.org, rajmohan.mani@intel.com
Subject: [PATCH 1/1] staging: imgu: Use vmap() instead of __get_vm_area() and map_vm_area()
Date:   Fri, 17 Apr 2020 15:54:31 +0300
Message-Id: <20200417125431.25105-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Switch to vmap() instead of using both __get_vm_area() and map_vm_area().

While at it, also assign vm_struct.nr_pages field.

Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
This is just compile tested but reasonably trivial.

 drivers/staging/media/ipu3/ipu3-dmamap.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-dmamap.c b/drivers/staging/media/ipu3/ipu3-dmamap.c
index 7431322379f6..58e6683e5770 100644
--- a/drivers/staging/media/ipu3/ipu3-dmamap.c
+++ b/drivers/staging/media/ipu3/ipu3-dmamap.c
@@ -123,16 +123,12 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 		iovaddr += PAGE_SIZE;
 	}
 
-	/* Now grab a virtual region */
-	map->vma = __get_vm_area(size, VM_USERMAP, VMALLOC_START, VMALLOC_END);
+	map->vma = vmap(pages, size / PAGE_SIZE, VM_USERMAP, PAGE_KERNEL);
 	if (!map->vma)
 		goto out_unmap;
 
 	map->vma->pages = pages;
-	/* And map it in KVA */
-	if (map_vm_area(map->vma, PAGE_KERNEL, pages))
-		goto out_vunmap;
-
+	map->vma->nr_pages = size / PAGE_SIZE;
 	map->size = size;
 	map->daddr = iova_dma_addr(&imgu->iova_domain, iova);
 	map->vaddr = map->vma->addr;
@@ -142,9 +138,6 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 
 	return map->vma->addr;
 
-out_vunmap:
-	vunmap(map->vma->addr);
-
 out_unmap:
 	imgu_dmamap_free_buffer(pages, size);
 	imgu_mmu_unmap(imgu->mmu, iova_dma_addr(&imgu->iova_domain, iova),
-- 
2.20.1

