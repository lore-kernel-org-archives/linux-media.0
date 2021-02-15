Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E9C433DB
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377D964E68
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhBOEgb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:36:31 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45902 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBOEg1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Feb 2021 23:36:27 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 054E41AC1;
        Mon, 15 Feb 2021 05:28:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613363326;
        bh=4tj5PJka52MVI4dvI2OWAEj0v8/0Fz+MCdGCi93/9XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDd4q3DvWUzDwPWN0T359tPvnYtMlelQafik6JVq0BNXpZSdr2ttNPia2r3qaiNer
         ouB0jX5p2H0tc5zbwE8ogD11BZhYCvmZoaHZ7ZEwqS5HFIlaCknz4u0uch8s7ZdOvK
         hXOLBT8amKPpD34jlm4HqL0lY3dBryzoGxfA8a9c=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 45/77] media: imx: imx7-media-csi: Set the MIPI data type based on the bus code
Date:   Mon, 15 Feb 2021 06:27:09 +0200
Message-Id: <20210215042741.28850-46-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
References: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The MIPI CSI-2 data type depends solely on the media bus code on the
sink pad. Deriving it from the pixel format is confusing. Simplify the
code.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 64 +++++++++++++---------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 0ad18885542b..b4bd161bec40 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -482,7 +482,6 @@ static void imx7_csi_configure(struct imx7_csi *csi)
 {
 	struct imx_media_video_dev *vdev = csi->vdev;
 	struct v4l2_pix_format *out_pix = &vdev->fmt;
-	__u32 in_code = csi->format_mbus[IMX7_CSI_PAD_SINK].code;
 	u32 cr1, cr18;
 	int width = out_pix->width;
 
@@ -518,37 +517,52 @@ static void imx7_csi_configure(struct imx7_csi *csi)
 	cr18 &= BIT_MIPI_DATA_FORMAT_MASK;
 	cr18 |= BIT_DATA_FROM_MIPI;
 
-	switch (out_pix->pixelformat) {
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_YUYV:
-		cr18 |= BIT_MIPI_DATA_FORMAT_YUV422_8B;
+	switch (csi->format_mbus[IMX7_CSI_PAD_SINK].code) {
+	case MEDIA_BUS_FMT_Y8_1X8:
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		cr18 |= BIT_MIPI_DATA_FORMAT_RAW8;
 		break;
-	case V4L2_PIX_FMT_GREY:
-		if (in_code == MEDIA_BUS_FMT_Y8_1X8)
-			cr18 |= BIT_MIPI_DATA_FORMAT_RAW8;
-		else if (in_code == MEDIA_BUS_FMT_Y10_1X10)
-			cr18 |= BIT_MIPI_DATA_FORMAT_RAW10;
-		else
-			cr18 |= BIT_MIPI_DATA_FORMAT_RAW12;
-		break;
-	case V4L2_PIX_FMT_Y10:
+	case MEDIA_BUS_FMT_Y10_1X10:
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
 		cr18 |= BIT_MIPI_DATA_FORMAT_RAW10;
-		cr1 |= BIT_PIXEL_BIT;
 		break;
-	case V4L2_PIX_FMT_Y12:
+	case MEDIA_BUS_FMT_Y12_1X12:
+	case MEDIA_BUS_FMT_SBGGR12_1X12:
+	case MEDIA_BUS_FMT_SGBRG12_1X12:
+	case MEDIA_BUS_FMT_SGRBG12_1X12:
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
 		cr18 |= BIT_MIPI_DATA_FORMAT_RAW12;
-		cr1 |= BIT_PIXEL_BIT;
 		break;
+	case MEDIA_BUS_FMT_Y14_1X14:
+	case MEDIA_BUS_FMT_SBGGR14_1X14:
+	case MEDIA_BUS_FMT_SGBRG14_1X14:
+	case MEDIA_BUS_FMT_SGRBG14_1X14:
+	case MEDIA_BUS_FMT_SRGGB14_1X14:
+		cr18 |= BIT_MIPI_DATA_FORMAT_RAW14;
+		break;
+	/*
+	 * CSI-2 sources are supposed to use the 1X16 formats, but not all of
+	 * them comply. Support both variants.
+	 */
+	case MEDIA_BUS_FMT_UYVY8_2X8:
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+	case MEDIA_BUS_FMT_YUYV8_2X8:
+	case MEDIA_BUS_FMT_YUYV8_1X16:
+		cr18 |= BIT_MIPI_DATA_FORMAT_YUV422_8B;
+		break;
+	}
+
+	switch (out_pix->pixelformat) {
+	case V4L2_PIX_FMT_Y10:
+	case V4L2_PIX_FMT_Y12:
 	case V4L2_PIX_FMT_SBGGR8:
-		cr18 |= BIT_MIPI_DATA_FORMAT_RAW8;
-		break;
 	case V4L2_PIX_FMT_SBGGR16:
-		if (in_code == MEDIA_BUS_FMT_SBGGR10_1X10)
-			cr18 |= BIT_MIPI_DATA_FORMAT_RAW10;
-		else if (in_code == MEDIA_BUS_FMT_SBGGR12_1X12)
-			cr18 |= BIT_MIPI_DATA_FORMAT_RAW12;
-		else if (in_code == MEDIA_BUS_FMT_SBGGR14_1X14)
-			cr18 |= BIT_MIPI_DATA_FORMAT_RAW14;
 		cr1 |= BIT_PIXEL_BIT;
 		break;
 	}
-- 
Regards,

Laurent Pinchart

