Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7EAC77B7E
	for <linux-media@archiver.kernel.org>; Wed, 24 May 2023 01:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbjEXB1y (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 May 2023 21:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbjEXB1w (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 May 2023 21:27:52 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 54346126;
        Tue, 23 May 2023 18:27:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 932E018002B642;
        Wed, 24 May 2023 09:27:35 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     YongSu Yoo <yongsuyoo0215@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: [PATCH] media: dvb_ringbuffer: Return -EFAULT if copy fails
Date:   Wed, 24 May 2023 09:27:33 +0800
Message-Id: <20230524012733.414441-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The copy_to/from_user() functions return the number of bytes remaining
to be copied, but we want to return -EFAULT to the user.

Fixes: 04da2daee383 ("[media] ngene: properly handle __user ptr")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/media/dvb-core/dvb_ringbuffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c b/drivers/media/dvb-core/dvb_ringbuffer.c
index 7d4558de8e83..f132578840ad 100644
--- a/drivers/media/dvb-core/dvb_ringbuffer.c
+++ b/drivers/media/dvb-core/dvb_ringbuffer.c
@@ -216,7 +216,7 @@ ssize_t dvb_ringbuffer_write_user(struct dvb_ringbuffer *rbuf,
 	if (split > 0) {
 		status = copy_from_user(rbuf->data+rbuf->pwrite, buf, split);
 		if (status)
-			return len - todo;
+			return -EFAULT;
 		buf += split;
 		todo -= split;
 		/* smp_store_release() for write pointer update to ensure that
@@ -228,7 +228,7 @@ ssize_t dvb_ringbuffer_write_user(struct dvb_ringbuffer *rbuf,
 	}
 	status = copy_from_user(rbuf->data+rbuf->pwrite, buf, todo);
 	if (status)
-		return len - todo;
+		return -EFAULT;
 	/* smp_store_release() for write pointer update, see above */
 	smp_store_release(&rbuf->pwrite, (rbuf->pwrite + todo) % rbuf->size);
 
-- 
2.30.2

