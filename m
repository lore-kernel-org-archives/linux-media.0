Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA099C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B0D206DD
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfC2P31 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:29:27 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:56163 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728903AbfC2P30 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 11:29:26 -0400
Received: from test-no.fritz.box ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9tRYhPNkWUjKf9tRchwWqV; Fri, 29 Mar 2019 16:29:24 +0100
From:   hverkuil-cisco@xs4all.nl
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna3@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [RFC PATCH 2/5] vicodec: pass on enc output format to capture side
Date:   Fri, 29 Mar 2019 16:29:17 +0100
Message-Id: <20190329152920.30179-3-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
References: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfC2k2zGZ74dUk36SqrnOE6Rybhehj+vS4rBH6Ifr424c6+AMeZpDHsdw6NEI/tOTcnr57WRKGjmUSG6oF0x0l8BKGWrlFRweYgEMMgMtYqyCLH9C9O7v
 GudIHCec00RSQ/XMZ5QuIA44UvLSbXmaWPKgveV/benAK3s507ZrOFYgGV4HusSniVafUglmwEhESZmOlKPoFPlJ+6FeYNYDQX7ZlJSuRj8gIXiyI3vfLecG
 4UUPeThQjvDiAtOrtMJBGQTsSe85YkIMGDuwcQX20Em5fnZXOlES1D8WZ+4ayh9P
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Setting the encoder output format to e.g. 1920x1080 will set the
crop rectangle to 1920x1080, the coded resolution to 1920x1088 and
the capture coded resolution and sizeimage to 1920x1088 as well.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 64 ++++++++++++++++---
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index a6b35db7203a..3b5124838f15 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -1032,16 +1032,10 @@ static int vidioc_s_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 	default:
 		return -EINVAL;
 	}
-	if (q_data->visible_width > q_data->coded_width)
-		q_data->visible_width = q_data->coded_width;
-	if (q_data->visible_height > q_data->coded_height)
-		q_data->visible_height = q_data->coded_height;
-
 
 	dprintk(ctx->dev,
-		"Setting format for type %d, coded wxh: %dx%d, visible wxh: %dx%d, fourcc: %08x\n",
+		"Setting format for type %d, coded wxh: %dx%d, fourcc: 0x%08x\n",
 		f->type, q_data->coded_width, q_data->coded_height,
-		q_data->visible_width, q_data->visible_height,
 		q_data->info->id);
 
 	return 0;
@@ -1063,18 +1057,69 @@ static int vidioc_s_fmt_vid_out(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
 	struct vicodec_ctx *ctx = file2ctx(file);
-	struct v4l2_pix_format_mplane *pix_mp;
+	struct vicodec_q_data *q_data;
+	struct vicodec_q_data *q_data_cap;
 	struct v4l2_pix_format *pix;
+	struct v4l2_pix_format_mplane *pix_mp;
+	u32 coded_w = 0, coded_h = 0;
+	unsigned int size = 0;
+	u32 w, h;
 	int ret;
 
+	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT) {
+		w = f->fmt.pix.width;
+		h = f->fmt.pix.height;
+	} else {
+		w = f->fmt.pix_mp.width;
+		h = f->fmt.pix_mp.height;
+	}
+	q_data = get_q_data(ctx, f->type);
+	q_data_cap = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+
 	ret = vidioc_try_fmt_vid_out(file, priv, f);
 	if (ret)
 		return ret;
 
+	if (ctx->is_enc) {
+		struct vb2_queue *vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
+		struct vb2_queue *vq_cap = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+							   V4L2_BUF_TYPE_VIDEO_CAPTURE);
+		const struct v4l2_fwht_pixfmt_info *info = ctx->is_stateless ?
+			&pixfmt_stateless_fwht : &pixfmt_fwht;
+
+		if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT) {
+			coded_w = f->fmt.pix.width;
+			coded_h = f->fmt.pix.height;
+		} else {
+			coded_w = f->fmt.pix_mp.width;
+			coded_h = f->fmt.pix_mp.height;
+		}
+		if (vb2_is_busy(vq) && (coded_w != q_data->coded_width ||
+					coded_h != q_data->coded_height))
+			return -EBUSY;
+		size = coded_w * coded_h *
+			info->sizeimage_mult / info->sizeimage_div;
+		if (!ctx->is_stateless)
+			size += sizeof(struct fwht_cframe_hdr);
+
+		if (vb2_is_busy(vq_cap) && size > q_data_cap->sizeimage)
+			return -EBUSY;
+	}
+
 	ret = vidioc_s_fmt(file2ctx(file), f);
 	if (!ret) {
+		if (ctx->is_enc) {
+			q_data->visible_width = w;
+			q_data->visible_height = h;
+			q_data_cap->coded_width = coded_w;
+			q_data_cap->coded_height = coded_h;
+			if (q_data_cap->sizeimage < size)
+				q_data_cap->sizeimage = size;
+			dprintk(ctx->dev,
+				"Setting output crop to %dx%d\n", w, h);
+		}
+
 		switch (f->type) {
-		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
 			pix = &f->fmt.pix;
 			ctx->state.colorspace = pix->colorspace;
@@ -1082,7 +1127,6 @@ static int vidioc_s_fmt_vid_out(struct file *file, void *priv,
 			ctx->state.ycbcr_enc = pix->ycbcr_enc;
 			ctx->state.quantization = pix->quantization;
 			break;
-		case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 		case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
 			pix_mp = &f->fmt.pix_mp;
 			ctx->state.colorspace = pix_mp->colorspace;
-- 
2.20.1

