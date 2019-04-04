Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93377C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 07:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684DF2075E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 07:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDDHkf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:40:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33655 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDHkf (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 03:40:35 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hBwyz-0007cx-OU; Thu, 04 Apr 2019 09:40:21 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hBwyv-00051Q-7C; Thu, 04 Apr 2019 09:40:17 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, rmfrfs@gmail.com, zhengsq@rock-chips.com,
        prabhakar.csengg@gmail.com, corbet@lwn.net,
        wenyou.yang@microchip.com, lkundrak@v3.sk,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        jacopo+renesas@jmondi.org
Cc:     linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/6] media: v4l2-subdev: add stubs for v4l2_subdev_get_try_*
Date:   Thu,  4 Apr 2019 09:39:57 +0200
Message-Id: <20190404074002.18730-2-m.felsch@pengutronix.de>
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

In case of missing CONFIG_VIDEO_V4L2_SUBDEV_API those helpers aren't
available. So each driver have to add ifdefs around those helpers or
add the CONFIG_VIDEO_V4L2_SUBDEV_API as dependcy.

Make these helpers available in case of CONFIG_VIDEO_V4L2_SUBDEV_API
isn't set to avoid ifdefs. This approach is less error prone too.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
The patch was previously part of series [1]. Since I want to get
series [1] merged in 5.2 I split this possible stopper out of the
serie and prepared a own series for it. I applied Jacopos comments and
switched to Lubomir's approach [2]. During discussion on series [2]
Sakari pointed out Hans approach [3] which didn't got into the kernel
due to Mauro's concerns. So I think this would be the smalles common
dennominator.

[1] https://patchwork.kernel.org/cover/10786553/
[2] https://patchwork.kernel.org/patch/10703029/
[3] https://patchwork.linuxtv.org/patch/53370/
---
 include/media/v4l2-subdev.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a7fa5b80915a..eea792757426 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -984,7 +984,34 @@ static inline struct v4l2_rect
 		pad = 0;
 	return &cfg[pad].try_compose;
 }
-#endif
+
+#else /* !defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
+
+static inline struct v4l2_mbus_framefmt
+*v4l2_subdev_get_try_format(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_pad_config *cfg,
+			    unsigned int pad)
+{
+	return ERR_PTR(-ENOTTY);
+}
+
+static inline struct v4l2_rect
+*v4l2_subdev_get_try_crop(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_pad_config *cfg,
+			  unsigned int pad)
+{
+	return ERR_PTR(-ENOTTY);
+}
+
+static inline struct v4l2_rect
+*v4l2_subdev_get_try_compose(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_pad_config *cfg,
+			     unsigned int pad)
+{
+	return ERR_PTR(-ENOTTY);
+}
+
+#endif /* defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
 
 extern const struct v4l2_file_operations v4l2_subdev_fops;
 
-- 
2.20.1

