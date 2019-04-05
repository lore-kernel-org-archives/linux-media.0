Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911ECC4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 09:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEF521850
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 09:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfDEJl3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:41:29 -0400
Received: from retiisi.org.uk ([95.216.213.190]:40158 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730236AbfDEJl3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Apr 2019 05:41:29 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id A48FA634C80;
        Fri,  5 Apr 2019 12:40:44 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, niklas.soderlund@ragnatech.se,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH 1/9] davinci-vpif: Don't dereference endpoint after putting it, fix refcounting
Date:   Fri,  5 Apr 2019 12:41:18 +0300
Message-Id: <20190405094127.18975-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
References: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The davinci-vpif driver dereferences its local endpoints after releasing
the reference to them.

The driver also puts its endpoints explicitly while the
of_graph_get_next_endpoint() does that, too, leading to obtaining a
reference once and releasing it twice.

Both are fixed by this patch.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index b5aacb0fb96b..72bdb3c10962 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1555,7 +1555,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 		if (!rem) {
 			dev_dbg(&pdev->dev, "Remote device at %pOF not found\n",
 				endpoint);
-			of_node_put(endpoint);
 			goto done;
 		}
 
@@ -1567,7 +1566,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 					    GFP_KERNEL);
 		if (!chan->inputs) {
 			of_node_put(rem);
-			of_node_put(endpoint);
 			goto err_cleanup;
 		}
 
@@ -1578,7 +1576,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 
 		err = v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint),
 						 &bus_cfg);
-		of_node_put(endpoint);
 		if (err) {
 			dev_err(&pdev->dev, "Could not parse the endpoint\n");
 			of_node_put(rem);
@@ -1609,6 +1606,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 	}
 
 done:
+	of_node_put(endpoint);
 	pdata->asd_sizes[0] = i;
 	pdata->subdev_count = i;
 	pdata->card_name = "DA850/OMAP-L138 Video Capture";
@@ -1616,6 +1614,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 	return pdata;
 
 err_cleanup:
+	of_node_put(endpoint);
 	v4l2_async_notifier_cleanup(&vpif_obj.notifier);
 
 	return NULL;
-- 
2.11.0

