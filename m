Return-Path: <SRS0=K/Uv=5X=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA2AC2BB55
	for <linux-media@archiver.kernel.org>; Tue,  7 Apr 2020 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB28B2076E
	for <linux-media@archiver.kernel.org>; Tue,  7 Apr 2020 16:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgDGQfu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:35:50 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39977 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgDGQfu (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 7 Apr 2020 12:35:50 -0400
X-Originating-IP: 2.224.242.101
Received: from localhost.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9172940008;
        Tue,  7 Apr 2020 16:35:47 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@google.com, pavel@ucw.cz
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), libcamera-devel@lists.libcamera.org
Subject: [PATCH v8 10/11] media: i2c: ov5670: Parse and register properties
Date:   Tue,  7 Apr 2020 18:38:24 +0200
Message-Id: <20200407163825.1766483-11-jacopo@jmondi.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407163825.1766483-1-jacopo@jmondi.org>
References: <20200407163825.1766483-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Parse device properties and register controls for them using the newly
introduced helpers.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/i2c/ov5670.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
index 041fcbb4eebd..f118d44b0889 100644
--- a/drivers/media/i2c/ov5670.c
+++ b/drivers/media/i2c/ov5670.c
@@ -7,6 +7,7 @@
 #include <linux/pm_runtime.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
 
 #define OV5670_REG_CHIP_ID		0x300a
 #define OV5670_CHIP_ID			0x005670
@@ -2059,6 +2060,8 @@ static const struct v4l2_ctrl_ops ov5670_ctrl_ops = {
 /* Initialize control handlers */
 static int ov5670_init_controls(struct ov5670 *ov5670)
 {
+	struct i2c_client *client = v4l2_get_subdevdata(&ov5670->sd);
+	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	s64 vblank_max;
 	s64 vblank_def;
@@ -2129,6 +2132,15 @@ static int ov5670_init_controls(struct ov5670 *ov5670)
 		goto error;
 	}
 
+	ret = v4l2_fwnode_device_parse(&client->dev, &props);
+	if (ret)
+		return ret;
+
+	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &ov5670_ctrl_ops,
+					      &props);
+	if (ret)
+		return ret;
+
 	ov5670->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
-- 
2.26.0

