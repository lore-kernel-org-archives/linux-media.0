Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A7C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 07:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6898F20700
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 07:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbfDAHmK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:42:10 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:47338 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731833AbfDAHmK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 03:42:10 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Ara1hYrbiNG8zAra4h9JbI; Mon, 01 Apr 2019 09:42:09 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] v4l2-ctrls.h: remove spurious text
Message-ID: <008ba0b8-e300-057e-1ee3-30f97ec4c163@xs4all.nl>
Date:   Mon, 1 Apr 2019 09:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLznkUl23iXJE/9LjDz5u7jpK+5AKoUUren6R9lYFre336QbZwOJHC/SZisrI5+n0MEm6AgoYM4dMC4VHTZz99jcAdGkeXOFBn8GqHc1ud+wSLWsFpSP
 EPoSFI6jo6VyBhDeb/ksyEQHfm/yVfdH5ldrnvlb86iaVlJlsC3b6RK0NwBNyDCiy6jAQfVmif2U2A==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Somehow the string "Controls name" got pasted in two places
where it doesn't belong. Remove that text.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index bd621cec65a5..e86a374fa91b 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -937,7 +937,7 @@ s32 v4l2_ctrl_g_ctrl(struct v4l2_ctrl *ctrl);
  * __v4l2_ctrl_s_ctrl() - Unlocked variant of v4l2_ctrl_s_ctrl().
  *
  * @ctrl:	The control.
- * @val:	TheControls name new value.
+ * @val:	The new value.
  *
  * This sets the control's new value safely by going through the control
  * framework. This function assumes the control's handler is already locked,
@@ -1042,7 +1042,7 @@ int __v4l2_ctrl_s_ctrl_string(struct v4l2_ctrl *ctrl, const char *s);
  *
  * @ctrl:	The control.
  * @s:		The new string.
- *Controls name
+ *
  * This sets the control's new string safely by going through the control
  * framework. This function will lock the control's handler, so it cannot be
  * used from within the &v4l2_ctrl_ops functions.
