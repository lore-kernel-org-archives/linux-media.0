Return-Path: <SRS0=wJZ5=DQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509D7C433DF
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 14:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0711422261
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 14:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbgJIOC0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 9 Oct 2020 10:02:26 -0400
Received: from retiisi.eu ([95.216.213.190]:50828 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388007AbgJIOC0 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 9 Oct 2020 10:02:26 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 0C8CA634C87
        for <linux-media@vger.kernel.org>; Fri,  9 Oct 2020 17:01:32 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 1/1] v4l: subdev: Improve link format validation debug messages
Date:   Fri,  9 Oct 2020 17:02:23 +0300
Message-Id: <20201009140223.600-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The existing link format validation failure debug message in media-entity.c
helped to poinpoint the point of failure but provided no additional
information what's wrong. Tell the user exactly why the validation failed.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
I pulled this old patch from the VC patchset. It can be merged now without
the rest.

 drivers/media/v4l2-core/v4l2-subdev.c | 40 ++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index a7d508e74d6b..e1dfbcc96a4a 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -792,21 +792,47 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
 				      struct v4l2_subdev_format *source_fmt,
 				      struct v4l2_subdev_format *sink_fmt)
 {
+	bool pass = true;
+
 	/* The width, height and code must match. */
-	if (source_fmt->format.width != sink_fmt->format.width
-	    || source_fmt->format.height != sink_fmt->format.height
-	    || source_fmt->format.code != sink_fmt->format.code)
-		return -EPIPE;
+	if (source_fmt->format.width != sink_fmt->format.width) {
+		dev_dbg(sd->entity.graph_obj.mdev->dev,
+			"%s: width does not match (source %u, sink %u)\n",
+			__func__,
+			source_fmt->format.width, sink_fmt->format.width);
+		pass = false;
+	}
+
+	if (source_fmt->format.height != sink_fmt->format.height) {
+		dev_dbg(sd->entity.graph_obj.mdev->dev,
+			"%s: height does not match (source %u, sink %u)\n",
+			__func__,
+			source_fmt->format.height, sink_fmt->format.height);
+		pass = false;
+	}
+
+	if (source_fmt->format.code != sink_fmt->format.code) {
+		dev_dbg(sd->entity.graph_obj.mdev->dev,
+			"%s: media bus code does not match (source 0x%8.8x, sink 0x%8.8x)\n",
+			__func__,
+			source_fmt->format.code, sink_fmt->format.code);
+		pass = false;
+	}
 
 	/* The field order must match, or the sink field order must be NONE
 	 * to support interlaced hardware connected to bridges that support
 	 * progressive formats only.
 	 */
 	if (source_fmt->format.field != sink_fmt->format.field &&
-	    sink_fmt->format.field != V4L2_FIELD_NONE)
-		return -EPIPE;
+	    sink_fmt->format.field != V4L2_FIELD_NONE) {
+		dev_dbg(sd->entity.graph_obj.mdev->dev,
+			"%s: field does not match (source %u, sink %u)\n",
+			__func__,
+			source_fmt->format.field, sink_fmt->format.field);
+		pass = false;
+	}
 
-	return 0;
+	return pass ? 0 : -EPIPE;
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate_default);
 
-- 
2.27.0

