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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA65C10F06
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083A320882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9uStryg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDCWSQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37486 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDCWSP (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so678703wmf.2
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2sPcabTL5atb+mRA0+z8Gv8NLDdZCGeHUnldZdaoJyM=;
        b=e9uStrygdb6QlSMxVjWvLEeTxMzrOp+fUv7pFYZZ/9jAnWoUhIBnyJhrJI5S2/Odm3
         oKqqUpLMsKoBtjdEMR5fBPkMoss9ujPl9LVcvrktTgaGfSLLsXUMSVb5UXxhSUfNMqG1
         hgUyJAhOxUrKIQmv3KHeizyw09tUMHjTRf4UGluv057WHzS9AdabnjaYu/Y5HM/C/yx3
         cM+jRSgipuNiugxtU0LdEg1eljWOdGE+wd5vt0FcAWC8/oANmV96uaHNqnhQ4u2eFTqI
         Nue3nfLKmsbufoEy25CEkv6s9ugPSqFiEtiE6UwXrht0cV6BnRY/fJ4FzIixf4OxYK7L
         lYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2sPcabTL5atb+mRA0+z8Gv8NLDdZCGeHUnldZdaoJyM=;
        b=Xc/yRbETHOJMGIg5n6EefRj0FxWhVyhM6Fbduj2Yc5/aHcmGy7l37iB7M5xzD+DMOL
         MKXGgEfyf0Upv/W/f3iT6ah3VS+rq5l+1lhH++k9N6N0GB5DbXavPuUJ3ieii6AeNBp8
         uwb8x3qylhrmy8OcscggWdeW1YZyu3qNijKJUi3OHph/nl7PsktVGmlc2Lwo6FzUYyBm
         i41J2n0nyfGsy3y25YneYj0InNP2TQbc1mRvmlHuoUMtEi+OpGiBEYo2zdJlyM6dJlb7
         qFWD7RAcDE6GN34jzHr97A4oh11YIvirxPphG5p3qSt13CkRrD8cc063y05uXrhck3YL
         6JdA==
X-Gm-Message-State: APjAAAXHUAKoyPimUqOmA4t4TPbtAFQ4dKQBQ4ls/AeSsQwdWJdx/kuF
        GChnOMhwhXAb67U25T8ArKs=
X-Google-Smtp-Source: APXvYqwVhYtP8JtI7g76maUeZg+y3oVW4+OzJtSJUTyV1Db+emPOf6yKXMnhkaEArhn6hZhurhL/qw==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr1566500wmj.113.1554329894191;
        Wed, 03 Apr 2019 15:18:14 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:13 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 05/16] vicodec: add V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
Date:   Wed,  3 Apr 2019 15:14:50 -0700
Message-Id: <20190403221501.32814-6-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

The stateful encoder requires the presence of this control.
Since a single buffer is sufficient for vicodec, we just
set this control to 1.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 75b6bc5a6f3b..b3bf5c4d73cd 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -1841,13 +1841,16 @@ static int vicodec_open(struct file *file)
 	file->private_data = &ctx->fh;
 	ctx->dev = dev;
 	hdl = &ctx->hdl;
-	v4l2_ctrl_handler_init(hdl, 4);
+	v4l2_ctrl_handler_init(hdl, 5);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_MPEG_VIDEO_GOP_SIZE,
 			  1, 16, 1, 10);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_FWHT_I_FRAME_QP,
 			  1, 31, 1, 20);
 	v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops, V4L2_CID_FWHT_P_FRAME_QP,
 			  1, 31, 1, 20);
+	if (ctx->is_enc)
+		v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops,
+				  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 1, 1, 1);
 	if (ctx->is_stateless)
 		v4l2_ctrl_new_custom(hdl, &vicodec_ctrl_stateless_state, NULL);
 	if (hdl->error) {
-- 
2.17.1

