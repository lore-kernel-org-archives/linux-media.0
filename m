Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83601C433E6
	for <linux-media@archiver.kernel.org>; Tue, 16 Feb 2021 17:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5351564E04
	for <linux-media@archiver.kernel.org>; Tue, 16 Feb 2021 17:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhBPRne (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:43:34 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:35499 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhBPRnA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Feb 2021 12:43:00 -0500
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B41C4200013;
        Tue, 16 Feb 2021 17:41:51 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] media: i2c: max9286: Initialize remotes when bound
Date:   Tue, 16 Feb 2021 18:41:44 +0100
Message-Id: <20210216174146.106639-15-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216174146.106639-1-jacopo+renesas@jmondi.org>
References: <20210216174146.106639-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

With the introduction of the .init() core subdev operation in the
max9271 GMSL serializer, the max9286 deserializer needs to explicitly
initialize the remote devices by calling the .init() subdev operation on
each probed camera.

Call the .init() subdev operation at remote bound time and toggle
the reverse channel amplitude to compensate for the remote ends
noise immunity threshold.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/max9286.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index 7913b5f2249e..c41284de89b6 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -554,25 +554,39 @@ static int max9286_notify_bound(struct v4l2_async_notifier *notifier,
 	dev_dbg(&priv->client->dev, "Bound %s pad: %u on index %u\n",
 		subdev->name, src_pad, index);
 
+	/*
+	 * Initialize the remote camera. Increase the channel amplitude
+	 * to compensate for the remote noise immunity threshold.
+	 */
+	max9286_reverse_channel_setup(priv, MAX9286_REV_AMP_HIGH);
+	ret = v4l2_subdev_call(subdev, core, init, 0);
+	if (ret) {
+		dev_err(&priv->client->dev,
+			"Failed to initialize camera device %u\n", index);
+		return ret;
+	}
+
 	/*
 	 * We can only register v4l2_async_notifiers, which do not provide a
 	 * means to register a complete callback. bound_sources allows us to
 	 * identify when all remote serializers have completed their probe.
 	 */
-	if (priv->bound_sources != priv->source_mask)
+	if (priv->bound_sources != priv->source_mask) {
+		/*
+		 * If not all remotes have probed yet, restore the initial
+		 * reverse channel amplitude to allow the next camera to probe.
+		 */
+		max9286_reverse_channel_setup(priv, priv->init_rev_chan_mv);
 		return 0;
+	}
 
 	/*
 	 * All enabled sources have probed and enabled their reverse control
 	 * channels:
-	 *
-	 * - Increase the reverse channel amplitude to compensate for the
-	 *   remote ends high threshold
 	 * - Verify all configuration links are properly detected
 	 * - Disable auto-ack as communication on the control channel are now
 	 *   stable.
 	 */
-	max9286_reverse_channel_setup(priv, MAX9286_REV_AMP_HIGH);
 	max9286_check_config_link(priv, priv->source_mask);
 
 	/*
-- 
2.30.0

