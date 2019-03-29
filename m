Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9454CC43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 03:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3F218A2
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 03:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLamwxiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfC2DUy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:20:54 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:53937 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfC2DUy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 23:20:54 -0400
Received: by mail-vk1-f202.google.com with SMTP id 5so290781vkg.20
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mqVVgS3VJCrOdTY9MaSG2UYIdfGVYo0XjzfpxE/xxGQ=;
        b=DLamwxiEhHKmfKC0b92s74I31LjVzNKLUirgBAAVHvqFXxHqpsyJYObPoefb1artC2
         V0YWogmyVi1dkeERjjz4UmFZsryy5pL1DAsFZ/LnJe0Fz5uFbiMLvPx33ocvxZYT0hEm
         Kw3pkCA38wbe+jxOhJZ54cK7+TRsQi8v5EdSBAmBcmpG4D6uOgyK7wxdr806VQ0pYkeK
         z13jgWtweN06JIwSQVgF27vwVYgLKxiET82RKu28XeajqQ5KY9kuJRDu9h6CDKUc1FrM
         WC8AbMs5c5/JlYuLMBUBoy06+Tb+xwOB1ncq7827lA40ToGlPURQ2GcEflIC+MEG18/z
         hMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mqVVgS3VJCrOdTY9MaSG2UYIdfGVYo0XjzfpxE/xxGQ=;
        b=GSDQs/cqPaY1vlUIlg+XI1D5hA40RKan6XVbQKdOaA/K88sBiXpoFAZ6mUrf3fRzZU
         kchx2ruk74T06gluupZI83i8YNj4pWmsq6fH2DrmltNbm7mEsPrpb79xbgzZQ7rdq7k7
         FNmuBwOuh/xkiFlEsOE1ZDzsdvOV+wUMUq4BlM8yUuG39eGYWDYl4jsvgXHvLnpkVsOa
         iZw8t4AN5+jzWjrwKeXK+96PlA/7JiTs8Z+njjNkk2JrlH77ZwPloIxMMI1nSdvB2E7q
         iG0fGOMq2/7d9SQgkLovhxgyevJn7A+eohM63fKSOU1cJQ3YkS/N2v5VXm8ss5ARgfg6
         K2Jg==
X-Gm-Message-State: APjAAAUbsaHK2k6PqEEIJWKOBxC1vn2sm2m4bGXTJ0OHnrBishlD/nmS
        VXj7qP91HSFEYpnuIvDkkYjET6n+U968
X-Google-Smtp-Source: APXvYqzX6wgUlg1ASklJyYMriFgDJnAdTfzFtVwT14yjWVjApwKGX74VSmLLgu+fgdsKuc1IbWCzS1cdembs
X-Received: by 2002:a1f:8d0b:: with SMTP id p11mr3636101vkd.0.1553829653216;
 Thu, 28 Mar 2019 20:20:53 -0700 (PDT)
Date:   Fri, 29 Mar 2019 11:20:46 +0800
In-Reply-To: <20190128072948.45788-1-linfish@google.com>
Message-Id: <20190329032046.58230-1-linfish@google.com>
Mime-Version: 1.0
References: <20190128072948.45788-1-linfish@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v8] [media] v4l: add I / P frame min max QP definitions
From:   Fish Lin <linfish@google.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Smitha T Murthy <smitha.t@samsung.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fish Lin <linfish@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add following V4L2 QP parameters for H.264:
* V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP
* V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP
* V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP
* V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP

These controls will limit QP range for intra and inter frame,
provide more manual control to improve video encode quality.

Signed-off-by: Fish Lin <linfish@google.com>
---
Changelog since v7:
- Correct patch format.

Changelog since v6:
- Adjust ctrl id start from 385.

Changelog since v5:
- Adjust documentation wording.

Changelog since v4:
- Fix patch subject and send again.

Changelog since v3:
- Put document in ext-ctrls-codec.rst instead of extended-controls.rst
  (which was previous version).

Changelog since v2:
- Add interaction with V4L2_CID_MPEG_VIDEO_H264_MIN/MAX_QP
  description in the document.

Changelog since v1:
- Add description in document.

 .../media/uapi/v4l/ext-ctrls-codec.rst        | 24 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls.c          |  4 ++++
 include/uapi/linux/v4l2-controls.h            |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
index c97fb7923be5..5b2db52d3b4e 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
@@ -1048,6 +1048,30 @@ enum v4l2_mpeg_video_h264_entropy_mode -
     Quantization parameter for an B frame for H264. Valid range: from 0
     to 51.
 
+``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP (integer)``
+    Minimum quantization parameter for the H264 I frame to limit I frame
+    quality to a range. Valid range: from 0 to 51. If
+    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is also set, the quantization parameter
+    should be chosen to meet both requirements.
+
+``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP (integer)``
+    Maximum quantization parameter for the H264 I frame to limit I frame
+    quality to a range. Valid range: from 0 to 51. If
+    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is also set, the quantization parameter
+    should be chosen to meet both requirements.
+
+``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP (integer)``
+    Minimum quantization parameter for the H264 P frame to limit P frame
+    quality to a range. Valid range: from 0 to 51. If
+    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is also set, the quantization parameter
+    should be chosen to meet both requirements.
+
+``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP (integer)``
+    Maximum quantization parameter for the H264 P frame to limit P frame
+    quality to a range. Valid range: from 0 to 51. If
+    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is also set, the quantization parameter
+    should be chosen to meet both requirements.
+
 ``V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP (integer)``
     Quantization parameter for an I frame for MPEG4. Valid range: from 1
     to 31.
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index b79d3bbd8350..115fb8debe23 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -828,6 +828,10 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION:
 								return "H264 Constrained Intra Pred";
 	case V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET:	return "H264 Chroma QP Index Offset";
+	case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP:		return "H264 I-Frame Minimum QP Value";
+	case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP:		return "H264 I-Frame Maximum QP Value";
+	case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP:		return "H264 P-Frame Minimum QP Value";
+	case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP:		return "H264 P-Frame Maximum QP Value";
 	case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:		return "MPEG4 I-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:		return "MPEG4 P-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:		return "MPEG4 B-Frame QP Value";
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 06479f2fb3ae..93feaf9c8a37 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -535,6 +535,10 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type {
 #define V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP	(V4L2_CID_MPEG_BASE+382)
 #define V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION	(V4L2_CID_MPEG_BASE+383)
 #define V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET		(V4L2_CID_MPEG_BASE+384)
+#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP	(V4L2_CID_MPEG_BASE+385)
+#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP	(V4L2_CID_MPEG_BASE+386)
+#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP	(V4L2_CID_MPEG_BASE+387)
+#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP	(V4L2_CID_MPEG_BASE+388)
 #define V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP	(V4L2_CID_MPEG_BASE+400)
 #define V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP	(V4L2_CID_MPEG_BASE+401)
 #define V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP	(V4L2_CID_MPEG_BASE+402)
-- 
2.21.0.392.gf8f6787159e-goog

