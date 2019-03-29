Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163DDC43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 02:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DAF218A2
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 02:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pp63DvsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfC2C76 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:59:58 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:45799 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfC2C76 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 22:59:58 -0400
Received: by mail-yb1-f201.google.com with SMTP id k65so711428ybc.12
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 19:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e4qO0Xpnv7bzZTjFrcD9GxfRGtNUSgyuAtohdyhEJNs=;
        b=pp63DvsXUBltHv4i/TUcaEaPCKT3+inYGWPS0Lz312IxhQ8amc9nSgRU2Df7yNlU+b
         /0BJeu+RyJGezMH8Ix7OpfNsTlfG5o+nqMVIXul8ahpq1Gp/lvPtvatJ/vX/JLW3YMbx
         zd/oNiOvX9be/+QGAKEAc+pmxRI/1cJ5lHRt+J6VpcozDqWIVmx6APM10KlfS3QaIImT
         IuW/H5F0iU1fpSV117Hi3O/Mml0mjapID4DzwWTCAo51glC1gBMyoOZlXlcv7BP79HYi
         t2QRiYwTHKGgdzMbJTvmWJ4TUWhxsw34S2sv+UAT+3S+z7WDZEsovUpfxgodyVYA1jhN
         Qz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e4qO0Xpnv7bzZTjFrcD9GxfRGtNUSgyuAtohdyhEJNs=;
        b=dWLSoQcOEKOvun0uoyQnxrxJ1hb609MD3p2NGpxy7c50JsaBx5exxJ0XRKCtoyBKMY
         y2iML+TUImZ+vYWYqgYgN+pah638CJ5tE9ntUc097CFzeQWHLnZm6IZGnd6QqJyOONAj
         hmmv+z9B4W1cN/MkSoMkgRHlBRuHzObFjmJCE+6XpWgcmCAZ6wUdp8wzRg4rOtf0KMRa
         KwH8Mu3TqKEk+hPHc3CH+F9njmoSiAMnxu1YL9qiwQ6duk5i9ectTIosEn5nSX3G4S3z
         A/yzHA6lyyuLCKhBsv70t38mssVJsJDexmnHqyZ2LpOeoAZPfu7WPdn7GAb3JvBpbUhG
         YzqQ==
X-Gm-Message-State: APjAAAVwlgnOjO1GF9u01OIhC80/qsIWxIL/qS4SjsIrOu+FQqMYYz67
        Df9G0gfnYJ/fRCGqnlQ3uZb0oxGMx8dM
X-Google-Smtp-Source: APXvYqxShNIharv4eHH0PKSmwDPDmLymMu8pE7OMG2rmXEuUZy8zXj/6+pCA3PEar0uht0VY1SrRH62NOhUj
X-Received: by 2002:a81:dd0:: with SMTP id 199mr3114723ywn.21.1553828396833;
 Thu, 28 Mar 2019 19:59:56 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:59:50 +0800
In-Reply-To: <20190128072948.45788-1-linfish@google.com>
Message-Id: <20190329025950.52582-1-linfish@google.com>
Mime-Version: 1.0
References: <20190128072948.45788-1-linfish@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v7] [media] v4l: add I / P frame min max QP definitions
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
 include/uapi/linux/v4l2-controls.h            |  6 +++++
 3 files changed, 34 insertions(+)

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
index 06479f2fb3ae..4421baa84177 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -535,6 +535,12 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type {
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
2.21.0.225.g810b269d1ac-goog

