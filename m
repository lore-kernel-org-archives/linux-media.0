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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE76C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAE52133D
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjimXlkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDCWSP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54655 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDCWSO (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so563730wml.4
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WM4V9PQvsPngXYIkdD5A0deEFdEL42tCk3s3+5JpINs=;
        b=EjimXlkg+ZnY+/d3tDY8BhOZEaejNSkFbIAkAQ+kR7z1Bc+TTO7QERXQpZ/xofY+Q+
         PYWA9cG5Qr/GNCYmDNKzJQfs5S92ia0jKLcEF6eiCy/taQpSMJ7nxxnAyseRigiDfbQB
         neCSH8BjTjTo+tXoCGY3Fcj4mEkWI3IeeXvuyUzVNw0ejitn0nc8CLSLrVIdgzhn1F83
         BOofxNBzRyk0t0qcpW6EfQRIgeragFPtcru+qAlZe31H/LmE2o8pGLhgVSHPZDuF9unP
         ABhUzuxuP1cUpb05RoA8hcGkS7iqSoDHqybJ0WSqkT6RODIdb45C2o2Mj+6g5iqI1oEW
         QfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WM4V9PQvsPngXYIkdD5A0deEFdEL42tCk3s3+5JpINs=;
        b=XgeFm37OEY0EbTajdVLd2jd89UiEhSNybxDIR0XAzHkAG0wiRRjaNz6lkChE5prQgd
         M3BEskX/DDhLnNvpKmsYskCXRpzzpCnaB9HXRKgz0g4EpXuqsNHEZDlFERtpu1zhWNl/
         y3gG3DNW6KuR+q8PqTUjcLo/3z/RYUqYPvrQD5WBgJ61Q00YMVUM5bafGW9hEs0hGp1i
         jmrBiTaQOIz3dfUa/w3H7edO8gJBDsuHrdGzqIDkUyB/at43++MhumE+xTjPaB1FhjHC
         E6OQ2+YoU5sxzkbkrWOliTWzb1fikh2XfHbng6SH95PLTeqgDzW/CP021Cr4cZBb/pwB
         6GXg==
X-Gm-Message-State: APjAAAVkhk4LBiyDjl1S74uqwXzESf+lVx97sWOvnh4El/ihR333Dv2C
        T9T7kxWdAT+va0h9nb0ppIE=
X-Google-Smtp-Source: APXvYqxF7j4Nq1gRMtpfGut7s51lfZgGYhX3OXZfp6sjrQUGXyCqVZ1NdyAEQ4Q5hUTSNZxPkE54yw==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr1498843wme.36.1554329892980;
        Wed, 03 Apr 2019 15:18:12 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:12 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 04/16] vicodec: pass on enc output format to capture side
Date:   Wed,  3 Apr 2019 15:14:49 -0700
Message-Id: <20190403221501.32814-5-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403221501.32814-1-dafna3@gmail.com>
References: <20190403221501.32814-1-dafna3@gmail.com>
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
index aa3af796929b..75b6bc5a6f3b 100644
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
2.17.1

