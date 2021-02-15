Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2185FC433E6
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFDC64E68
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBOEeX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:34:23 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45902 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhBOEeT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Feb 2021 23:34:19 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CFEAA1961;
        Mon, 15 Feb 2021 05:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613363314;
        bh=h46O8aL94ffxw1UVjiEDisL2eYelDmPvg4QQ2RluqiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQvWd0KQVg8yceSikrXqllZS4k06e3v8T0gTzcP0SiuXjcAq2hrdFQRK/25knWPbl
         NpFlfKT2OerWMgXLwA3OScw9BiJwOOyNijYn5STw9GXuJBMQIbxUqwqrR/gdmLYKlj
         yBwnuAs7JSD0chuidQbcIXfTKm/1kho7gz9WCPP4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 31/77] media: imx: imx7-media-csi: Remove control handler
Date:   Mon, 15 Feb 2021 06:26:55 +0200
Message-Id: <20210215042741.28850-32-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
References: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The control handler isn't used, drop it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 90cf4b889e23..c64c5196939b 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -18,7 +18,6 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
-#include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
@@ -173,8 +172,6 @@ struct imx7_csi {
 	const struct imx_media_pixfmt *cc[IMX7_CSI_PADS_NUM];
 	struct v4l2_fract frame_interval[IMX7_CSI_PADS_NUM];
 
-	struct v4l2_ctrl_handler ctrl_hdlr;
-
 	void __iomem *regbase;
 	int irq;
 	struct clk *mclk;
@@ -476,8 +473,6 @@ static int imx7_csi_link_setup(struct media_entity *entity,
 		}
 		csi->sink = remote->entity;
 	} else {
-		v4l2_ctrl_handler_free(&csi->ctrl_hdlr);
-		v4l2_ctrl_handler_init(&csi->ctrl_hdlr, 0);
 		csi->sink = NULL;
 	}
 
@@ -1289,9 +1284,6 @@ static int imx7_csi_probe(struct platform_device *pdev)
 	csi->sd.grp_id = IMX_MEDIA_GRP_ID_CSI;
 	snprintf(csi->sd.name, sizeof(csi->sd.name), "csi");
 
-	v4l2_ctrl_handler_init(&csi->ctrl_hdlr, 0);
-	csi->sd.ctrl_handler = &csi->ctrl_hdlr;
-
 	for (i = 0; i < IMX7_CSI_PADS_NUM; i++)
 		csi->pad[i].flags = (i == IMX7_CSI_PAD_SINK) ?
 			MEDIA_PAD_FL_SINK : MEDIA_PAD_FL_SOURCE;
@@ -1299,7 +1291,7 @@ static int imx7_csi_probe(struct platform_device *pdev)
 	ret = media_entity_pads_init(&csi->sd.entity, IMX7_CSI_PADS_NUM,
 				     csi->pad);
 	if (ret < 0)
-		goto free;
+		goto cleanup;
 
 	ret = imx7_csi_async_register(csi);
 	if (ret)
@@ -1311,9 +1303,6 @@ static int imx7_csi_probe(struct platform_device *pdev)
 	v4l2_async_notifier_unregister(&csi->notifier);
 	v4l2_async_notifier_cleanup(&csi->notifier);
 
-free:
-	v4l2_ctrl_handler_free(&csi->ctrl_hdlr);
-
 cleanup:
 	v4l2_async_notifier_unregister(&imxmd->notifier);
 	v4l2_async_notifier_cleanup(&imxmd->notifier);
@@ -1343,7 +1332,6 @@ static int imx7_csi_remove(struct platform_device *pdev)
 	v4l2_async_notifier_unregister(&csi->notifier);
 	v4l2_async_notifier_cleanup(&csi->notifier);
 	v4l2_async_unregister_subdev(sd);
-	v4l2_ctrl_handler_free(&csi->ctrl_hdlr);
 
 	mutex_destroy(&csi->lock);
 
-- 
Regards,

Laurent Pinchart

