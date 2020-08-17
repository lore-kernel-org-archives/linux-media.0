Return-Path: <SRS0=xaSx=B3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1BBC433DF
	for <linux-media@archiver.kernel.org>; Mon, 17 Aug 2020 14:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32D520729
	for <linux-media@archiver.kernel.org>; Mon, 17 Aug 2020 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgHQOcP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:32:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50277 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgHQOcO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Aug 2020 10:32:14 -0400
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 83DC1C0005;
        Mon, 17 Aug 2020 14:32:10 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        sakari.ailus@iki.fi, hverkuil@xs4all.nl, hyunk@xilinx.com,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH 3/4] media: i2c: max9286: Do not allow changing format
Date:   Mon, 17 Aug 2020 16:35:39 +0200
Message-Id: <20200817143540.247340-4-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817143540.247340-1-jacopo+renesas@jmondi.org>
References: <20200817143540.247340-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As the MAX9286 chip does not allow changing the format of the video
stream, always return the format retrieived from the remote subdevices
when an attempt to change it is made.

The -max9286_get_pad_format() format is now unsued, so remove it.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/max9286.c | 58 +++++++------------------------------
 1 file changed, 10 insertions(+), 48 deletions(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index e6a70dbd27df..a4e23396c4b6 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -689,54 +689,6 @@ static int max9286_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static struct v4l2_mbus_framefmt *
-max9286_get_pad_format(struct max9286_priv *priv,
-		       struct v4l2_subdev_pad_config *cfg,
-		       unsigned int pad, u32 which)
-{
-	switch (which) {
-	case V4L2_SUBDEV_FORMAT_TRY:
-		return v4l2_subdev_get_try_format(&priv->sd, cfg, pad);
-	case V4L2_SUBDEV_FORMAT_ACTIVE:
-		return &priv->fmt[pad];
-	default:
-		return NULL;
-	}
-}
-
-static int max9286_set_fmt(struct v4l2_subdev *sd,
-			   struct v4l2_subdev_pad_config *cfg,
-			   struct v4l2_subdev_format *format)
-{
-	struct max9286_priv *priv = sd_to_max9286(sd);
-	struct v4l2_mbus_framefmt *cfg_fmt;
-
-	if (format->pad == MAX9286_SRC_PAD)
-		return -EINVAL;
-
-	/* Refuse non YUV422 formats as we hardcode DT to 8 bit YUV422 */
-	switch (format->format.code) {
-	case MEDIA_BUS_FMT_UYVY8_1X16:
-	case MEDIA_BUS_FMT_VYUY8_1X16:
-	case MEDIA_BUS_FMT_YUYV8_1X16:
-	case MEDIA_BUS_FMT_YVYU8_1X16:
-		break;
-	default:
-		format->format.code = MEDIA_BUS_FMT_UYVY8_1X16;
-		break;
-	}
-
-	cfg_fmt = max9286_get_pad_format(priv, cfg, format->pad, format->which);
-	if (!cfg_fmt)
-		return -EINVAL;
-
-	mutex_lock(&priv->mutex);
-	*cfg_fmt = format->format;
-	mutex_unlock(&priv->mutex);
-
-	return 0;
-}
-
 static int max9286_get_fmt(struct v4l2_subdev *sd,
 			   struct v4l2_subdev_pad_config *cfg,
 			   struct v4l2_subdev_format *format)
@@ -781,6 +733,16 @@ static int max9286_get_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int max9286_set_fmt(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_pad_config *cfg,
+			   struct v4l2_subdev_format *format)
+{
+	if (format->pad == MAX9286_SRC_PAD)
+		return -EINVAL;
+
+	return max9286_get_fmt(sd, cfg, format);
+}
+
 static const struct v4l2_subdev_video_ops max9286_video_ops = {
 	.s_stream	= max9286_s_stream,
 };
-- 
2.27.0

