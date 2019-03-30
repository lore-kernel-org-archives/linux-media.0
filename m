Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F719C4360F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428F82146F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKTGoJ2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfC3Upt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51226 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3Upt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so6042525wmf.1
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9f90xLY6+DqHwHHOVozYVA09oMmI/32qgl0gBE7ssGs=;
        b=jKTGoJ2aQde/8ezexkMWjITUcpD48pzYXFY+gDjGrCIP46K256elUcRAMtqYEWGqfC
         qVvsiBNAjGFYlkIkwLCgVgeYMReaTlrL0BwTwn6k72a4tn4uslJtNzf3ULSlPzs3YWVz
         ZmFqT/zsAPGihY4zjCSfi5RmrX5TWl352KXV6fBuTbVBrQRwzPHEYjZjhPI952kytwLI
         Mmda12D/vYj1EZSQdm+S6f/8Ko+cIMqLFslA1yfZaxwF9aYnW/ynbmgsGyPXBErld25q
         cnDTuflPdk85XkeEE/KoliWJDLZ+4AHbkTeAEceS81bUeow9fATHbfN40rmu8y5gpCps
         yftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9f90xLY6+DqHwHHOVozYVA09oMmI/32qgl0gBE7ssGs=;
        b=GVuEldPbvwHGno1h834a/3sxKlpkUN7hgEacwKfbLDTruhjyf3dsAcCy+kh6X3N/jE
         QeAx2htd6hY34ztd4mMhdhdvhgpxPQ9YAERGh+paIAS+7zdo5G7bU/cZ6OxtgbITukTV
         v+bXzBtXGxwxBqV9r3Smar0PlXyJ8U/2+7C9twQ8tsBjg7hMLg1vJqoo9XW936/fU6ca
         6qi8OqYissSqpO1njElO/IEeMaH06iCq1BdSgFITAfXakB9pJ5d485xtK5s3qB/w1UQ9
         vz7RqCWH88Ru4oTY667g/8IiA0kpe0BRomFEcUSG0X7bM6sRSPVlq8XCDrGwvjxTGldc
         XBbQ==
X-Gm-Message-State: APjAAAVREoG9sxLjdqw5i/YFd+yKo3V7o0L3Adcq9RRHH1LmTr8pFLqd
        OqZyeshVTG81gicW4bPC1Oq5KdEzhxQ=
X-Google-Smtp-Source: APXvYqwgfSdbAxHAUNt0AwerZTT9yrzIjrm9DIsOyTCgTibpc3IgRzaPo2xZOY6BWNr+Bl3A2GuJew==
X-Received: by 2002:a1c:ce42:: with SMTP id e63mr7861241wmg.118.1553978746614;
        Sat, 30 Mar 2019 13:45:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:46 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 03/14] vicodec: pass on enc output format to capture side
Date:   Sat, 30 Mar 2019 13:43:01 -0700
Message-Id: <20190330204311.107417-4-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
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
2.17.1

