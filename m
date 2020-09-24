Return-Path: <SRS0=PL4U=DB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7013AC4727E
	for <linux-media@archiver.kernel.org>; Thu, 24 Sep 2020 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB7823899
	for <linux-media@archiver.kernel.org>; Thu, 24 Sep 2020 17:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgIXRbg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:31:36 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33711 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgIXRbf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 24 Sep 2020 13:31:35 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 Sep 2020 10:31:35 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Sep 2020 10:31:33 -0700
Received: from dikshita-linux.qualcomm.com ([10.204.65.237])
  by ironmsg01-blr.qualcomm.com with ESMTP; 24 Sep 2020 23:01:20 +0530
Received: by dikshita-linux.qualcomm.com (Postfix, from userid 347544)
        id 4B8DD4E7E; Thu, 24 Sep 2020 23:01:19 +0530 (IST)
From:   Dikshita Agarwal <dikshita@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, Dikshita Agarwal <dikshita@codeaurora.org>
Subject: [PATCH 2/2] venus: venc: fix handlig of S_SELECTION and G_SELECTION
Date:   Thu, 24 Sep 2020 23:01:14 +0530
Message-Id: <1600968674-11559-3-git-send-email-dikshita@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600968674-11559-1-git-send-email-dikshita@codeaurora.org>
References: <1600968674-11559-1-git-send-email-dikshita@codeaurora.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

- return correct width and height for G_SELECTION
- if requested rectangle wxh doesn't match with capture port wxh
  adjust the rectangle to supported wxh.

Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
---
 drivers/media/platform/qcom/venus/venc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 7d2aaa8..a2cc12d 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -463,13 +463,13 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	switch (s->target) {
 	case V4L2_SEL_TGT_CROP_DEFAULT:
 	case V4L2_SEL_TGT_CROP_BOUNDS:
-		s->r.width = inst->width;
-		s->r.height = inst->height;
-		break;
-	case V4L2_SEL_TGT_CROP:
 		s->r.width = inst->out_width;
 		s->r.height = inst->out_height;
 		break;
+	case V4L2_SEL_TGT_CROP:
+		s->r.width = inst->width;
+		s->r.height = inst->height;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -490,10 +490,14 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 
 	switch (s->target) {
 	case V4L2_SEL_TGT_CROP:
-		if (s->r.width != inst->out_width ||
-		    s->r.height != inst->out_height ||
-		    s->r.top != 0 || s->r.left != 0)
-			return -EINVAL;
+		if (s->r.width != inst->width ||
+		    s->r.height != inst->height ||
+		    s->r.top != 0 || s->r.left != 0) {
+			s->r.top = 0;
+			s->r.left = 0;
+			s->r.width = inst->width;
+			s->r.height = inst->height;
+		}
 		break;
 	default:
 		return -EINVAL;
-- 
1.9.1

