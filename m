Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCBEC10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F9420880
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfDOMor (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:44:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60997 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfDOMof (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 08:44:35 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yJ-0000RM-7l; Mon, 15 Apr 2019 14:44:27 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yG-00025G-Ut; Mon, 15 Apr 2019 14:44:24 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v6 02/13] media: v4l2-fwnode: add v4l2_fwnode_connector
Date:   Mon, 15 Apr 2019 14:44:02 +0200
Message-Id: <20190415124413.18456-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415124413.18456-1-m.felsch@pengutronix.de>
References: <20190415124413.18456-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Currently every driver needs to parse the connector endpoints by it self.
This is the initial work to make this generic. The generic connector has
some common fields and some connector specific parts. The generic one
includes:
  - type
  - label
  - remote_port (the port where the connector is connected to)
  - remote_id   (the endpoint where the connector is connected to)

The specific fields are within a union, since only one of them can be
available at the time. Since this is the initial support the patch adds
only the analog-connector specific ones.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
[1] https://patchwork.kernel.org/cover/10794703/

v6:
- fix some spelling and style issues
- rm unnecessary comments
- drop vga and dvi connector

v2-v4:
- nothing since the patch was squashed from series [1] into this
  series.

 include/media/v4l2-connector.h | 30 ++++++++++++++++++++++++++++++
 include/media/v4l2-fwnode.h    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 include/media/v4l2-connector.h

diff --git a/include/media/v4l2-connector.h b/include/media/v4l2-connector.h
new file mode 100644
index 000000000000..3a951c54f50e
--- /dev/null
+++ b/include/media/v4l2-connector.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * v4l2-connector.h
+ *
+ * V4L2 connector types.
+ *
+ * Copyright 2019 Pengutronix, Marco Felsch <kernel@pengutronix.de>
+ */
+
+#ifndef V4L2_CONNECTOR_H
+#define V4L2_CONNECTOR_H
+
+#define V4L2_CONNECTOR_MAX_LABEL 41
+
+/**
+ * enum v4l2_connector_type - connector type
+ * @V4L2_CON_UNKNOWN:   unknown connector type, no V4L2 connetor configuration
+ * @V4L2_CON_COMPOSITE: analog composite connector
+ * @V4L2_CON_SVIDEO:    analog svideo connector
+ * @V4L2_CON_HDMI:      digital hdmi connector
+ */
+enum v4l2_connector_type {
+	V4L2_CON_UNKNOWN,
+	V4L2_CON_COMPOSITE,
+	V4L2_CON_SVIDEO,
+	V4L2_CON_HDMI,
+};
+
+#endif /* V4L2_CONNECTOR_H */
+
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index 6c07825e18b9..f4df1b95c5ef 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+#include <media/v4l2-connector.h>
 #include <media/v4l2-mediabus.h>
 #include <media/v4l2-subdev.h>
 
@@ -126,6 +127,38 @@ struct v4l2_fwnode_link {
 	unsigned int remote_port;
 };
 
+/**
+ * struct v4l2_fwnode_connector_analog - analog connector data structure
+ * @supported_tvnorms: tv norms this connector supports, set to V4L2_STD_ALL
+ *                     if no restrictions are specified.
+ */
+struct v4l2_fwnode_connector_analog {
+	v4l2_std_id supported_tvnorms;
+};
+
+/**
+ * struct v4l2_fwnode_connector - the connector data structure
+ * @remote_port: identifier of the remote endpoint port the connector connects
+ *		 to
+ * @remote_id: identifier of the remote endpoint the connector connects to
+ * @label: connetor label
+ * @type: connector type
+ * @connector: connector configuration
+ * @connector.analog: analog connector configuration
+ *                    &struct v4l2_fwnode_connector_analog
+ */
+struct v4l2_fwnode_connector {
+	unsigned int remote_port;
+	unsigned int remote_id;
+	char label[V4L2_CONNECTOR_MAX_LABEL];
+	enum v4l2_connector_type type;
+
+	union {
+		struct v4l2_fwnode_connector_analog analog;
+		/* future connectors */
+	} connector;
+};
+
 /**
  * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
  * @fwnode: pointer to the endpoint's fwnode handle
-- 
2.20.1

