Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7A1C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4662146F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIEhecC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfC3Up5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45941 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbfC3Up4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so6821746wra.12
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aymg/ZymsAqHb3+yj5jowOK+nJ0BpAR2xNjEHjFq82E=;
        b=UIEhecC2CiU5znBacto5rV9LFhAxOeYkEXTNzptSt77Fq4cNvIsG0vvZ5vthAaQzsu
         rbYiiTIeAA0TZlChytUBZPHo5WczGEgyYxfnYhjsooNJMd6z8JStAsA0VVir7NCyEG4V
         OeG5KAu6dl1yTQLkg15ukPp7zgYz8r67SJnbPnmBxmLGs4/zPanUHlAa4l0UF2dVI+oE
         prlSLjKZVmQc6pMl9pZNUS50ihE9BMtgw2l8LHCasfn4NcrttfSaYWazWa0zq9EtLsRI
         h0JJruMallKrqPFTwMZ33samMXblq00GYvZDfg24HTDHyO4fDwTCLxIuhT71aDjkHPNy
         GybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aymg/ZymsAqHb3+yj5jowOK+nJ0BpAR2xNjEHjFq82E=;
        b=WZbzhIB7h5npdmOSqHGcsQuqoycd3/2T+Gf1v6ghIhH5+aHScMoGcCsPLLXz3CQZfD
         HdYttJMU1MyjJU0JwaU76yiQylDyi6MmApan6OXiV35dVa/jfaBtlg6re8M57EMqq7Or
         SbTAsCZEg1PLKwEet38T3YEfmCGYRsrO41c76NVN/0pyyyHxn3BjSXfd4KqGXJP519G/
         cb7vsK6zhGZxHyyUJeFGKGVpjLwS9Qrl3yRhbudnHFAbZbLPhWLrUw//vpFQTJecS/uT
         SSe5T8By7vUmTW+L3JL7Rf+pMaZ7HjPLH55VMsqtQgAykcwa6oNsAN3Qjg92lEanUozJ
         W/Cg==
X-Gm-Message-State: APjAAAV0yuoJy3PHXIp44nT30PngUnRaqTzhHdLuBvnvdEUXrvPmqS8B
        H9kIFSVUbPqwJargOIu3GvH3rb+JkEE=
X-Google-Smtp-Source: APXvYqzqhv3PcnnhG/2Nfpr95rMv/SrQkICQN8zrs3ihZtDOy1Yjz4urQGw3hL//jSoTVcSeWpcpqw==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr32190120wrw.301.1553978753923;
        Sat, 30 Mar 2019 13:45:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:53 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH 10/14] media: vicodec: add field 'dev_inst' to vicodec_ctx
Date:   Sat, 30 Mar 2019 13:43:08 -0700
Message-Id: <20190330204311.107417-11-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
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
index 6276a803cc4d..a701afd7cecb 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -121,6 +121,7 @@ struct vicodec_ctx {
 	bool			has_stopped;
 	spinlock_t		*lock;
 
+	struct vicodec_dev_instance *dev_inst;
 	struct v4l2_ctrl_handler hdl;
 
 	struct vb2_v4l2_buffer *last_src_buf;
@@ -404,7 +405,6 @@ static enum vb2_buffer_state get_next_header(struct vicodec_ctx *ctx,
 static void device_run(void *priv)
 {
 	struct vicodec_ctx *ctx = priv;
-	struct vicodec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct vicodec_q_data *q_src, *q_dst;
 	u32 state;
@@ -454,13 +454,7 @@ static void device_run(void *priv)
 	ctx->comp_has_frame = false;
 	spin_unlock(ctx->lock);
 
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
@@ -1771,12 +1765,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
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
@@ -1899,10 +1888,15 @@ static int vicodec_open(struct file *file)
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
@@ -1959,19 +1953,9 @@ static int vicodec_open(struct file *file)
 
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

