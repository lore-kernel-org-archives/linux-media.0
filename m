Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2F3C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CFA20811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfC1UGf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:06:35 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42461 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfC1UGf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:06:35 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 653BFE0020;
        Thu, 28 Mar 2019 20:06:32 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 31/31] media: rcar-csi2: Implement has_route()
Date:   Thu, 28 Mar 2019 21:06:08 +0100
Message-Id: <20190328200608.9463-32-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Now that the rcar-csi2 subdevice supports internal routing, add an
has_route() operation used during graph traversal.

The internal routing between the sink and the source pads depends on the
virtual channel used to transmit the video stream from the remote
subdevice to the R-Car CSI-2 receiver.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index 54713e9e5366..5ec2947a0732 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -1028,7 +1028,39 @@ static int rcsi2_confirm_start_v3m_e3(struct rcar_csi2 *priv)
  * Platform Device Driver.
  */
 
+static bool rcar_csi2_has_route(struct media_entity *entity,
+				unsigned int pad0, unsigned int pad1)
+{
+	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
+	struct rcar_csi2 *priv = sd_to_csi2(sd);
+	struct v4l2_mbus_frame_desc fd;
+	unsigned int i;
+
+	/* Support only direct sink->source routes. */
+	if (pad0 != RCAR_CSI2_SINK)
+		return false;
+
+	/* Get the frame description: already validate at 'bound' time. */
+	rcsi2_get_remote_frame_desc(priv, &fd);
+	for (i = 0; i < fd.num_entries; i++) {
+		struct v4l2_mbus_frame_desc_entry *entry = &fd.entry[i];
+		int source_pad = rcsi2_vc_to_pad(entry->bus.csi2.channel);
+
+		if (source_pad < 0) {
+			dev_err(priv->dev, "Virtual Channel out of range: %u\n",
+				entry->bus.csi2.channel);
+			return false;
+		}
+
+		if (source_pad == pad1)
+			return true;
+	}
+
+	return false;
+}
+
 static const struct media_entity_operations rcar_csi2_entity_ops = {
+	.has_route = rcar_csi2_has_route,
 	.link_validate = v4l2_subdev_link_validate,
 };
 
-- 
2.21.0

