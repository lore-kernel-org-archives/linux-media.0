Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F1C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF5D214C6
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDHMdL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:33:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38469 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfDHMdK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:33:10 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDTSW-00005P-EL; Mon, 08 Apr 2019 14:33:08 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 06/10] media: coda: implement encoder frame size enumeration
Date:   Mon,  8 Apr 2019 14:32:52 +0200
Message-Id: <20190408123256.22868-6-p.zabel@pengutronix.de>
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

The stateful encoder API requires VIDIOC_ENUM_FRAMESIZES to be
implemented.
Allow enumeration of supported frame sizes for encoding.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index c0421f06ca48..943f003c26c4 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1077,6 +1077,42 @@ static int coda_decoder_cmd(struct file *file, void *fh,
 	return 0;
 }
 
+static int coda_enum_framesizes(struct file *file, void *fh,
+				struct v4l2_frmsizeenum *fsize)
+{
+	struct coda_ctx *ctx = fh_to_ctx(fh);
+	struct coda_q_data *q_data_dst;
+	const struct coda_codec *codec;
+
+	if (ctx->inst_type != CODA_INST_ENCODER)
+		return -ENOTTY;
+
+	if (fsize->index)
+		return -EINVAL;
+
+	if (coda_format_normalize_yuv(fsize->pixel_format) ==
+	    V4L2_PIX_FMT_YUV420) {
+		q_data_dst = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+		codec = coda_find_codec(ctx->dev, fsize->pixel_format,
+					q_data_dst->fourcc);
+	} else {
+		codec = coda_find_codec(ctx->dev, V4L2_PIX_FMT_YUV420,
+					fsize->pixel_format);
+	}
+	if (!codec)
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+	fsize->stepwise.min_width = MIN_W;
+	fsize->stepwise.max_width = codec->max_w;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.min_height = MIN_H;
+	fsize->stepwise.max_height = codec->max_h;
+	fsize->stepwise.step_height = 1;
+
+	return 0;
+}
+
 static int coda_enum_frameintervals(struct file *file, void *fh,
 				    struct v4l2_frmivalenum *f)
 {
@@ -1255,6 +1291,7 @@ static const struct v4l2_ioctl_ops coda_ioctl_ops = {
 	.vidioc_g_parm		= coda_g_parm,
 	.vidioc_s_parm		= coda_s_parm,
 
+	.vidioc_enum_framesizes	= coda_enum_framesizes,
 	.vidioc_enum_frameintervals = coda_enum_frameintervals,
 
 	.vidioc_subscribe_event = coda_subscribe_event,
-- 
2.20.1

