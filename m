Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE6CC4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 06:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2BD2186A
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 06:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfDEGDt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:03:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38139 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEGDt (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 02:03:49 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hCHwl-00081Z-US; Fri, 05 Apr 2019 08:03:27 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hCHwh-0003Lg-0S; Fri, 05 Apr 2019 08:03:23 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/13] dt-bindings: connector: analog: add tv norms property
Date:   Fri,  5 Apr 2019 08:03:05 +0200
Message-Id: <20190405060317.11240-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405060317.11240-1-m.felsch@pengutronix.de>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
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

Some connectors no matter if in- or output supports only a limited
range of tv norms. It doesn't matter if the hardware behind that
connector supports more than the listed formats since the users are
restriced by a label e.g. to plug only a camera into this connector
which uses the PAL format.

This patch adds the capability to describe such limitation within the
firmware. There are no format restrictions if the property isn't
present, so it's completely backward compatible.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/connector/analog-tv-connector.txt |  4 ++
 include/dt-bindings/media/tvnorms.h           | 42 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 include/dt-bindings/media/tvnorms.h

diff --git a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
index 0c0970c210ab..346f8937a0b7 100644
--- a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
+++ b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
@@ -6,6 +6,9 @@ Required properties:
 
 Optional properties:
 - label: a symbolic name for the connector
+- tvnorms: limit the supported tv norms on a connector to the given ones else
+           all tv norms are allowed. Possible video standards are defined in
+           include/dt-bindings/media/tvnorms.h.
 
 Required nodes:
 - Video port for TV input
@@ -16,6 +19,7 @@ Example
 tv: connector {
 	compatible = "composite-video-connector";
 	label = "tv";
+	tvnorms = <(TVNORM_PAL_M | TVNORM_NTSC_M)>;
 
 	port {
 		tv_connector_in: endpoint {
diff --git a/include/dt-bindings/media/tvnorms.h b/include/dt-bindings/media/tvnorms.h
new file mode 100644
index 000000000000..ec3b414a7a00
--- /dev/null
+++ b/include/dt-bindings/media/tvnorms.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only or X11 */
+/*
+ * Copyright 2019 Pengutronix, Marco Felsch <kernel@pengutronix.de>
+ */
+
+#ifndef _DT_BINDINGS_MEDIA_TVNORMS_H
+#define _DT_BINDINGS_MEDIA_TVNORMS_H
+
+/* one bit for each */
+#define TVNORM_PAL_B          0x00000001
+#define TVNORM_PAL_B1         0x00000002
+#define TVNORM_PAL_G          0x00000004
+#define TVNORM_PAL_H          0x00000008
+#define TVNORM_PAL_I          0x00000010
+#define TVNORM_PAL_D          0x00000020
+#define TVNORM_PAL_D1         0x00000040
+#define TVNORM_PAL_K          0x00000080
+
+#define TVNORM_PAL_M          0x00000100
+#define TVNORM_PAL_N          0x00000200
+#define TVNORM_PAL_Nc         0x00000400
+#define TVNORM_PAL_60         0x00000800
+
+#define TVNORM_NTSC_M         0x00001000	/* BTSC */
+#define TVNORM_NTSC_M_JP      0x00002000	/* EIA-J */
+#define TVNORM_NTSC_443       0x00004000
+#define TVNORM_NTSC_M_KR      0x00008000	/* FM A2 */
+
+#define TVNORM_SECAM_B        0x00010000
+#define TVNORM_SECAM_D        0x00020000
+#define TVNORM_SECAM_G        0x00040000
+#define TVNORM_SECAM_H        0x00080000
+#define TVNORM_SECAM_K        0x00100000
+#define TVNORM_SECAM_K1       0x00200000
+#define TVNORM_SECAM_L        0x00400000
+#define TVNORM_SECAM_LC       0x00800000
+
+/* ATSC/HDTV */
+#define TVNORM_ATSC_8_VSB     0x01000000
+#define TVNORM_ATSC_16_VSB    0x02000000
+
+#endif /* _DT_BINDINGS_MEDIA_TVNORMS_H */
-- 
2.20.1

