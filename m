Return-Path: <SRS0=OySw=WP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB11AC3A5A2
	for <linux-media@archiver.kernel.org>; Mon, 19 Aug 2019 12:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2762086C
	for <linux-media@archiver.kernel.org>; Mon, 19 Aug 2019 12:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfHSMuT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:50:19 -0400
Received: from retiisi.org.uk ([95.216.213.190]:47452 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727512AbfHSMuS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Aug 2019 08:50:18 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1002])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id DAD86634C89;
        Mon, 19 Aug 2019 15:49:45 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl
Subject: [PATCH 2/6] v4l: subdev: Provide a locking scheme for subdev operations
Date:   Mon, 19 Aug 2019 15:47:24 +0300
Message-Id: <20190819124728.10511-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819124728.10511-1-sakari.ailus@linux.intel.com>
References: <20190819124728.10511-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The V4L2 sub-device's operations are called both from other drivers as
well as through the IOCTL uAPI. Previously the sub-device drivers were
responsible for managing their own serialisation. This patch adds an
optional mutex the drivers may set, and it will be used to serialise
access to driver's data related to a device across the driver's ops.

Access to the driver's controls through the control framework works as
usual, i.e. using a different mutex.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/media/v4l2-subdev.h | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 71f1f2f0da53..dc6e11019df6 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -9,6 +9,7 @@
 #define _V4L2_SUBDEV_H
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 #include <linux/v4l2-subdev.h>
 #include <media/media-entity.h>
 #include <media/v4l2-async.h>
@@ -828,6 +829,7 @@ struct v4l2_subdev_platform_data {
  * @host_priv: pointer to private data used by the device where the subdev
  *	is attached.
  * @devnode: subdev device node
+ * @lock: A mutex for serialising access to the subdev's operations. Optional.
  * @dev: pointer to the physical device, if any
  * @fwnode: The fwnode_handle of the subdev, usually the same as
  *	    either dev->of_node->fwnode or dev->fwnode (whichever is non-NULL).
@@ -862,6 +864,7 @@ struct v4l2_subdev {
 	void *dev_priv;
 	void *host_priv;
 	struct video_device *devnode;
+	struct mutex *lock;
 	struct device *dev;
 	struct fwnode_handle *fwnode;
 	struct list_head async_list;
@@ -1101,16 +1104,22 @@ extern const struct v4l2_subdev_ops v4l2_subdev_call_wrappers;
 	({								\
 		struct v4l2_subdev *__sd = (sd);			\
 		int __result;						\
-		if (!__sd)						\
+		if (!__sd) {						\
 			__result = -ENODEV;				\
-		else if (!(__sd->ops->o && __sd->ops->o->f))		\
+		} else if (!(__sd->ops->o && __sd->ops->o->f)) {	\
 			__result = -ENOIOCTLCMD;			\
-		else if (v4l2_subdev_call_wrappers.o &&			\
-			 v4l2_subdev_call_wrappers.o->f)		\
-			__result = v4l2_subdev_call_wrappers.o->f(	\
-							__sd, ##args);	\
-		else							\
-			__result = __sd->ops->o->f(__sd, ##args);	\
+		} else {						\
+			if (__sd->lock)					\
+				mutex_lock(__sd->lock);			\
+			if (v4l2_subdev_call_wrappers.o &&		\
+				 v4l2_subdev_call_wrappers.o->f)	\
+				__result = v4l2_subdev_call_wrappers.o->f( \
+					__sd, ##args);			\
+			else						\
+				__result = __sd->ops->o->f(__sd, ##args); \
+			if (__sd->lock)					\
+				mutex_unlock(__sd->lock);			\
+		}							\
 		__result;						\
 	})
 
-- 
2.20.1

