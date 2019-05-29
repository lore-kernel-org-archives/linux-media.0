Return-Path: <SRS0=CnRj=T5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64DEC28CC0
	for <linux-media@archiver.kernel.org>; Wed, 29 May 2019 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0A5240FF
	for <linux-media@archiver.kernel.org>; Wed, 29 May 2019 19:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfE2T3A (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 29 May 2019 15:29:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54744 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfE2T3A (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 29 May 2019 15:29:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 935B2283EB6
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 2/2] media: v4l2-ctrl: Move compound control initialization
Date:   Wed, 29 May 2019 16:28:11 -0300
Message-Id: <20190529192811.13986-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529192811.13986-1-ezequiel@collabora.com>
References: <20190529192811.13986-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Rework std_init adding an explicit initialization for
compound controls.

While here, make sure the control is initialized to zero,
before providing default values for all its fields.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 55 +++++++++++++++++-----------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index c7d5fdb8efb4..44afda1d77b3 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1506,25 +1506,49 @@ static bool std_equal(const struct v4l2_ctrl *ctrl, u32 idx,
 	}
 }
 
-static void std_init(const struct v4l2_ctrl *ctrl, u32 idx,
+static void std_init_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 		     union v4l2_ctrl_ptr ptr)
 {
 	struct v4l2_ctrl_mpeg2_slice_params *p_mpeg2_slice_params;
 
+	memset(ptr.p, 0, ctrl->elem_size);
+
 	/*
 	 * The cast is needed to get rid of a gcc warning complaining that
 	 * V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS is not part of the
 	 * v4l2_ctrl_type enum.
 	 */
 	switch ((u32)ctrl->type) {
+	case V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS:
+		p_mpeg2_slice_params = ptr.p;
+		/* 4:2:0 */
+		p_mpeg2_slice_params->sequence.chroma_format = 1;
+		/* 8 bits */
+		p_mpeg2_slice_params->picture.intra_dc_precision = 0;
+		/* interlaced top field */
+		p_mpeg2_slice_params->picture.picture_structure = 1;
+		p_mpeg2_slice_params->picture.picture_coding_type =
+					V4L2_MPEG2_PICTURE_CODING_TYPE_I;
+		return;
+	default:
+		idx *= ctrl->elem_size;
+		memset(ptr.p + idx, 0, ctrl->elem_size);
+		return;
+	}
+}
+
+static void std_init(const struct v4l2_ctrl *ctrl, u32 idx,
+		     union v4l2_ctrl_ptr ptr)
+{
+	switch (ctrl->type) {
 	case V4L2_CTRL_TYPE_STRING:
 		idx *= ctrl->elem_size;
 		memset(ptr.p_char + idx, ' ', ctrl->minimum);
 		ptr.p_char[idx + ctrl->minimum] = '\0';
-		break;
+		return;
 	case V4L2_CTRL_TYPE_INTEGER64:
 		ptr.p_s64[idx] = ctrl->default_value;
-		break;
+		return;
 	case V4L2_CTRL_TYPE_INTEGER:
 	case V4L2_CTRL_TYPE_INTEGER_MENU:
 	case V4L2_CTRL_TYPE_MENU:
@@ -1533,32 +1557,21 @@ static void std_init(const struct v4l2_ctrl *ctrl, u32 idx,
 	case V4L2_CTRL_TYPE_BUTTON:
 	case V4L2_CTRL_TYPE_CTRL_CLASS:
 		ptr.p_s32[idx] = ctrl->default_value;
-		break;
+		return;
 	case V4L2_CTRL_TYPE_U8:
 		ptr.p_u8[idx] = ctrl->default_value;
-		break;
+		return;
 	case V4L2_CTRL_TYPE_U16:
 		ptr.p_u16[idx] = ctrl->default_value;
-		break;
+		return;
 	case V4L2_CTRL_TYPE_U32:
 		ptr.p_u32[idx] = ctrl->default_value;
-		break;
-	case V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS:
-		p_mpeg2_slice_params = ptr.p;
-		/* 4:2:0 */
-		p_mpeg2_slice_params->sequence.chroma_format = 1;
-		/* 8 bits */
-		p_mpeg2_slice_params->picture.intra_dc_precision = 0;
-		/* interlaced top field */
-		p_mpeg2_slice_params->picture.picture_structure = 1;
-		p_mpeg2_slice_params->picture.picture_coding_type =
-					V4L2_MPEG2_PICTURE_CODING_TYPE_I;
-		break;
+		return;
 	default:
-		idx *= ctrl->elem_size;
-		memset(ptr.p + idx, 0, ctrl->elem_size);
-		break;
+		std_init_compound(ctrl, idx, ptr);
+		return;
 	}
+
 }
 
 static void std_log(const struct v4l2_ctrl *ctrl)
-- 
2.20.1

