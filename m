Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF4BC282E2
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F52C218D2
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 08:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfDVIId (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:08:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfDVIIb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 04:08:31 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 10E33282449;
        Mon, 22 Apr 2019 09:08:28 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 11/15] rockchip/vpu: Prepare things to support decoders
Date:   Mon, 22 Apr 2019 10:08:14 +0200
Message-Id: <20190422080818.29130-12-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422080818.29130-1-boris.brezillon@collabora.com>
References: <20190422080818.29130-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The code in rockchip_vpu_v4l2 was hardcoded for encoder support.
Modify it more generic to support the decoder case so that we can
re-use the same vb2/v4l2 ops for both devices.

Co-developed-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes from v2:
* New patch
---
 .../staging/media/rockchip/vpu/rockchip_vpu.h |   6 +
 .../media/rockchip/vpu/rockchip_vpu_v4l2.c    | 504 ++++++++++--------
 2 files changed, 292 insertions(+), 218 deletions(-)

diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
index 1b2df7b84ffd..ce0fb185c5f8 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
@@ -252,4 +252,10 @@ static inline u32 vepu_read(struct rockchip_vpu_dev *vpu, u32 reg)
 	return val;
 }
 
+static inline bool
+rockchip_vpu_is_encoder_ctx(const struct rockchip_vpu_ctx *ctx)
+{
+	return true;
+}
+
 #endif /* ROCKCHIP_VPU_H_ */
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
index 832f3b015f1d..f5e47babfa90 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_v4l2.c
@@ -31,14 +31,23 @@
 #include "rockchip_vpu_v4l2.h"
 
 static const struct rockchip_vpu_fmt *
-rockchip_vpu_find_format(struct rockchip_vpu_ctx *ctx, u32 fourcc)
+rockchip_vpu_get_formats(const struct rockchip_vpu_ctx *ctx,
+			 unsigned int *num_fmts)
 {
-	struct rockchip_vpu_dev *dev = ctx->dev;
 	const struct rockchip_vpu_fmt *formats;
-	unsigned int num_fmts, i;
 
-	formats = dev->variant->enc_fmts;
-	num_fmts = dev->variant->num_enc_fmts;
+	formats = ctx->dev->variant->enc_fmts;
+	*num_fmts = ctx->dev->variant->num_enc_fmts;
+
+	return formats;
+}
+
+static const struct rockchip_vpu_fmt *
+rockchip_vpu_find_format(const struct rockchip_vpu_fmt *formats,
+			 unsigned int num_fmts, u32 fourcc)
+{
+	unsigned int i;
+
 	for (i = 0; i < num_fmts; i++)
 		if (formats[i].fourcc == fourcc)
 			return &formats[i];
@@ -46,14 +55,11 @@ rockchip_vpu_find_format(struct rockchip_vpu_ctx *ctx, u32 fourcc)
 }
 
 static const struct rockchip_vpu_fmt *
-rockchip_vpu_get_default_fmt(struct rockchip_vpu_ctx *ctx, bool bitstream)
+rockchip_vpu_get_default_fmt(const struct rockchip_vpu_fmt *formats,
+			     unsigned int num_fmts, bool bitstream)
 {
-	struct rockchip_vpu_dev *dev = ctx->dev;
-	const struct rockchip_vpu_fmt *formats;
-	unsigned int num_fmts, i;
+	unsigned int i;
 
-	formats = dev->variant->enc_fmts;
-	num_fmts = dev->variant->num_enc_fmts;
 	for (i = 0; i < num_fmts; i++) {
 		if (bitstream == (formats[i].codec_mode != RK_VPU_MODE_NONE))
 			return &formats[i];
@@ -64,10 +70,11 @@ rockchip_vpu_get_default_fmt(struct rockchip_vpu_ctx *ctx, bool bitstream)
 static int vidioc_querycap(struct file *file, void *priv,
 			   struct v4l2_capability *cap)
 {
+	struct video_device *vfd = video_devdata(file);
 	struct rockchip_vpu_dev *vpu = video_drvdata(file);
 
 	strscpy(cap->driver, vpu->dev->driver->name, sizeof(cap->driver));
-	strscpy(cap->card, vpu->vfd_enc->name, sizeof(cap->card));
+	strscpy(cap->card, vfd->name, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform: %s",
 		 vpu->dev->driver->name);
 	return 0;
@@ -77,7 +84,8 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 				  struct v4l2_frmsizeenum *fsize)
 {
 	struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
-	const struct rockchip_vpu_fmt *fmt;
+	const struct rockchip_vpu_fmt *formats, *fmt;
+	unsigned int num_fmts;
 
 	if (fsize->index != 0) {
 		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
@@ -85,7 +93,8 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	fmt = rockchip_vpu_find_format(ctx, fsize->pixel_format);
+	formats = rockchip_vpu_get_formats(ctx, &num_fmts);
+	fmt = rockchip_vpu_find_format(formats, num_fmts, fsize->pixel_format);
 	if (!fmt) {
 		vpu_debug(0, "unsupported bitstream format (%08x)\n",
 			  fsize->pixel_format);
@@ -102,19 +111,32 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 	return 0;
 }
 
-static int vidioc_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
-					  struct v4l2_fmtdesc *f)
-{
-	struct rockchip_vpu_dev *dev = video_drvdata(file);
-	const struct rockchip_vpu_fmt *fmt;
-	const struct rockchip_vpu_fmt *formats;
-	int num_fmts, i, j = 0;
+static int vidioc_enum_fmt(struct file *file, void *priv,
+			   struct v4l2_fmtdesc *f, bool capture)
 
-	formats = dev->variant->enc_fmts;
-	num_fmts = dev->variant->num_enc_fmts;
+{
+	struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
+	const struct rockchip_vpu_fmt *fmt, *formats;
+	unsigned int num_fmts, i, j = 0;
+	bool skip_mode_none;
+
+	/*
+	 * When dealing with an encoder:
+	 *  - on the capture side we want to filter out all MODE_NONE formats.
+	 *  - on the output side we want to filter out all formats that are
+	 *    not MODE_NONE.
+	 * When dealing with a decoder:
+	 *  - on the capture side we want to filter out all formats that are
+	 *    not MODE_NONE.
+	 *  - on the output side we want to filter out all MODE_NONE formats.
+	 */
+	skip_mode_none = capture == rockchip_vpu_is_encoder_ctx(ctx);
+
+	formats = rockchip_vpu_get_formats(ctx, &num_fmts);
 	for (i = 0; i < num_fmts; i++) {
-		/* Skip uncompressed formats */
-		if (formats[i].codec_mode == RK_VPU_MODE_NONE)
+		bool mode_none = formats[i].codec_mode == RK_VPU_MODE_NONE;
+
+		if (skip_mode_none == mode_none)
 			continue;
 		if (j == f->index) {
 			fmt = &formats[i];
@@ -126,27 +148,16 @@ static int vidioc_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
 	return -EINVAL;
 }
 
+static int vidioc_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
+					  struct v4l2_fmtdesc *f)
+{
+	return vidioc_enum_fmt(file, priv, f, true);
+}
+
 static int vidioc_enum_fmt_vid_out_mplane(struct file *file, void *priv,
 					  struct v4l2_fmtdesc *f)
 {
-	struct rockchip_vpu_dev *dev = video_drvdata(file);
-	const struct rockchip_vpu_fmt *formats;
-	const struct rockchip_vpu_fmt *fmt;
-	int num_fmts, i, j = 0;
-
-	formats = dev->variant->enc_fmts;
-	num_fmts = dev->variant->num_enc_fmts;
-	for (i = 0; i < num_fmts; i++) {
-		if (formats[i].codec_mode != RK_VPU_MODE_NONE)
-			continue;
-		if (j == f->index) {
-			fmt = &formats[i];
-			f->pixelformat = fmt->fourcc;
-			return 0;
-		}
-		++j;
-	}
-	return -EINVAL;
+	return vidioc_enum_fmt(file, priv, f, false);
 }
 
 static int vidioc_g_fmt_out_mplane(struct file *file, void *priv,
@@ -175,144 +186,150 @@ static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
 	return 0;
 }
 
-static int
-vidioc_try_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
+static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f,
+			  bool capture)
 {
 	struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
-	const struct rockchip_vpu_fmt *fmt;
+	const struct rockchip_vpu_fmt *formats, *fmt, *vpu_fmt;
+	unsigned int num_fmts;
+	bool coded;
 
-	vpu_debug(4, "%c%c%c%c\n",
+	coded = capture == rockchip_vpu_is_encoder_ctx(ctx);
+
+	vpu_debug(4, "trying format %c%c%c%c\n",
 		  (pix_mp->pixelformat & 0x7f),
 		  (pix_mp->pixelformat >> 8) & 0x7f,
 		  (pix_mp->pixelformat >> 16) & 0x7f,
 		  (pix_mp->pixelformat >> 24) & 0x7f);
 
-	fmt = rockchip_vpu_find_format(ctx, pix_mp->pixelformat);
+	formats = rockchip_vpu_get_formats(ctx, &num_fmts);
+	fmt = rockchip_vpu_find_format(formats, num_fmts, pix_mp->pixelformat);
 	if (!fmt) {
-		fmt = rockchip_vpu_get_default_fmt(ctx, true);
+		fmt = rockchip_vpu_get_default_fmt(formats, num_fmts, coded);
 		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 
-	pix_mp->num_planes = 1;
+	if (coded) {
+		pix_mp->num_planes = 1;
+		vpu_fmt = fmt;
+	} else if (rockchip_vpu_is_encoder_ctx(ctx)) {
+		vpu_fmt = ctx->vpu_dst_fmt;
+	} else {
+		vpu_fmt = ctx->vpu_src_fmt;
+	}
+
 	pix_mp->field = V4L2_FIELD_NONE;
 	pix_mp->width = clamp(pix_mp->width,
-			      fmt->frmsize.min_width,
-			      fmt->frmsize.max_width);
+			      vpu_fmt->frmsize.min_width,
+			      vpu_fmt->frmsize.max_width);
 	pix_mp->height = clamp(pix_mp->height,
-			       fmt->frmsize.min_height,
-			       fmt->frmsize.max_height);
-	/* Round up to macroblocks. */
-	pix_mp->width = round_up(pix_mp->width, fmt->frmsize.step_width);
-	pix_mp->height = round_up(pix_mp->height, fmt->frmsize.step_height);
+			       vpu_fmt->frmsize.min_height,
+			       vpu_fmt->frmsize.max_height);
 
-	/*
-	 * For compressed formats the application can specify
-	 * sizeimage. If the application passes a zero sizeimage,
-	 * let's default to the maximum frame size.
-	 */
-	if (!pix_mp->plane_fmt[0].sizeimage)
+	/* Round up to macroblocks. */
+	pix_mp->width = round_up(pix_mp->width, vpu_fmt->frmsize.step_width);
+	pix_mp->height = round_up(pix_mp->height, vpu_fmt->frmsize.step_height);
+
+	if (!coded) {
+		/* Fill remaining fields */
+		v4l2_fill_pixfmt_mp(pix_mp, fmt->fourcc, pix_mp->width,
+				    pix_mp->height);
+	} else if (!pix_mp->plane_fmt[0].sizeimage) {
+		/*
+		 * For coded formats the application can specify
+		 * sizeimage. If the application passes a zero sizeimage,
+		 * let's default to the maximum frame size.
+		 */
 		pix_mp->plane_fmt[0].sizeimage = fmt->header_size +
 			pix_mp->width * pix_mp->height * fmt->max_depth;
-	memset(pix_mp->plane_fmt[0].reserved, 0,
-	       sizeof(pix_mp->plane_fmt[0].reserved));
+	}
+
 	return 0;
 }
 
-static int
-vidioc_try_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
+static int vidioc_try_fmt_cap_mplane(struct file *file, void *priv,
+				     struct v4l2_format *f)
 {
-	struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
-	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
-	const struct rockchip_vpu_fmt *fmt;
-	unsigned int width, height;
-	int i;
-
-	vpu_debug(4, "%c%c%c%c\n",
-		  (pix_mp->pixelformat & 0x7f),
-		  (pix_mp->pixelformat >> 8) & 0x7f,
-		  (pix_mp->pixelformat >> 16) & 0x7f,
-		  (pix_mp->pixelformat >> 24) & 0x7f);
-
-	fmt = rockchip_vpu_find_format(ctx, pix_mp->pixelformat);
-	if (!fmt) {
-		fmt = rockchip_vpu_get_default_fmt(ctx, false);
-		f->fmt.pix.pixelformat = fmt->fourcc;
-	}
-
-	pix_mp->field = V4L2_FIELD_NONE;
-	width = clamp(pix_mp->width,
-		      ctx->vpu_dst_fmt->frmsize.min_width,
-		      ctx->vpu_dst_fmt->frmsize.max_width);
-	height = clamp(pix_mp->height,
-		       ctx->vpu_dst_fmt->frmsize.min_height,
-		       ctx->vpu_dst_fmt->frmsize.max_height);
-	/* Round up to macroblocks. */
-	width = round_up(width, ctx->vpu_dst_fmt->frmsize.step_width);
-	height = round_up(height, ctx->vpu_dst_fmt->frmsize.step_height);
-
-	/* Fill remaining fields */
-	v4l2_fill_pixfmt_mp(pix_mp, fmt->fourcc, width, height);
-
-	for (i = 0; i < pix_mp->num_planes; i++) {
-		memset(pix_mp->plane_fmt[i].reserved, 0,
-		       sizeof(pix_mp->plane_fmt[i].reserved));
-	}
-	return 0;
+	return vidioc_try_fmt(file, priv, f, true);
 }
 
-static void rockchip_vpu_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
-				       struct rockchip_vpu_ctx *ctx)
+static int vidioc_try_fmt_out_mplane(struct file *file, void *priv,
+				     struct v4l2_format *f)
 {
-	struct v4l2_pix_format_mplane *fmt = &ctx->dst_fmt;
-
-	ctx->vpu_dst_fmt = rockchip_vpu_get_default_fmt(ctx, true);
+	return vidioc_try_fmt(file, priv, f, false);
+}
 
+static void
+rockchip_vpu_reset_fmt(struct v4l2_pix_format_mplane *fmt,
+		       const struct rockchip_vpu_fmt *vpu_fmt)
+{
 	memset(fmt, 0, sizeof(*fmt));
 
+	fmt->pixelformat = vpu_fmt->fourcc;
+	fmt->field = V4L2_FIELD_NONE;
+	fmt->colorspace = V4L2_COLORSPACE_JPEG,
+	fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
+	fmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+}
+
+static void
+rockchip_vpu_reset_encoded_fmt(struct rockchip_vpu_ctx *ctx)
+{
+	const struct rockchip_vpu_fmt *vpu_fmt, *formats;
+	struct v4l2_pix_format_mplane *fmt;
+	unsigned int num_fmts;
+
+	formats = rockchip_vpu_get_formats(ctx, &num_fmts);
+	vpu_fmt = rockchip_vpu_get_default_fmt(formats, num_fmts, true);
+
+	if (rockchip_vpu_is_encoder_ctx(ctx)) {
+		ctx->vpu_dst_fmt = vpu_fmt;
+		fmt = &ctx->dst_fmt;
+	} else {
+		ctx->vpu_src_fmt = vpu_fmt;
+		fmt = &ctx->src_fmt;
+	}
+
+	rockchip_vpu_reset_fmt(fmt, vpu_fmt);
 	fmt->num_planes = 1;
-	fmt->width = clamp(fmt->width, ctx->vpu_dst_fmt->frmsize.min_width,
-			   ctx->vpu_dst_fmt->frmsize.max_width);
-	fmt->height = clamp(fmt->height, ctx->vpu_dst_fmt->frmsize.min_height,
-			    ctx->vpu_dst_fmt->frmsize.max_height);
-	fmt->pixelformat = ctx->vpu_dst_fmt->fourcc;
-	fmt->field = V4L2_FIELD_NONE;
-	fmt->colorspace = V4L2_COLORSPACE_JPEG,
-	fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
-	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
-	fmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
-
-	fmt->plane_fmt[0].sizeimage = ctx->vpu_dst_fmt->header_size +
-		fmt->width * fmt->height * ctx->vpu_dst_fmt->max_depth;
+	fmt->width = vpu_fmt->frmsize.min_width;
+	fmt->height = vpu_fmt->frmsize.min_height;
+	fmt->plane_fmt[0].sizeimage = vpu_fmt->header_size +
+				fmt->width * fmt->height * vpu_fmt->max_depth;
 }
 
-static void rockchip_vpu_reset_src_fmt(struct rockchip_vpu_dev *vpu,
-				       struct rockchip_vpu_ctx *ctx)
+static void
+rockchip_vpu_reset_raw_fmt(struct rockchip_vpu_ctx *ctx)
 {
-	struct v4l2_pix_format_mplane *fmt = &ctx->src_fmt;
-	unsigned int width, height;
+	const struct rockchip_vpu_fmt *raw_vpu_fmt, *encoded_vpu_fmt, *formats;
+	struct v4l2_pix_format_mplane *fmt;
+	unsigned int num_fmts;
 
-	ctx->vpu_src_fmt = rockchip_vpu_get_default_fmt(ctx, false);
+	formats = rockchip_vpu_get_formats(ctx, &num_fmts);
+	raw_vpu_fmt = rockchip_vpu_get_default_fmt(formats, num_fmts, false);
 
-	memset(fmt, 0, sizeof(*fmt));
+	if (rockchip_vpu_is_encoder_ctx(ctx)) {
+		ctx->vpu_src_fmt = raw_vpu_fmt;
+		fmt = &ctx->src_fmt;
+		encoded_vpu_fmt = ctx->vpu_dst_fmt;
+	} else {
+		ctx->vpu_dst_fmt = raw_vpu_fmt;
+		fmt = &ctx->dst_fmt;
+		encoded_vpu_fmt = ctx->vpu_src_fmt;
+	}
 
-	width = clamp(fmt->width, ctx->vpu_dst_fmt->frmsize.min_width,
-		      ctx->vpu_dst_fmt->frmsize.max_width);
-	height = clamp(fmt->height, ctx->vpu_dst_fmt->frmsize.min_height,
-		       ctx->vpu_dst_fmt->frmsize.max_height);
-	fmt->field = V4L2_FIELD_NONE;
-	fmt->colorspace = V4L2_COLORSPACE_JPEG,
-	fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
-	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
-	fmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
-
-	v4l2_fill_pixfmt_mp(fmt, ctx->vpu_src_fmt->fourcc, width, height);
+	rockchip_vpu_reset_fmt(fmt, raw_vpu_fmt);
+	v4l2_fill_pixfmt_mp(fmt, raw_vpu_fmt->fourcc,
+			    encoded_vpu_fmt->frmsize.min_width,
+			    encoded_vpu_fmt->frmsize.min_height);
 }
 
 void rockchip_vpu_reset_fmts(struct rockchip_vpu_ctx *ctx)
 {
-	rockchip_vpu_reset_dst_fmt(ctx->dev, ctx);
-	rockchip_vpu_reset_src_fmt(ctx->dev, ctx);
+	rockchip_vpu_reset_encoded_fmt(ctx);
+	rockchip_vpu_reset_raw_fmt(ctx);
 }
 
 static int
@@ -320,6 +337,8 @@ vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
+	const struct rockchip_vpu_fmt *formats;
+	unsigned int num_fmts;
 	struct vb2_queue *vq;
 	int ret;
 
@@ -328,20 +347,40 @@ vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	if (vb2_is_streaming(vq))
 		return -EBUSY;
 
+	if (!rockchip_vpu_is_encoder_ctx(ctx)) {
+		struct vb2_queue *peer_vq;
+
+		/*
+		 * Since format change on the CAPTURE queue will reset
+		 * the OUTPUT queue, we can't allow doing so
+		 * when the OUTPUT queue has buffers allocated.
+		 */
+		peer_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+					  V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+		if (vb2_is_busy(peer_vq))
+			return -EBUSY;
+	}
+
 	ret = vidioc_try_fmt_out_mplane(file, priv, f);
 	if (ret)
 		return ret;
 
-	ctx->vpu_src_fmt = rockchip_vpu_find_format(ctx, pix_mp->pixelformat);
+	formats = rockchip_vpu_get_formats(ctx, &num_fmts);
+	ctx->vpu_src_fmt = rockchip_vpu_find_format(formats, num_fmts,
+						    pix_mp->pixelformat);
 	ctx->src_fmt = *pix_mp;
 
-	/* Propagate to the CAPTURE format */
-	ctx->dst_fmt.colorspace = pix_mp->colorspace;
-	ctx->dst_fmt.ycbcr_enc = pix_mp->ycbcr_enc;
-	ctx->dst_fmt.xfer_func = pix_mp->xfer_func;
-	ctx->dst_fmt.quantization = pix_mp->quantization;
-	ctx->dst_fmt.width = pix_mp->width;
-	ctx->dst_fmt.height = pix_mp->height;
+	if (rockchip_vpu_is_encoder_ctx(ctx)) {
+		/* Propagate to the CAPTURE format */
+		ctx->dst_fmt.colorspace = pix_mp->colorspace;
+		ctx->dst_fmt.ycbcr_enc = pix_mp->ycbcr_enc;
+		ctx->dst_fmt.xfer_func = pix_mp->xfer_func;
+		ctx->dst_fmt.quantization = pix_mp->quantization;
+		ctx->dst_fmt.width = pix_mp->width;
+		ctx->dst_fmt.height = pix_mp->height;
+	} else {
+		rockchip_vpu_reset_raw_fmt(ctx);
+	}
 
 	vpu_debug(0, "OUTPUT codec mode: %d\n", ctx->vpu_src_fmt->codec_mode);
 	vpu_debug(0, "fmt - w: %d, h: %d\n",
@@ -349,13 +388,14 @@ vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	return 0;
 }
 
-static int
-vidioc_s_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
+static int vidioc_s_fmt_cap_mplane(struct file *file, void *priv,
+				   struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
-	struct rockchip_vpu_dev *vpu = ctx->dev;
-	struct vb2_queue *vq, *peer_vq;
+	const struct rockchip_vpu_fmt *formats;
+	struct vb2_queue *vq;
+	unsigned int num_fmts;
 	int ret;
 
 	/* Change not allowed if queue is streaming. */
@@ -363,24 +403,30 @@ vidioc_s_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	if (vb2_is_streaming(vq))
 		return -EBUSY;
 
-	/*
-	 * Since format change on the CAPTURE queue will reset
-	 * the OUTPUT queue, we can't allow doing so
-	 * when the OUTPUT queue has buffers allocated.
-	 */
-	peer_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-				  V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
-	if (vb2_is_busy(peer_vq) &&
-	    (pix_mp->pixelformat != ctx->dst_fmt.pixelformat ||
-	     pix_mp->height != ctx->dst_fmt.height ||
-	     pix_mp->width != ctx->dst_fmt.width))
-		return -EBUSY;
+	if (rockchip_vpu_is_encoder_ctx(ctx)) {
+		struct vb2_queue *peer_vq;
+
+		/*
+		 * Since format change on the CAPTURE queue will reset
+		 * the OUTPUT queue, we can't allow doing so
+		 * when the OUTPUT queue has buffers allocated.
+		 */
+		peer_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+					  V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
+		if (vb2_is_busy(peer_vq) &&
+		    (pix_mp->pixelformat != ctx->dst_fmt.pixelformat ||
+		     pix_mp->height != ctx->dst_fmt.height ||
+		     pix_mp->width != ctx->dst_fmt.width))
+			return -EBUSY;
+	}
 
 	ret = vidioc_try_fmt_cap_mplane(file, priv, f);
 	if (ret)
 		return ret;
 
-	ctx->vpu_dst_fmt = rockchip_vpu_find_format(ctx, pix_mp->pixelformat);
+	formats = rockchip_vpu_get_formats(ctx, &num_fmts);
+	ctx->vpu_dst_fmt = rockchip_vpu_find_format(formats, num_fmts,
+						    pix_mp->pixelformat);
 	ctx->dst_fmt = *pix_mp;
 
 	vpu_debug(0, "CAPTURE codec mode: %d\n", ctx->vpu_dst_fmt->codec_mode);
@@ -394,7 +440,18 @@ vidioc_s_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	 * the raw format again after we return, so we don't need
 	 * anything smarter.
 	 */
-	rockchip_vpu_reset_src_fmt(vpu, ctx);
+	if (rockchip_vpu_is_encoder_ctx(ctx)) {
+		rockchip_vpu_reset_raw_fmt(ctx);
+	} else {
+		/* Propagate to the OUTPUT format */
+		ctx->src_fmt.colorspace = pix_mp->colorspace;
+		ctx->src_fmt.ycbcr_enc = pix_mp->ycbcr_enc;
+		ctx->src_fmt.xfer_func = pix_mp->xfer_func;
+		ctx->src_fmt.quantization = pix_mp->quantization;
+		ctx->src_fmt.width = pix_mp->width;
+		ctx->src_fmt.height = pix_mp->height;
+	}
+
 	return 0;
 }
 
@@ -464,48 +521,37 @@ rockchip_vpu_queue_setup(struct vb2_queue *vq,
 	return 0;
 }
 
-static int rockchip_vpu_buf_prepare(struct vb2_buffer *vb)
+static int
+rockchip_vpu_buf_plane_check(struct vb2_buffer *vb,
+			     const struct rockchip_vpu_fmt *vpu_fmt,
+			     struct v4l2_pix_format_mplane *pixfmt)
 {
-	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
-	struct vb2_queue *vq = vb->vb2_queue;
-	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vq);
-	struct v4l2_pix_format_mplane *pixfmt;
 	unsigned int sz;
-	int ret = 0;
 	int i;
 
-	switch (vq->type) {
-	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
-		pixfmt = &ctx->dst_fmt;
-		break;
-	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		pixfmt = &ctx->src_fmt;
-
-		if (vbuf->field == V4L2_FIELD_ANY)
-			vbuf->field = V4L2_FIELD_NONE;
-		if (vbuf->field != V4L2_FIELD_NONE) {
-			vpu_debug(4, "field %d not supported\n",
-				  vbuf->field);
-			return -EINVAL;
-		}
-		break;
-	default:
-		vpu_err("invalid queue type: %d\n", vq->type);
-		return -EINVAL;
-	}
-
 	for (i = 0; i < pixfmt->num_planes; ++i) {
 		sz = pixfmt->plane_fmt[i].sizeimage;
 		vpu_debug(4, "plane %d size: %ld, sizeimage: %u\n",
 			  i, vb2_plane_size(vb, i), sz);
 		if (vb2_plane_size(vb, i) < sz) {
-			vpu_err("plane %d is too small\n", i);
-			ret = -EINVAL;
-			break;
+			vpu_err("plane %d is too small for output\n", i);
+			return -EINVAL;
 		}
 	}
+	return 0;
+}
 
-	return ret;
+static int rockchip_vpu_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_queue *vq = vb->vb2_queue;
+	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vq);
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type))
+		return rockchip_vpu_buf_plane_check(vb, ctx->vpu_src_fmt,
+						    &ctx->src_fmt);
+
+	return rockchip_vpu_buf_plane_check(vb, ctx->vpu_dst_fmt,
+					    &ctx->dst_fmt);
 }
 
 static void rockchip_vpu_buf_queue(struct vb2_buffer *vb)
@@ -516,10 +562,17 @@ static void rockchip_vpu_buf_queue(struct vb2_buffer *vb)
 	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
 }
 
-static int rockchip_vpu_start_streaming(struct vb2_queue *q, unsigned int count)
+static bool rockchip_vpu_vq_is_coded(struct vb2_queue *q)
+{
+	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(q);
+
+	return rockchip_vpu_is_encoder_ctx(ctx) != V4L2_TYPE_IS_OUTPUT(q->type);
+}
+
+static int rockchip_vpu_start_streaming(struct vb2_queue *q,
+					unsigned int count)
 {
 	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(q);
-	enum rockchip_vpu_codec_mode codec_mode;
 	int ret = 0;
 
 	if (V4L2_TYPE_IS_OUTPUT(q->type))
@@ -527,38 +580,33 @@ static int rockchip_vpu_start_streaming(struct vb2_queue *q, unsigned int count)
 	else
 		ctx->sequence_cap = 0;
 
-	/* Set codec_ops for the chosen destination format */
-	codec_mode = ctx->vpu_dst_fmt->codec_mode;
+	if (rockchip_vpu_vq_is_coded(q)) {
+		enum rockchip_vpu_codec_mode codec_mode;
 
-	vpu_debug(4, "Codec mode = %d\n", codec_mode);
-	ctx->codec_ops = &ctx->dev->variant->codec_ops[codec_mode];
+		if (V4L2_TYPE_IS_OUTPUT(q->type))
+			codec_mode = ctx->vpu_src_fmt->codec_mode;
+		else
+			codec_mode = ctx->vpu_dst_fmt->codec_mode;
 
-	if (!V4L2_TYPE_IS_OUTPUT(q->type))
+		vpu_debug(4, "Codec mode = %d\n", codec_mode);
+		ctx->codec_ops = &ctx->dev->variant->codec_ops[codec_mode];
 		if (ctx->codec_ops && ctx->codec_ops->init)
 			ret = ctx->codec_ops->init(ctx);
+	}
+
 	return ret;
 }
 
-static void rockchip_vpu_stop_streaming(struct vb2_queue *q)
+static void
+rockchip_vpu_return_bufs(struct vb2_queue *q,
+			 struct vb2_v4l2_buffer *(*buf_remove)(struct v4l2_m2m_ctx *))
 {
 	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(q);
 
-	if (!V4L2_TYPE_IS_OUTPUT(q->type))
-		if (ctx->codec_ops && ctx->codec_ops->exit)
-			ctx->codec_ops->exit(ctx);
-
-	/*
-	 * The mem2mem framework calls v4l2_m2m_cancel_job before
-	 * .stop_streaming, so there isn't any job running and
-	 * it is safe to return all the buffers.
-	 */
 	for (;;) {
 		struct vb2_v4l2_buffer *vbuf;
 
-		if (V4L2_TYPE_IS_OUTPUT(q->type))
-			vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-		else
-			vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+		vbuf = buf_remove(ctx->fh.m2m_ctx);
 		if (!vbuf)
 			break;
 		v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
@@ -567,6 +615,26 @@ static void rockchip_vpu_stop_streaming(struct vb2_queue *q)
 	}
 }
 
+static void rockchip_vpu_stop_streaming(struct vb2_queue *q)
+{
+	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(q);
+
+	if (rockchip_vpu_vq_is_coded(q)) {
+		if (ctx->codec_ops && ctx->codec_ops->exit)
+			ctx->codec_ops->exit(ctx);
+	}
+
+	/*
+	 * The mem2mem framework calls v4l2_m2m_cancel_job before
+	 * .stop_streaming, so there isn't any job running and
+	 * it is safe to return all the buffers.
+	 */
+	if (V4L2_TYPE_IS_OUTPUT(q->type))
+		rockchip_vpu_return_bufs(q, v4l2_m2m_src_buf_remove);
+	else
+		rockchip_vpu_return_bufs(q, v4l2_m2m_dst_buf_remove);
+}
+
 static void rockchip_vpu_buf_request_complete(struct vb2_buffer *vb)
 {
 	struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
-- 
2.20.1

