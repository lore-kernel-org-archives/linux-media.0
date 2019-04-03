Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED32C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CF220882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWzlWgxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDCWSa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34985 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDCWS3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so695998wmd.0
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=53+zCVrSNNXnGB2H2mZfd8ai2PG61TezGRoLM40CipI=;
        b=OWzlWgxRkieR08VvIf4/FUhhiy2EsYyTM3kZdpb/h+eCdI36DFyufUOpS33mKStYv0
         wm32iETOTK2Jkip6NNOwfAJ1Vbtf7IYNFQJPUGMEToxkR1A1r4RczpNyM4Eg1BoIIzRH
         Gtq2ql+J8YDWR12KO7SuRuxFHKf8t49k3Pjoa0oDutVjJPzy/gpvwqNz/i04MdU/r/N1
         XgG0wRrK7kjdSkZh6n8OYc81jarS4CA929WQ7gCHFf23rMi3HZj+p0h4WxQ+dU+0fdYu
         nGK9t9plN/pI2oUtCQw72BUVMtz911hraJAvZ1Wc9c95y08duPGnzTCPQWYob5pYDiSt
         u8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=53+zCVrSNNXnGB2H2mZfd8ai2PG61TezGRoLM40CipI=;
        b=IQ7V5iddRKxy20Fu/kkJFPk52ZO1cuI1gXDgymHxJCAEEqCgdhfwlA9m+Sdu3FG9Iz
         WbYPV3c6/lLoIzKPRXhBs7HTa69hDmuI88/f6x3MBzQq5tn7zbRKcD6Gdf/hWjZ0UGbz
         5W9iNhitDp5uZoYcO/mIbgaEgO1U9uOGrmq9MohjPY46MY3/0d8ltY+uLIq/4h9962fr
         SD0LpmY5qL6c+6q9/v0bHJFCCg5rk89F12O59QE9Aue56AvYOWaKlVnMOAROG0mApBfU
         ds5jiZOWAxntCazG0hHjHuih8vEDccdXzSiGK3c2sa1CprInpJgEiKRueiBiQsmN1Cyk
         Xx4g==
X-Gm-Message-State: APjAAAXghhYS0s6ln/hdp/G1E1APA3K79XC5F7kI8kEgi7SlQQY8U4a4
        GhVYzhY7Pkhjgi9AW7ll4KI=
X-Google-Smtp-Source: APXvYqyOlyjObL0b5epquJIwL+Gn8rkSfzlFamTnYX4LFaKuMIbGSPfw0bjrnuP5V4HI1RLutHx6yg==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr1633803wmb.7.1554329907441;
        Wed, 03 Apr 2019 15:18:27 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:26 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com
Subject: [PATCH v2 16/16] media: vicodec: Add support for stateless encoder
Date:   Wed,  3 Apr 2019 15:15:01 -0700
Message-Id: <20190403221501.32814-17-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Adjust the stateless API code to support
both encoder and decoder.

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 106 ++++++++++++------
 1 file changed, 73 insertions(+), 33 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index c972c175707c..e1bfcc480716 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -140,6 +140,7 @@ struct vicodec_ctx {
 	bool			comp_has_next_frame;
 	bool			first_source_change_sent;
 	bool			source_changed;
+	struct v4l2_ctrl	*ctrl_fwht_params;
 };
 
 static const struct v4l2_event vicodec_eos_event = {
@@ -256,6 +257,21 @@ static void update_state_from_header(struct vicodec_ctx *ctx)
 	ctx->state.quantization = ntohl(p_hdr->quantization);
 }
 
+static void update_stateless_params_from_header(const struct vicodec_ctx *ctx,
+						struct v4l2_ctrl_fwht_params *params)
+{
+	const struct fwht_cframe_hdr *p_hdr = &ctx->state.header;
+
+	params->version = ntohl(p_hdr->version);
+	params->width = ntohl(p_hdr->width);
+	params->height = ntohl(p_hdr->height);
+	params->flags =	ntohl(p_hdr->flags);
+	params->colorspace = ntohl(p_hdr->colorspace);
+	params->xfer_func = ntohl(p_hdr->xfer_func);
+	params->ycbcr_enc = ntohl(p_hdr->ycbcr_enc);
+	params->quantization = ntohl(p_hdr->quantization);
+}
+
 static int device_process(struct vicodec_ctx *ctx,
 			  struct vb2_v4l2_buffer *src_vb,
 			  struct vb2_v4l2_buffer *dst_vb)
@@ -276,33 +292,35 @@ static int device_process(struct vicodec_ctx *ctx,
 		ret = v4l2_ctrl_request_setup(src_req, &ctx->hdl);
 		if (ret)
 			return ret;
-		update_state_from_header(ctx);
-
-		ctx->state.header.size =
-			htonl(vb2_get_plane_payload(&src_vb->vb2_buf, 0));
-		/*
-		 * set the reference buffer from the reference timestamp
-		 * only if this is a P-frame
-		 */
-		if (!(ntohl(ctx->state.header.flags) & FWHT_FL_I_FRAME)) {
-			struct vb2_buffer *ref_vb2_buf;
-			int ref_buf_idx;
-			struct vb2_queue *vq_cap =
+		if (!ctx->is_enc) {
+			update_state_from_header(ctx);
+
+			ctx->state.header.size =
+				htonl(vb2_get_plane_payload(&src_vb->vb2_buf, 0));
+			/*
+			 * set the reference buffer from the reference timestamp
+			 * only if this is a P-frame
+			 */
+			if (!(ntohl(ctx->state.header.flags) & FWHT_FL_I_FRAME)) {
+				struct vb2_buffer *ref_vb2_buf;
+				int ref_buf_idx;
+				struct vb2_queue *vq_cap =
 				v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-						V4L2_BUF_TYPE_VIDEO_CAPTURE);
-
-			ref_buf_idx = vb2_find_timestamp(vq_cap,
-							 ctx->state.ref_frame_ts, 0);
-			if (ref_buf_idx < 0)
-				return -EINVAL;
-
-			ref_vb2_buf = vq_cap->bufs[ref_buf_idx];
-			if (ref_vb2_buf->state == VB2_BUF_STATE_ERROR)
-				ret = -EINVAL;
-			ctx->state.ref_frame.buf =
-				vb2_plane_vaddr(ref_vb2_buf, 0);
-		} else {
-			ctx->state.ref_frame.buf = NULL;
+					V4L2_BUF_TYPE_VIDEO_CAPTURE);
+
+				ref_buf_idx = vb2_find_timestamp(vq_cap,
+					ctx->state.ref_frame_ts, 0);
+				if (ref_buf_idx < 0)
+					return -EINVAL;
+
+				ref_vb2_buf = vq_cap->bufs[ref_buf_idx];
+				if (ref_vb2_buf->state == VB2_BUF_STATE_ERROR)
+					ret = -EINVAL;
+				ctx->state.ref_frame.buf =
+					vb2_plane_vaddr(ref_vb2_buf, 0);
+			} else {
+				ctx->state.ref_frame.buf = NULL;
+			}
 		}
 	}
 	p_dst = vb2_plane_vaddr(&dst_vb->vb2_buf, 0);
@@ -315,18 +333,36 @@ static int device_process(struct vicodec_ctx *ctx,
 	if (ctx->is_enc) {
 		struct vicodec_q_data *q_src;
 		int comp_sz_or_errcode;
-		struct fwht_cframe_hdr *p_hdr = (struct fwht_cframe_hdr *) p_dst;
-		u8 *comp_buf = p_dst + sizeof(struct fwht_cframe_hdr);
-
+		struct fwht_cframe_hdr *p_hdr;
+		u8 *comp_buf;
 
+		if (ctx->is_stateless) {
+			p_hdr = &ctx->state.header;
+			comp_buf = p_dst;
+		} else {
+			p_hdr = (struct fwht_cframe_hdr *) p_dst;
+			comp_buf = p_dst + sizeof(struct fwht_cframe_hdr);
+		}
 		q_src = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
 		state->info = q_src->info;
 		comp_sz_or_errcode = v4l2_fwht_encode(state, p_src, comp_buf,
 						      p_hdr);
 		if (comp_sz_or_errcode < 0)
 			return comp_sz_or_errcode;
-		vb2_set_plane_payload(&dst_vb->vb2_buf, 0,
-				      comp_sz_or_errcode + sizeof(*p_hdr));
+
+		if (!ctx->is_stateless) {
+			comp_sz_or_errcode += sizeof(*p_hdr);
+		} else {
+			int ret;
+			struct v4l2_ctrl_fwht_params params;
+
+			update_stateless_params_from_header(ctx, &params);
+			ret = v4l2_ctrl_s_ctrl_ptr(ctx->ctrl_fwht_params,
+						   &params);
+			if (ret)
+				return ret;
+		}
+		vb2_set_plane_payload(&dst_vb->vb2_buf, 0, comp_sz_or_errcode);
 	} else {
 		struct vicodec_q_data *q_dst;
 		unsigned int comp_frame_size = ntohl(ctx->state.header.size);
@@ -1739,7 +1775,7 @@ static void vicodec_stop_streaming(struct vb2_queue *q)
 
 	if ((!V4L2_TYPE_IS_OUTPUT(q->type) && !ctx->is_enc) ||
 	    (V4L2_TYPE_IS_OUTPUT(q->type) && ctx->is_enc)) {
-		if (!ctx->is_stateless)
+		if (!ctx->is_stateless || ctx->is_enc)
 			kvfree(ctx->state.ref_frame.buf);
 		ctx->state.ref_frame.buf = NULL;
 		ctx->state.ref_frame.luma = NULL;
@@ -1819,6 +1855,8 @@ static int vicodec_try_ctrl(struct v4l2_ctrl *ctrl)
 	const struct v4l2_ctrl_fwht_params *params;
 	struct vicodec_q_data *q_dst = get_q_data(ctx,
 			V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	if (ctx->is_enc)
+		return 0;
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_FWHT_PARAMS:
@@ -1943,7 +1981,9 @@ static int vicodec_open(struct file *file)
 		v4l2_ctrl_new_std(hdl, &vicodec_ctrl_ops,
 				  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 1, 1, 1);
 	if (ctx->is_stateless)
-		v4l2_ctrl_new_custom(hdl, &vicodec_ctrl_stateless_state, NULL);
+		ctx->ctrl_fwht_params =
+			v4l2_ctrl_new_custom(hdl, &vicodec_ctrl_stateless_state,
+					     NULL);
 	if (hdl->error) {
 		rc = hdl->error;
 		v4l2_ctrl_handler_free(hdl);
-- 
2.17.1

