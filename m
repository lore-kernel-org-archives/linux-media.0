Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F51C10F11
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA8820811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfC1UF4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:05:56 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56371 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfC1UFz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:05:55 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2FC72E001B;
        Thu, 28 Mar 2019 20:05:53 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v4 09/31] media: entity: Add media_entity_has_route() function
Date:   Thu, 28 Mar 2019 21:05:46 +0100
Message-Id: <20190328200608.9463-10-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

This is a wrapper around the media entity has_route operation.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/media-entity.c | 19 +++++++++++++++++++
 include/media/media-entity.h | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/media/media-entity.c b/drivers/media/media-entity.c
index 21278a4c6362..451dfdf5e44f 100644
--- a/drivers/media/media-entity.c
+++ b/drivers/media/media-entity.c
@@ -237,6 +237,25 @@ EXPORT_SYMBOL_GPL(media_entity_pads_init);
  * Graph traversal
  */
 
+bool media_entity_has_route(struct media_entity *entity, unsigned int pad0,
+			    unsigned int pad1)
+{
+	if (pad0 >= entity->num_pads || pad1 >= entity->num_pads)
+		return false;
+
+	if (pad0 == pad1)
+		return true;
+
+	if (!entity->ops || !entity->ops->has_route)
+		return true;
+
+	if (entity->pads[pad1].index < entity->pads[pad0].index)
+		swap(pad0, pad1);
+
+	return entity->ops->has_route(entity, pad0, pad1);
+}
+EXPORT_SYMBOL_GPL(media_entity_has_route);
+
 static struct media_pad *
 media_pad_other(struct media_pad *pad, struct media_link *link)
 {
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 9a7c2d33a153..af7c3ccb9959 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -906,6 +906,23 @@ int media_entity_get_fwnode_pad(struct media_entity *entity,
 __must_check int media_graph_walk_init(
 	struct media_graph *graph, struct media_device *mdev);
 
+/**
+ * media_entity_has_route - Check if two entity pads are connected internally
+ *
+ * @entity: The entity
+ * @pad0: The first pad index
+ * @pad1: The second pad index
+ *
+ * This function can be used to check whether two pads of an entity are
+ * connected internally in the entity.
+ *
+ * The caller must hold entity->graph_obj.mdev->mutex.
+ *
+ * Return: true if the pads are connected internally and false otherwise.
+ */
+bool media_entity_has_route(struct media_entity *entity, unsigned int pad0,
+			    unsigned int pad1);
+
 /**
  * media_graph_walk_cleanup - Release resources used by graph walk.
  *
-- 
2.21.0

