Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A85C4320A
	for <linux-media@archiver.kernel.org>; Wed, 25 Aug 2021 08:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2086128A
	for <linux-media@archiver.kernel.org>; Wed, 25 Aug 2021 08:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbhHYIpp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 Aug 2021 04:45:45 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:26322 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbhHYIpp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 Aug 2021 04:45:45 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Aug 2021 01:44:59 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Aug 2021 01:44:58 -0700
X-QCInternal: smtphost
Received: from c-mansur-linux.qualcomm.com ([10.204.83.180])
  by ironmsg01-blr.qualcomm.com with ESMTP; 25 Aug 2021 14:14:39 +0530
Received: by c-mansur-linux.qualcomm.com (Postfix, from userid 461723)
        id D527722757; Wed, 25 Aug 2021 14:14:37 +0530 (IST)
From:   Mansur Alisha Shaik <mansur@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org,
        nhebert@chromium.org, Mansur Alisha Shaik <mansur@codeaurora.org>
Subject: [PATCH] venus: vdec: update output buffer size during vdec_s_fmt()
Date:   Wed, 25 Aug 2021 14:14:34 +0530
Message-Id: <20210825084434.32309-1-mansur@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Video driver maintains an internal context for the output buffer size.
During S_fmt() on capture plane, the output buffer size is not updated
in driver context. As a result, during buf_prepare(), the size of the
vb2_plane and internal size of the buffer, as maintained by the driver,
does not match. This leads to buf_prepare() failure.
Update the instance context for the output buffer size during s_fmt().

Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 198e47eb63f4..c129b061a325 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -332,8 +332,11 @@ static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		inst->fmt_out = fmt;
-	else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+	else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		inst->fmt_cap = fmt;
+		inst->output2_buf_size =
+			venus_helper_get_framesz(pixfmt_cap, orig_pixmp.width, orig_pixmp.height);
+	}
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

