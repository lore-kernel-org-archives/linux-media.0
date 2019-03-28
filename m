Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D6C10F0A
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42120811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfC1UGS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:06:18 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56735 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfC1UGR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:06:17 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5651FE001D;
        Thu, 28 Mar 2019 20:06:14 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 21/31] v4l: subdev: Improve link format validation debug messages
Date:   Thu, 28 Mar 2019 21:05:58 +0100
Message-Id: <20190328200608.9463-22-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

The existing link format validation failure debug message in media-entity.c
helped to poinpoint the point of failure but provided no additional
information what's wrong. Tell the user exactly why the validation failed.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 40 ++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 61323a016e6e..c1a0220e660b 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -625,21 +625,47 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
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
2.21.0

