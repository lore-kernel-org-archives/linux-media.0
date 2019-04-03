Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B97C10F06
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D867820882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umlnx+h6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDCWS3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34487 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDCWS2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so924341wrq.1
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ispdb462hbKT51g52eJZ6tHm3l/BTCofEhGezrMbwmk=;
        b=Umlnx+h6J6TUNtXVYWVJrDgzNt4y3QsnKDlkI9ImUpE1OMghyI+bJ+zQKCkJentg1G
         50AK42BjoqwlHHkT3V7ioMpmZ4+CqqCt89OC1rJgg+cKubyXeytxZT82gLQ3s5WY6pGA
         /JnGDT/9pxevFWSMA2xnbYHE4UOJLNof0IkHdtPCClxDw5U/SM7Nmgn1HK3UlrImy/5I
         nvPRQI2WPdieIQNAkzSpR9yAlIMlkCo/qJO5z8T6ii0g8Eyc3YcmhGrCsMTWQ/oaSGcc
         X24bk39EvRuXEinzUh6ZOKiJVUAIb3F14LrjGE/I7WIo/P+470uBTKFUYz5NnXRDN6mn
         2dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ispdb462hbKT51g52eJZ6tHm3l/BTCofEhGezrMbwmk=;
        b=JHFzB6rOkJeo8NeuT6CPoEMngFRWthHfc5JVgeGqxhas4UBukcKCbaBgpJYztEEsxj
         W995uSlAAZvA9xKvF94lK4oVVlsMwLU4yE12bckRPmhMOHwFTS0trZOEKYmUzPDIK0q2
         WbeOYUMhXaIu0UnsQeuiY/3mSc5cstzUkZb9AiHZEfIfKa2n/B/cmazPlkerKfS4JAoT
         hNw7Mhcd8R0HJTN7oL5U/DV674Zp84b4G0D08mD7hSbeHY9WxVxnOFXFvXdoFGCZvRo8
         X5hjBc/En9UG3ewc5qGb5EnvAtSguLBR19ZQe3U2nrSU9ydA9ExRp2NYobdX+PBmPBbz
         JgaQ==
X-Gm-Message-State: APjAAAXfA4yapsg+dOp4WS0N/oeflta0/C5qOHEbh8MGB4tb55cBJvbm
        MM8I34rFdYi8NU0IgaX/NF8=
X-Google-Smtp-Source: APXvYqwJv7jgRzoMTTtblNHooVlraet3AP0HGrLJ50a1mcL72Q8eemyiA3YB6XO4cEipu6vsDStf8A==
X-Received: by 2002:adf:f110:: with SMTP id r16mr1259832wro.153.1554329906232;
        Wed, 03 Apr 2019 15:18:26 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:25 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com
Subject: [PATCH v2 15/16] media: vicodec: set pixelformat V4L2_PIX_FMT_FWHT_STATELESS for stateless encoder
Date:   Wed,  3 Apr 2019 15:15:00 -0700
Message-Id: <20190403221501.32814-16-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

for stateless encoder, set the capture pixelformat
to V4L2_PIX_FMT_FWHT_STATELESS and the pix info to
pixfmt_stateless_fwht

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 8780df73a41f..c972c175707c 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -903,8 +903,12 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
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
@@ -914,8 +918,13 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 		if (!multiplanar)
 			return -EINVAL;
 		pix_mp = &f->fmt.pix_mp;
-		pix_mp->pixelformat = ctx->is_enc ? V4L2_PIX_FMT_FWHT :
-				      find_fmt(pix_mp->pixelformat)->id;
+		if (!ctx->is_enc)
+			pix_mp->pixelformat =
+				find_fmt(f->fmt.pix_mp.pixelformat)->id;
+		else if (ctx->is_stateless)
+			pix_mp->pixelformat = V4L2_PIX_FMT_FWHT_STATELESS;
+		else
+			pix_mp->pixelformat = V4L2_PIX_FMT_FWHT;
 		pix_mp->colorspace = ctx->state.colorspace;
 		pix_mp->xfer_func = ctx->state.xfer_func;
 		pix_mp->ycbcr_enc = ctx->state.ycbcr_enc;
@@ -1647,22 +1656,22 @@ static int vicodec_start_streaming(struct vb2_queue *q,
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
@@ -1964,9 +1973,10 @@ static int vicodec_open(struct file *file)
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

