Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5DEC43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2836820869
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 19:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfDZTwH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:52:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTwH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 15:52:07 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:9080:61b7:f4a4:2020:fc95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C8267272EC0;
        Fri, 26 Apr 2019 20:52:01 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 05/14] media: vimc: cap: refactor singleplanar as a subset of multiplanar
Date:   Fri, 26 Apr 2019 16:51:05 -0300
Message-Id: <20190426195114.5002-6-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426195114.5002-1-andrealmeid@collabora.com>
References: <20190426195114.5002-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Since multiplanar is a superset of single planar formats, instead of
having different implementations for them, treat all formats as
multiplanar. If we need to work with single planar formats, convert them to
multiplanar (with num_planes = 1), re-use the multiplanar code, and
transform them back to single planar. This is implemented with
v4l2_fmt_sp2mp_func().

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
---
Changes in v5: none

Changes in v4:
- Add comment that was in wrong commit
- Check the return of try_fmt function

Changes in v3:
- Commit title renamed
- Get rid of `if (IS_MULTIPLANAR(vcap))` checks and functions to do this
check

Changes in v2:
- Make more clear that the generic function _vimc_cap_try_fmt_vid_cap_mp
expects a multiplanar format as input 

 drivers/media/platform/vimc/vimc-capture.c | 57 ++++++++++++++--------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index ae703c52d3f8..fa0d75eb06e8 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -118,6 +118,9 @@ static void vimc_cap_get_format(struct vimc_ent_device *ved,
 	*fmt = vcap->format.fmt.pix;
 }
 
+/*
+ * Functions to handle both single- and multi-planar VIDIOC FMT
+ */
 static int vimc_cap_g_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
@@ -128,10 +131,10 @@ static int vimc_cap_g_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
-static int vimc_cap_try_fmt_vid_cap(struct file *file, void *priv,
-				    struct v4l2_format *f)
+static int vimc_cap_try_fmt_vid_cap_mp(struct file *file, void *priv,
+				       struct v4l2_format *f)
 {
-	struct v4l2_pix_format *format = &f->fmt.pix;
+	struct v4l2_pix_format_mplane *format = &f->fmt.pix_mp;
 
 	format->width = clamp_t(u32, format->width, VIMC_FRAME_MIN_WIDTH,
 				VIMC_FRAME_MAX_WIDTH) & ~1;
@@ -149,20 +152,43 @@ static int vimc_cap_try_fmt_vid_cap(struct file *file, void *priv,
 	if (!v4l2_format_info(format->pixelformat))
 		format->pixelformat = fmt_default.fmt.pix.pixelformat;
 
-	return v4l2_fill_pixfmt(format, format->pixelformat,
-				format->width, format->height);
+	return v4l2_fill_pixfmt_mp(format, format->pixelformat,
+				   format->width, format->height);
 }
 
-static int vimc_cap_s_fmt_vid_cap(struct file *file, void *priv,
-				  struct v4l2_format *f)
+static int vimc_cap_enum_fmt_vid_cap(struct file *file, void *priv,
+				     struct v4l2_fmtdesc *f)
+{
+	if (f->index >= ARRAY_SIZE(vimc_cap_supported_pixfmt))
+		return -EINVAL;
+
+	f->pixelformat = vimc_cap_supported_pixfmt[f->index];
+
+	return 0;
+}
+
+/*
+ * VIDIOC FMT handlers for single-planar
+ */
+static int vimc_cap_try_fmt_vid_cap_sp(struct file *file, void *priv,
+				       struct v4l2_format *f)
+{
+	return v4l2_fmt_sp2mp_func(file, priv, f, vimc_cap_try_fmt_vid_cap_mp);
+}
+
+static int vimc_cap_s_fmt_vid_cap_sp(struct file *file, void *priv,
+				     struct v4l2_format *f)
 {
 	struct vimc_cap_device *vcap = video_drvdata(file);
+	int ret;
 
 	/* Do not change the format while stream is on */
 	if (vb2_is_busy(&vcap->queue))
 		return -EBUSY;
 
-	vimc_cap_try_fmt_vid_cap(file, priv, f);
+	ret = v4l2_fmt_sp2mp_func(file, priv, f, vimc_cap_try_fmt_vid_cap_mp);
+	if (ret)
+		return ret;
 
 	dev_dbg(vcap->dev, "%s: format update: "
 		"old:%dx%d (0x%x, %d, %d, %d, %d) "
@@ -185,17 +211,6 @@ static int vimc_cap_s_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
-static int vimc_cap_enum_fmt_vid_cap(struct file *file, void *priv,
-				     struct v4l2_fmtdesc *f)
-{
-	if (f->index >= ARRAY_SIZE(vimc_cap_supported_pixfmt))
-		return -EINVAL;
-
-	f->pixelformat = vimc_cap_supported_pixfmt[f->index];
-
-	return 0;
-}
-
 static bool vimc_cap_is_pixfmt_supported(u32 pixelformat)
 {
 	unsigned int i;
@@ -240,8 +255,8 @@ static const struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
 	.vidioc_querycap = vimc_cap_querycap,
 
 	.vidioc_g_fmt_vid_cap = vimc_cap_g_fmt_vid_cap,
-	.vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap,
-	.vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap_sp,
+	.vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap_sp,
 	.vidioc_enum_fmt_vid_cap = vimc_cap_enum_fmt_vid_cap,
 	.vidioc_enum_framesizes = vimc_cap_enum_framesizes,
 
-- 
2.21.0

