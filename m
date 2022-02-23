Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A9FC433F5
	for <linux-media@archiver.kernel.org>; Wed, 23 Feb 2022 09:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiBWJzp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Feb 2022 04:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiBWJzo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Feb 2022 04:55:44 -0500
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 01:55:17 PST
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.eu [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0632388B21
        for <linux-media@vger.kernel.org>; Wed, 23 Feb 2022 01:55:16 -0800 (PST)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::c1:2])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 1569A634C91;
        Wed, 23 Feb 2022 11:49:06 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 1/1] v4l: fwnode: Remove now-redundant loop from v4l2_fwnode_parse_reference()
Date:   Wed, 23 Feb 2022 11:47:20 +0200
Message-Id: <20220223094720.19196-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

v4l2_fwnode_parse_reference() relied on counting the number of references
for async array memory allocation. The array is long gone so remove
counting the references now.

This also changes how the function arrives in different unsuccessful
return values but the functionality remains unchanged.

Also the check for -ENODATA is removed, it was made redundant by commit
c343bc2ce2c6 ("ACPI: properties: Align return codes of
__acpi_node_get_property_reference()").

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 28 ++++++++-------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 71dcc9a96535..fe2dfc8f9d56 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -894,25 +894,8 @@ static int v4l2_fwnode_reference_parse(struct device *dev,
 	int ret;
 
 	for (index = 0;
-	     !(ret = fwnode_property_get_reference_args(dev_fwnode(dev),
-							prop, NULL, 0,
-							index, &args));
-	     index++)
-		fwnode_handle_put(args.fwnode);
-
-	if (!index)
-		return -ENOENT;
-
-	/*
-	 * Note that right now both -ENODATA and -ENOENT may signal
-	 * out-of-bounds access. Return the error in cases other than that.
-	 */
-	if (ret != -ENOENT && ret != -ENODATA)
-		return ret;
-
-	for (index = 0;
-	     !fwnode_property_get_reference_args(dev_fwnode(dev), prop, NULL,
-						 0, index, &args);
+	     !(ret = fwnode_property_get_reference_args(dev_fwnode(dev), prop,
+							NULL, 0, index, &args));
 	     index++) {
 		struct v4l2_async_subdev *asd;
 
@@ -928,7 +911,12 @@ static int v4l2_fwnode_reference_parse(struct device *dev,
 		}
 	}
 
-	return 0;
+	/* -ENOENT here means successful parsing */
+	if (ret != -ENOENT)
+		return ret;
+
+	/* Return -ENOENT if no references were found */
+	return index ?: -ENOENT;
 }
 
 /*
-- 
2.30.2

