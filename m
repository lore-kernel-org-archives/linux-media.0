Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010DDC4167D
	for <linux-media@archiver.kernel.org>; Mon,  9 May 2022 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiEIJvu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 May 2022 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiEIJUe (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 May 2022 05:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4245014AA69
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 02:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C62DB810AC
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 09:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1347DC385AB;
        Mon,  9 May 2022 09:15:58 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 3/7] videobuf2-dma-sg.c: kvmalloc_array -> kvcalloc
Date:   Mon,  9 May 2022 11:15:49 +0200
Message-Id: <20220509091553.2637089-4-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
References: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes smatch warning:

drivers/media/common/videobuf2/videobuf2-dma-sg.c:129 vb2_dma_sg_alloc() warn: Please consider using kvcalloc instead

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index f8a21c560ad2..fa69158a65b1 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -126,8 +126,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
 	 * there is no memory consistency guarantee, hence dma-sg ignores DMA
 	 * attributes passed from the upper layer.
 	 */
-	buf->pages = kvmalloc_array(buf->num_pages, sizeof(struct page *),
-				    GFP_KERNEL | __GFP_ZERO);
+	buf->pages = kvcalloc(buf->num_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!buf->pages)
 		goto fail_pages_array_alloc;
 
-- 
2.34.1

