Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E677C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2DD20700
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfC1SIR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:08:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54162 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfC1SIQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 14:08:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 8399E282280
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v3 2/2] media: Introduce helpers to fill pixel format structs
Date:   Thu, 28 Mar 2019 15:07:04 -0300
Message-Id: <20190328180704.24761-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328180704.24761-1-ezequiel@collabora.com>
References: <20190328180704.24761-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add two new API helpers, v4l2_fill_pixfmt and v4l2_fill_pixfmt_mp,
to be used by drivers to calculate plane sizes and bytes per lines.

Note that driver-specific padding and alignment are not
taken into account, and must be done by drivers using this API.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 164 ++++++++++++++++++++++++++
 include/media/v4l2-common.h           |  33 ++++++
 2 files changed, 197 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 663730f088cd..d869a2910435 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -445,3 +445,167 @@ int v4l2_s_parm_cap(struct video_device *vdev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(v4l2_s_parm_cap);
+
+const struct v4l2_format_info *v4l2_format_info(u32 format)
+{
+	static const struct v4l2_format_info formats[] = {
+		/* RGB formats */
+		{ .format = V4L2_PIX_FMT_BGR24,   .mem_planes = 1, .comp_planes = 1, .bpp = { 3, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_RGB24,   .mem_planes = 1, .comp_planes = 1, .bpp = { 3, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_HSV24,   .mem_planes = 1, .comp_planes = 1, .bpp = { 3, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_BGR32,   .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_XBGR32,  .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_RGB32,   .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_XRGB32,  .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_HSV32,   .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_ARGB32,  .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_ABGR32,  .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_GREY,    .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+
+		/* YUV packed formats */
+		{ .format = V4L2_PIX_FMT_YUYV,    .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YVYU,    .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_UYVY,    .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_VYUY,    .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+
+		/* YUV planar formats */
+		{ .format = V4L2_PIX_FMT_NV12,    .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_NV21,    .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_NV16,    .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_NV61,    .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_NV24,    .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_NV42,    .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+
+		{ .format = V4L2_PIX_FMT_YUV410,  .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
+		{ .format = V4L2_PIX_FMT_YVU410,  .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
+		{ .format = V4L2_PIX_FMT_YUV411P, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YUV420,  .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_YVU420,  .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_YUV422P, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 1 },
+
+		/* YUV planar formats, non contiguous variant */
+		{ .format = V4L2_PIX_FMT_YUV420M, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_YVU420M, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_YUV422M, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YVU422M, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YUV444M, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YVU444M, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 1, .vdiv = 1 },
+
+		{ .format = V4L2_PIX_FMT_NV12M,   .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_NV21M,   .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_NV16M,   .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_NV61M,   .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); ++i)
+		if (formats[i].format == format)
+			return &formats[i];
+	return NULL;
+}
+EXPORT_SYMBOL(v4l2_format_info);
+
+static inline unsigned int v4l2_format_block_width(const struct v4l2_format_info *info, int plane)
+{
+	if (!info->block_w[plane])
+		return 1;
+	return info->block_w[plane];
+}
+
+static inline unsigned int v4l2_format_block_height(const struct v4l2_format_info *info, int plane)
+{
+	if (!info->block_h[plane])
+		return 1;
+	return info->block_h[plane];
+}
+
+int v4l2_fill_pixfmt_mp(struct v4l2_pix_format_mplane *pixfmt,
+			 int pixelformat, int width, int height)
+{
+	const struct v4l2_format_info *info;
+	struct v4l2_plane_pix_format *plane;
+	int i;
+
+	info = v4l2_format_info(pixelformat);
+	if (!info)
+		return -EINVAL;
+
+	pixfmt->width = width;
+	pixfmt->height = height;
+	pixfmt->pixelformat = pixelformat;
+	pixfmt->num_planes = info->mem_planes;
+
+	if (info->mem_planes == 1) {
+		plane = &pixfmt->plane_fmt[0];
+		plane->bytesperline = ALIGN(width, v4l2_format_block_width(info, 0)) * info->bpp[0];
+		plane->sizeimage = 0;
+
+		for (i = 0; i < info->comp_planes; i++) {
+			unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
+			unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
+			unsigned int aligned_width;
+			unsigned int aligned_height;
+
+			aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
+			aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
+
+			plane->sizeimage += info->bpp[i] *
+				DIV_ROUND_UP(aligned_width, hdiv) *
+				DIV_ROUND_UP(aligned_height, vdiv);
+		}
+	} else {
+		for (i = 0; i < info->comp_planes; i++) {
+			unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
+			unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
+			unsigned int aligned_width;
+			unsigned int aligned_height;
+
+			aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
+			aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
+
+			plane = &pixfmt->plane_fmt[i];
+			plane->bytesperline =
+				info->bpp[i] * DIV_ROUND_UP(aligned_width, hdiv);
+			plane->sizeimage =
+				plane->bytesperline * DIV_ROUND_UP(aligned_height, vdiv);
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(v4l2_fill_pixfmt_mp);
+
+int v4l2_fill_pixfmt(struct v4l2_pix_format *pixfmt, int pixelformat, int width, int height)
+{
+	const struct v4l2_format_info *info;
+	int i;
+
+	info = v4l2_format_info(pixelformat);
+	if (!info)
+		return -EINVAL;
+
+	/* Single planar API cannot be used for multi plane formats. */
+	if (info->mem_planes > 1)
+		return -EINVAL;
+
+	pixfmt->width = width;
+	pixfmt->height = height;
+	pixfmt->pixelformat = pixelformat;
+	pixfmt->bytesperline = ALIGN(width, v4l2_format_block_width(info, 0)) * info->bpp[0];
+	pixfmt->sizeimage = 0;
+
+	for (i = 0; i < info->comp_planes; i++) {
+		unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
+		unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
+		unsigned int aligned_width;
+		unsigned int aligned_height;
+
+		aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
+		aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
+
+		pixfmt->sizeimage += info->bpp[i] *
+			DIV_ROUND_UP(aligned_width, hdiv) *
+			DIV_ROUND_UP(aligned_height, vdiv);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(v4l2_fill_pixfmt);
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index 2b93cb281fa5..0a41bbecf3d3 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -392,4 +392,37 @@ int v4l2_s_parm_cap(struct video_device *vdev,
 	((u64)(a).numerator * (b).denominator OP	\
 	(u64)(b).numerator * (a).denominator)
 
+/* ------------------------------------------------------------------------- */
+
+/* Pixel format and FourCC helpers */
+
+/**
+ * struct v4l2_format_info - information about a V4L2 format
+ * @format: 4CC format identifier (V4L2_PIX_FMT_*)
+ * @mem_planes: Number of memory planes, which includes the alpha plane (1 to 4).
+ * @comp_planes: Number of component planes, which includes the alpha plane (1 to 4).
+ * @bpp: Array of per-plane bytes per pixel
+ * @hdiv: Horizontal chroma subsampling factor
+ * @vdiv: Vertical chroma subsampling factor
+ * @block_w: Per-plane macroblock pixel width (optional)
+ * @block_h: Per-plane macroblock pixel height (optional)
+ */
+struct v4l2_format_info {
+	u32 format;
+	u8 mem_planes;
+	u8 comp_planes;
+	u8 bpp[4];
+	u8 hdiv;
+	u8 vdiv;
+	u8 block_w[4];
+	u8 block_h[4];
+};
+
+const struct v4l2_format_info *v4l2_format_info(u32 format);
+
+int v4l2_fill_pixfmt(struct v4l2_pix_format *pixfmt, int pixelformat,
+		     int width, int height);
+int v4l2_fill_pixfmt_mp(struct v4l2_pix_format_mplane *pixfmt, int pixelformat,
+			int width, int height);
+
 #endif /* V4L2_COMMON_H_ */
-- 
2.20.1

