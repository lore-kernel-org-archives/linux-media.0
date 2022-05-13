Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4BCC4332F
	for <linux-media@archiver.kernel.org>; Fri, 13 May 2022 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353946AbiEMOTH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 May 2022 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354381AbiEMOTD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 May 2022 10:19:03 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC01C14AC82
        for <linux-media@vger.kernel.org>; Fri, 13 May 2022 07:19:01 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D5D96240017;
        Fri, 13 May 2022 14:18:59 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     sakari.ailus@iki.fi, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v7 26/28] media: ov5640: Adjust format to bpp in s_fmt
Date:   Fri, 13 May 2022 16:14:14 +0200
Message-Id: <20220513141416.120552-27-jacopo@jmondi.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513141416.120552-1-jacopo@jmondi.org>
References: <20220513141416.120552-1-jacopo@jmondi.org>
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

Adjust the image sizes according to the above constraints.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 125ada9ae5fc..096e2ee924aa 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -2698,6 +2698,7 @@ static int ov5640_try_fmt_internal(struct v4l2_subdev *sd,
 				   enum ov5640_frame_rate fr,
 				   const struct ov5640_mode_info **new_mode)
 {
+	unsigned int bpp = ov5640_code_to_bpp(fmt->code);
 	struct ov5640_dev *sensor = to_ov5640_dev(sd);
 	const struct ov5640_mode_info *mode;
 	int i;
@@ -2705,6 +2706,17 @@ static int ov5640_try_fmt_internal(struct v4l2_subdev *sd,
 	mode = ov5640_find_mode(sensor, fmt->width, fmt->height, true);
 	if (!mode)
 		return -EINVAL;
+
+	/*
+	 * Adjust mode according to bpp:
+	 * - 8bpp modes work for resolution >= 1280x720
+	 * - 24bpp modes work resolution < 1280x720
+	 */
+	if (bpp == 8 && mode->width < 1280)
+		mode = &ov5640_mode_data[OV5640_MODE_720P_1280_720];
+	else if (bpp == 24 && mode->width > 1024)
+		mode = &ov5640_mode_data[OV5640_MODE_XGA_1024_768];
+
 	fmt->width = mode->width;
 	fmt->height = mode->height;
 
-- 
2.35.1

