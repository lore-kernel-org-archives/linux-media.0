Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D5C4708D
	for <linux-media@archiver.kernel.org>; Fri,  6 Jan 2023 13:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjAFNdv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Jan 2023 08:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjAFNdd (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 6 Jan 2023 08:33:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856360CF5
        for <linux-media@vger.kernel.org>; Fri,  6 Jan 2023 05:32:35 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 187B36F0;
        Fri,  6 Jan 2023 14:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673011954;
        bh=TTPvnjixzQq8nNftVB7Ltt0v1lgPrUEMfOP1BzURFHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHBJDxyBoHBT1yypox+3xi1YAdRqPTKWTpQU64DQRTU0GYNa07eykcVhGiV9UVkcX
         QQWxrYsy9E7BHxX6exwL92hqHeiby9Y2jgpr64WkP8pP9jDvm1OonvNzSDsmo0OeDc
         ieFLVXbJaQC1qnhyNMJWLhU5FWM9iVsfV7txe+oY=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 1/6] media: imx-pxp: Sort headers alphabetically
Date:   Fri,  6 Jan 2023 15:32:22 +0200
Message-Id: <20230106133227.13685-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230106133227.13685-1-laurent.pinchart@ideasonboard.com>
References: <20230106133227.13685-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Sorting headers alphabetically helps locating duplicates, and make it
easier to figure out where to insert new headers.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/nxp/imx-pxp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-pxp.c b/drivers/media/platform/nxp/imx-pxp.c
index 04cc8df2a498..dcb04217288b 100644
--- a/drivers/media/platform/nxp/imx-pxp.c
+++ b/drivers/media/platform/nxp/imx-pxp.c
@@ -20,15 +20,15 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
-#include <linux/platform_device.h>
-#include <media/v4l2-mem2mem.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-ioctl.h>
 #include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 
 #include "imx-pxp.h"
-- 
Regards,

Laurent Pinchart

