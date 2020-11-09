Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C71C2D0A3
	for <linux-media@archiver.kernel.org>; Mon,  9 Nov 2020 16:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFED20897
	for <linux-media@archiver.kernel.org>; Mon,  9 Nov 2020 16:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgKIQxC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:53:02 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38339 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgKIQxC (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 Nov 2020 11:53:02 -0500
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7708320009;
        Mon,  9 Nov 2020 16:52:59 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     linux-media@vger.kernel.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        roman.kovalivskyi@globallogic.com, dafna.hirschfeld@collabora.com,
        dave.stevenson@raspberrypi.org, naush@raspberrypi.com,
        erosca@de.adit-jv.com
Subject: [PATCH v3 28/29] media: ov5647: Support VIDIOC_SUBSCRIBE_EVENT
Date:   Mon,  9 Nov 2020 17:49:33 +0100
Message-Id: <20201109164934.134919-29-jacopo@jmondi.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109164934.134919-1-jacopo@jmondi.org>
References: <20201109164934.134919-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The driver reports the V4L2_SUBDEV_FL_HAS_EVENTS flag but does not
support subscribing and unsubscribing to events.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/i2c/ov5647.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index afb8173458bbe..5235045ef0012 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -24,6 +24,7 @@
 #include <linux/videodev2.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-image-sizes.h>
 #include <media/v4l2-mediabus.h>
@@ -977,6 +978,8 @@ static int ov5647_sensor_set_register(struct v4l2_subdev *sd,
 
 /* Subdev core operations registration */
 static const struct v4l2_subdev_core_ops ov5647_subdev_core_ops = {
+	.subscribe_event	= v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event	= v4l2_event_subdev_unsubscribe,
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	.g_register		= ov5647_sensor_get_register,
 	.s_register		= ov5647_sensor_set_register,
-- 
2.29.1

