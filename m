Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DF3C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64752075E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 07:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfDDHki (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:40:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43873 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDHke (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 03:40:34 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hBwyz-0007d2-OT; Thu, 04 Apr 2019 09:40:21 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hBwyv-00051n-AS; Thu, 04 Apr 2019 09:40:17 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, rmfrfs@gmail.com, zhengsq@rock-chips.com,
        prabhakar.csengg@gmail.com, corbet@lwn.net,
        wenyou.yang@microchip.com, lkundrak@v3.sk,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        jacopo+renesas@jmondi.org
Cc:     linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 5/6] media: ov7670: get rid of extra ifdefs
Date:   Thu,  4 Apr 2019 09:40:01 +0200
Message-Id: <20190404074002.18730-6-m.felsch@pengutronix.de>
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
 drivers/media/i2c/ov7670.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index 44c3eed8a858..7d6fd9842a75 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -1097,9 +1097,7 @@ static int ov7670_set_fmt(struct v4l2_subdev *sd,
 		struct v4l2_subdev_format *format)
 {
 	struct ov7670_info *info = to_state(sd);
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *mbus_fmt;
-#endif
 	int ret;
 
 	if (format->pad)
@@ -1109,13 +1107,13 @@ static int ov7670_set_fmt(struct v4l2_subdev *sd,
 		ret = ov7670_try_fmt_internal(sd, &format->format, NULL, NULL);
 		if (ret)
 			return ret;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
+
 		mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format->pad);
+		if (IS_ERR(mbus_fmt))
+			return PTR_ERR(mbus_fmt);
+
 		*mbus_fmt = format->format;
 		return 0;
-#else
-		return -ENOTTY;
-#endif
 	}
 
 	ret = ov7670_try_fmt_internal(sd, &format->format, &info->fmt, &info->wsize);
@@ -1138,18 +1136,15 @@ static int ov7670_get_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_format *format)
 {
 	struct ov7670_info *info = to_state(sd);
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *mbus_fmt;
-#endif
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, 0);
+		if (IS_ERR(mbus_fmt))
+			return PTR_ERR(mbus_fmt);
+
 		format->format = *mbus_fmt;
 		return 0;
-#else
-		return -ENOTTY;
-#endif
 	} else {
 		format->format = info->format;
 	}
-- 
2.20.1

