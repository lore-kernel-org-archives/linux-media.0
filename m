Return-Path: <SRS0=bGZa=4U=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA01C3F2D7
	for <linux-media@archiver.kernel.org>; Tue,  3 Mar 2020 11:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AC32083E
	for <linux-media@archiver.kernel.org>; Tue,  3 Mar 2020 11:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Qwz2Q2hT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCCLCE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:02:04 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:46135 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727970AbgCCLCD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 3 Mar 2020 06:02:03 -0500
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:d0e2:a5af:5d0f:8e60])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 95JIjjGK0EE3q95JJjzPPs; Tue, 03 Mar 2020 12:02:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1583233321; bh=F2vcK36o2wdJW4t3vuT3zm9xxyFiPtkoebbz/0k3YOs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=Qwz2Q2hTDxfROlKTS//6btl6V1o+lZHZHPEV5NZrR6GP110iz6xphBSkIwPjEtfpK
         2yG8DPAYFFV1/0GSfAaZ/V/jc8ctgOSA43zspHxGIFjDw/1DVjDJdkcK0kqMBuylAS
         6Cra6laZp8H/huOV8nqUNoY/rlPWDWLrHw1x9sSWufMVRj2R12nxlYSAEjFvTA2cdO
         4ngfuKZtJQefeVrIOuIh8JVw04n3haaTNJV6I/ppjsXM8Fa/j8tixQj37jU4oJZcEk
         1BOkJSbRxZvFt86UVTt4Wv9mUCWkCsZHEO70kU9mOueKzYJbGGUA03LO8vi3Yxy21z
         mxM/KPJaXtvWg==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 1/2] v4l2-ctrls: v4l2_ctrl_g/s_ctrl*(): don't continue when WARN_ON
Date:   Tue,  3 Mar 2020 12:01:59 +0100
Message-Id: <20200303110200.2571176-2-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303110200.2571176-1-hverkuil-cisco@xs4all.nl>
References: <20200303110200.2571176-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfE3eFw8HVjrTgaSo7BBUWo/XaNk/Alv5sZRNy/PE0NIRm5ujaXkjV6p5ek+GRCKGCc3UPnLPN49fSis0IrGD0mg6icS8SYFv4A1cvwhTBLXnSIVzSUUx
 sQmfe+vNp3v11jO1RMpgxM/fKz3cAnvzqn1EGHk3tEXQ0nfCwtv7TC3dEcQEyjRRU3WCaBGg/IC6M1xv9tP0znR7K47ITGxvXftqQnAgEjkUlXbs8tGMmyAQ
 xldQHRUiTH3s3BzPNzQoGhv3TW5GY8Md53lL+OBUkJdrHfo8NJhEs8Nc/YtjucMzVJbz9ZwGtCOJ0/SxDABgraA8i4kq2fBg+ubfMv24m/zTd+KoisoHIzMK
 2oHgUnZ4
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the v4l2_ctrl_g_ctrl*() or __v4l2_ctrl_s_ctrl*() functions
are called for the wrong control type then they call WARN_ON
since that is a driver error. But they still continue, potentially
overwriting data. Change this to return an error (s_ctrl) or 0
(g_ctrl), just to be safe.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 2928c5e0a73d..d3bacf6b59d6 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -3794,7 +3794,8 @@ s32 v4l2_ctrl_g_ctrl(struct v4l2_ctrl *ctrl)
 	struct v4l2_ext_control c;
 
 	/* It's a driver bug if this happens. */
-	WARN_ON(!ctrl->is_int);
+	if (WARN_ON(!ctrl->is_int))
+		return 0;
 	c.value = 0;
 	get_ctrl(ctrl, &c);
 	return c.value;
@@ -3806,7 +3807,8 @@ s64 v4l2_ctrl_g_ctrl_int64(struct v4l2_ctrl *ctrl)
 	struct v4l2_ext_control c;
 
 	/* It's a driver bug if this happens. */
-	WARN_ON(ctrl->is_ptr || ctrl->type != V4L2_CTRL_TYPE_INTEGER64);
+	if (WARN_ON(ctrl->is_ptr || ctrl->type != V4L2_CTRL_TYPE_INTEGER64))
+		return 0;
 	c.value64 = 0;
 	get_ctrl(ctrl, &c);
 	return c.value64;
@@ -4215,7 +4217,8 @@ int __v4l2_ctrl_s_ctrl(struct v4l2_ctrl *ctrl, s32 val)
 	lockdep_assert_held(ctrl->handler->lock);
 
 	/* It's a driver bug if this happens. */
-	WARN_ON(!ctrl->is_int);
+	if (WARN_ON(!ctrl->is_int))
+		return -EINVAL;
 	ctrl->val = val;
 	return set_ctrl(NULL, ctrl, 0);
 }
@@ -4226,7 +4229,8 @@ int __v4l2_ctrl_s_ctrl_int64(struct v4l2_ctrl *ctrl, s64 val)
 	lockdep_assert_held(ctrl->handler->lock);
 
 	/* It's a driver bug if this happens. */
-	WARN_ON(ctrl->is_ptr || ctrl->type != V4L2_CTRL_TYPE_INTEGER64);
+	if (WARN_ON(ctrl->is_ptr || ctrl->type != V4L2_CTRL_TYPE_INTEGER64))
+		return -EINVAL;
 	*ctrl->p_new.p_s64 = val;
 	return set_ctrl(NULL, ctrl, 0);
 }
@@ -4237,7 +4241,8 @@ int __v4l2_ctrl_s_ctrl_string(struct v4l2_ctrl *ctrl, const char *s)
 	lockdep_assert_held(ctrl->handler->lock);
 
 	/* It's a driver bug if this happens. */
-	WARN_ON(ctrl->type != V4L2_CTRL_TYPE_STRING);
+	if (WARN_ON(ctrl->type != V4L2_CTRL_TYPE_STRING))
+		return -EINVAL;
 	strscpy(ctrl->p_new.p_char, s, ctrl->maximum + 1);
 	return set_ctrl(NULL, ctrl, 0);
 }
@@ -4249,7 +4254,8 @@ int __v4l2_ctrl_s_ctrl_area(struct v4l2_ctrl *ctrl,
 	lockdep_assert_held(ctrl->handler->lock);
 
 	/* It's a driver bug if this happens. */
-	WARN_ON(ctrl->type != V4L2_CTRL_TYPE_AREA);
+	if (WARN_ON(ctrl->type != V4L2_CTRL_TYPE_AREA))
+		return -EINVAL;
 	*ctrl->p_new.p_area = *area;
 	return set_ctrl(NULL, ctrl, 0);
 }
-- 
2.25.1

