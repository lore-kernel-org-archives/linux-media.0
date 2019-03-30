Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB03EC43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDF8218D8
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8/x54B/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfC3UqA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:46:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33771 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfC3Up7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so6864028wrp.0
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MwCbYlPB7RmKx965GxAhkkGCVi8TVyMw8A/MDOhQhs4=;
        b=L8/x54B/D8yiHY9koLQKsvrR/4Ky36bfQWDAoWb+pz/jlgy39Sq1IDvgAAFYQT8J02
         Dbue74cHuceHXrnlX41xKeKDlt/6wIkAYFy9wpIs2rXCKMagYuhrJCTMT/0xBwxY6Q9J
         HwG1h7EMqstcOW9xz72tpHthznsNAFIkz9g4lSOnXgMtgEO9kE2d3DBksuylRWWHmUzQ
         7oo4WaHxjPMNBVnHrr+jv4KPsAF52zFSVvWlpcFLrIPuU7lvtUxHTM8SB4SLVpCYhUy6
         22Psn2nib0g5gwH/gvwSzVStWAclBx+nnhpuE+G5DUSbjCQTvgz9DmxHk19uKUJb3mlN
         hZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MwCbYlPB7RmKx965GxAhkkGCVi8TVyMw8A/MDOhQhs4=;
        b=qOPsBtDwzU/XnKU0FZjVYmP5disp4772syN8Ecq0SJAeXvtjd0GpwEv4FjaGJxjySS
         Ky6ceI68tYaTiYx75iNMexcWFz/x2KbR/jJVgDIYPAU7bs+xjHomhRnkjnwoEP0tvm+p
         XmCGbp1QdycyaoCmHgSiKvSkKuMv1U0JkMBE7yzsFml5zcTMpdTZSX/E9b/R/2KiJtz0
         fWVM6fOi5J842JFZ03YLEyd3KINZsWOzRIKO03apsj+IQcMcYLBYbp5fyaWvbzfx8pu4
         Wov1RVGnKGQ/7Bcbx4p0X3+4OemM+sBKJ+7SNoi1YnYiznS164PJ7OyMCOm7BI3r+y8q
         od9Q==
X-Gm-Message-State: APjAAAVsEToUaTzN9RodkR/kA4ifSs4+VvvCIMDmJmOV62moVhxKBi7a
        W4hFjJHF7rzl0x1xwGx5nBJVx3oPy4Q=
X-Google-Smtp-Source: APXvYqxRJ2/F8gYn0sFIf069rNQJ/JIn+SdIMvOvcmKqN3k4SRBsi0Jwgxzzo5eZddONTm3sCi+Btw==
X-Received: by 2002:adf:e407:: with SMTP id g7mr24709025wrm.47.1553978757026;
        Sat, 30 Mar 2019 13:45:57 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:56 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH 13/14] media: vicodec: Add support for stateless encoder
Date:   Sat, 30 Mar 2019 13:43:11 -0700
Message-Id: <20190330204311.107417-14-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Adjust the stateless API code to support
both encoder and decoder.

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 58 +++++++++++--------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index f042c4b618ba..3808e72b2361 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -280,29 +280,31 @@ static int device_process(struct vicodec_ctx *ctx,
 
 		ctx->state.header.size =
 			htonl(vb2_get_plane_payload(&src_vb->vb2_buf, 0));
-		/*
-		 * set the reference buffer from the reference timestamp
-		 * only if this is a P-frame
-		 */
-		if (!(ntohl(ctx->state.header.flags) & FWHT_FL_I_FRAME)) {
-			struct vb2_buffer *ref_vb2_buf;
-			int ref_buf_idx;
-			struct vb2_queue *vq_cap =
+		if (!ctx->is_enc) {
+			/*
+			 * set the reference buffer from the reference timestamp
+			 * only if this is a P-frame
+			*/
+			if (!(ntohl(ctx->state.header.flags) & FWHT_FL_I_FRAME)) {
+				struct vb2_buffer *ref_vb2_buf;
+				int ref_buf_idx;
+				struct vb2_queue *vq_cap =
 				v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-						V4L2_BUF_TYPE_VIDEO_CAPTURE);
+				V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
-			ref_buf_idx = vb2_find_timestamp(vq_cap,
-							 ctx->state.ref_frame_ts, 0);
-			if (ref_buf_idx < 0)
-				return -EINVAL;
+				ref_buf_idx = vb2_find_timestamp(vq_cap,
+				ctx->state.ref_frame_ts, 0);
+				if (ref_buf_idx < 0)
+					return -EINVAL;
 
-			ref_vb2_buf = vq_cap->bufs[ref_buf_idx];
-			if (ref_vb2_buf->state == VB2_BUF_STATE_ERROR)
-				ret = -EINVAL;
-			ctx->state.ref_frame.buf =
+				ref_vb2_buf = vq_cap->bufs[ref_buf_idx];
+				if (ref_vb2_buf->state == VB2_BUF_STATE_ERROR)
+					ret = -EINVAL;
+				ctx->state.ref_frame.buf =
 				vb2_plane_vaddr(ref_vb2_buf, 0);
-		} else {
-			ctx->state.ref_frame.buf = NULL;
+			} else {
+				ctx->state.ref_frame.buf = NULL;
+			}
 		}
 	}
 	p_dst = vb2_plane_vaddr(&dst_vb->vb2_buf, 0);
@@ -1722,7 +1724,7 @@ static void vicodec_stop_streaming(struct vb2_queue *q)
 
 	if ((!V4L2_TYPE_IS_OUTPUT(q->type) && !ctx->is_enc) ||
 	    (V4L2_TYPE_IS_OUTPUT(q->type) && ctx->is_enc)) {
-		if (!ctx->is_stateless)
+		if (!ctx->is_stateless || ctx->is_enc)
 			kvfree(ctx->state.ref_frame.buf);
 		ctx->state.ref_frame.buf = NULL;
 		ctx->state.ref_frame.luma = NULL;
@@ -1800,20 +1802,26 @@ static int vicodec_try_ctrl(struct v4l2_ctrl *ctrl)
 	struct vicodec_ctx *ctx = container_of(ctrl->handler,
 			struct vicodec_ctx, hdl);
 	const struct v4l2_ctrl_fwht_params *params;
-	struct vicodec_q_data *q_dst = get_q_data(ctx,
-			V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	struct vicodec_q_data *q_data;
+
+	if (ctx->is_enc)
+		q_data = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
+	else
+		q_data = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_FWHT_PARAMS:
 		params = ctrl->p_new.p_fwht_params;
-		if (params->width > q_dst->coded_width ||
+		if (params->width > q_data->coded_width ||
 		    params->width < MIN_WIDTH ||
-		    params->height > q_dst->coded_height ||
+		    params->height > q_data->coded_height ||
 		    params->height < MIN_HEIGHT)
 			return -EINVAL;
+		if (ctx->is_enc)
+			return 0;
 		if (!validate_by_version(params->flags, params->version))
 			return -EINVAL;
-		if (!validate_stateless_params_flags(params, q_dst->info))
+		if (!validate_stateless_params_flags(params, q_data->info))
 			return -EINVAL;
 		return 0;
 	default:
-- 
2.17.1

