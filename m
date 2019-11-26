Return-Path: <SRS0=dpHg=ZS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA8C432C0
	for <linux-media@archiver.kernel.org>; Tue, 26 Nov 2019 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113E720727
	for <linux-media@archiver.kernel.org>; Tue, 26 Nov 2019 14:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfKZObH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:31:07 -0500
Received: from mblankhorst.nl ([141.105.120.124]:35012 "EHLO mblankhorst.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfKZObH (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 26 Nov 2019 09:31:07 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 09:31:06 EST
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] udmabuf: Remove deleted map/unmap handlers.
Date:   Tue, 26 Nov 2019 15:25:16 +0100
Message-Id: <20191126142516.630200-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Commit 7f0de8d80816 ("dma-buf: Drop dma_buf_k(un)map") removed map/unmap
handlers, but they still existed in udmabuf. Remove them there as well

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: 7f0de8d80816 ("dma-buf: Drop dma_buf_k(un)map")
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/dma-buf/udmabuf.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 9635897458a0..9de539c1def4 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -93,26 +93,10 @@ static void release_udmabuf(struct dma_buf *buf)
 	kfree(ubuf);
 }
 
-static void *kmap_udmabuf(struct dma_buf *buf, unsigned long page_num)
-{
-	struct udmabuf *ubuf = buf->priv;
-	struct page *page = ubuf->pages[page_num];
-
-	return kmap(page);
-}
-
-static void kunmap_udmabuf(struct dma_buf *buf, unsigned long page_num,
-			   void *vaddr)
-{
-	kunmap(vaddr);
-}
-
 static const struct dma_buf_ops udmabuf_ops = {
 	.map_dma_buf	  = map_udmabuf,
 	.unmap_dma_buf	  = unmap_udmabuf,
 	.release	  = release_udmabuf,
-	.map		  = kmap_udmabuf,
-	.unmap		  = kunmap_udmabuf,
 	.mmap		  = mmap_udmabuf,
 };
 
-- 
2.24.0

