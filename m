Return-Path: <SRS0=UxAd=TY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A3EC46460
	for <linux-media@archiver.kernel.org>; Fri, 24 May 2019 23:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208D520675
	for <linux-media@archiver.kernel.org>; Fri, 24 May 2019 23:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfEXXRh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 May 2019 19:17:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:23063 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfEXXRg (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 May 2019 19:17:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 16:17:36 -0700
X-ExtLoop1: 1
Received: from maru.jf.intel.com ([10.54.51.75])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2019 16:17:35 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org, linux-media@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 11/11] media: aspeed: add a workaround to fix a silicon bug
Date:   Fri, 24 May 2019 16:17:25 -0700
Message-Id: <20190524231725.12320-12-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
References: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

AST2500 silicon revision A1 and A2 have a silicon bug which causes
extremly long capturing time on specific resolutions (1680 width).
To fix the bug, this commit adjusts the capturing window register
setting to 1728 if detected width is 1680. The compression window
register setting will be kept as the original width so output
result will be the same.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
v1 -> v2:
 New.

 drivers/media/platform/aspeed-video.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index b05b073b63bc..f93989f532d6 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -824,8 +824,27 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
 	struct v4l2_bt_timings *act = &video->active_timings;
 	unsigned int size = act->width * act->height;
 
+	/* Set capture/compression frame sizes */
 	aspeed_video_calc_compressed_size(video, size);
 
+	if (video->active_timings.width == 1680) {
+		/*
+		 * This is a workaround to fix a silicon bug on A1 and A2
+		 * revisions. Since it doesn't break capturing operation on A0
+		 * revision, use it for all revisions without checking the
+		 * revision ID.
+		 */
+		aspeed_video_write(video, VE_CAP_WINDOW,
+				   1728 << 16 | act->height);
+		size += (1728 - 1680) * video->active_timings.height;
+	} else {
+		aspeed_video_write(video, VE_CAP_WINDOW,
+				   act->width << 16 | act->height);
+	}
+	aspeed_video_write(video, VE_COMP_WINDOW,
+			   act->width << 16 | act->height);
+	aspeed_video_write(video, VE_SRC_SCANLINE_OFFSET, act->width * 4);
+
 	/* Don't use direct mode below 1024 x 768 (irqs don't fire) */
 	if (size < DIRECT_FETCH_THRESHOLD) {
 		aspeed_video_write(video, VE_TGS_0,
@@ -842,13 +861,6 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
 		aspeed_video_update(video, VE_CTRL, 0, VE_CTRL_DIRECT_FETCH);
 	}
 
-	/* Set capture/compression frame sizes */
-	aspeed_video_write(video, VE_CAP_WINDOW,
-			   act->width << 16 | act->height);
-	aspeed_video_write(video, VE_COMP_WINDOW,
-			   act->width << 16 | act->height);
-	aspeed_video_write(video, VE_SRC_SCANLINE_OFFSET, act->width * 4);
-
 	size *= 4;
 
 	if (size == video->srcs[0].size / 2) {
-- 
2.21.0

