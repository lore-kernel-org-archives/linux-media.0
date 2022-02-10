Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A5C433EF
	for <linux-media@archiver.kernel.org>; Thu, 10 Feb 2022 11:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiBJLJ5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 10 Feb 2022 06:09:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiBJLJ4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 10 Feb 2022 06:09:56 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E4128
        for <linux-media@vger.kernel.org>; Thu, 10 Feb 2022 03:09:57 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id A021D240011;
        Thu, 10 Feb 2022 11:09:53 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     slongerbeam@gmail.com
Cc:     laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        hverkuil-cisco@xs4all.nl, mirela.rabulea@nxp.com,
        xavier.roumegue@oss.nxp.com, tomi.valkeinen@ideasonboard.com,
        hugues.fruchet@st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        aford173@gmail.com, festevam@gmail.com,
        eugen.hristev@microchip.com, jbrunet@baylibre.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2 21/23] media: ov5640: Add RGB888/BGR888 formats
Date:   Thu, 10 Feb 2022 12:10:42 +0100
Message-Id: <20220210111044.152904-2-jacopo@jmondi.org>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220210110458.152494-1-jacopo@jmondi.org>
References: <20220210110458.152494-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for RGB888/BGR888 image formats.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/i2c/ov5640.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 3a21f4648acf..f894570ac53c 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -224,6 +224,14 @@ static const struct ov5640_pixfmt {
 		.code = MEDIA_BUS_FMT_RGB565_1X16,
 		.colorspace = V4L2_COLORSPACE_SRGB,
 		.bpp = 16,
+	}, {
+		.code = MEDIA_BUS_FMT_RGB888_1X24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.bpp = 24,
+	}, {
+		.code = MEDIA_BUS_FMT_BGR888_1X24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.bpp = 16,
 	}, {
 		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
 		.colorspace = V4L2_COLORSPACE_SRGB,
@@ -2777,6 +2785,16 @@ static int ov5640_set_framefmt(struct ov5640_dev *sensor,
 		fmt = 0x61;
 		mux = OV5640_FMT_MUX_RGB;
 		break;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		/* RGB888: BGR */
+		fmt = 0x22;
+		mux = OV5640_FMT_MUX_RGB;
+		break;
+	case MEDIA_BUS_FMT_BGR888_1X24:
+		/* BGR888: RGB */
+		fmt = 0x23;
+		mux = OV5640_FMT_MUX_RGB;
+		break;
 	case MEDIA_BUS_FMT_JPEG_1X8:
 		/* YUV422, YUYV */
 		fmt = 0x30;
-- 
2.35.0

