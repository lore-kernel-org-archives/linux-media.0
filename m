Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4FFC10F05
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29564206DD
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfC2P33 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:29:29 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:46526 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728720AbfC2P31 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 11:29:27 -0400
Received: from test-no.fritz.box ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9tRYhPNkWUjKf9tRdhwWr3; Fri, 29 Mar 2019 16:29:25 +0100
From:   hverkuil-cisco@xs4all.nl
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna3@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [RFC PATCH 5/5] vicodec: improve handling of ENC_CMD_STOP/START
Date:   Fri, 29 Mar 2019 16:29:20 +0100
Message-Id: <20190329152920.30179-6-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
References: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLXKiIlvnN3diLgi5pvnP5v52/OlZhwwUac3zIRWJbdV3IOGRjkhLXxwp0SZyO6EvxIxwd0MZrgt5U6PVz79wPm+/XMwERjFfEd8CW1zUECCzei5/qpU
 itcDxQrK/hWX3OtNSeWRO7Tu/52/h6OMkGwOvXo/GR0gZjIwxOHTl2d8lxBTXlMbTvSt3YPJynWbNcEg+2mAKV+9STulibi3zy6apbbo/8a7o1A4qHAUPjU0
 ueGhgwtVpFJg/bg6/qhMVn6zqdCz6ZetFqpEK0zCNfqeCxvxHLY8v1MBsPaeqTTg
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
index b0c1d7cd1db6..980c30cc9d48 100644
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
2.20.1

