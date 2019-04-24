Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A86C10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 10:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA9420811
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 10:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfDXKn4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:43:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47665 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfDXKn4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 06:43:56 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hJFNZ-0002f4-Pu; Wed, 24 Apr 2019 12:43:53 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v2] media: v4l2-ctrl: add MPEG-2 profile and level controls
Date:   Wed, 24 Apr 2019 12:43:47 +0200
Message-Id: <20190424104347.20212-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412155135.13907-9-p.zabel@pengutronix.de>
References: <20190412155135.13907-9-p.zabel@pengutronix.de>
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

Add MPEG-2 CID definitions for profiles and levels defined in ITU-T Rec.
H.262.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Moved CIDs up to V4L2_CID_MPEG_BASE+270
---
 .../media/uapi/v4l/ext-ctrls-codec.rst        | 56 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls.c          | 23 ++++++++
 include/uapi/linux/v4l2-controls.h            | 18 ++++++
 3 files changed, 97 insertions(+)

diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
index 4a8446203085..843c93e8e7bc 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
@@ -759,6 +759,32 @@ enum v4l2_mpeg_video_h264_level -
 
 
 
+.. _v4l2-mpeg-video-mpeg2-level:
+
+``V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL``
+    (enum)
+
+enum v4l2_mpeg_video_mpeg2_level -
+    The level information for the MPEG2 elementary stream. Applicable to
+    MPEG2 codecs. Possible values are:
+
+
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_MPEG_VIDEO_MPEG2_LEVEL_LOW``
+      - Low Level (LL)
+    * - ``V4L2_MPEG_VIDEO_MPEG2_LEVEL_MAIN``
+      - Main Level (ML)
+    * - ``V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH_1440``
+      - High-1440 Level (H-14)
+    * - ``V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH``
+      - High Level (HL)
+
+
+
 .. _v4l2-mpeg-video-mpeg4-level:
 
 ``V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL``
@@ -845,6 +871,36 @@ enum v4l2_mpeg_video_h264_profile -
 
 
 
+.. _v4l2-mpeg-video-mpeg2-profile:
+
+``V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE``
+    (enum)
+
+enum v4l2_mpeg_video_mpeg2_profile -
+    The profile information for MPEG2. Applicable to MPEG2 codecs.
+    Possible values are:
+
+
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_SIMPLE``
+      - Simple profile (SP)
+    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_MAIN``
+      - Main profile (MP)
+    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_SNR_SCALABLE``
+      - SNR Scalable profile (SNR)
+    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_SPATIALLY_SCALABLE``
+      - Spatially Scalable profile (Spt)
+    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH``
+      - High profile (HP)
+    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_MULTIVIEW``
+      - Multi-view profile (MVP)
+
+
+
 .. _v4l2-mpeg-video-mpeg4-profile:
 
 ``V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE``
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 89a1fe564675..ed2f1f2ede5a 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -406,6 +406,21 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"Explicit",
 		NULL,
 	};
+	static const char * const mpeg_mpeg2_level[] = {
+		"Low",
+		"Main",
+		"High 1440",
+		"High",
+		NULL,
+	};
+	static const char * const mpeg2_profile[] = {
+		"Simple",
+		"Main",
+		"SNR Scalable",
+		"Spatially Scalable",
+		"High",
+		NULL,
+	};
 	static const char * const mpeg_mpeg4_level[] = {
 		"0",
 		"0b",
@@ -622,6 +637,10 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return h264_fp_arrangement_type;
 	case V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE:
 		return h264_fmo_map_type;
+	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
+		return mpeg_mpeg2_level;
+	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
+		return mpeg2_profile;
 	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
 		return mpeg_mpeg4_level;
 	case V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE:
@@ -832,6 +851,8 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP:		return "H264 I-Frame Maximum QP Value";
 	case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP:		return "H264 P-Frame Minimum QP Value";
 	case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP:		return "H264 P-Frame Maximum QP Value";
+	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:			return "MPEG2 Level";
+	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:			return "MPEG2 Profile";
 	case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:		return "MPEG4 I-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:		return "MPEG4 P-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:		return "MPEG4 B-Frame QP Value";
@@ -1196,6 +1217,8 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC:
 	case V4L2_CID_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE:
 	case V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE:
+	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
+	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE:
 	case V4L2_CID_JPEG_CHROMA_SUBSAMPLING:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 37807f23231e..d9f2c76b71bb 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -404,6 +404,24 @@ enum v4l2_mpeg_video_multi_slice_mode {
 #define V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE		(V4L2_CID_MPEG_BASE+228)
 #define V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME		(V4L2_CID_MPEG_BASE+229)
 
+/* CIDs for the MPEG-2 Part 2 (H.262) codec */
+#define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_MPEG_BASE+270)
+enum v4l2_mpeg_video_mpeg2_level {
+	V4L2_MPEG_VIDEO_MPEG2_LEVEL_LOW		= 0,
+	V4L2_MPEG_VIDEO_MPEG2_LEVEL_MAIN	= 1,
+	V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH_1440	= 2,
+	V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH	= 3,
+};
+#define V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE		(V4L2_CID_MPEG_BASE+271)
+enum v4l2_mpeg_video_mpeg2_profile {
+	V4L2_MPEG_VIDEO_MPEG2_PROFILE_SIMPLE				= 0,
+	V4L2_MPEG_VIDEO_MPEG2_PROFILE_MAIN				= 1,
+	V4L2_MPEG_VIDEO_MPEG2_PROFILE_SNR_SCALABLE			= 2,
+	V4L2_MPEG_VIDEO_MPEG2_PROFILE_SPATIALLY_SCALABLE		= 3,
+	V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH				= 4,
+	V4L2_MPEG_VIDEO_MPEG2_PROFILE_MULTIVIEW				= 5,
+};
+
 /* CIDs for the FWHT codec as used by the vicodec driver. */
 #define V4L2_CID_FWHT_I_FRAME_QP             (V4L2_CID_MPEG_BASE + 290)
 #define V4L2_CID_FWHT_P_FRAME_QP             (V4L2_CID_MPEG_BASE + 291)
-- 
2.20.1

