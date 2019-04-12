Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F6C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F4820693
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfDLPvn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50837 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDLPvn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEySr-0000EY-F0; Fri, 12 Apr 2019 17:51:41 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 07/13] media: coda: update profile and level controls after sequence initialization
Date:   Fri, 12 Apr 2019 17:51:29 +0200
Message-Id: <20190412155135.13907-7-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412155135.13907-1-p.zabel@pengutronix.de>
References: <20190412155135.13907-1-p.zabel@pengutronix.de>
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

The header report return value from decoder sequence initialization is
available on CodaHx4 and CODA7541 already. Use the profile and level
identification values reported by the firmware to update codec specific
profile and level controls after sequence initialization has succeeded.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-bit.c    | 11 ++++
 drivers/media/platform/coda/coda-common.c | 66 +++++++++++++----------
 drivers/media/platform/coda/coda.h        |  3 ++
 drivers/media/platform/coda/coda_regs.h   |  2 +-
 4 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index 228743b82ace..d774a5aaa422 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -1814,6 +1814,17 @@ static int __coda_start_decoding(struct coda_ctx *ctx)
 					  (top_bottom & 0x3ff);
 	}
 
+	if (dev->devtype->product != CODA_DX6) {
+		u8 profile, level;
+
+		val = coda_read(dev, CODA7_RET_DEC_SEQ_HEADER_REPORT);
+		profile = val & 0xff;
+		level = (val >> 8) & 0x7f;
+
+		if (profile || level)
+			coda_update_profile_level_ctrls(ctx, profile, level);
+	}
+
 	ret = coda_alloc_framebuffers(ctx, q_data_dst, src_fourcc);
 	if (ret < 0) {
 		v4l2_err(&dev->v4l2_dev, "failed to allocate framebuffers\n");
diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index af13e9b3d851..667dafc06afb 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1557,42 +1557,53 @@ static void coda_update_menu_ctrl(struct v4l2_ctrl *ctrl, int value)
 	v4l2_ctrl_unlock(ctrl);
 }
 
-static void coda_update_h264_profile_ctrl(struct coda_ctx *ctx)
+void coda_update_profile_level_ctrls(struct coda_ctx *ctx, u8 profile_idc,
+				     u8 level_idc)
 {
 	const char * const *profile_names;
+	const char * const *level_names;
+	struct v4l2_ctrl *profile_ctrl;
+	struct v4l2_ctrl *level_ctrl;
+	const char *codec_name;
+	u32 profile_cid;
+	u32 level_cid;
 	int profile;
+	int level;
 
-	profile = coda_h264_profile(ctx->params.h264_profile_idc);
-	if (profile < 0) {
-		v4l2_warn(&ctx->dev->v4l2_dev, "Invalid H264 Profile: %u\n",
-			  ctx->params.h264_profile_idc);
+	switch (ctx->codec->src_fourcc) {
+	case V4L2_PIX_FMT_H264:
+		codec_name = "H264";
+		profile_cid = V4L2_CID_MPEG_VIDEO_H264_PROFILE;
+		level_cid = V4L2_CID_MPEG_VIDEO_H264_LEVEL;
+		profile_ctrl = ctx->h264_profile_ctrl;
+		level_ctrl = ctx->h264_level_ctrl;
+		profile = coda_h264_profile(profile_idc);
+		level = coda_h264_level(level_idc);
+		break;
+	default:
 		return;
 	}
 
-	coda_update_menu_ctrl(ctx->h264_profile_ctrl, profile);
-
-	profile_names = v4l2_ctrl_get_menu(V4L2_CID_MPEG_VIDEO_H264_PROFILE);
+	profile_names = v4l2_ctrl_get_menu(profile_cid);
+	level_names = v4l2_ctrl_get_menu(level_cid);
 
-	coda_dbg(1, ctx, "Parsed H264 Profile: %s\n", profile_names[profile]);
-}
-
-static void coda_update_h264_level_ctrl(struct coda_ctx *ctx)
-{
-	const char * const *level_names;
-	int level;
+	if (profile < 0) {
+		v4l2_warn(&ctx->dev->v4l2_dev, "Invalid %s profile: %u\n",
+			  codec_name, profile_idc);
+	} else {
+		coda_dbg(1, ctx, "Parsed %s profile: %s\n", codec_name,
+			 profile_names[profile]);
+		coda_update_menu_ctrl(profile_ctrl, profile);
+	}
 
-	level = coda_h264_level(ctx->params.h264_level_idc);
 	if (level < 0) {
-		v4l2_warn(&ctx->dev->v4l2_dev, "Invalid H264 Level: %u\n",
-			  ctx->params.h264_level_idc);
-		return;
+		v4l2_warn(&ctx->dev->v4l2_dev, "Invalid %s level: %u\n",
+			  codec_name, level_idc);
+	} else {
+		coda_dbg(1, ctx, "Parsed %s level: %s\n", codec_name,
+			 level_names[level]);
+		coda_update_menu_ctrl(level_ctrl, level);
 	}
-
-	coda_update_menu_ctrl(ctx->h264_level_ctrl, level);
-
-	level_names = v4l2_ctrl_get_menu(V4L2_CID_MPEG_VIDEO_H264_LEVEL);
-
-	coda_dbg(1, ctx, "Parsed H264 Level: %s\n", level_names[level]);
 }
 
 static void coda_buf_queue(struct vb2_buffer *vb)
@@ -1625,8 +1636,9 @@ static void coda_buf_queue(struct vb2_buffer *vb)
 			 */
 			if (!ctx->params.h264_profile_idc) {
 				coda_sps_parse_profile(ctx, vb);
-				coda_update_h264_profile_ctrl(ctx);
-				coda_update_h264_level_ctrl(ctx);
+				coda_update_profile_level_ctrls(ctx,
+						ctx->params.h264_profile_idc,
+						ctx->params.h264_level_idc);
 			}
 		}
 
diff --git a/drivers/media/platform/coda/coda.h b/drivers/media/platform/coda/coda.h
index 31c80bda2c0b..1c822dfdb3ce 100644
--- a/drivers/media/platform/coda/coda.h
+++ b/drivers/media/platform/coda/coda.h
@@ -328,6 +328,9 @@ int coda_sps_parse_profile(struct coda_ctx *ctx, struct vb2_buffer *vb);
 int coda_h264_sps_fixup(struct coda_ctx *ctx, int width, int height, char *buf,
 			int *size, int max_size);
 
+void coda_update_profile_level_ctrls(struct coda_ctx *ctx, u8 profile_idc,
+				     u8 level_idc);
+
 bool coda_jpeg_check_buffer(struct coda_ctx *ctx, struct vb2_buffer *vb);
 int coda_jpeg_write_tables(struct coda_ctx *ctx);
 void coda_set_jpeg_compression_quality(struct coda_ctx *ctx, int quality);
diff --git a/drivers/media/platform/coda/coda_regs.h b/drivers/media/platform/coda/coda_regs.h
index e675e38f3475..35cec9f83085 100644
--- a/drivers/media/platform/coda/coda_regs.h
+++ b/drivers/media/platform/coda/coda_regs.h
@@ -181,7 +181,7 @@
 #define CODA_RET_DEC_SEQ_FRATE_DR		0x1e8
 #define CODA_RET_DEC_SEQ_JPG_PARA		0x1e4
 #define CODA_RET_DEC_SEQ_JPG_THUMB_IND		0x1e8
-#define CODA9_RET_DEC_SEQ_HEADER_REPORT		0x1ec
+#define CODA7_RET_DEC_SEQ_HEADER_REPORT		0x1ec
 
 /* Decoder Picture Run */
 #define CODA_CMD_DEC_PIC_ROT_MODE		0x180
-- 
2.20.1

