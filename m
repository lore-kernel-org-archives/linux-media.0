Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D607C4360F
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B19E206DD
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfC2P31 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:29:27 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:43974 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728945AbfC2P30 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 11:29:26 -0400
Received: from test-no.fritz.box ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9tRYhPNkWUjKf9tRdhwWqs; Fri, 29 Mar 2019 16:29:25 +0100
From:   hverkuil-cisco@xs4all.nl
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna3@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [RFC PATCH 4/5] videobuf2-v4l2: set last_buffer_dequeued in dqbuf
Date:   Fri, 29 Mar 2019 16:29:19 +0100
Message-Id: <20190329152920.30179-5-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
References: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLXKiIlvnN3diLgi5pvnP5v52/OlZhwwUac3zIRWJbdV3IOGRjkhLXxwp0SZyO6EvxIxwd0MZrgt5U6PVz79wPm+/XMwERjFfEd8CW1zUECCzei5/qpU
 itcDxQrK/hWX3OtNSeWRO7Tu/52/h6OMkGwOvXo/GR0gZjIwxOHTl2d8lxBTXlMbTvSt3YPJynWbNcEg+2mAKV+9STulibi3zy6apbbo/8a7o1A4qHAUPjU0
 ueGhgwtVpFJg/bg6/qhMVn6zqdCz6ZetFqpEK0zCNfqeCxvxHLY8v1MBsPaeqTTg
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

last_buffer_dequeued was set to true in __fill_v4l2_buffer, but this
is called for qbuf as well. Move it to vb2_dqbuf.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index b11a779e97b0..379738372651 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -562,11 +562,6 @@ static void __fill_v4l2_buffer(struct vb2_buffer *vb, void *pb)
 		b->flags |= V4L2_BUF_FLAG_REQUEST_FD;
 		b->request_fd = vbuf->request_fd;
 	}
-
-	if (!q->is_output &&
-		b->flags & V4L2_BUF_FLAG_DONE &&
-		b->flags & V4L2_BUF_FLAG_LAST)
-		q->last_buffer_dequeued = true;
 }
 
 /*
@@ -785,6 +780,11 @@ int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
 
 	ret = vb2_core_dqbuf(q, NULL, b, nonblocking);
 
+	if (!q->is_output &&
+	    b->flags & V4L2_BUF_FLAG_DONE &&
+	    b->flags & V4L2_BUF_FLAG_LAST)
+		q->last_buffer_dequeued = true;
+
 	/*
 	 *  After calling the VIDIOC_DQBUF V4L2_BUF_FLAG_DONE must be
 	 *  cleared.
-- 
2.20.1

