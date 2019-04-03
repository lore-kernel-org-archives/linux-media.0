Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE88C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3907B20882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f29wQzOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDCWSS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43163 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDCWSS (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so849983wrx.10
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bfIlPIdrRzyCk4DM79SzuuR3xqBJzBd5V/CyZ7ITpBU=;
        b=f29wQzObsamMAGcz0wszlVPKUPA2KEKX3MaEvSHdZKuv+njCZHoYeoEonAq06SXFL9
         VSrR3N6YVftKyyEm8yVnXzM0DM55RMAJVzwlc3FlYKJ87OtG/5xpUUqdwWgZcVp7ijYu
         2nE3G/nMH7+D1keWyTYkWgNZfSfNc2w5UdrE8eeZvTfDuzTvX6I2IY7e949hIEqwkFZv
         21wT0vICYzdCZw8a8L0RCdJdWobwNdZiyoZgxnYR11jG89HVfQh3oBjpRYbZMF85PWPY
         djzKfiZ+dvwUQsjcoOYsdMPw9fuTLo1dszz6ndb9yPWlObhcproliBrRr1W5CBymuWNp
         CPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfIlPIdrRzyCk4DM79SzuuR3xqBJzBd5V/CyZ7ITpBU=;
        b=Smyhsm+UeSS9/IpvnDw6/uczvVotm5/KAbIA6tawWMwAb+XzHJseqKsepdB65ulX2d
         yeiGmSjn87HmBRq0dzYVAVN0cMIwBN0YAZ7N0cCRvztotexLUVtCYVIb303Slo1rS3DT
         S4Rhd4Ig1mZJ6Khz+eMlKjoYS2qBHk7/68qRzytmMe+vGGudG5Ry8wOT6sHtFmPGdR7W
         hORvkzN78ylsuz5LXVeG0j+dzNoXaYB+8c3zac91pRJX6xEMVGrWzRgY+vjzGjI5XxVP
         rODKYCqhFGsWxKzE3QLhooCNv3ZDExb0NBr9mxaYahYdTFa8xvW6LDvjR6LXNLjrm5AJ
         3qfg==
X-Gm-Message-State: APjAAAXxFA2tQwybVGzt/cE5eHBR0JtIYcXFc4BPlqa/ZbcOCq4BB6OI
        OytgYlaPfJQ95vPffKD5W20=
X-Google-Smtp-Source: APXvYqzc+Fb2gylWoHr9KLBm2b+0MUd38mSOIG26VxVXTEJE5jGFzZrH8IaI+53zaa3HC6o+blLZwA==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr1334808wru.117.1554329896754;
        Wed, 03 Apr 2019 15:18:16 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:16 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 07/16] vicodec: restrict decoder format list when src fmt is known
Date:   Wed,  3 Apr 2019 15:14:52 -0700
Message-Id: <20190403221501.32814-8-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Report the full list of supported decoder formats until the
format encoded in the bitstream is known. After that only
report the formats compatible with that initial format.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index a9a0f6a1b69e..21000cc2f395 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -671,7 +671,6 @@ static int job_ready(void *priv)
 			v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 
 		update_capture_data_from_header(ctx);
-		ctx->first_source_change_sent = true;
 		v4l2_event_queue_fh(&ctx->fh, &rs_event);
 		set_last_buffer(dst_buf, src_buf, ctx);
 		ctx->source_changed = true;
@@ -718,7 +717,7 @@ static int enum_fmt(struct v4l2_fmtdesc *f, struct vicodec_ctx *ctx,
 		const struct v4l2_fwht_pixfmt_info *info =
 					get_q_data(ctx, f->type)->info;
 
-		if (!info || ctx->is_enc)
+		if (!ctx->first_source_change_sent || ctx->is_enc)
 			info = v4l2_fwht_get_pixfmt(f->index);
 		else
 			info = v4l2_fwht_find_nth_fmt(info->width_div,
@@ -769,9 +768,6 @@ static int vidioc_g_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 	q_data = get_q_data(ctx, f->type);
 	info = q_data->info;
 
-	if (!info)
-		info = v4l2_fwht_get_pixfmt(0);
-
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
@@ -1371,6 +1367,16 @@ static int vicodec_subscribe_event(struct v4l2_fh *fh,
 	}
 }
 
+static int vicodec_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
+{
+	struct vicodec_ctx *ctx = container_of(fh, struct vicodec_ctx, fh);
+	int ret = v4l2_m2m_ioctl_streamon(file, fh, i);
+
+	if (!ret && !ctx->is_enc && V4L2_TYPE_IS_OUTPUT(i))
+		ctx->first_source_change_sent = true;
+	return ret;
+}
+
 static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
 	.vidioc_querycap	= vidioc_querycap,
 
@@ -1402,7 +1408,7 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
 
-	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
+	.vidioc_streamon	= vicodec_streamon,
 	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
 
 	.vidioc_g_selection	= vidioc_g_selection,
@@ -1618,9 +1624,6 @@ static int vicodec_start_streaming(struct vb2_queue *q,
 	unsigned int total_planes_size;
 	u8 *new_comp_frame = NULL;
 
-	if (!info)
-		return -EINVAL;
-
 	chroma_div = info->width_div * info->height_div;
 	q_data->sequence = 0;
 
@@ -1726,6 +1729,8 @@ static void vicodec_stop_streaming(struct vb2_queue *q)
 			ctx->next_is_last = false;
 		}
 	}
+	if (!ctx->is_enc && V4L2_TYPE_IS_OUTPUT(q->type))
+		ctx->first_source_change_sent = false;
 
 	if ((!V4L2_TYPE_IS_OUTPUT(q->type) && !ctx->is_enc) ||
 	    (V4L2_TYPE_IS_OUTPUT(q->type) && ctx->is_enc)) {
-- 
2.17.1

