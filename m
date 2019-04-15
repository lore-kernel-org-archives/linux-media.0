Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCFEC282DA
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED07520818
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfDOMoo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:44:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfDOMog (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 08:44:36 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yJ-0000RS-88; Mon, 15 Apr 2019 14:44:27 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yH-00025Y-25; Mon, 15 Apr 2019 14:44:25 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH v6 08/13] media: tvp5150: initialize subdev before parsing device tree
Date:   Mon, 15 Apr 2019 14:44:08 +0200
Message-Id: <20190415124413.18456-9-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415124413.18456-1-m.felsch@pengutronix.de>
References: <20190415124413.18456-1-m.felsch@pengutronix.de>
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

From: Michael Tretter <m.tretter@pengutronix.de>

There are several debug prints in the tvp5150_parse_dt() function, which
do not print the prefix, because the v4l2_subdev is not initialized, yet.

Initialize the v4l2_subdev before parsing the device tree to fix the
debug messages.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/media/i2c/tvp5150.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 9331609425bf..305a5e256b31 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -1973,6 +1973,9 @@ static int tvp5150_probe(struct i2c_client *c,
 
 	core->regmap = map;
 	sd = &core->sd;
+	v4l2_i2c_subdev_init(sd, c, &tvp5150_ops);
+	sd->internal_ops = &tvp5150_internal_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 
 	if (IS_ENABLED(CONFIG_OF) && np) {
 		res = tvp5150_parse_dt(core, np);
@@ -1985,10 +1988,6 @@ static int tvp5150_probe(struct i2c_client *c,
 		core->mbus_type = V4L2_MBUS_BT656;
 	}
 
-	v4l2_i2c_subdev_init(sd, c, &tvp5150_ops);
-	sd->internal_ops = &tvp5150_internal_ops;
-	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
-
 	res = tvp5150_mc_init(core);
 	if (res)
 		goto err_cleanup_dt;
-- 
2.20.1

