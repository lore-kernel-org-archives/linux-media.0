Return-Path: <SRS0=vVRq=3E=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873DBC32771
	for <linux-media@archiver.kernel.org>; Wed, 15 Jan 2020 19:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623EC207E0
	for <linux-media@archiver.kernel.org>; Wed, 15 Jan 2020 19:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgAOTN6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:13:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOTN5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 15 Jan 2020 14:13:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id D4F7E293475
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, skhan@linuxfoundation.org,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH v2] media: vimc: streamer: if kthread_stop fails, ignore the error
Date:   Wed, 15 Jan 2020 21:13:34 +0200
Message-Id: <20200115191334.27346-1-dafna.hirschfeld@collabora.com>
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
did not yet ran. This can happen if userspace calls
streamon and streamoff right after.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
Changes from v1: undo deletion of an empty line

 drivers/media/platform/vimc/vimc-streamer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vimc/vimc-streamer.c b/drivers/media/platform/vimc/vimc-streamer.c
index cd6b55433c9e..417970dbad14 100644
--- a/drivers/media/platform/vimc/vimc-streamer.c
+++ b/drivers/media/platform/vimc/vimc-streamer.c
@@ -216,7 +216,7 @@ int vimc_streamer_s_stream(struct vimc_stream *stream,
 
 		ret = kthread_stop(stream->kthread);
 		if (ret)
-			return ret;
+			dev_warn(ved->dev, "kthread_stop returned '%d'\n", ret);
 
 		stream->kthread = NULL;
 
-- 
2.17.1

