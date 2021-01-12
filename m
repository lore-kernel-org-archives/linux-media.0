Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1B2C4332D
	for <linux-media@archiver.kernel.org>; Tue, 12 Jan 2021 13:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BD722E03
	for <linux-media@archiver.kernel.org>; Tue, 12 Jan 2021 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbhALNYm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 12 Jan 2021 08:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbhALNYl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 12 Jan 2021 08:24:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726BC061794
        for <linux-media@vger.kernel.org>; Tue, 12 Jan 2021 05:24:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id B918D1F451D5
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kernel@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 05/13] media: st-mipid02: Use v4l2_async_notifier_add_fwnode_remote_subdev helpers
Date:   Tue, 12 Jan 2021 10:23:31 -0300
Message-Id: <20210112132339.5621-6-ezequiel@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112132339.5621-1-ezequiel@collabora.com>
References: <20210112132339.5621-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The use of v4l2_async_notifier_add_subdev is discouraged.
Drivers are instead encouraged to use a helper such as
v4l2_async_notifier_add_fwnode_remote_subdev.

This fixes a misuse of the API, as v4l2_async_notifier_add_subdev
should get a kmalloc'ed struct v4l2_async_subdev,
removing some boilerplate code while at it.

Use the appropriate helper v4l2_async_notifier_add_fwnode_remote_subdev,
which handles the needed setup, instead of open-coding it.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/i2c/st-mipid02.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 003ba22334cd..9e04ff02257c 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -92,7 +92,6 @@ struct mipid02_dev {
 	u64 link_frequency;
 	struct v4l2_fwnode_endpoint tx;
 	/* remote source */
-	struct v4l2_async_subdev asd;
 	struct v4l2_async_notifier notifier;
 	struct v4l2_subdev *s_subdev;
 	/* registers */
@@ -844,6 +843,7 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
 {
 	struct v4l2_fwnode_endpoint ep = { .bus_type = V4L2_MBUS_CSI2_DPHY };
 	struct i2c_client *client = bridge->i2c_client;
+	struct v4l2_async_subdev *asd;
 	struct device_node *ep_node;
 	int ret;
 
@@ -875,17 +875,17 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
 	bridge->rx = ep;
 
 	/* register async notifier so we get noticed when sensor is connected */
-	bridge->asd.match.fwnode =
-		fwnode_graph_get_remote_port_parent(of_fwnode_handle(ep_node));
-	bridge->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
+	v4l2_async_notifier_init(&bridge->notifier);
+	asd = v4l2_async_notifier_add_fwnode_remote_subdev(
+					&bridge->notifier,
+					of_fwnode_handle(ep_node),
+					sizeof(*asd));
 	of_node_put(ep_node);
 
-	v4l2_async_notifier_init(&bridge->notifier);
-	ret = v4l2_async_notifier_add_subdev(&bridge->notifier, &bridge->asd);
-	if (ret) {
+	if (IS_ERR(asd)) {
+		ret = PTR_ERR(asd);
 		dev_err(&client->dev, "fail to register asd to notifier %d",
 			ret);
-		fwnode_handle_put(bridge->asd.match.fwnode);
 		return ret;
 	}
 	bridge->notifier.ops = &mipid02_notifier_ops;
-- 
2.29.2

