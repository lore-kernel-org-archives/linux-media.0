Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C6FC10F14
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA83214C6
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDHMdL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:33:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45191 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDHMdK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:33:10 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDTSW-00005P-FG; Mon, 08 Apr 2019 14:33:08 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 07/10] media: coda: limit frame interval enumeration to supported frame sizes
Date:   Mon,  8 Apr 2019 14:32:53 +0200
Message-Id: <20190408123256.22868-7-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408123256.22868-1-p.zabel@pengutronix.de>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
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

Let VIDIOC_ENUM_FRAMEINTERVALS return -EINVAL if userspace queries
frame intervals for unsupported frame sizes.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 33 ++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 943f003c26c4..2966eb1c4d2d 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1117,7 +1117,8 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
 				    struct v4l2_frmivalenum *f)
 {
 	struct coda_ctx *ctx = fh_to_ctx(fh);
-	int i;
+	struct coda_q_data *q_data;
+	const struct coda_codec *codec;
 
 	if (f->index)
 		return -EINVAL;
@@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
 	if (!ctx->vdoa && f->pixel_format == V4L2_PIX_FMT_YUYV)
 		return -EINVAL;
 
-	for (i = 0; i < CODA_MAX_FORMATS; i++) {
-		if (f->pixel_format == ctx->cvd->src_formats[i] ||
-		    f->pixel_format == ctx->cvd->dst_formats[i])
-			break;
+	if (ctx->inst_type == CODA_INST_ENCODER) {
+		if (coda_format_normalize_yuv(f->pixel_format) ==
+		    V4L2_PIX_FMT_YUV420) {
+			q_data = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+			codec = coda_find_codec(ctx->dev, f->pixel_format,
+						q_data->fourcc);
+		} else {
+			codec = coda_find_codec(ctx->dev, V4L2_PIX_FMT_YUV420,
+						f->pixel_format);
+		}
+	} else {
+		if (coda_format_normalize_yuv(f->pixel_format) ==
+		    V4L2_PIX_FMT_YUV420) {
+			q_data = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
+			codec = coda_find_codec(ctx->dev, q_data->fourcc,
+						f->pixel_format);
+		} else {
+			codec = coda_find_codec(ctx->dev, f->pixel_format,
+						V4L2_PIX_FMT_YUV420);
+		}
 	}
-	if (i == CODA_MAX_FORMATS)
+	if (!codec)
+		return -EINVAL;
+
+	if (f->width < MIN_W || f->width > codec->max_w ||
+	    f->height < MIN_H || f->height > codec->max_h)
 		return -EINVAL;
 
 	f->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
-- 
2.20.1

