Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A07C433E9
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEC423741
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 18:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbhANSGG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbhANSFy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 14 Jan 2021 13:05:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14779C061786;
        Thu, 14 Jan 2021 10:05:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 192A41F45C75
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, hans.verkuil@cisco.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Subject: [PATCH 3/3] media: videobuf2-v4l2: remove redundant error test
Date:   Thu, 14 Jan 2021 15:01:49 -0300
Message-Id: <20210114180149.1755892-4-helen.koike@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114180149.1755892-1-helen.koike@collabora.com>
References: <20210114180149.1755892-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

request_fd is validated under media_request_get_by_fd() just below this
check. Thus remove it.

Suggested-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 96d3b2b2aa31..bb642c0775d1 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -488,11 +488,6 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 		    !q->ops->buf_out_validate))
 		return -EINVAL;
 
-	if (b->request_fd < 0) {
-		dprintk(q, 1, "%s: request_fd < 0\n", opname);
-		return -EINVAL;
-	}
-
 	req = media_request_get_by_fd(mdev, b->request_fd);
 	if (IS_ERR(req)) {
 		dprintk(q, 1, "%s: invalid request_fd\n", opname);
-- 
2.29.2

