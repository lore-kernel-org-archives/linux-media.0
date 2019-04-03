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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643D6C10F06
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295D820882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aztEk3Zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDCWST (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40822 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDCWSS (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so878781wre.7
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RWUptrEyuF9yugjjCgeYTKgevmbCFUs8gDEKccF/CRM=;
        b=aztEk3ZzKpttVqwJFVLQ+GNzENVTwbgk1gYdFlocZ7xe1hP+PUx7DJP2/sGFmA3DHU
         CG/Ui/2aH9+K/hTAtVIMC+0cINlfrKxSHmV/ySa5zW4QLExC+NFQW1kBGcG0ce9hte3/
         HlB/LozPY1pzFZz7ex3quCIyajTfwwacHUEXBPxp1a2W4FJFTH6UR1Jostj4/abq6W0Q
         OjbNytoukgRVz1ejC0R+WS0+xzSrD/qCFVqk+/FkePcHlYF0SGmpGMCYT9QiXkGu2DPU
         8jshl1bpoa/22KUg+rJTele1nIblvpRXIyQJQi/tmyuA0NRQndSTTCVhjovi+0GdyP43
         Uetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RWUptrEyuF9yugjjCgeYTKgevmbCFUs8gDEKccF/CRM=;
        b=Miu8qxIzV45gZ3+1DhTaWjuHbASgmRFlHu5lsgENg9HXEU9vZyOwZY8MxsmmuoRVGL
         madf0HfTrqrGuCF7eEsCHV6LqYLebzlCgHTWiSf/30zUDe5mrYLW+7zkq8LchtnIkFdp
         F5biTojzmiAuuGW1H8UpLBRJYMvIyvMAfA90LgZuTYNvSz5NWYIpEi4cR4N/qu7CC2+i
         ILpsNhUt2W+x84m2xDax5SYIUHl7G4LryNZXHe26L+o9eXUasVb30jTQV8bI9a5rUnRx
         sqh/oR0VJGNjWDwkY/26q59Ms4/nJi3Hl1DBmphZwkWFXVJh0ReptQ6jdujJyoXqZFjQ
         PBBg==
X-Gm-Message-State: APjAAAU6PAXYHIoBTr+TixRqadq3Fx8f+/JjJ2FgVK8ROhu3NgrcnoaX
        v/zz5DYRnl/DTAHNY+3RAci3SICEF5o=
X-Google-Smtp-Source: APXvYqz6GrAYCSEPOMWEgWQBaYQRWmUKgYo1Oeu74OIu3YoGgrQp3BqsMuoA+S7AbenqMd8j4n+sqA==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr1328366wrw.22.1554329895551;
        Wed, 03 Apr 2019 15:18:15 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:14 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 06/16] vicodec: improve handling of ENC_CMD_STOP/START
Date:   Wed,  3 Apr 2019 15:14:51 -0700
Message-Id: <20190403221501.32814-7-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Correctly handle stopping and restarting the encoder, keeping
track of the stop and drain states.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 121 +++++++++++++++---
 1 file changed, 100 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index b3bf5c4d73cd..a9a0f6a1b69e 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -116,12 +116,14 @@ struct vicodec_ctx {
 	struct vicodec_dev	*dev;
 	bool			is_enc;
 	bool			is_stateless;
+	bool			is_draining;
+	bool			next_is_last;
+	bool			has_stopped;
 	spinlock_t		*lock;
 
 	struct v4l2_ctrl_handler hdl;
 
 	struct vb2_v4l2_buffer *last_src_buf;
-	struct vb2_v4l2_buffer *last_dst_buf;
 
 	/* Source and destination queue data */
 	struct vicodec_q_data   q_data[2];
@@ -138,6 +140,10 @@ struct vicodec_ctx {
 	bool			source_changed;
 };
 
+static const struct v4l2_event vicodec_eos_event = {
+	.type = V4L2_EVENT_EOS
+};
+
 static inline struct vicodec_ctx *file2ctx(struct file *file)
 {
 	return container_of(file->private_data, struct vicodec_ctx, fh);
@@ -397,9 +403,6 @@ static enum vb2_buffer_state get_next_header(struct vicodec_ctx *ctx,
 /* device_run() - prepares and starts the device */
 static void device_run(void *priv)
 {
-	static const struct v4l2_event eos_event = {
-		.type = V4L2_EVENT_EOS
-	};
 	struct vicodec_ctx *ctx = priv;
 	struct vicodec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
@@ -423,12 +426,12 @@ static void device_run(void *priv)
 	dst_buf->flags &= ~V4L2_BUF_FLAG_LAST;
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, !ctx->is_enc);
 
-	ctx->last_dst_buf = dst_buf;
-
 	spin_lock(ctx->lock);
 	if (!ctx->comp_has_next_frame && src_buf == ctx->last_src_buf) {
 		dst_buf->flags |= V4L2_BUF_FLAG_LAST;
-		v4l2_event_queue_fh(&ctx->fh, &eos_event);
+		v4l2_event_queue_fh(&ctx->fh, &vicodec_eos_event);
+		ctx->is_draining = false;
+		ctx->has_stopped = true;
 	}
 	if (ctx->is_enc || ctx->is_stateless) {
 		src_buf->sequence = q_src->sequence++;
@@ -579,6 +582,8 @@ static int job_ready(void *priv)
 	unsigned int max_to_copy;
 	unsigned int comp_frame_size;
 
+	if (ctx->has_stopped)
+		return 0;
 	if (ctx->source_changed)
 		return 0;
 	if (ctx->is_stateless || ctx->is_enc || ctx->comp_has_frame)
@@ -1217,25 +1222,45 @@ static int vidioc_s_selection(struct file *file, void *priv,
 	return 0;
 }
 
-static void vicodec_mark_last_buf(struct vicodec_ctx *ctx)
+static int vicodec_mark_last_buf(struct vicodec_ctx *ctx)
 {
-	static const struct v4l2_event eos_event = {
-		.type = V4L2_EVENT_EOS
-	};
+	struct vb2_v4l2_buffer *next_dst_buf;
+	int ret = 0;
 
 	spin_lock(ctx->lock);
+	if (ctx->is_draining) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+	if (ctx->has_stopped)
+		goto unlock;
+
 	ctx->last_src_buf = v4l2_m2m_last_src_buf(ctx->fh.m2m_ctx);
-	if (!ctx->last_src_buf && ctx->last_dst_buf) {
-		ctx->last_dst_buf->flags |= V4L2_BUF_FLAG_LAST;
-		v4l2_event_queue_fh(&ctx->fh, &eos_event);
+	ctx->is_draining = true;
+	if (ctx->last_src_buf)
+		goto unlock;
+
+	next_dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	if (!next_dst_buf) {
+		ctx->next_is_last = true;
+		goto unlock;
 	}
+
+	next_dst_buf->flags |= V4L2_BUF_FLAG_LAST;
+	vb2_buffer_done(&next_dst_buf->vb2_buf, VB2_BUF_STATE_DONE);
+	ctx->is_draining = false;
+	ctx->has_stopped = true;
+	v4l2_event_queue_fh(&ctx->fh, &vicodec_eos_event);
+
+unlock:
 	spin_unlock(ctx->lock);
+	return ret;
 }
 
 static int vicodec_try_encoder_cmd(struct file *file, void *fh,
 				struct v4l2_encoder_cmd *ec)
 {
-	if (ec->cmd != V4L2_ENC_CMD_STOP)
+	if (ec->cmd != V4L2_ENC_CMD_STOP && ec->cmd != V4L2_ENC_CMD_START)
 		return -EINVAL;
 
 	if (ec->flags & V4L2_ENC_CMD_STOP_AT_GOP_END)
@@ -1254,8 +1279,22 @@ static int vicodec_encoder_cmd(struct file *file, void *fh,
 	if (ret < 0)
 		return ret;
 
-	vicodec_mark_last_buf(ctx);
-	return 0;
+	if (!vb2_is_streaming(&ctx->fh.m2m_ctx->cap_q_ctx.q) ||
+	    !vb2_is_streaming(&ctx->fh.m2m_ctx->out_q_ctx.q))
+		return 0;
+
+	if (ec->cmd == V4L2_ENC_CMD_STOP)
+		return vicodec_mark_last_buf(ctx);
+	ret = 0;
+	spin_lock(ctx->lock);
+	if (ctx->is_draining) {
+		ret = -EBUSY;
+	} else if (ctx->has_stopped) {
+		ctx->has_stopped = false;
+		vb2_clear_last_buffer_dequeued(&ctx->fh.m2m_ctx->cap_q_ctx.q);
+	}
+	spin_unlock(ctx->lock);
+	return ret;
 }
 
 static int vicodec_try_decoder_cmd(struct file *file, void *fh,
@@ -1283,8 +1322,7 @@ static int vicodec_decoder_cmd(struct file *file, void *fh,
 	if (ret < 0)
 		return ret;
 
-	vicodec_mark_last_buf(ctx);
-	return 0;
+	return vicodec_mark_last_buf(ctx);
 }
 
 static int vicodec_enum_framesizes(struct file *file, void *fh,
@@ -1462,6 +1500,23 @@ static void vicodec_buf_queue(struct vb2_buffer *vb)
 		return;
 	}
 
+	if (vb2_is_streaming(vq_cap)) {
+		if (!V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type) &&
+		    ctx->next_is_last) {
+			unsigned int i;
+
+			for (i = 0; i < vb->num_planes; i++)
+				vb->planes[i].bytesused = 0;
+			vbuf->flags |= V4L2_BUF_FLAG_LAST;
+			vb2_buffer_done(vb, VB2_BUF_STATE_DONE);
+			ctx->is_draining = false;
+			ctx->has_stopped = true;
+			ctx->next_is_last = false;
+			v4l2_event_queue_fh(&ctx->fh, &vicodec_eos_event);
+			return;
+		}
+	}
+
 	/*
 	 * if both queues are streaming, the source change event is
 	 * handled in job_ready
@@ -1571,8 +1626,6 @@ static int vicodec_start_streaming(struct vb2_queue *q,
 
 	if (V4L2_TYPE_IS_OUTPUT(q->type))
 		ctx->last_src_buf = NULL;
-	else
-		ctx->last_dst_buf = NULL;
 
 	state->gop_cnt = 0;
 
@@ -1648,6 +1701,32 @@ static void vicodec_stop_streaming(struct vb2_queue *q)
 
 	vicodec_return_bufs(q, VB2_BUF_STATE_ERROR);
 
+	if (ctx->is_enc) {
+		if (V4L2_TYPE_IS_OUTPUT(q->type)) {
+			if (ctx->is_draining) {
+				struct vb2_v4l2_buffer *next_dst_buf;
+
+				spin_lock(ctx->lock);
+				ctx->last_src_buf = NULL;
+				next_dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+				if (!next_dst_buf) {
+					ctx->next_is_last = true;
+				} else {
+					next_dst_buf->flags |= V4L2_BUF_FLAG_LAST;
+					vb2_buffer_done(&next_dst_buf->vb2_buf, VB2_BUF_STATE_DONE);
+					ctx->is_draining = false;
+					ctx->has_stopped = true;
+					v4l2_event_queue_fh(&ctx->fh, &vicodec_eos_event);
+				}
+				spin_unlock(ctx->lock);
+			}
+		} else {
+			ctx->is_draining = false;
+			ctx->has_stopped = false;
+			ctx->next_is_last = false;
+		}
+	}
+
 	if ((!V4L2_TYPE_IS_OUTPUT(q->type) && !ctx->is_enc) ||
 	    (V4L2_TYPE_IS_OUTPUT(q->type) && ctx->is_enc)) {
 		if (!ctx->is_stateless)
-- 
2.17.1

