Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B41C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942BB2146F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWNlZJXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfC3Upr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35801 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbfC3Upr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so6869537wrp.2
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kh4BeWbL0XXVBjuQMhrIp5mV5ORgkdRe+08rKr1QdK8=;
        b=oWNlZJXXTLjnQzBDrt9BQDMFGB/Zwehs3EP90PHpvc8lyzp3hm1ffU4l7s10O1PvJQ
         h84ISpQiSJQBrPp+tDPJ/0RMwlvT6e6jpUK/BD6b5z4Z9lPC0HnSm27g0Ez3mwiCnOc7
         sPiQn3JrP+H4kvHUSH8brHUgPtRV+aczVfCVDUvGvgv31cQiMPOjVyzWZDeOGkPWKK6Z
         ffCndxrT8VaIgjxyGZDQb4E7sjOfsqyoCKuwGGrqm49gngKGNWsrrekZH7dX3g2+5SrE
         q/1JM37OatMsBWRZGgA6bh2NTFEBnsNHBwD2tS9LJ0RRLK8+2hhxMlbQzT1BlmRY0lye
         KoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kh4BeWbL0XXVBjuQMhrIp5mV5ORgkdRe+08rKr1QdK8=;
        b=sLLRTPFOlRWe1Kev+y000PtYsTQkdZx0FvMzKUv8oHGuVbbaZUAet81EdQ5qf+cbnb
         YxZOHBsC1O0QRPC5xVEOVfsNwczc8RacPzObJ8oOFm1RhM2HYhZ17xOZVk4tCCa2Ux5p
         v9388mkcras/IG7mcl124xH/ySKi68CTC+D1ef27z1d8oq6+Utvk5HCz+ak+tTqjEed/
         i6JXHuqxrzT3sRffIIX5m/G2tKsGik32nmH+XkQBf82IF4ZyNxCNI0EZK1vHoPKZmBLy
         MqN2ZL4atmPtsjbWSeq/lR0WjtFGtXYIXAmilWj6SFOvI8zir8pACBWISXWuootxtgZG
         qKUA==
X-Gm-Message-State: APjAAAUH2f5b0xEuABAXNU02fq7JFUIKmVTTA2rPdDL++Ym6GKB/+E2j
        jmDvrJPMnIz1FR9/OkeZxAArH5fyrpU=
X-Google-Smtp-Source: APXvYqzwD9d51YikQDYTROt9kisIB0yaZnLb+C+stn1U9D+zr8d1dIdY3JKgvVmBMy2ks9tj3+xCHw==
X-Received: by 2002:adf:e443:: with SMTP id t3mr4553706wrm.257.1553978745460;
        Sat, 30 Mar 2019 13:45:45 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:44 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 02/14] vicodec: always return a valid format.
Date:   Sat, 30 Mar 2019 13:43:00 -0700
Message-Id: <20190330204311.107417-3-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Rather than returning width/height values of 0, just default to
a format. Formats in V4L2 are always supposed to be valid, there
is no concept of an invalid format.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index bd01a9206aa6..a6b35db7203a 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -1771,11 +1771,13 @@ static const struct v4l2_ctrl_config vicodec_ctrl_stateless_state = {
  */
 static int vicodec_open(struct file *file)
 {
+	const struct v4l2_fwht_pixfmt_info *info = v4l2_fwht_get_pixfmt(0);
 	struct video_device *vfd = video_devdata(file);
 	struct vicodec_dev *dev = video_drvdata(file);
 	struct vicodec_ctx *ctx = NULL;
 	struct v4l2_ctrl_handler *hdl;
-	unsigned int size;
+	unsigned int raw_size;
+	unsigned int comp_size;
 	int rc = 0;
 
 	if (mutex_lock_interruptible(vfd->lock))
@@ -1814,7 +1816,7 @@ static int vicodec_open(struct file *file)
 	v4l2_ctrl_handler_setup(hdl);
 
 	if (ctx->is_enc)
-		ctx->q_data[V4L2_M2M_SRC].info = v4l2_fwht_get_pixfmt(0);
+		ctx->q_data[V4L2_M2M_SRC].info = info;
 	else if (ctx->is_stateless)
 		ctx->q_data[V4L2_M2M_SRC].info = &pixfmt_stateless_fwht;
 	else
@@ -1823,22 +1825,22 @@ static int vicodec_open(struct file *file)
 	ctx->q_data[V4L2_M2M_SRC].coded_height = 720;
 	ctx->q_data[V4L2_M2M_SRC].visible_width = 1280;
 	ctx->q_data[V4L2_M2M_SRC].visible_height = 720;
-	size = 1280 * 720 * ctx->q_data[V4L2_M2M_SRC].info->sizeimage_mult /
-		ctx->q_data[V4L2_M2M_SRC].info->sizeimage_div;
+	raw_size = 1280 * 720 * info->sizeimage_mult / info->sizeimage_div;
+	comp_size = 1280 * 720 * pixfmt_fwht.sizeimage_mult /
+				 pixfmt_fwht.sizeimage_div;
 	if (ctx->is_enc || ctx->is_stateless)
-		ctx->q_data[V4L2_M2M_SRC].sizeimage = size;
+		ctx->q_data[V4L2_M2M_SRC].sizeimage = raw_size;
 	else
 		ctx->q_data[V4L2_M2M_SRC].sizeimage =
-			size + sizeof(struct fwht_cframe_hdr);
+			comp_size + sizeof(struct fwht_cframe_hdr);
+	ctx->q_data[V4L2_M2M_DST] = ctx->q_data[V4L2_M2M_SRC];
 	if (ctx->is_enc) {
-		ctx->q_data[V4L2_M2M_DST] = ctx->q_data[V4L2_M2M_SRC];
 		ctx->q_data[V4L2_M2M_DST].info = &pixfmt_fwht;
-		ctx->q_data[V4L2_M2M_DST].sizeimage = 1280 * 720 *
-			ctx->q_data[V4L2_M2M_DST].info->sizeimage_mult /
-			ctx->q_data[V4L2_M2M_DST].info->sizeimage_div +
-			sizeof(struct fwht_cframe_hdr);
+		ctx->q_data[V4L2_M2M_DST].sizeimage =
+			comp_size + sizeof(struct fwht_cframe_hdr);
 	} else {
-		ctx->q_data[V4L2_M2M_DST].info = NULL;
+		ctx->q_data[V4L2_M2M_DST].info = info;
+		ctx->q_data[V4L2_M2M_DST].sizeimage = raw_size;
 	}
 
 	ctx->state.colorspace = V4L2_COLORSPACE_REC709;
-- 
2.17.1

