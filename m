Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD5CC433FE
	for <linux-media@archiver.kernel.org>; Wed, 23 Feb 2022 15:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiBWPEJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Feb 2022 10:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbiBWPEI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Feb 2022 10:04:08 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D690CC4
        for <linux-media@vger.kernel.org>; Wed, 23 Feb 2022 07:03:40 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 15394E0006;
        Wed, 23 Feb 2022 15:03:35 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        hverkuil-cisco@xs4all.nl, mirela.rabulea@nxp.com,
        xavier.roumegue@oss.nxp.com, tomi.valkeinen@ideasonboard.com,
        hugues.fruchet@st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        aford173@gmail.com, festevam@gmail.com,
        Eugen.Hristev@microchip.com, jbrunet@baylibre.com,
        paul.elder@ideasonboard.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH v4 24/27] media: ov5640: Restrict sizes to mbus code
Date:   Wed, 23 Feb 2022 15:56:00 +0100
Message-Id: <20220223145603.121603-25-jacopo@jmondi.org>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220223145603.121603-1-jacopo@jmondi.org>
References: <20220223145603.121603-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The ov5640 driver supports different sizes for different mbus_codes.
In particular:

- 8bpp modes: high resolution sizes (>= 1280x720)
- 16bpp modes: all sizes
- 24bpp modes: low resolutions sizes (< 1280x720)

Restrict the frame sizes enumerations to the above constraints.

While at it, make sure the fse->mbus_code parameter is valid, and return
-EINVAL if it's not.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov5640.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 0e9f04fdcee2..d29613b746f0 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3449,14 +3449,28 @@ static int ov5640_enum_frame_size(struct v4l2_subdev *sd,
 				  struct v4l2_subdev_state *sd_state,
 				  struct v4l2_subdev_frame_size_enum *fse)
 {
+	u32 bpp = ov5640_code_to_bpp(fse->code);
+	unsigned int index = fse->index;
+
 	if (fse->pad != 0)
 		return -EINVAL;
-	if (fse->index >= OV5640_NUM_MODES)
+	if (!bpp)
+		return -EINVAL;
+
+	/* Only low-resolution modes are supported for 24bpp formats. */
+	if (bpp == 24 && index >= OV5640_MODE_720P_1280_720)
+		return -EINVAL;
+
+	/* FIXME: Low resolution modes don't work in 8bpp formats. */
+	if (bpp == 8)
+		index += OV5640_MODE_720P_1280_720;
+
+	if (index >= OV5640_NUM_MODES)
 		return -EINVAL;
 
-	fse->min_width = ov5640_mode_data[fse->index].width;
+	fse->min_width = ov5640_mode_data[index].width;
 	fse->max_width = fse->min_width;
-	fse->min_height = ov5640_mode_data[fse->index].height;
+	fse->min_height = ov5640_mode_data[index].height;
 	fse->max_height = fse->min_height;
 
 	return 0;
-- 
2.35.0

