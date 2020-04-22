Return-Path: <SRS0=ldT+=6G=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EECFC54FCB
	for <linux-media@archiver.kernel.org>; Wed, 22 Apr 2020 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3205F20882
	for <linux-media@archiver.kernel.org>; Wed, 22 Apr 2020 20:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDVU7a (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:59:30 -0400
Received: from gofer.mess.org ([88.97.38.141]:42811 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVU7a (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 22 Apr 2020 16:59:30 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id C3AFDC6366; Wed, 22 Apr 2020 21:59:28 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Brad Love <brad@nextdimension.cc>
Subject: [PATCH] media: si2157: ensure wait_status is initialized
Date:   Wed, 22 Apr 2020 21:59:28 +0100
Message-Id: <20200422205928.8714-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

smatch reports wait_status is uninitialized, because smatch cannot assume
the loop body is ever executed.

Clarify the code so that wait_status is retrieved at least once.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/tuners/si2157.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 6b452565dedb..088d96fdf8f6 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -327,7 +327,7 @@ static int si2157_tune_wait(struct i2c_client *client, u8 is_digital)
 	/* wait tuner command complete */
 	start_time = jiffies;
 	timeout = start_time + msecs_to_jiffies(TUN_TIMEOUT);
-	while (!time_after(jiffies, timeout)) {
+	for (;;) {
 		ret = i2c_master_recv(client, &wait_status,
 				      sizeof(wait_status));
 		if (ret < 0) {
@@ -337,6 +337,9 @@ static int si2157_tune_wait(struct i2c_client *client, u8 is_digital)
 			goto err_mutex_unlock;
 		}
 
+		if (time_after(jiffies, timeout))
+			break;
+
 		/* tuner done? */
 		if ((wait_status & 0x81) == 0x81)
 			break;
-- 
2.25.3

