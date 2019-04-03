Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D82C10F06
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F96520882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxsgUEQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDCWSV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37494 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDCWSU (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so678960wmf.2
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i5hySsiSdpJ8GOLdDU4HYynean1/a10NETeKXmN1rS8=;
        b=uxsgUEQ+SAcYWI4glakiPWcYpTzh0eFms9GpiKh6BCjIXthAb3hUuHuTzVtLCkRNNW
         nl47zi83AKUYjSOuHr5jsNldvfaL1SZ7HSFhZiLwH1uvZdDVF/pIat868VpyKje6aqu2
         QXdnsTYh644hwVRBU6IZoSzC8Td6ozfqqizU1kryXIIwq+uhEtmYA8Mr5eBmQOQtxboh
         2iJh2JdlMaMyyxaZiXZnMESGvRGcbZE84Oq+xYik76DO+xAQPyAzAksUODa58RtoyF3m
         ghymS6rO+l9FCifpKokNuKkGIfybh8++zhhLSnQsKWVAgPxw+mK6oCCmbqlpTVX2YbS6
         yC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i5hySsiSdpJ8GOLdDU4HYynean1/a10NETeKXmN1rS8=;
        b=hVOzgdC7LjAVQmhlcaTcH6Nhw2m+Gz/0uiVLo/iiPa9CdAiL9Illi/gxzDeBKrM8Ts
         A7FtfjLCNfHwEmCffoteq2RJCWfDIChnS8xQInwtNrlwuLa9jkuAHHXdpxYijyT+3TEu
         n1Mvj1EEYIULetJ/du4/DqMCZyA0bpHBrfDtyyryIkSPvXmjxOGiLLex0V4Ra4Rf2wm4
         J68A4M2Nee51gCM4cvCPmUsD1NCaCI8os9MxhqnRVxPqGN2vUARbXFsQcqKatjMGK3Oa
         3r6eikRGY9rB/NPmv2g4RnBiMFtV0NK8uqJ0+xZZEzbTMjKfEMg7CWZYUndK6krlMQD4
         7pfQ==
X-Gm-Message-State: APjAAAVtM1k9O8qsR13fcwA69C0zlj3y4auZELdwFTqVyzh5n3OV+Lzd
        5ApooEUcgukfRVZUbq6sRpY=
X-Google-Smtp-Source: APXvYqzAUjL6/iFbU4UfJyBRHGvNKM1VDbC3AdNtgv3roRNSDVIjf51bk3EUUy4KG9VpAtB4lme5Ow==
X-Received: by 2002:a1c:1b10:: with SMTP id b16mr1689216wmb.90.1554329899301;
        Wed, 03 Apr 2019 15:18:19 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:18 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 09/16] v4l2-ctrls: add v4l2_ctrl_s_ctrl_ptr()
Date:   Wed,  3 Apr 2019 15:14:54 -0700
Message-Id: <20190403221501.32814-10-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

Add a function to set a compound control by passing a pointer to the
new data.

Functions to set other control types already existed, but not for this.

This is needed for stateless encoders.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 11 ++++++++
 include/media/v4l2-ctrls.h           | 42 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index b1ae2e555c68..c6e8f5838b65 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -3855,6 +3855,17 @@ int __v4l2_ctrl_s_ctrl_string(struct v4l2_ctrl *ctrl, const char *s)
 }
 EXPORT_SYMBOL(__v4l2_ctrl_s_ctrl_string);
 
+int __v4l2_ctrl_s_ctrl_ptr(struct v4l2_ctrl *ctrl, const void *ptr)
+{
+	lockdep_assert_held(ctrl->handler->lock);
+
+	/* It's a driver bug if this happens. */
+	WARN_ON(!ctrl->is_ptr);
+	memcpy(ctrl->p_new.p, ptr, ctrl->elems * ctrl->elem_size);
+	return set_ctrl(NULL, ctrl, 0);
+}
+EXPORT_SYMBOL(__v4l2_ctrl_s_ctrl_ptr);
+
 void v4l2_ctrl_request_complete(struct media_request *req,
 				struct v4l2_ctrl_handler *main_hdl)
 {
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index bd621cec65a5..87c4ade17e22 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -1060,6 +1060,48 @@ static inline int v4l2_ctrl_s_ctrl_string(struct v4l2_ctrl *ctrl, const char *s)
 	return rval;
 }
 
+/**
+ * __v4l2_ctrl_s_ctrl_ptr() - Unlocked variant of v4l2_ctrl_s_ctrl_ptr().
+ *
+ * @ctrl:	The control.
+ * @ptr:	Pointer to the new control contents.
+ *
+ * This sets the control's new content safely by going through the control
+ * framework. This function assumes the control's handler is already locked,
+ * allowing it to be used from within the &v4l2_ctrl_ops functions.
+ *
+ * This function is for pointer type controls only and will memcpy()
+ * @ctrl->elems * @ctrl->elem_size bytes from @ptr to the internal
+ * control data.
+ */
+int __v4l2_ctrl_s_ctrl_ptr(struct v4l2_ctrl *ctrl, const void *ptr);
+
+/**
+ * v4l2_ctrl_s_ctrl_ptr() - Helper function to set a control's string value
+ *	 from within a driver.
+ *
+ * @ctrl:	The control.
+ * @ptr:	Pointer to the new control contents.
+ *
+ * This sets the control's new content safely by going through the control
+ * framework. This function will lock the control's handler, so it cannot be
+ * used from within the &v4l2_ctrl_ops functions.
+ *
+ * This function is for pointer type controls only and will memcpy()
+ * @ctrl->elems * @ctrl->elem_size bytes from @ptr to the internal
+ * control data.
+ */
+static inline int v4l2_ctrl_s_ctrl_ptr(struct v4l2_ctrl *ctrl, const void *ptr)
+{
+	int rval;
+
+	v4l2_ctrl_lock(ctrl);
+	rval = __v4l2_ctrl_s_ctrl_ptr(ctrl, ptr);
+	v4l2_ctrl_unlock(ctrl);
+
+	return rval;
+}
+
 /* Internal helper functions that deal with control events. */
 extern const struct v4l2_subscribed_event_ops v4l2_ctrl_sub_ev_ops;
 
-- 
2.17.1

