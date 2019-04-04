Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B5C10F05
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 07:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF212147C
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 07:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDDHkh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:40:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39385 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDDHke (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 03:40:34 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hBwyz-0007d3-OS; Thu, 04 Apr 2019 09:40:21 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hBwyv-00051s-BJ; Thu, 04 Apr 2019 09:40:17 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, rmfrfs@gmail.com, zhengsq@rock-chips.com,
        prabhakar.csengg@gmail.com, corbet@lwn.net,
        wenyou.yang@microchip.com, lkundrak@v3.sk,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        jacopo+renesas@jmondi.org
Cc:     linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 6/6] media: ov7740: get rid of extra ifdefs
Date:   Thu,  4 Apr 2019 09:40:02 +0200
Message-Id: <20190404074002.18730-7-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404074002.18730-1-m.felsch@pengutronix.de>
References: <20190404074002.18730-1-m.felsch@pengutronix.de>
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

We can drop the ifdef dance since the v4l2_subdev_get_try_format
return the correct value in both cases with or without
CONFIG_VIDEO_V4L2_SUBDEV_API is enabled.

The patch is based on Lubomir's series [1].

[1] https://patchwork.kernel.org/cover/10703017/

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/media/i2c/ov7740.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 54e80a60aa57..58171f21d315 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -804,9 +804,7 @@ static int ov7740_set_fmt(struct v4l2_subdev *sd,
 	struct ov7740 *ov7740 = container_of(sd, struct ov7740, subdev);
 	const struct ov7740_pixfmt *ovfmt;
 	const struct ov7740_framesize *fsize;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *mbus_fmt;
-#endif
 	int ret;
 
 	mutex_lock(&ov7740->mutex);
@@ -819,16 +817,17 @@ static int ov7740_set_fmt(struct v4l2_subdev *sd,
 		ret = ov7740_try_fmt_internal(sd, &format->format, NULL, NULL);
 		if (ret)
 			goto error;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
+
 		mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format->pad);
+		if (IS_ERR(mbus_fmt)) {
+			ret = PTR_ERR(mbus_fmt);
+			goto error;
+		}
+
 		*mbus_fmt = format->format;
 
 		mutex_unlock(&ov7740->mutex);
 		return 0;
-#else
-		ret = -ENOTTY;
-		goto error;
-#endif
 	}
 
 	ret = ov7740_try_fmt_internal(sd, &format->format, &ovfmt, &fsize);
@@ -851,25 +850,25 @@ static int ov7740_get_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_format *format)
 {
 	struct ov7740 *ov7740 = container_of(sd, struct ov7740, subdev);
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *mbus_fmt;
-#endif
 	int ret = 0;
 
 	mutex_lock(&ov7740->mutex);
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, 0);
+		if (IS_ERR(mbus_fmt)) {
+			ret = PTR_ERR(mbus_fmt);
+			goto error;
+		}
+
 		format->format = *mbus_fmt;
 		ret = 0;
-#else
-		ret = -ENOTTY;
-#endif
 	} else {
 		format->format = ov7740->format;
 	}
-	mutex_unlock(&ov7740->mutex);
 
+error:
+	mutex_unlock(&ov7740->mutex);
 	return ret;
 }
 
-- 
2.20.1

