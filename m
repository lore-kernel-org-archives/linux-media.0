Return-Path: <SRS0=dfwv=UR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3407C31E5D
	for <linux-media@archiver.kernel.org>; Tue, 18 Jun 2019 16:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D8621530
	for <linux-media@archiver.kernel.org>; Tue, 18 Jun 2019 16:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfFRQqC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:46:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48743 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbfFRQpp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Jun 2019 12:45:45 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hdHEt-0003WX-Hv; Tue, 18 Jun 2019 18:45:43 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, kernel@pengutronix.de
Subject: [PATCH 08/28] media: coda: add sequence initialization work
Date:   Tue, 18 Jun 2019 18:45:15 +0200
Message-Id: <20190618164535.20162-9-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618164535.20162-1-p.zabel@pengutronix.de>
References: <20190618164535.20162-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add a sequence initialization work item to be run when OUTPUT buffers
are queued in the initialization state.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-bit.c    | 25 +++++++++++++++++++++++
 drivers/media/platform/coda/coda-common.c | 24 ++++++++++++++++++++++
 drivers/media/platform/coda/coda.h        |  2 ++
 3 files changed, 51 insertions(+)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index cecfd51e3838..9f8e2342d175 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -1824,6 +1824,30 @@ static int __coda_decoder_seq_init(struct coda_ctx *ctx)
 	return 0;
 }
 
+static void coda_dec_seq_init_work(struct work_struct *work)
+{
+	struct coda_ctx *ctx = container_of(work,
+					    struct coda_ctx, seq_init_work);
+	struct coda_dev *dev = ctx->dev;
+	int ret;
+
+	mutex_lock(&ctx->buffer_mutex);
+	mutex_lock(&dev->coda_mutex);
+
+	if (ctx->initialized == 1)
+		goto out;
+
+	ret = __coda_decoder_seq_init(ctx);
+	if (ret < 0)
+		goto out;
+
+	ctx->initialized = 1;
+
+out:
+	mutex_unlock(&dev->coda_mutex);
+	mutex_unlock(&ctx->buffer_mutex);
+}
+
 static int __coda_start_decoding(struct coda_ctx *ctx)
 {
 	struct coda_q_data *q_data_src, *q_data_dst;
@@ -2352,6 +2376,7 @@ const struct coda_context_ops coda_bit_decode_ops = {
 	.prepare_run = coda_prepare_decode,
 	.finish_run = coda_finish_decode,
 	.run_timeout = coda_decode_timeout,
+	.seq_init_work = coda_dec_seq_init_work,
 	.seq_end_work = coda_seq_end_work,
 	.release = coda_bit_release,
 };
diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 232bda4b7016..f8cfafa2ce42 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1684,6 +1684,19 @@ static void coda_buf_queue(struct vb2_buffer *vb)
 			/* This set buf->sequence = ctx->qsequence++ */
 			coda_fill_bitstream(ctx, NULL);
 		mutex_unlock(&ctx->bitstream_mutex);
+
+		if (!ctx->initialized) {
+			/*
+			 * Run sequence initialization in case the queued
+			 * buffer contained headers.
+			 */
+			if (vb2_is_streaming(vb->vb2_queue) &&
+			    ctx->ops->seq_init_work) {
+				queue_work(ctx->dev->workqueue,
+					   &ctx->seq_init_work);
+				flush_work(&ctx->seq_init_work);
+			}
+		}
 	} else {
 		if (ctx->inst_type == CODA_INST_ENCODER &&
 		    vq->type == V4L2_BUF_TYPE_VIDEO_OUTPUT)
@@ -1761,6 +1774,15 @@ static int coda_start_streaming(struct vb2_queue *q, unsigned int count)
 				ret = -EINVAL;
 				goto err;
 			}
+
+			if (!ctx->initialized) {
+				/* Run sequence initialization */
+				if (ctx->ops->seq_init_work) {
+					queue_work(ctx->dev->workqueue,
+						   &ctx->seq_init_work);
+					flush_work(&ctx->seq_init_work);
+				}
+			}
 		}
 
 		ctx->streamon_out = 1;
@@ -2317,6 +2339,8 @@ static int coda_open(struct file *file)
 	ctx->use_bit = !ctx->cvd->direct;
 	init_completion(&ctx->completion);
 	INIT_WORK(&ctx->pic_run_work, coda_pic_run_work);
+	if (ctx->ops->seq_init_work)
+		INIT_WORK(&ctx->seq_init_work, ctx->ops->seq_init_work);
 	if (ctx->ops->seq_end_work)
 		INIT_WORK(&ctx->seq_end_work, ctx->ops->seq_end_work);
 	v4l2_fh_init(&ctx->fh, video_devdata(file));
diff --git a/drivers/media/platform/coda/coda.h b/drivers/media/platform/coda/coda.h
index 0c2cace53ce8..c97ea3e24b80 100644
--- a/drivers/media/platform/coda/coda.h
+++ b/drivers/media/platform/coda/coda.h
@@ -185,6 +185,7 @@ struct coda_context_ops {
 	int (*prepare_run)(struct coda_ctx *ctx);
 	void (*finish_run)(struct coda_ctx *ctx);
 	void (*run_timeout)(struct coda_ctx *ctx);
+	void (*seq_init_work)(struct work_struct *work);
 	void (*seq_end_work)(struct work_struct *work);
 	void (*release)(struct coda_ctx *ctx);
 };
@@ -193,6 +194,7 @@ struct coda_ctx {
 	struct coda_dev			*dev;
 	struct mutex			buffer_mutex;
 	struct work_struct		pic_run_work;
+	struct work_struct		seq_init_work;
 	struct work_struct		seq_end_work;
 	struct completion		completion;
 	const struct coda_video_device	*cvd;
-- 
2.20.1

