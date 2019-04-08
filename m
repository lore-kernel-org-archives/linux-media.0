Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC2C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA4A214C6
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDHMdP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:33:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59425 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfDHMdK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:33:10 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDTSW-00005P-83; Mon, 08 Apr 2019 14:33:08 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 01/10] media: coda: set codec earlier
Date:   Mon,  8 Apr 2019 14:32:47 +0200
Message-Id: <20190408123256.22868-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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

The chosen codec depends on the coded format, which is known as soon as
the S_FMT call on the coded queue. This allows to use the codec in
callbacks that may be called before start_streaming, such as buf_queue.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 28 ++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index fa0b22fb7991..a403bc2995b4 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -764,6 +764,7 @@ static int coda_s_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct coda_ctx *ctx = fh_to_ctx(priv);
 	struct coda_q_data *q_data_src;
+	const struct coda_codec *codec;
 	struct v4l2_rect r;
 	int ret;
 
@@ -784,6 +785,15 @@ static int coda_s_fmt_vid_cap(struct file *file, void *priv,
 	if (ctx->inst_type != CODA_INST_ENCODER)
 		return 0;
 
+	/* Setting the coded format determines the selected codec */
+	codec = coda_find_codec(ctx->dev, q_data_src->fourcc,
+				f->fmt.pix.pixelformat);
+	if (!codec) {
+		v4l2_err(&ctx->dev->v4l2_dev, "failed to determine codec\n");
+		return -EINVAL;
+	}
+	ctx->codec = codec;
+
 	ctx->colorspace = f->fmt.pix.colorspace;
 	ctx->xfer_func = f->fmt.pix.xfer_func;
 	ctx->ycbcr_enc = f->fmt.pix.ycbcr_enc;
@@ -796,6 +806,7 @@ static int coda_s_fmt_vid_out(struct file *file, void *priv,
 			      struct v4l2_format *f)
 {
 	struct coda_ctx *ctx = fh_to_ctx(priv);
+	const struct coda_codec *codec;
 	struct v4l2_format f_cap;
 	struct vb2_queue *dst_vq;
 	int ret;
@@ -811,6 +822,15 @@ static int coda_s_fmt_vid_out(struct file *file, void *priv,
 	if (ctx->inst_type != CODA_INST_DECODER)
 		return 0;
 
+	/* Setting the coded format determines the selected codec */
+	codec = coda_find_codec(ctx->dev, f->fmt.pix.pixelformat,
+				V4L2_PIX_FMT_YUV420);
+	if (!codec) {
+		v4l2_err(&ctx->dev->v4l2_dev, "failed to determine codec\n");
+		return -EINVAL;
+	}
+	ctx->codec = codec;
+
 	ctx->colorspace = f->fmt.pix.colorspace;
 	ctx->xfer_func = f->fmt.pix.xfer_func;
 	ctx->ycbcr_enc = f->fmt.pix.ycbcr_enc;
@@ -1680,14 +1700,6 @@ static int coda_start_streaming(struct vb2_queue *q, unsigned int count)
 
 	ctx->gopcounter = ctx->params.gop_size - 1;
 
-	ctx->codec = coda_find_codec(ctx->dev, q_data_src->fourcc,
-				     q_data_dst->fourcc);
-	if (!ctx->codec) {
-		v4l2_err(v4l2_dev, "couldn't tell instance type.\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
 	if (q_data_dst->fourcc == V4L2_PIX_FMT_JPEG)
 		ctx->params.gop_size = 1;
 	ctx->gopcounter = ctx->params.gop_size - 1;
-- 
2.20.1

