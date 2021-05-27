Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E7DC47082
	for <linux-media@archiver.kernel.org>; Thu, 27 May 2021 03:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13067613CC
	for <linux-media@archiver.kernel.org>; Thu, 27 May 2021 03:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhE0DFS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 May 2021 23:05:18 -0400
Received: from m12-14.163.com ([220.181.12.14]:51345 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhE0DFS (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 May 2021 23:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/VKnD
        DG75EYHNMX8C4IYiyBE2gD7ZxB8aaHRc0kvE10=; b=Pd2dLyDtHfKfnwNjTXsz+
        lYq3ynmGZhzhO3fqw9gsL0jGInYm3vULysvcpIvVa8gBsGALHhji76/SGs7TzVah
        VgpK9XT583VybxZ7LAdDRTeqtjNSAv6+xXfDotmNbxIbWjgbVlExC8g5t94rxD1r
        bJl9BFEuKsghfqfxeTW/fo=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowACHP21RCK9gYWPgLA--.64646S2;
        Thu, 27 May 2021 10:47:46 +0800 (CST)
From:   lijian_8010a29@163.com
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] media: v4l2-event: Modified variable type 'unsigned' to 'unsigned int'
Date:   Thu, 27 May 2021 10:46:43 +0800
Message-Id: <20210527024643.133352-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACHP21RCK9gYWPgLA--.64646S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4xZw4UCw15Jw4xJryfXrb_yoW8GF1rpF
        1vk34ayrW5tFsF9ay3JF15X3Wrt34xJanrKr47G34xZw13tFn7JaySyw13Ja1FyF97ZFy2
        y34Iq3yUJFW8GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1uc_UUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/xtbBERKfUFaEEd2hFgAAsl
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: lijian <lijian@yulong.com>

Prefer 'unsigned int' to bare use of 'unsigned'.
So modified variable type 'unsigned' to 'unsigned int' in v4l2-event.c.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/media/v4l2-core/v4l2-event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index caad58bde326..c5ce9f11ad7b 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -18,7 +18,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 
-static unsigned sev_pos(const struct v4l2_subscribed_event *sev, unsigned idx)
+static unsigned int sev_pos(const struct v4l2_subscribed_event *sev, unsigned int idx)
 {
 	idx += sev->first;
 	return idx >= sev->elems ? idx - sev->elems : idx;
@@ -221,12 +221,12 @@ static void __v4l2_event_unsubscribe(struct v4l2_subscribed_event *sev)
 }
 
 int v4l2_event_subscribe(struct v4l2_fh *fh,
-			 const struct v4l2_event_subscription *sub, unsigned elems,
+			 const struct v4l2_event_subscription *sub, unsigned int elems,
 			 const struct v4l2_subscribed_event_ops *ops)
 {
 	struct v4l2_subscribed_event *sev, *found_ev;
 	unsigned long flags;
-	unsigned i;
+	unsigned int i;
 	int ret = 0;
 
 	if (sub->type == V4L2_EVENT_ALL)
-- 
2.25.1

