Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B270BC56201
	for <linux-media@archiver.kernel.org>; Thu, 19 Nov 2020 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2BD22202
	for <linux-media@archiver.kernel.org>; Thu, 19 Nov 2020 16:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgKSQfz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:35:55 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:5511 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbgKSQfz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 19 Nov 2020 11:35:55 -0500
X-Originating-IP: 93.34.118.233
Received: from localhost.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B07C7240089;
        Thu, 19 Nov 2020 16:35:50 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        roman.kovalivskyi@globallogic.com, dafna.hirschfeld@collabora.com,
        dave.stevenson@raspberrypi.org, naush@raspberrypi.com,
        erosca@de.adit-jv.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v4 20/30] media: ov5647: Set V4L2_SUBDEV_FL_HAS_EVENTS flag
Date:   Thu, 19 Nov 2020 17:35:40 +0100
Message-Id: <20201119163549.793282-1-jacopo@jmondi.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201119161956.756455-1-jacopo@jmondi.org>
References: <20201119161956.756455-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The ov5647 subdev can generate control events, therefore set
the V4L2_SUBDEV_FL_HAS_EVENTS flag.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/i2c/ov5647.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index bb85e9c53c9cc..45144a600c536 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1416,7 +1416,7 @@ static int ov5647_probe(struct i2c_client *client)
 	sd = &sensor->sd;
 	v4l2_i2c_subdev_init(sd, client, &ov5647_subdev_ops);
 	sd->internal_ops = &ov5647_subdev_internal_ops;
-	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 
 	sensor->pad.flags = MEDIA_PAD_FL_SOURCE;
 	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
-- 
2.29.1

