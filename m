Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA51C433E0
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 15:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A4D22B45
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 15:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbhAEPec (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:34:32 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:37698 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbhAEPec (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 5 Jan 2021 10:34:32 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3CC0100E;
        Tue,  5 Jan 2021 16:29:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609860595;
        bh=UpTOQBUpyfiHBhDq+ToymZk7Edqy7ioyf5Aw1JfgIn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxu1F/bznkBRWXDXF+iJuXQFxoOzPdg9dpFhR3Z+MtpMTgjlhrm2+YUlMSIfs+ceN
         V8HDzwSj7Bze2YQLGKQ1dkLw4z4hV1cjnA+kKsIEOMyoVnbi0shO/YJPHZ575RVcHK
         BkSuQdDwghST/0bfcZS+sgEpkJ6+BZ/qQunZ1rYc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 30/75] media: imx: imx7-media-csi: Disable legacy video node API
Date:   Tue,  5 Jan 2021 17:28:07 +0200
Message-Id: <20210105152852.5733-31-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
References: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Support for the MC-centric API has been tested on the i.MX7. Enable it
for that platform. i.MX6 should be converted next.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 466e7e3567aa..afd1a7e35bfe 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1089,7 +1089,7 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
 	}
 
 	csi->vdev = imx_media_capture_device_init(csi->sd.dev, &csi->sd,
-						  IMX7_CSI_PAD_SRC, true);
+						  IMX7_CSI_PAD_SRC, false);
 	if (IS_ERR(csi->vdev))
 		return PTR_ERR(csi->vdev);
 
-- 
Regards,

Laurent Pinchart

