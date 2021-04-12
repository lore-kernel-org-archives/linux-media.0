Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC488C433ED
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 15:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84B061261
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 15:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbhDLP5h (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Apr 2021 11:57:37 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33845 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhDLP5g (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Apr 2021 11:57:36 -0400
X-Originating-IP: 24.194.32.49
Received: from coplandos.local (cpe-24-194-32-49.nycap.res.rr.com [24.194.32.49])
        (Authenticated sender: vrzh@vrzh.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C86801BF210;
        Mon, 12 Apr 2021 15:57:15 +0000 (UTC)
From:   Martiros Shakhzadyan <vrzh@vrzh.net>
To:     mchehab@kernel.org
Cc:     sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        linux-media@vger.kernel.org, vrzh@vrzh.net
Subject: [PATCH] staging: media: atomisp: Removed a function entry log
Date:   Mon, 12 Apr 2021 11:59:59 -0400
Message-Id: <20210412155959.6647-1-vrzh@vrzh.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Removed a function entry log in ov2722_remove, as ftrace is a preferred
method for function entry/exit tracing.

Signed-off-by: Martiros Shakhzadyan <vrzh@vrzh.net>
---
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
index c017e9066b7a..912eadaffc44 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
@@ -1175,8 +1175,6 @@ static int ov2722_remove(struct i2c_client *client)
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct ov2722_device *dev = to_ov2722_sensor(sd);
 
-	dev_dbg(&client->dev, "ov2722_remove...\n");
-
 	dev->platform_data->csi_cfg(sd, 0);
 	v4l2_ctrl_handler_free(&dev->ctrl_handler);
 	v4l2_device_unregister_subdev(sd);
-- 
2.31.1

