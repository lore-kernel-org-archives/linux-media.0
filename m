Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D4FC49EA5
	for <linux-media@archiver.kernel.org>; Wed, 16 Jun 2021 12:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF7C60FDB
	for <linux-media@archiver.kernel.org>; Wed, 16 Jun 2021 12:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhFPMr5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:47:57 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37285 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhFPMr4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Jun 2021 08:47:56 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6D0331C0017;
        Wed, 16 Jun 2021 12:45:47 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 05/15] media: i2c: max9286: Rework comments in .bound()
Date:   Wed, 16 Jun 2021 14:46:06 +0200
Message-Id: <20210616124616.49249-6-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616124616.49249-1-jacopo+renesas@jmondi.org>
References: <20210616124616.49249-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Rephrase a comment in .bound() callback to make it clear we register
a subdev notifier and remove a redundant comment about disabling i2c
auto-ack.

No functional changes intended.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/max9286.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index 9124d5fa6ea3..e1c7173f2d00 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -556,9 +556,9 @@ static int max9286_notify_bound(struct v4l2_async_notifier *notifier,
 		subdev->name, src_pad, index);
 
 	/*
-	 * We can only register v4l2_async_notifiers, which do not provide a
-	 * means to register a complete callback. bound_sources allows us to
-	 * identify when all remote serializers have completed their probe.
+	 * As we register a subdev notifiers we won't get a .complete() callback
+	 * here, so we have to use bound_sources to identify when all remote
+	 * serializers have probed.
 	 */
 	if (priv->bound_sources != priv->source_mask)
 		return 0;
@@ -575,11 +575,6 @@ static int max9286_notify_bound(struct v4l2_async_notifier *notifier,
 	 */
 	max9286_reverse_channel_setup(priv, MAX9286_REV_AMP_HIGH);
 	max9286_check_config_link(priv, priv->source_mask);
-
-	/*
-	 * Re-configure I2C with local acknowledge disabled after cameras have
-	 * probed.
-	 */
 	max9286_configure_i2c(priv, false);
 
 	return max9286_set_pixelrate(priv);
-- 
2.31.1

