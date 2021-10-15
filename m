Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E35C433F5
	for <linux-media@archiver.kernel.org>; Fri, 15 Oct 2021 12:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9476460E54
	for <linux-media@archiver.kernel.org>; Fri, 15 Oct 2021 12:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhJOMJD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbhJOMJA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Oct 2021 08:09:00 -0400
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Oct 2021 05:06:52 PDT
Received: from mblankhorst.nl (mblankhorst.nl [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF16C061570
        for <linux-media@vger.kernel.org>; Fri, 15 Oct 2021 05:06:52 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 2/2] dma-buf: Fix dma_resv_test_signaled.
Date:   Fri, 15 Oct 2021 13:57:20 +0200
Message-Id: <20211015115720.79958-3-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015115720.79958-1-maarten.lankhorst@linux.intel.com>
References: <20211015115720.79958-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Commit 7fa828cb9265 ("dma-buf: use new iterator in dma_resv_test_signaled")
accidentally forgot to test whether the dma-buf is actually signaled, breaking
pretty much everything depending on it.

Fixes: 7fa828cb9265 ("dma-buf: use new iterator in dma_resv_test_signaled")
Cc: Christian König <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/dma-buf/dma-resv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 70a8082660c5..37ab2875e469 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -655,14 +655,16 @@ bool dma_resv_test_signaled(struct dma_resv *obj, bool test_all)
 {
 	struct dma_resv_iter cursor;
 	struct dma_fence *fence;
+	bool ret = true;
 
 	dma_resv_iter_begin(&cursor, obj, test_all);
 	dma_resv_for_each_fence_unlocked(&cursor, fence) {
-		dma_resv_iter_end(&cursor);
-		return false;
+		ret = dma_fence_is_signaled(fence);
+		if (!ret)
+			break;
 	}
 	dma_resv_iter_end(&cursor);
-	return true;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dma_resv_test_signaled);
 
-- 
2.33.0

