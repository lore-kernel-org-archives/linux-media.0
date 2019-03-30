Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9E4C10F00
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA0B2146F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4HCy85D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfC3Up7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42881 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbfC3Up6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so6823636wrx.9
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IcGGoCBGp8cgu8kIadgArHwCTJTAxAhiQo+nKORdetY=;
        b=d4HCy85DyHdh+YRJgj5xo22AwkaBEpfqkWaDKymm2pNi1ozhBfbNnkmrBpQSvVFy0H
         +sWXATx3Hsn/r1qRpLxoVoCbhMrUCKkurskLwLSbKK0t0HEl8nj2NUNUSiEJIybEg2y3
         MlG7GLu7KVCqknrqvV5NrUWJqsrylXeIFqB+X2Linz0wjjMhbbhfRLkq9lTmnGrtXMAu
         5jI0kKbboNF+CTYFfqmD3Tau/HGNTzjPTZajdeEfws9SXlrhBcQWh4MvO/yl/iTzQkd8
         ocYa5Ali73hJwlK7P+chebgbJZAb+VLOS2PDlYNUi6SiNwuAAThEhhOkQk09LS+/4YKx
         xl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IcGGoCBGp8cgu8kIadgArHwCTJTAxAhiQo+nKORdetY=;
        b=Ua42KeZMzooUNxr1lFzsKUO5nsXWr1/+FWQvnYfN2G/bngEz7iA0VKv6+gAUweVLT3
         P9POp8d3oROSUjDUJEZiAuSVzd+Kj+dx5DCAO3hcKcovbJiDAlaz7rPewFB/CzHB6N4U
         yLvbsRDD9r99qQQKgeFeftmitOWSvxd3tS250iVrWfjsbKW+StIDHJpPj36CQFsK4cyM
         S5J8a9UcGuC7AFaVdW4+Wk8dwFD+rhoMcZM0PCFp1mOjTBHr40r1dYNWzEZzkd00GieV
         G/varvEPEvDaAd86/4od/TNR7oNX6hMlgy0iCll7pxzaQl195dTAAuxGrl+R6pYhXfpD
         arog==
X-Gm-Message-State: APjAAAXHdHEjOBaoVJ+Dz394h+dx5jaPHEVYB4SJzVCpOw1K97r0ViDd
        4Vj/WSh4ply8iYxzkd7JqvKWN2jfYgc=
X-Google-Smtp-Source: APXvYqwn9AdO3crYERD3abWL2ZbnrscXjGtKAJ5cGCGoR9yWi4DBbSvV/vPbOzW59iwxWpZdWTztrw==
X-Received: by 2002:adf:dcce:: with SMTP id x14mr24963489wrm.315.1553978755999;
        Sat, 30 Mar 2019 13:45:55 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:55 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH 12/14] media: vicodec: set pixelformat V4L2_PIX_FMT_FWHT_STATELESS for stateless encoder
Date:   Sat, 30 Mar 2019 13:43:10 -0700
Message-Id: <20190330204311.107417-13-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

for stateless encoder, set the capture pixelformat
to V4L2_PIX_FMT_FWHT_STATELESS and the pix info to
pixfmt_stateless_fwht

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 6bfcd266ffc4..f042c4b618ba 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -895,8 +895,12 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 		if (multiplanar)
 			return -EINVAL;
 		pix = &f->fmt.pix;
-		pix->pixelformat = ctx->is_enc ? V4L2_PIX_FMT_FWHT :
-				   find_fmt(f->fmt.pix.pixelformat)->id;
+		if (!ctx->is_enc)
+			pix->pixelformat = find_fmt(f->fmt.pix.pixelformat)->id;
+		else if (ctx->is_stateless)
+			pix->pixelformat = V4L2_PIX_FMT_FWHT_STATELESS;
+		else
+			pix->pixelformat = V4L2_PIX_FMT_FWHT;
 		pix->colorspace = ctx->state.colorspace;
 		pix->xfer_func = ctx->state.xfer_func;
 		pix->ycbcr_enc = ctx->state.ycbcr_enc;
@@ -906,8 +910,12 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 		if (!multiplanar)
 			return -EINVAL;
 		pix_mp = &f->fmt.pix_mp;
-		pix_mp->pixelformat = ctx->is_enc ? V4L2_PIX_FMT_FWHT :
-				      find_fmt(pix_mp->pixelformat)->id;
+		if (!ctx->is_enc)
+			pix_mp->pixelformat = find_fmt(f->fmt.pix_mp.pixelformat)->id;
+		else if (ctx->is_stateless)
+			pix_mp->pixelformat = V4L2_PIX_FMT_FWHT_STATELESS;
+		else
+			pix_mp->pixelformat = V4L2_PIX_FMT_FWHT;
 		pix_mp->colorspace = ctx->state.colorspace;
 		pix_mp->xfer_func = ctx->state.xfer_func;
 		pix_mp->ycbcr_enc = ctx->state.ycbcr_enc;
@@ -1631,22 +1639,22 @@ static int vicodec_start_streaming(struct vb2_queue *q,
 	state->stride = q_data->coded_width *
 				info->bytesperline_mult;
 
-	if (ctx->is_stateless) {
+	if (!ctx->is_enc && ctx->is_stateless) {
 		state->ref_stride = state->stride;
 		return 0;
 	}
 	state->ref_stride = q_data->coded_width * info->luma_alpha_step;
 
 	state->ref_frame.buf = kvmalloc(total_planes_size, GFP_KERNEL);
-	state->ref_frame.luma = state->ref_frame.buf;
 	new_comp_frame = kvmalloc(ctx->comp_max_size, GFP_KERNEL);
 
-	if (!state->ref_frame.luma || !new_comp_frame) {
-		kvfree(state->ref_frame.luma);
+	if (!state->ref_frame.buf || !new_comp_frame) {
+		kvfree(state->ref_frame.buf);
 		kvfree(new_comp_frame);
 		vicodec_return_bufs(q, VB2_BUF_STATE_QUEUED);
 		return -ENOMEM;
 	}
+	state->ref_frame.luma = state->ref_frame.buf;
 	/*
 	 * if state->compressed_frame was already allocated then
 	 * it contain data of the first frame of the new resolution
@@ -1948,9 +1956,10 @@ static int vicodec_open(struct file *file)
 			comp_size + sizeof(struct fwht_cframe_hdr);
 	ctx->q_data[V4L2_M2M_DST] = ctx->q_data[V4L2_M2M_SRC];
 	if (ctx->is_enc) {
-		ctx->q_data[V4L2_M2M_DST].info = &pixfmt_fwht;
-		ctx->q_data[V4L2_M2M_DST].sizeimage =
-			comp_size + sizeof(struct fwht_cframe_hdr);
+		ctx->q_data[V4L2_M2M_DST].info = ctx->is_stateless ?
+			&pixfmt_stateless_fwht : &pixfmt_fwht;
+		ctx->q_data[V4L2_M2M_DST].sizeimage = comp_size +
+			sizeof(struct fwht_cframe_hdr);
 	} else {
 		ctx->q_data[V4L2_M2M_DST].info = info;
 		ctx->q_data[V4L2_M2M_DST].sizeimage = raw_size;
-- 
2.17.1

