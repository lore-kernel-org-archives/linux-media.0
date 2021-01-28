Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44362C433DB
	for <linux-media@archiver.kernel.org>; Thu, 28 Jan 2021 12:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD4564DCC
	for <linux-media@archiver.kernel.org>; Thu, 28 Jan 2021 12:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhA1MQk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:16:40 -0500
Received: from retiisi.eu ([95.216.213.190]:39842 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhA1MQT (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Jan 2021 07:16:19 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id CB38C634C92;
        Thu, 28 Jan 2021 14:12:38 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, kernel@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Helen Koike <helen.koike@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v4 06/14] media: cadence: Use v4l2_async_notifier_add_fwnode_remote_subdev
Date:   Thu, 28 Jan 2021 14:09:37 +0200
Message-Id: <20210128120945.5062-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128120945.5062-1-sakari.ailus@linux.intel.com>
References: <20210128120945.5062-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

The use of v4l2_async_notifier_add_subdev will be discouraged.
Drivers are instead encouraged to use a helper such as
v4l2_async_notifier_add_fwnode_remote_subdev.

This fixes a misuse of the API, as v4l2_async_notifier_add_subdev
should get a kmalloc'ed struct v4l2_async_subdev,
removing some boilerplate code while at it.

Use the appropriate helper v4l2_async_notifier_add_fwnode_remote_subdev,
which handles the needed setup, instead of open-coding it.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index be9ec59774d6..7d299cacef8c 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -81,7 +81,6 @@ struct csi2rx_priv {
 	struct media_pad		pads[CSI2RX_PAD_MAX];
 
 	/* Remote source */
-	struct v4l2_async_subdev	asd;
 	struct v4l2_subdev		*source_subdev;
 	int				source_pad;
 };
@@ -362,6 +361,7 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
 {
 	struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
+	struct v4l2_async_subdev *asd;
 	struct fwnode_handle *fwh;
 	struct device_node *ep;
 	int ret;
@@ -395,17 +395,13 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
 		return -EINVAL;
 	}
 
-	csi2rx->asd.match.fwnode = fwnode_graph_get_remote_port_parent(fwh);
-	csi2rx->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
-	of_node_put(ep);
-
 	v4l2_async_notifier_init(&csi2rx->notifier);
 
-	ret = v4l2_async_notifier_add_subdev(&csi2rx->notifier, &csi2rx->asd);
-	if (ret) {
-		fwnode_handle_put(csi2rx->asd.match.fwnode);
-		return ret;
-	}
+	asd = v4l2_async_notifier_add_fwnode_remote_subdev(&csi2rx->notifier,
+							   fwh, sizeof(*asd));
+	of_node_put(ep);
+	if (IS_ERR(asd))
+		return PTR_ERR(asd);
 
 	csi2rx->notifier.ops = &csi2rx_notifier_ops;
 
-- 
2.29.2

