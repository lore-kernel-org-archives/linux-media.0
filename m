Return-Path: <SRS0=PKt4=VM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC2C76195
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6039D20665
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 21:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbfGOVHK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:07:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52712 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfGOVHK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Jul 2019 17:07:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 067A828B6A6
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 5/6] media: v4l2-core: introduce a helper to unregister a SPI subdev
Date:   Mon, 15 Jul 2019 18:06:46 -0300
Message-Id: <20190715210649.31681-6-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715210649.31681-1-ezequiel@collabora.com>
References: <20190715210649.31681-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Introduce a new video4linux2 SPI helper, to unregister a subdev.
This allows to get rid of some more ifdefs.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/v4l2-core/v4l2-device.c | 14 ++------------
 drivers/media/v4l2-core/v4l2-spi.c    |  8 ++++++++
 include/media/v4l2-common.h           |  9 +++++++++
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-device.c b/drivers/media/v4l2-core/v4l2-device.c
index aa277f5bc862..c2811238996f 100644
--- a/drivers/media/v4l2-core/v4l2-device.c
+++ b/drivers/media/v4l2-core/v4l2-device.c
@@ -11,9 +11,6 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
-#if defined(CONFIG_SPI)
-#include <linux/spi/spi.h>
-#endif
 #include <linux/videodev2.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
@@ -124,15 +121,8 @@ void v4l2_device_unregister(struct v4l2_device *v4l2_dev)
 			continue;
 		}
 #endif
-#if defined(CONFIG_SPI)
-		if (sd->flags & V4L2_SUBDEV_FL_IS_SPI) {
-			struct spi_device *spi = v4l2_get_subdevdata(sd);
-
-			if (spi && !spi->dev.of_node && !spi->dev.fwnode)
-				spi_unregister_device(spi);
-			continue;
-		}
-#endif
+		else if (sd->flags & V4L2_SUBDEV_FL_IS_SPI)
+			v4l2_spi_subdev_unregister(sd);
 	}
 	/* Mark as unregistered, thus preventing duplicate unregistrations */
 	v4l2_dev->name[0] = '\0';
diff --git a/drivers/media/v4l2-core/v4l2-spi.c b/drivers/media/v4l2-core/v4l2-spi.c
index ab5a7eb4205d..2a7e82e1412d 100644
--- a/drivers/media/v4l2-core/v4l2-spi.c
+++ b/drivers/media/v4l2-core/v4l2-spi.c
@@ -8,6 +8,14 @@
 #include <media/v4l2-common.h>
 #include <media/v4l2-device.h>
 
+void v4l2_spi_subdev_unregister(struct v4l2_subdev *sd)
+{
+	struct spi_device *spi = v4l2_get_subdevdata(sd);
+
+	if (spi && !spi->dev.of_node && !spi->dev.fwnode)
+		spi_unregister_device(spi);
+}
+
 void v4l2_spi_subdev_init(struct v4l2_subdev *sd, struct spi_device *spi,
 		const struct v4l2_subdev_ops *ops)
 {
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index 8e66edddd37b..e2878654d043 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -285,6 +285,13 @@ struct v4l2_subdev *v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
 void v4l2_spi_subdev_init(struct v4l2_subdev *sd, struct spi_device *spi,
 		const struct v4l2_subdev_ops *ops);
 
+/**
+ * v4l2_spi_subdev_unregister - Unregister a v4l2_subdev
+ *
+ * @sd: pointer to &struct v4l2_subdev
+ */
+void v4l2_spi_subdev_unregister(struct v4l2_subdev *sd);
+
 #else
 
 static inline struct v4l2_subdev *
@@ -299,6 +306,8 @@ v4l2_spi_subdev_init(struct v4l2_subdev *sd, struct spi_device *spi,
 		     const struct v4l2_subdev_ops *ops)
 {}
 
+static inline void v4l2_spi_subdev_unregister(struct v4l2_subdev *sd)
+{}
 #endif
 
 /* ------------------------------------------------------------------------- */
-- 
2.22.0

