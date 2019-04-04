Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D8AC10F0C
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 07:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E752075E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 07:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfDDHke (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:40:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39765 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDHkd (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 03:40:33 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hBwyz-0007cz-OR; Thu, 04 Apr 2019 09:40:21 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hBwyv-00051X-8L; Thu, 04 Apr 2019 09:40:17 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, rmfrfs@gmail.com, zhengsq@rock-chips.com,
        prabhakar.csengg@gmail.com, corbet@lwn.net,
        wenyou.yang@microchip.com, lkundrak@v3.sk,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        jacopo+renesas@jmondi.org
Cc:     linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/6] media: ov2680: get rid of extra ifdefs
Date:   Thu,  4 Apr 2019 09:39:59 +0200
Message-Id: <20190404074002.18730-4-m.felsch@pengutronix.de>
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
 drivers/media/i2c/ov2680.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index b10bcfabaeeb..ea750e8304fe 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -672,11 +672,11 @@ static int ov2680_get_fmt(struct v4l2_subdev *sd,
 	mutex_lock(&sensor->lock);
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		fmt = v4l2_subdev_get_try_format(&sensor->sd, cfg, format->pad);
-#else
-		ret = -ENOTTY;
-#endif
+		if (IS_ERR(fmt)) {
+			ret = PTR_ERR(fmt);
+			goto unlock;
+		}
 	} else {
 		fmt = &sensor->fmt;
 	}
@@ -684,6 +684,7 @@ static int ov2680_get_fmt(struct v4l2_subdev *sd,
 	if (fmt)
 		format->format = *fmt;
 
+unlock:
 	mutex_unlock(&sensor->lock);
 
 	return ret;
@@ -695,9 +696,7 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 {
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
 	struct v4l2_mbus_framefmt *fmt = &format->format;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *try_fmt;
-#endif
 	const struct ov2680_mode_info *mode;
 	int ret = 0;
 
@@ -720,13 +719,12 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 	}
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		try_fmt = v4l2_subdev_get_try_format(sd, cfg, 0);
+		if (IS_ERR(try_fmt)) {
+			ret = PTR_ERR(try_fmt);
+			goto unlock;
+		}
 		format->format = *try_fmt;
-#else
-		ret = -ENOTTY;
-#endif
-
 		goto unlock;
 	}
 
-- 
2.20.1

