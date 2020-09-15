Return-Path: <SRS0=a2Vr=CY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6A7C2D0E0
	for <linux-media@archiver.kernel.org>; Tue, 15 Sep 2020 12:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB59120936
	for <linux-media@archiver.kernel.org>; Tue, 15 Sep 2020 12:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIOMgC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 15 Sep 2020 08:36:02 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41135 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIOMfx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 15 Sep 2020 08:35:53 -0400
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 666011BF20C;
        Tue, 15 Sep 2020 12:35:42 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2] media: i2c: max9286: Fix async subdev size
Date:   Tue, 15 Sep 2020 14:39:14 +0200
Message-Id: <20200915123914.22807-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Since
commit 86d37bf31af6 ("media: i2c: max9286: Allocate v4l2_async_subdev dynamically")
the async subdevice registered to the max9286 notifier is dynamically
allocated by the v4l2 framework by using the
v4l2_async_notifier_add_fwnode_subdev() function. In order to allocate
enough space for max9286_asd structure that encloses the async subdevice
paired with a pointer to the corresponding source, pass to the framework
the size of the whole structure in place of the one of the enclosed async
subdev.

Fixes: 86d37bf31af6 ("media: i2c: max9286: Allocate v4l2_async_subdev dynamically")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/max9286.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index c82c1493e099..6852448284ea 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -577,10 +577,11 @@ static int max9286_v4l2_notifier_register(struct max9286_priv *priv)
 	for_each_source(priv, source) {
 		unsigned int i = to_index(priv, source);
 		struct v4l2_async_subdev *asd;
+		struct max9286_asd *masd;

 		asd = v4l2_async_notifier_add_fwnode_subdev(&priv->notifier,
 							    source->fwnode,
-							    sizeof(*asd));
+							    sizeof(*masd));
 		if (IS_ERR(asd)) {
 			dev_err(dev, "Failed to add subdev for source %u: %ld",
 				i, PTR_ERR(asd));
@@ -588,7 +589,8 @@ static int max9286_v4l2_notifier_register(struct max9286_priv *priv)
 			return PTR_ERR(asd);
 		}

-		to_max9286_asd(asd)->source = source;
+		masd = to_max9286_asd(asd);
+		masd->source = source;
 	}

 	priv->notifier.ops = &max9286_notify_ops;
--
2.28.0

