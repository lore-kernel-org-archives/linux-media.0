Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC8AC4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 09:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C70A206B8
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 09:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDCJnb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:43:31 -0400
Received: from retiisi.org.uk ([95.216.213.190]:46832 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbfDCJnb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 3 Apr 2019 05:43:31 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 61C74634C83;
        Wed,  3 Apr 2019 12:42:54 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 3/3] videobuf2-core.h: Document the alloc memop size argument as page aligned
Date:   Wed,  3 Apr 2019 12:43:28 +0300
Message-Id: <20190403094328.4895-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403094328.4895-1-sakari.ailus@linux.intel.com>
References: <20190403094328.4895-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The size argument of the alloc memop, which allocates buffer memory, is
page aligned. Document it as such in the only caller as well as ops
documentation.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 1 +
 include/media/videobuf2-core.h                  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 8fd0d80640c2..ffa798bc2496 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -205,6 +205,7 @@ static int __vb2_buf_mem_alloc(struct vb2_buffer *vb)
 	 * NOTE: mmapped areas should be page aligned
 	 */
 	for (plane = 0; plane < vb->num_planes; ++plane) {
+		/* Memops alloc requires size to be page aligned. */
 		unsigned long size = PAGE_ALIGN(vb->planes[plane].length);
 
 		/* Did it wrap around? */
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index fe010ad62b90..c8c7b7fea9e8 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -54,7 +54,8 @@ struct vb2_threadio_data;
  *		will then be passed as @buf_priv argument to other ops in this
  *		structure. Additional gfp_flags to use when allocating the
  *		are also passed to this operation. These flags are from the
- *		gfp_flags field of vb2_queue.
+ *		gfp_flags field of vb2_queue. The size argument to this function
+ *		shall be *page aligned*.
  * @put:	inform the allocator that the buffer will no longer be used;
  *		usually will result in the allocator freeing the buffer (if
  *		no other users of this buffer are present); the @buf_priv
-- 
2.11.0

