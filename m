Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF58C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 07:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CB020857
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 07:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfDAHur (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:50:47 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:52441 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731943AbfDAHur (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 03:50:47 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id AriMhYvJtNG8zAriPh9NC8; Mon, 01 Apr 2019 09:50:45 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Dafna Hirschfeld <dafna3@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] v4l2-ctrls: add v4l2_ctrl_s_ctrl_ptr()
Message-ID: <825c2c17-9d88-67eb-d5d2-7e8d1e2371a7@xs4all.nl>
Date:   Mon, 1 Apr 2019 09:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDthznUno0wcz7C9FoGtU45oS93nsqptONV5UFRywYfouGsWhxog7USBknhlD/9sLV1SApsOXdJDnzPfP5w59R47FrPulPM0hOe2leu7p5uyBzx/G6St
 cb1i6ucJhsh48LZJZVYgoGaUmBVD+Uwh6kIb+xWyb2i/PjKgO/0VjUAkCayzsg1LWtKy8X8wCXKcdifopzlA/uT392bxGPPfWao=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add a function to set a compound control by passing a pointer to the
new data.

Functions to set other control types already existed, but not for this.

This is needed for stateless encoders.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
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

