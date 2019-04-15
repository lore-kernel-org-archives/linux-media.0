Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25292C282DA
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E992077C
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfDOMor (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:44:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfDOMof (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 08:44:35 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yJ-0000RR-83; Mon, 15 Apr 2019 14:44:27 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yH-00025V-1b; Mon, 15 Apr 2019 14:44:25 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v6 07/13] media: tvp5150: add FORMAT_TRY support for get/set selection handlers
Date:   Mon, 15 Apr 2019 14:44:07 +0200
Message-Id: <20190415124413.18456-8-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415124413.18456-1-m.felsch@pengutronix.de>
References: <20190415124413.18456-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Since commit 10d5509c8d50 ("[media] v4l2: remove g/s_crop from video ops")
the 'which' field for set/get_selection must be FORMAT_ACTIVE. There is
no way to try different selections. The patch adds a helper function to
select the correct selection memory space (sub-device file handle or
driver state) which will be set/returned.

The TVP5150 AVID will be updated if the 'which' field is FORMAT_ACTIVE
and the requested selection rectangle differs from the already set one.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:

v5:
 - handle stub for v4l2_subdev_get_try_crop() internal since commit
   ("media: v4l2-subdev: add stubs for v4l2_subdev_get_try_*")
   isn't anymore part of this series.
 - add error handling of __tvp5150_get_pad_crop()
v4:
 - fix merge conflict due to rebase on top of media-tree/master
 - __tvp5150_get_pad_crop(): cosmetic alignment fixes

 drivers/media/i2c/tvp5150.c | 130 ++++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 34 deletions(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 4e3228b2ccbc..9331609425bf 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -19,6 +19,7 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-mc.h>
+#include <media/v4l2-rect.h>
 
 #include "tvp5150_reg.h"
 
@@ -997,20 +998,48 @@ static void tvp5150_set_default(v4l2_std_id std, struct v4l2_rect *crop)
 		crop->height = TVP5150_V_MAX_OTHERS;
 }
 
+static struct v4l2_rect *
+__tvp5150_get_pad_crop(struct tvp5150 *decoder,
+		       struct v4l2_subdev_pad_config *cfg, unsigned int pad,
+		       enum v4l2_subdev_format_whence which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+#if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
+		return v4l2_subdev_get_try_crop(&decoder->sd, cfg, pad);
+#else
+		return ERR_PTR(-ENOTTY);
+#endif
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &decoder->rect;
+	default:
+		return NULL;
+	}
+}
+
 static int tvp5150_fill_fmt(struct v4l2_subdev *sd,
 			    struct v4l2_subdev_pad_config *cfg,
 			    struct v4l2_subdev_format *format)
 {
 	struct v4l2_mbus_framefmt *f;
+	struct v4l2_rect *__crop;
 	struct tvp5150 *decoder = to_tvp5150(sd);
 
 	if (!format || (format->pad != TVP5150_PAD_VID_OUT))
 		return -EINVAL;
 
 	f = &format->format;
+	__crop = __tvp5150_get_pad_crop(decoder, cfg, format->pad,
+					format->which);
+	if (IS_ERR_OR_NULL(__crop)) {
+		if (!__crop)
+			return -EINVAL;
+		else
+			return PTR_ERR(__crop);
+	}
 
-	f->width = decoder->rect.width;
-	f->height = decoder->rect.height / 2;
+	f->width = __crop->width;
+	f->height = __crop->height / 2;
 
 	f->code = TVP5150_MBUS_FMT;
 	f->field = TVP5150_FIELD;
@@ -1021,17 +1050,51 @@ static int tvp5150_fill_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
+unsigned int tvp5150_get_hmax(struct v4l2_subdev *sd)
+{
+	struct tvp5150 *decoder = to_tvp5150(sd);
+	v4l2_std_id std;
+
+	/* Calculate height based on current standard */
+	if (decoder->norm == V4L2_STD_ALL)
+		std = tvp5150_read_std(sd);
+	else
+		std = decoder->norm;
+
+	return (std & V4L2_STD_525_60) ?
+		TVP5150_V_MAX_525_60 : TVP5150_V_MAX_OTHERS;
+}
+
+static inline void
+__tvp5150_set_selection(struct v4l2_subdev *sd, struct v4l2_rect rect)
+{
+	struct tvp5150 *decoder = to_tvp5150(sd);
+	unsigned int hmax = tvp5150_get_hmax(sd);
+
+	regmap_write(decoder->regmap, TVP5150_VERT_BLANKING_START, rect.top);
+	regmap_write(decoder->regmap, TVP5150_VERT_BLANKING_STOP,
+		     rect.top + rect.height - hmax);
+	regmap_write(decoder->regmap, TVP5150_ACT_VD_CROP_ST_MSB,
+		     rect.left >> TVP5150_CROP_SHIFT);
+	regmap_write(decoder->regmap, TVP5150_ACT_VD_CROP_ST_LSB,
+		     rect.left | (1 << TVP5150_CROP_SHIFT));
+	regmap_write(decoder->regmap, TVP5150_ACT_VD_CROP_STP_MSB,
+		     (rect.left + rect.width - TVP5150_MAX_CROP_LEFT) >>
+		     TVP5150_CROP_SHIFT);
+	regmap_write(decoder->regmap, TVP5150_ACT_VD_CROP_STP_LSB,
+		     rect.left + rect.width - TVP5150_MAX_CROP_LEFT);
+}
+
 static int tvp5150_set_selection(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_pad_config *cfg,
 				 struct v4l2_subdev_selection *sel)
 {
 	struct tvp5150 *decoder = to_tvp5150(sd);
 	struct v4l2_rect rect = sel->r;
-	v4l2_std_id std;
-	int hmax;
+	struct v4l2_rect *__crop;
+	unsigned int hmax;
 
-	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE ||
-	    sel->target != V4L2_SEL_TGT_CROP)
+	if (sel->target != V4L2_SEL_TGT_CROP)
 		return -EINVAL;
 
 	dev_dbg_lvl(sd->dev, 1, debug, "%s left=%d, top=%d, width=%d, height=%d\n",
@@ -1040,17 +1103,7 @@ static int tvp5150_set_selection(struct v4l2_subdev *sd,
 	/* tvp5150 has some special limits */
 	rect.left = clamp(rect.left, 0, TVP5150_MAX_CROP_LEFT);
 	rect.top = clamp(rect.top, 0, TVP5150_MAX_CROP_TOP);
-
-	/* Calculate height based on current standard */
-	if (decoder->norm == V4L2_STD_ALL)
-		std = tvp5150_read_std(sd);
-	else
-		std = decoder->norm;
-
-	if (std & V4L2_STD_525_60)
-		hmax = TVP5150_V_MAX_525_60;
-	else
-		hmax = TVP5150_V_MAX_OTHERS;
+	hmax = tvp5150_get_hmax(sd);
 
 	/*
 	 * alignments:
@@ -1063,20 +1116,23 @@ static int tvp5150_set_selection(struct v4l2_subdev *sd,
 			      hmax - TVP5150_MAX_CROP_TOP - rect.top,
 			      hmax - rect.top, 0, 0);
 
-	regmap_write(decoder->regmap, TVP5150_VERT_BLANKING_START, rect.top);
-	regmap_write(decoder->regmap, TVP5150_VERT_BLANKING_STOP,
-		     rect.top + rect.height - hmax);
-	regmap_write(decoder->regmap, TVP5150_ACT_VD_CROP_ST_MSB,
-		     rect.left >> TVP5150_CROP_SHIFT);
-	regmap_write(decoder->regmap, TVP5150_ACT_VD_CROP_ST_LSB,
-		     rect.left | (1 << TVP5150_CROP_SHIFT));
-	regmap_write(decoder->regmap, TVP5150_ACT_VD_CROP_STP_MSB,
-		     (rect.left + rect.width - TVP5150_MAX_CROP_LEFT) >>
-		     TVP5150_CROP_SHIFT);
-	regmap_write(decoder->regmap, TVP5150_ACT_VD_CROP_STP_LSB,
-		     rect.left + rect.width - TVP5150_MAX_CROP_LEFT);
+	__crop = __tvp5150_get_pad_crop(decoder, cfg, sel->pad, sel->which);
+	if (IS_ERR_OR_NULL(__crop)) {
+		if (!__crop)
+			return -EINVAL;
+		else
+			return PTR_ERR(__crop);
+	}
+
+	/*
+	 * Update output image size if the selection (crop) rectangle size or
+	 * position has been modified.
+	 */
+	if (!v4l2_rect_equal(&rect, __crop))
+		if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+			__tvp5150_set_selection(sd, rect);
 
-	decoder->rect = rect;
+	*__crop = rect;
 
 	return 0;
 }
@@ -1086,11 +1142,9 @@ static int tvp5150_get_selection(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_selection *sel)
 {
 	struct tvp5150 *decoder = container_of(sd, struct tvp5150, sd);
+	struct v4l2_rect *__crop;
 	v4l2_std_id std;
 
-	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
-		return -EINVAL;
-
 	switch (sel->target) {
 	case V4L2_SEL_TGT_CROP_BOUNDS:
 		sel->r.left = 0;
@@ -1108,7 +1162,15 @@ static int tvp5150_get_selection(struct v4l2_subdev *sd,
 			sel->r.height = TVP5150_V_MAX_OTHERS;
 		return 0;
 	case V4L2_SEL_TGT_CROP:
-		sel->r = decoder->rect;
+		__crop = __tvp5150_get_pad_crop(decoder, cfg, sel->pad,
+						sel->which);
+		if (IS_ERR_OR_NULL(__crop)) {
+			if (!__crop)
+				return -EINVAL;
+			else
+				return PTR_ERR(__crop);
+		}
+		sel->r = *__crop;
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.20.1

