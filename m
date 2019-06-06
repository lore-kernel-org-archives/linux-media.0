Return-Path: <SRS0=7IOK=UF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919EFC28EB4
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755A920872
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 13:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfFFNCd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:02:33 -0400
Received: from retiisi.org.uk ([95.216.213.190]:49848 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbfFFNC2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 6 Jun 2019 09:02:28 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 4B445634C83;
        Thu,  6 Jun 2019 16:02:17 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        jacopo@jmondi.org, niklas.soderlund@ragnatech.se
Subject: [PATCH v2 4/9] v4l2-async: Add v4l2_async_notifier_add_fwnode_remote_subdev
Date:   Thu,  6 Jun 2019 16:02:20 +0300
Message-Id: <20190606130225.10751-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190606130225.10751-1-sakari.ailus@linux.intel.com>
References: <20190606130225.10751-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

v4l2_async_notifier_add_fwnode_remote_subdev is a convenience function for
parsing information on V4L2 fwnode subdevs.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 23 +++++++++++++++++++++++
 include/media/v4l2-async.h           | 25 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index dc4e83b4f6ba..2ea8afbcbf8f 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -609,6 +609,29 @@ v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
 }
 EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_fwnode_subdev);
 
+int
+v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif,
+					     struct fwnode_handle *endpoint,
+					     struct v4l2_async_subdev *asd)
+{
+	struct fwnode_handle *remote_ep;
+	int ret;
+
+	remote_ep = fwnode_graph_get_remote_endpoint(endpoint);
+	if (!remote_ep)
+		return -ENOTCONN;
+
+	asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
+	asd->match.fwnode = remote_ep;
+
+	ret = v4l2_async_notifier_add_subdev(notif, asd);
+	if (ret)
+		fwnode_handle_put(remote_ep);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_fwnode_remote_subdev);
+
 struct v4l2_async_subdev *
 v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
 				   int adapter_id, unsigned short address,
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index b9141ffa188a..55ce3c1672a4 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -185,6 +185,31 @@ v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
 				      unsigned int asd_struct_size);
 
 /**
+ * v4l2_async_notifier_add_fwnode_remote_subdev - Allocate and add a fwnode
+ *						  remote async subdev to the
+ *						  notifier's master asd_list.
+ *
+ * @notif: pointer to &struct v4l2_async_notifier
+ * @endpoint: local endpoint the remote sub-device to be matched
+ * @asd: Async sub-device struct allocated by the caller. The &struct
+ *	 v4l2_async_subdev shall be the first member of the driver's async
+ *	 sub-device struct, i.e. both begin at the same memory address.
+ *
+ * Gets the remote endpoint of a given local endpoint, set it up for fwnode
+ * matching and add the async sub-device to the notifier's @asd_list. The
+ * function also gets a reference of the fwnode which is released later at
+ * notifier cleanup time.
+ *
+ * This is just like @v4l2_async_notifier_add_fwnode_subdev, but with the
+ * exception that the fwnode refers to a local endpoint, not the remote one, and
+ * the function relies on the caller to allocate the async sub-device struct.
+ */
+int
+v4l2_async_notifier_add_fwnode_remote_subdev(struct v4l2_async_notifier *notif,
+					     struct fwnode_handle *endpoint,
+					     struct v4l2_async_subdev *asd);
+
+/**
  * v4l2_async_notifier_add_i2c_subdev - Allocate and add an i2c async
  *				subdev to the notifier's master asd_list.
  *
-- 
2.11.0

