Return-Path: <SRS0=bW/p=CM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69785C433E2
	for <linux-media@archiver.kernel.org>; Thu,  3 Sep 2020 21:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4715F206E7
	for <linux-media@archiver.kernel.org>; Thu,  3 Sep 2020 21:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgICVMe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:12:34 -0400
Received: from foss.arm.com ([217.140.110.172]:41414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgICVMd (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 3 Sep 2020 17:12:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 394C61045;
        Thu,  3 Sep 2020 14:12:33 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78F1C3F68F;
        Thu,  3 Sep 2020 14:12:32 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] media: rcar-fcp: Drop local dma_parms
Date:   Thu,  3 Sep 2020 22:12:27 +0100
Message-Id: <20426a75cba769372c2f3f12f44a477e6fc8e979.1599167414.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Since commit 9495b7e92f71 ("driver core: platform: Initialize dma_parms
for platform devices"), struct platform_device already provides a
dma_parms structure, so we can save allocating another one.

Also the DMA segment size is simply a size, not a bitmask.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/media/platform/rcar-fcp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/rcar-fcp.c b/drivers/media/platform/rcar-fcp.c
index 5c6b00737fe7..13a84c7e3586 100644
--- a/drivers/media/platform/rcar-fcp.c
+++ b/drivers/media/platform/rcar-fcp.c
@@ -22,7 +22,6 @@
 struct rcar_fcp_device {
 	struct list_head list;
 	struct device *dev;
-	struct device_dma_parameters dma_parms;
 };
 
 static LIST_HEAD(fcp_devices);
@@ -138,8 +137,7 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 
 	fcp->dev = &pdev->dev;
 
-	fcp->dev->dma_parms = &fcp->dma_parms;
-	dma_set_max_seg_size(fcp->dev, DMA_BIT_MASK(32));
+	dma_set_max_seg_size(fcp->dev, UINT_MAX);
 
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.28.0.dirty

