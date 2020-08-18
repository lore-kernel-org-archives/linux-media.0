Return-Path: <SRS0=pHRl=B4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4043CC433E1
	for <linux-media@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B1207DA
	for <linux-media@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="v+tYen2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHROh2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:37:28 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:50027 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgHROhX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Aug 2020 10:37:23 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 82jnkV8V2uuXO82jpkceve; Tue, 18 Aug 2020 16:37:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1597761441; bh=Y6lbDmzt4ElLsjK1gJx6FtHmPT+QGmkuyOV4OeyNY/k=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=v+tYen2/9+ALVSx74weU5IhkQyHKHN8tz5RB84yt38ixAQSjx+mvI01+dnmUFqfRR
         vBMgZgjHfLvegpZSnrjv6qsPyUGw/cZHMuQR7s+QtQk8raxxJjlVrLoC4Ucg3r9FiW
         ykwqnZl+KOs/xaEDjubzOeB/A0TFTxnaSSW4hIhwCBiKvrCtR6oc2SA1SKQaVX4Msm
         20jxe4HFYDhCc4eukkhqRmNaQlIYkipuwjF24fkF8upvDcp6TOqy82PWgabBxHKQP5
         yc0lcHkB9QDJ3SC61bo/05NNAFMht8w9ld7R1gDxu9Of50jJ6oWOFF9HgaU3tCuPLO
         0THHj0VjCwsPg==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 05/12] videobuf2-core: add vb2_request_buffer_first()
Date:   Tue, 18 Aug 2020 16:37:12 +0200
Message-Id: <20200818143719.102128-6-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200818143719.102128-1-hverkuil-cisco@xs4all.nl>
References: <20200818143719.102128-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCuwSrPvT4fumm6uq5Q5WMyOX6OnYFqvqUTKnnAc42oTX5UrWuzWMQXEHZ0Xwab3bjAqBvapkeMtcnah8py0+THUdibAVA3JlkwbJKBA3FfrJVRuZCf9
 MutHBxYoEallZtP/q0OB2XnCJYFdu6h4EqCQrwiCWra8okfqXdZAkac5bbCbmkYM4fe4xJG4EgawT0xEbOL5+hT3oI9SgWjgRVgJ29iPievIqXhZJd6d629a
 vLCVQBuRiPUnJBSOtzjJGfW8g2/2zvya2zTX+mLp3FNEr3SVaCewyR1Wov6ClyHz5BVDVJeeN6e+zXNlMbcW5xoP9uhUmaOfWpjS5OYLoWNoNuaLH/wbAw26
 Wji31XDc
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add the vb2_request_buffer_first() helper function to obtain the
first vb2 buffer in the request.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../media/common/videobuf2/videobuf2-core.c   | 19 +++++++++++++++++++
 include/media/videobuf2-core.h                |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 5194056129de..01ca0add39c2 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1500,6 +1500,25 @@ unsigned int vb2_request_buffer_cnt(struct media_request *req)
 }
 EXPORT_SYMBOL_GPL(vb2_request_buffer_cnt);
 
+struct vb2_buffer *vb2_request_buffer_first(struct media_request *req)
+{
+	struct media_request_object *obj;
+	struct vb2_buffer *vb = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&req->lock, flags);
+	list_for_each_entry(obj, &req->objects, list) {
+		if (vb2_request_object_is_buffer(obj)) {
+			vb = container_of(obj, struct vb2_buffer, req_obj);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&req->lock, flags);
+
+	return vb;
+}
+EXPORT_SYMBOL_GPL(vb2_request_buffer_first);
+
 int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb)
 {
 	struct vb2_buffer *vb;
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index af7ecff725a5..58fbd9ef506a 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1258,4 +1258,11 @@ bool vb2_request_object_is_buffer(struct media_request_object *obj);
  */
 unsigned int vb2_request_buffer_cnt(struct media_request *req);
 
+/**
+ * vb2_request_buffer_first() - return the first buffer in the request
+ *
+ * @req:	the request.
+ */
+struct vb2_buffer *vb2_request_buffer_first(struct media_request *req);
+
 #endif /* _MEDIA_VIDEOBUF2_CORE_H */
-- 
2.27.0

