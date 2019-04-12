Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686EEC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D6520693
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDLPvs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:51:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50219 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfDLPvn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEySr-0000EY-Hh; Fri, 12 Apr 2019 17:51:41 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 10/13] media: coda: add decoder MPEG-2 profile and level controls
Date:   Fri, 12 Apr 2019 17:51:32 +0200
Message-Id: <20190412155135.13907-10-p.zabel@pengutronix.de>
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

The MPEG-2 decoder firmware reports profile and level indication that
can be used to set V4L2 MPEG-2 profile and level controls

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/Makefile      |  2 +-
 drivers/media/platform/coda/coda-common.c | 25 +++++++++++++
 drivers/media/platform/coda/coda-mpeg2.c  | 44 +++++++++++++++++++++++
 drivers/media/platform/coda/coda.h        |  6 ++++
 4 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/coda/coda-mpeg2.c

diff --git a/drivers/media/platform/coda/Makefile b/drivers/media/platform/coda/Makefile
index 3a068206cea8..5ac734d083cf 100644
--- a/drivers/media/platform/coda/Makefile
+++ b/drivers/media/platform/coda/Makefile
@@ -1,6 +1,6 @@
 ccflags-y += -I$(src)
 
-coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg4.o coda-jpeg.o
+coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
 
 obj-$(CONFIG_VIDEO_CODA) += coda.o
 obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o
diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 9d25899a9af6..1cd0fb5b1c5b 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1580,6 +1580,15 @@ void coda_update_profile_level_ctrls(struct coda_ctx *ctx, u8 profile_idc,
 		profile = coda_h264_profile(profile_idc);
 		level = coda_h264_level(level_idc);
 		break;
+	case V4L2_PIX_FMT_MPEG2:
+		codec_name = "MPEG-2";
+		profile_cid = V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE;
+		level_cid = V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL;
+		profile_ctrl = ctx->mpeg2_profile_ctrl;
+		level_ctrl = ctx->mpeg2_level_ctrl;
+		profile = coda_mpeg2_profile(profile_idc);
+		level = coda_mpeg2_level(level_idc);
+		break;
 	case V4L2_PIX_FMT_MPEG4:
 		codec_name = "MPEG-4";
 		profile_cid = V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE;
@@ -1939,6 +1948,8 @@ static int coda_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:
 		ctx->params.mpeg4_inter_qp = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
+	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
 		/* nothing to do, these are fixed */
@@ -2119,6 +2130,20 @@ static void coda_decode_ctrls(struct coda_ctx *ctx)
 	if (ctx->h264_level_ctrl)
 		ctx->h264_level_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
+	ctx->mpeg2_profile_ctrl = v4l2_ctrl_new_std_menu(&ctx->ctrls,
+		&coda_ctrl_ops, V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE,
+		V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH, 0,
+		V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH);
+	if (ctx->mpeg2_profile_ctrl)
+		ctx->mpeg2_profile_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	ctx->mpeg2_level_ctrl = v4l2_ctrl_new_std_menu(&ctx->ctrls,
+		&coda_ctrl_ops, V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL,
+		V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH, 0,
+		V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH);
+	if (ctx->mpeg2_level_ctrl)
+		ctx->mpeg2_level_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
 	ctx->mpeg4_profile_ctrl = v4l2_ctrl_new_std_menu(&ctx->ctrls,
 		&coda_ctrl_ops, V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE,
 		V4L2_MPEG_VIDEO_MPEG4_PROFILE_ADVANCED_CODING_EFFICIENCY, 0,
diff --git a/drivers/media/platform/coda/coda-mpeg2.c b/drivers/media/platform/coda/coda-mpeg2.c
new file mode 100644
index 000000000000..9caf840a3466
--- /dev/null
+++ b/drivers/media/platform/coda/coda-mpeg2.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Coda multi-standard codec IP - MPEG-2 helper functions
+ *
+ * Copyright (C) 2019 Pengutronix, Philipp Zabel
+ */
+
+#include <linux/kernel.h>
+#include <linux/videodev2.h>
+#include <coda.h>
+
+int coda_mpeg2_profile(int profile_idc)
+{
+	switch (profile_idc) {
+	case 5:
+		return V4L2_MPEG_VIDEO_MPEG2_PROFILE_SIMPLE;
+	case 4:
+		return V4L2_MPEG_VIDEO_MPEG2_PROFILE_MAIN;
+	case 3:
+		return V4L2_MPEG_VIDEO_MPEG2_PROFILE_SNR_SCALABLE;
+	case 2:
+		return V4L2_MPEG_VIDEO_MPEG2_PROFILE_SPATIALLY_SCALABLE;
+	case 1:
+		return V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH;
+	default:
+		return -EINVAL;
+	}
+}
+
+int coda_mpeg2_level(int level_idc)
+{
+	switch (level_idc) {
+	case 10:
+		return V4L2_MPEG_VIDEO_MPEG2_LEVEL_LOW;
+	case 8:
+		return V4L2_MPEG_VIDEO_MPEG2_LEVEL_MAIN;
+	case 6:
+		return V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH_1440;
+	case 4:
+		return V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/media/platform/coda/coda.h b/drivers/media/platform/coda/coda.h
index d8c8b3777db8..5c1a105ffdd2 100644
--- a/drivers/media/platform/coda/coda.h
+++ b/drivers/media/platform/coda/coda.h
@@ -122,6 +122,8 @@ struct coda_params {
 	s8			h264_chroma_qp_index_offset;
 	u8			h264_profile_idc;
 	u8			h264_level_idc;
+	u8			mpeg2_profile_idc;
+	u8			mpeg2_level_idc;
 	u8			mpeg4_intra_qp;
 	u8			mpeg4_inter_qp;
 	u8			gop_size;
@@ -217,6 +219,8 @@ struct coda_ctx {
 	struct v4l2_ctrl_handler	ctrls;
 	struct v4l2_ctrl		*h264_profile_ctrl;
 	struct v4l2_ctrl		*h264_level_ctrl;
+	struct v4l2_ctrl		*mpeg2_profile_ctrl;
+	struct v4l2_ctrl		*mpeg2_level_ctrl;
 	struct v4l2_ctrl		*mpeg4_profile_ctrl;
 	struct v4l2_ctrl		*mpeg4_level_ctrl;
 	struct v4l2_fh			fh;
@@ -330,6 +334,8 @@ int coda_sps_parse_profile(struct coda_ctx *ctx, struct vb2_buffer *vb);
 int coda_h264_sps_fixup(struct coda_ctx *ctx, int width, int height, char *buf,
 			int *size, int max_size);
 
+int coda_mpeg2_profile(int profile_idc);
+int coda_mpeg2_level(int level_idc);
 int coda_mpeg4_profile(int profile_idc);
 int coda_mpeg4_level(int level_idc);
 
-- 
2.20.1

