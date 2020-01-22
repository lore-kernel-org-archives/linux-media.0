Return-Path: <SRS0=cCoD=3L=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE0FC33CB6
	for <linux-media@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FBE20704
	for <linux-media@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgAVJx1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:53:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58730 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbgAVJx0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 22 Jan 2020 04:53:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 90F132935AE
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, skhan@linuxfoundation.org,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH v5] media: vimc: streamer: if kthread_stop fails, ignore the error
Date:   Wed, 22 Jan 2020 10:52:51 +0100
Message-Id: <20200122095251.15813-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Ignore errors returned from kthread_stop since the
vimc subdevices should still be notified that
streaming stopped so they can release the memory for
the streaming, and also kthread should be set to NULL.
kthread_stop can return -EINTR in case the thread
did not yet run. This can happen if userspace calls
streamon and streamoff right after.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
changes from v4: change dev_warn to dev_dbg, delete and add a empty lines
Changes from v3: change the comment to explain when kthread fails
changes since v2: add a comment explaning why we ignore the error
Changes from v1: undo deletion of an empty line

 drivers/media/platform/vimc/vimc-streamer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vimc/vimc-streamer.c b/drivers/media/platform/vimc/vimc-streamer.c
index cd6b55433c9e..9d2b1ff2ba45 100644
--- a/drivers/media/platform/vimc/vimc-streamer.c
+++ b/drivers/media/platform/vimc/vimc-streamer.c
@@ -215,8 +215,14 @@ int vimc_streamer_s_stream(struct vimc_stream *stream,
 			return 0;
 
 		ret = kthread_stop(stream->kthread);
+		/*
+		 * kthread_stop returns -EINTR in cases when streamon was
+		 * immediately followed by streamoff, and the thread didn't had
+		 * a chance to run. Ignore errors to stop the stream in the
+		 * pipeline.
+		 */
 		if (ret)
-			return ret;
+			dev_dbg(ved->dev, "kthread_stop returned '%d'\n", ret);
 
 		stream->kthread = NULL;
 
-- 
2.17.1

