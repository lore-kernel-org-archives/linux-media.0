Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B3AC4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DFD20882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5kvQ3g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDCWS0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44245 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDCWSZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so836309wrn.11
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhYAn7sb09ddBtLgtf1whCexcwR1iul0vubvq6vR/dg=;
        b=g5kvQ3g53PyiYlw1ZTLdBJ8J2zkFABqbKJzc3X+KwDZBiWfzYbU8eH81SQsMyo/tX8
         YLdT5MphZRUwBsSw7OKHz6T+zeH2yUSxADXUa4nv0vqt7pVVxzNnx5zbF7qcivWQYGwM
         4UXO4ttuScyaJC1xVmSVPM45+iePlFzOYyPM5Uh4Y+ThlJ+Ti0XOKkHAkIgtkBvQAzIw
         8OVYjBNA90S9giFGSYsRER7/poF/YfSKiYk/YjXQcVuDfMwtNdwq6DnTsdyeq24qvPyC
         Km19ZRz27ocjadHs1tZxPkeCtzi8kvR4IrKiOSBdQl38bQ04e2yIfy00/RmqrxPUqhWU
         3CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhYAn7sb09ddBtLgtf1whCexcwR1iul0vubvq6vR/dg=;
        b=RCgIstmJl20jIW4QyOBEMvPTUth7z3NRN/vGVI2vsnzZG+EwY2Q+O6O9h6DSHVOdHL
         Hknl+XNUzNTGr2oOsxN4Piw1voc3RNNBLrDdNvnwCJgi80BGt3c3Xk9hc6chLlpZ+Nso
         Eg3I3/PyaQfi+FPfhmdmvMWDU6aF9xVi3oIPQm+xdLbWj5LRJilh+4AxManelYmJdcGU
         cn1pex+kCjQsbLtXqkdc+F0h1GRCZ6GzjXXnR+ODnYvtM7sR9rIq2cw0GqFLVTQo1WAt
         w/7h+K8SJJ0HuaWcaKCcdtHQIWYmi2VNa75WtSHne08hG4/2wErqHbJ7i66zneTC0L0j
         ZiSA==
X-Gm-Message-State: APjAAAVmdLzVmhKnBzFzrhvgT+gLmjcstZAUo5mbb93vKgb4SDQBcdlc
        UTcMJVpGiqWE8WuE7IpoVfI=
X-Google-Smtp-Source: APXvYqwSCRKtd97ucF/DzZ1auSMNbux9HK7Xd19m+HMDbJ7oVKNAm6pjhzM5zS57McMFsO6vUo0G9A==
X-Received: by 2002:adf:dc88:: with SMTP id r8mr1355858wrj.28.1554329903851;
        Wed, 03 Apr 2019 15:18:23 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:23 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com
Subject: [PATCH v2 13/16] media: vicodec: add field 'dev_inst' to vicodec_ctx
Date:   Wed,  3 Apr 2019 15:14:58 -0700
Message-Id: <20190403221501.32814-14-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add the field 'dev_inst' to vicodec_ctx that points to
the 'vicodec_dev_instance'. This saves many if-elses

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
---
 drivers/media/platform/vicodec/vicodec-core.c | 42 ++++++-------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 3e93e86041f7..73661bc96671 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -121,6 +121,7 @@ struct vicodec_ctx {
 	bool			has_stopped;
 	spinlock_t		*lock;
 
+	struct vicodec_dev_instance *dev_inst;
 	struct v4l2_ctrl_handler hdl;
 
 	struct vb2_v4l2_buffer *last_src_buf;
@@ -413,7 +414,6 @@ static enum vb2_buffer_state get_next_header(struct vicodec_ctx *ctx,
 static void device_run(void *priv)
 {
 	struct vicodec_ctx *ctx = priv;
-	struct vicodec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct vicodec_q_data *q_src, *q_dst;
 	u32 state;
@@ -462,13 +462,7 @@ static void device_run(void *priv)
 	if (ctx->is_stateless && src_req)
 		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
 
-	if (ctx->is_enc)
-		v4l2_m2m_job_finish(dev->stateful_enc.m2m_dev, ctx->fh.m2m_ctx);
-	else if (ctx->is_stateless)
-		v4l2_m2m_job_finish(dev->stateless_dec.m2m_dev,
-				    ctx->fh.m2m_ctx);
-	else
-		v4l2_m2m_job_finish(dev->stateful_dec.m2m_dev, ctx->fh.m2m_ctx);
+	v4l2_m2m_job_finish(ctx->dev_inst->m2m_dev, ctx->fh.m2m_ctx);
 }
 
 static void job_remove_src_buf(struct vicodec_ctx *ctx, u32 state)
@@ -1787,12 +1781,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->ops = &vicodec_qops;
 	src_vq->mem_ops = &vb2_vmalloc_memops;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
-	if (ctx->is_enc)
-		src_vq->lock = &ctx->dev->stateful_enc.mutex;
-	else if (ctx->is_stateless)
-		src_vq->lock = &ctx->dev->stateless_dec.mutex;
-	else
-		src_vq->lock = &ctx->dev->stateful_dec.mutex;
+	src_vq->lock = &ctx->dev_inst->mutex;
 	src_vq->supports_requests = ctx->is_stateless;
 	src_vq->requires_requests = ctx->is_stateless;
 	ret = vb2_queue_init(src_vq);
@@ -1915,10 +1904,15 @@ static int vicodec_open(struct file *file)
 		goto open_unlock;
 	}
 
-	if (vfd == &dev->stateful_enc.vfd)
+	if (vfd == &dev->stateful_enc.vfd) {
 		ctx->is_enc = true;
-	else if (vfd == &dev->stateless_dec.vfd)
+		ctx->dev_inst = &dev->stateful_enc;
+	} else if (vfd == &dev->stateless_dec.vfd) {
 		ctx->is_stateless = true;
+		ctx->dev_inst = &dev->stateless_dec;
+	} else {
+		ctx->dev_inst = &dev->stateful_dec;
+	}
 
 	v4l2_fh_init(&ctx->fh, video_devdata(file));
 	file->private_data = &ctx->fh;
@@ -1975,19 +1969,9 @@ static int vicodec_open(struct file *file)
 
 	ctx->state.colorspace = V4L2_COLORSPACE_REC709;
 
-	if (ctx->is_enc) {
-		ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(dev->stateful_enc.m2m_dev,
-						    ctx, &queue_init);
-		ctx->lock = &dev->stateful_enc.lock;
-	} else if (ctx->is_stateless) {
-		ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(dev->stateless_dec.m2m_dev,
-						    ctx, &queue_init);
-		ctx->lock = &dev->stateless_dec.lock;
-	} else {
-		ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(dev->stateful_dec.m2m_dev,
-						    ctx, &queue_init);
-		ctx->lock = &dev->stateful_dec.lock;
-	}
+	ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(ctx->dev_inst->m2m_dev,
+					    ctx, &queue_init);
+	ctx->lock = &ctx->dev_inst->lock;
 
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
 		rc = PTR_ERR(ctx->fh.m2m_ctx);
-- 
2.17.1

