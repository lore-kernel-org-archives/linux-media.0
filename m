Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839D3C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 12:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C6820870
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 12:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDAMmD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:42:03 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:40540 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbfDAMmD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 08:42:03 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id AwGEhsyfpiLOmAwGHhc6Kz; Mon, 01 Apr 2019 14:42:02 +0200
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] videobuf2-v4l2.c: move up STATE_DEQUEUED check
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Message-ID: <ed8ffabb-683e-4cfc-8494-157544e1a0b8@xs4all.nl>
Date:   Mon, 1 Apr 2019 14:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFgeE9py21mT7o0YDQNinmLNvCxaq+BQxP4rEn19jCnlI83Yg5/faGVhc0lXMTV+b1K8mIHXwKZZlI7NknmRv1HERjhGk1wg5wg+cYKW0O1HV8/xkJXh
 Z8RHMPZ7Pg1wJybnvVIGW4YN+o2Ttx5VP67VvmIfEAKJiuUMoVkP24vAuoRgKngzojkeA2BFZO7XDg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If a buffer is queued to a request, followed by an attempt to queue
the same buffer again, then the second qbuf returns an error since
the buffer is not in the DEQUEUED state anymore.

However, before it gets to that check it executes the code under the
'if (!vb->prepared)' condition. This clears previously set data needed
for request handling, and now querybuf will no longer report that this
buffer is part of a request.

Move the state check to before the 'if' and make sure to only do the
state check when called from QBUF and if V4L2_BUF_FLAG_REQUEST_FD is
set.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index b11a779e97b0..732da6de1001 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -368,6 +368,12 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 	if (ret)
 		return ret;

+	if (!is_prepare && (b->flags & V4L2_BUF_FLAG_REQUEST_FD) &&
+	    vb->state != VB2_BUF_STATE_DEQUEUED) {
+		dprintk(1, "%s: buffer is not in dequeued state\n", opname);
+		return -EINVAL;
+	}
+
 	if (!vb->prepared) {
 		/* Copy relevant information provided by the userspace */
 		memset(vbuf->planes, 0,
@@ -423,11 +429,6 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 		    !q->ops->buf_out_validate))
 		return -EINVAL;

-	if (vb->state != VB2_BUF_STATE_DEQUEUED) {
-		dprintk(1, "%s: buffer is not in dequeued state\n", opname);
-		return -EINVAL;
-	}
-
 	if (b->request_fd < 0) {
 		dprintk(1, "%s: request_fd < 0\n", opname);
 		return -EINVAL;
