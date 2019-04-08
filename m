Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA4BC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F7A214C6
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDHMdP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:33:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48039 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDHMdK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:33:10 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDTSW-00005P-9l; Mon, 08 Apr 2019 14:33:08 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 02/10] media: coda: remove mask from decoder h.264 level control
Date:   Mon,  8 Apr 2019 14:32:48 +0200
Message-Id: <20190408123256.22868-2-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408123256.22868-1-p.zabel@pengutronix.de>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Since levels are specified in terms of maximum values, there is no
reason to filter out lower levels than the supported maximum.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index a403bc2995b4..de608de62908 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -2027,7 +2027,6 @@ static void coda_jpeg_encode_ctrls(struct coda_ctx *ctx)
 
 static void coda_decode_ctrls(struct coda_ctx *ctx)
 {
-	u64 mask;
 	u8 max;
 
 	ctx->h264_profile_ctrl = v4l2_ctrl_new_std_menu(&ctx->ctrls,
@@ -2041,27 +2040,14 @@ static void coda_decode_ctrls(struct coda_ctx *ctx)
 		ctx->h264_profile_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	if (ctx->dev->devtype->product == CODA_HX4 ||
-	    ctx->dev->devtype->product == CODA_7541) {
+	    ctx->dev->devtype->product == CODA_7541)
 		max = V4L2_MPEG_VIDEO_H264_LEVEL_4_0;
-		mask = ~((1 << V4L2_MPEG_VIDEO_H264_LEVEL_2_0) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_3_0) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_3_1) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_3_2) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_4_0));
-	} else if (ctx->dev->devtype->product == CODA_960) {
+	else if (ctx->dev->devtype->product == CODA_960)
 		max = V4L2_MPEG_VIDEO_H264_LEVEL_4_1;
-		mask = ~((1 << V4L2_MPEG_VIDEO_H264_LEVEL_2_0) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_3_0) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_3_1) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_3_2) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_4_0) |
-			 (1 << V4L2_MPEG_VIDEO_H264_LEVEL_4_1));
-	} else {
+	else
 		return;
-	}
 	ctx->h264_level_ctrl = v4l2_ctrl_new_std_menu(&ctx->ctrls,
-		&coda_ctrl_ops, V4L2_CID_MPEG_VIDEO_H264_LEVEL, max, mask,
-		max);
+		&coda_ctrl_ops, V4L2_CID_MPEG_VIDEO_H264_LEVEL, max, 0, max);
 	if (ctx->h264_level_ctrl)
 		ctx->h264_level_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 }
-- 
2.20.1

