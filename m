Return-Path: <SRS0=g9gv=EJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70192C2D0A3
	for <linux-media@archiver.kernel.org>; Tue,  3 Nov 2020 06:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232DD206DC
	for <linux-media@archiver.kernel.org>; Tue,  3 Nov 2020 06:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCG57 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 3 Nov 2020 01:57:59 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38858 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCG57 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 3 Nov 2020 01:57:59 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Nov 2020 22:57:59 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Nov 2020 22:57:57 -0800
X-QCInternal: smtphost
Received: from dikshita-linux.qualcomm.com ([10.204.65.237])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Nov 2020 12:27:50 +0530
Received: by dikshita-linux.qualcomm.com (Postfix, from userid 347544)
        id 207F0559F; Tue,  3 Nov 2020 12:27:49 +0530 (IST)
From:   Dikshita Agarwal <dikshita@codeaurora.org>
To:     linux-media@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl,
        Dikshita Agarwal <dikshita@codeaurora.org>
Subject: [RESEND PATCH] v4l2-ctrls: allow V4L2_CTRL_TYPE_BUTTON with request api
Date:   Tue,  3 Nov 2020 12:27:37 +0530
Message-Id: <1604386657-16495-1-git-send-email-dikshita@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

remove check for V4L2_CTRL_TYPE_BUTTON from
v4l2_ctrl_request_clone and v4l2_ctrl_request_setup().

Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index f320016..f6c4943 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -3391,9 +3391,6 @@ static int v4l2_ctrl_request_clone(struct v4l2_ctrl_handler *hdl,
 		/* Skip refs inherited from other devices */
 		if (ref->from_other_dev)
 			continue;
-		/* And buttons */
-		if (ctrl->type == V4L2_CTRL_TYPE_BUTTON)
-			continue;
 		err = handler_new_ref(hdl, ctrl, &new_ref, false, true);
 		if (err)
 			break;
@@ -4475,8 +4472,7 @@ int v4l2_ctrl_request_setup(struct media_request *req,
 		 * Skip if this control was already handled by a cluster.
 		 * Skip button controls and read-only controls.
 		 */
-		if (ref->req_done || ctrl->type == V4L2_CTRL_TYPE_BUTTON ||
-		    (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY))
+		if (ref->req_done || (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY))
 			continue;
 
 		v4l2_ctrl_lock(master);
-- 
1.9.1

