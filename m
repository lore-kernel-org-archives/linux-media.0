Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAE8C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 13:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31A8206C0
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 13:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfDDNPG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:15:06 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:37006 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfDDNPG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 4 Apr 2019 09:15:06 -0400
Received: from [IPv6:2001:420:44c1:2579:1ed:86b:7a55:d4f2] ([IPv6:2001:420:44c1:2579:1ed:86b:7a55:d4f2])
        by smtp-cloud8.xs4all.net with ESMTPA
        id C2Cqh6slwUjKfC2CuhJx8m; Thu, 04 Apr 2019 15:15:04 +0200
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] videobuf2-vmalloc: get_userptr: buffers are always writable
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <da1ee361-6850-557e-c1e3-add58632f06e@xs4all.nl>
Date:   Thu, 4 Apr 2019 15:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA3b3Fw4k2R4m/gY1OE6aSyjPdTIrBErIST0PQDIE5H6kvkiLHaaueetnl9bykXdGdBcs13RN+b7/VI82ZuOVd04MwwEqgRtPiycn5qQkMd4PdZ8Hwi4
 mpnZL2+HOppalTN0hCZnJN30cbaOa7EmKCnQOc+pfGroqtc0oVlmATwDTEa9f5Mirz1pIQidZ3LH3g7IEHxJRfjdSP8wOnRUxB9np8eXMlL9b8dVWUkzYPco
 1hm+20GK0240ij1XqUH466RjcbLm8ZUpRClM0C0ypai/FXnxwlR9wGC6gXWD9JjiMR+iNcMJQkqlLsbvdzIB1Q==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In vb2_vmalloc_get_userptr() the framevector is created with the
'write' argument set to false when vb2_create_framevec() is called
for OUTPUT buffers. So the pages are marked as read-only.

However, userspace will write to these buffers since it will fill
in the data to output. Since get_userptr is only called if the userptr
of the queued buffer has changed since the last time that same buffer
was queued, this will fail when the buffer contents is updated and the
buffer is queued again.

E.g., userspace fills buffer 1 with the output video and queues it.
The first time get_userptr is called and the pages are grabbed and
pinned in memory and marked read-only. The second time buffer 1 is
filled with different video data and queued again. Since the userptr
hasn't changed the get_userptr() callback isn't called again. Since
the pages were marked as read-only the new contents isn't updated.

Just always call vb2_create_framevec() with FOLL_WRITE to always
allow writing to the buffers.

Using USERPTR streaming with OUTPUT devices is almost never done. And
when it is done it is via v4l2-compliance and a driver like vim2m. But
since v4l2-compliance doesn't actually inspect the capture buffer and
compare it to the original output buffer, this issue was never noticed.

But the vicodec driver actually needs to parse the bitstream in the
OUTPUT buffers and any errors there will be immediately noticed. So
this time v4l2-compliance failed the USERPTR streaming test.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
Marek, is my analysis and solution correct? You are more of an expert
in this area than I am.
---
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 82389aead6ed..97817b3affdf 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -481,8 +481,7 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 	buf->dma_dir = dma_dir;

 	offset = lower_32_bits(offset_in_page(vaddr));
-	vec = vb2_create_framevec(vaddr, size, dma_dir == DMA_FROM_DEVICE ||
-					       dma_dir == DMA_BIDIRECTIONAL);
+	vec = vb2_create_framevec(vaddr, size);
 	if (IS_ERR(vec)) {
 		ret = PTR_ERR(vec);
 		goto fail_buf;
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 270c3162fdcb..f54dad591378 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -239,8 +239,7 @@ static void *vb2_dma_sg_get_userptr(struct device *dev, unsigned long vaddr,
 	buf->offset = vaddr & ~PAGE_MASK;
 	buf->size = size;
 	buf->dma_sgt = &buf->sg_table;
-	vec = vb2_create_framevec(vaddr, size, dma_dir == DMA_FROM_DEVICE ||
-					       dma_dir == DMA_BIDIRECTIONAL);
+	vec = vb2_create_framevec(vaddr, size);
 	if (IS_ERR(vec))
 		goto userptr_fail_pfnvec;
 	buf->vec = vec;
diff --git a/drivers/media/common/videobuf2/videobuf2-memops.c b/drivers/media/common/videobuf2/videobuf2-memops.c
index c4a85be48ac2..6e9e05153f4e 100644
--- a/drivers/media/common/videobuf2/videobuf2-memops.c
+++ b/drivers/media/common/videobuf2/videobuf2-memops.c
@@ -26,7 +26,6 @@
  * vb2_create_framevec() - map virtual addresses to pfns
  * @start:	Virtual user address where we start mapping
  * @length:	Length of a range to map
- * @write:	Should we map for writing into the area
  *
  * This function allocates and fills in a vector with pfns corresponding to
  * virtual address range passed in arguments. If pfns have corresponding pages,
@@ -35,17 +34,13 @@
  * failure. Returned vector needs to be freed via vb2_destroy_pfnvec().
  */
 struct frame_vector *vb2_create_framevec(unsigned long start,
-					 unsigned long length,
-					 bool write)
+					 unsigned long length)
 {
 	int ret;
 	unsigned long first, last;
 	unsigned long nr;
 	struct frame_vector *vec;
-	unsigned int flags = FOLL_FORCE;
-
-	if (write)
-		flags |= FOLL_WRITE;
+	unsigned int flags = FOLL_FORCE | FOLL_WRITE;

 	first = start >> PAGE_SHIFT;
 	last = (start + length - 1) >> PAGE_SHIFT;
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 1c6659f7c394..04d51ca63223 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -87,8 +87,7 @@ static void *vb2_vmalloc_get_userptr(struct device *dev, unsigned long vaddr,
 	buf->dma_dir = dma_dir;
 	offset = vaddr & ~PAGE_MASK;
 	buf->size = size;
-	vec = vb2_create_framevec(vaddr, size, dma_dir == DMA_FROM_DEVICE ||
-					       dma_dir == DMA_BIDIRECTIONAL);
+	vec = vb2_create_framevec(vaddr, size);
 	if (IS_ERR(vec)) {
 		ret = PTR_ERR(vec);
 		goto fail_pfnvec_create;
diff --git a/include/media/videobuf2-memops.h b/include/media/videobuf2-memops.h
index 4b5b84f93538..cd4a46331531 100644
--- a/include/media/videobuf2-memops.h
+++ b/include/media/videobuf2-memops.h
@@ -34,8 +34,7 @@ struct vb2_vmarea_handler {
 extern const struct vm_operations_struct vb2_common_vm_ops;

 struct frame_vector *vb2_create_framevec(unsigned long start,
-					 unsigned long length,
-					 bool write);
+					 unsigned long length);
 void vb2_destroy_framevec(struct frame_vector *vec);

 #endif
