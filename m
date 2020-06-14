Return-Path: <SRS0=EymB=74=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE2BC433E1
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A93520747
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IvqepTg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFOABK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:01:10 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33330 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgFOABH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 20:01:07 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D30E19EE;
        Mon, 15 Jun 2020 02:00:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592179233;
        bh=ffNGxeVl6v3t57G4qSzsUB+iWuZXbxarMSYilAPzqxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvqepTg3/Y9W9fFlY9Yy1bNceBwwo7T3mOpCtLPHsFpEAWPS6Z9gEeTvCWvOxg/39
         lkKzP/SqwPlSVOxOqKL3JFi2HHbhWHRCZmlpw2j2oddlAOXcZkeFm4dmFxpAAYPl2u
         BYZz+iCLGT49Y9xg8lTWPNCvptcFS4wKFl0abXxE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v1 049/107] media: ti-vpe: cal: Use of_graph_get_endpoint_by_regs() to parse OF
Date:   Mon, 15 Jun 2020 02:58:46 +0300
Message-Id: <20200614235944.17716-50-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
References: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Replace the manual of_get_next_port() and of_get_next_endpoint()
implementations and the corresponding logic in the caller with a call to
of_graph_get_endpoint_by_regs(). This greatly simplifies OF parsing.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c | 114 ++--------------------------
 1 file changed, 7 insertions(+), 107 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index c1866e58e9ec..7f2f206f578b 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -2008,125 +2008,26 @@ static const struct v4l2_async_notifier_operations cal_async_ops = {
 	.complete = cal_async_complete,
 };
 
-static struct device_node *
-of_get_next_port(const struct device_node *parent,
-		 struct device_node *prev)
-{
-	struct device_node *port;
-
-	if (!parent)
-		return NULL;
-
-	if (!prev) {
-		struct device_node *ports;
-		/*
-		 * It's the first call, we have to find a port subnode
-		 * within this node or within an optional 'ports' node.
-		 */
-		ports = of_get_child_by_name(parent, "ports");
-		if (ports)
-			parent = ports;
-
-		port = of_get_child_by_name(parent, "port");
-
-		/* release the 'ports' node */
-		of_node_put(ports);
-	} else {
-		struct device_node *ports;
-
-		ports = of_get_parent(prev);
-		if (!ports)
-			return NULL;
-
-		do {
-			port = of_get_next_child(ports, prev);
-			if (!port) {
-				of_node_put(ports);
-				return NULL;
-			}
-			prev = port;
-		} while (!of_node_name_eq(port, "port"));
-		of_node_put(ports);
-	}
-
-	return port;
-}
-
-static struct device_node *
-of_get_next_endpoint(const struct device_node *parent,
-		     struct device_node *prev)
-{
-	struct device_node *ep;
-
-	if (!parent)
-		return NULL;
-
-	do {
-		ep = of_get_next_child(parent, prev);
-		if (!ep)
-			return NULL;
-		prev = ep;
-	} while (!of_node_name_eq(ep, "endpoint"));
-
-	return ep;
-}
-
 static int of_cal_create_instance(struct cal_ctx *ctx, int inst)
 {
 	struct platform_device *pdev = ctx->cal->pdev;
-	struct device_node *ep_node, *port, *sensor_node, *parent;
+	struct device_node *ep_node, *sensor_node;
 	struct v4l2_fwnode_endpoint *endpoint;
 	struct v4l2_async_subdev *asd;
-	u32 regval = 0;
-	int ret, index, lane;
-	bool found_port = false;
-
-	parent = pdev->dev.of_node;
+	int ret = -EINVAL, lane;
 
 	endpoint = &ctx->phy->endpoint;
 
-	ep_node = NULL;
-	port = NULL;
-	sensor_node = NULL;
-	ret = -EINVAL;
-
-	ctx_dbg(3, ctx, "Scanning Port node for csi2 port: %d\n", inst);
-	for (index = 0; index < CAL_NUM_CSI2_PORTS; index++) {
-		port = of_get_next_port(parent, port);
-		if (!port) {
-			ctx_dbg(1, ctx, "No port node found for csi2 port:%d\n",
-				index);
-			goto cleanup_exit;
-		}
-
-		/* Match the slice number with <REG> */
-		of_property_read_u32(port, "reg", &regval);
-		ctx_dbg(3, ctx, "port:%d inst:%d <reg>:%d\n",
-			index, inst, regval);
-		if ((regval == inst) && (index == inst)) {
-			found_port = true;
-			break;
-		}
-	}
-
-	if (!found_port) {
-		ctx_dbg(1, ctx, "No port node matches csi2 port:%d\n",
-			inst);
-		goto cleanup_exit;
-	}
-
-	ctx_dbg(3, ctx, "Scanning sub-device for csi2 port: %d\n",
-		inst);
-
-	ep_node = of_get_next_endpoint(port, ep_node);
+	ctx_dbg(3, ctx, "Getting endpoint for port@%d\n", inst);
+	ep_node = of_graph_get_endpoint_by_regs(pdev->dev.of_node, inst, 0);
 	if (!ep_node) {
-		ctx_dbg(3, ctx, "can't get next endpoint\n");
-		goto cleanup_exit;
+		ctx_dbg(3, ctx, "Can't get endpoint\n");
+		return -EINVAL;
 	}
 
 	sensor_node = of_graph_get_remote_port_parent(ep_node);
 	if (!sensor_node) {
-		ctx_dbg(3, ctx, "can't get remote parent\n");
+		ctx_dbg(3, ctx, "Can't get remote parent\n");
 		goto cleanup_exit;
 	}
 
@@ -2187,7 +2088,6 @@ static int of_cal_create_instance(struct cal_ctx *ctx, int inst)
 cleanup_exit:
 	of_node_put(sensor_node);
 	of_node_put(ep_node);
-	of_node_put(port);
 
 	return ret;
 }
-- 
Regards,

Laurent Pinchart

