Return-Path: <SRS0=sDFD=DU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAEFC43457
	for <linux-media@archiver.kernel.org>; Tue, 13 Oct 2020 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C0D24829
	for <linux-media@archiver.kernel.org>; Tue, 13 Oct 2020 14:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgJMO16 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:27:58 -0400
Received: from retiisi.eu ([95.216.213.190]:53670 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387516AbgJMO16 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 13 Oct 2020 10:27:58 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1002])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 78C2E634C87;
        Tue, 13 Oct 2020 17:26:47 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com
Subject: [PATCH 2/2] Documentation: v4l: Document required controls on camera sensors
Date:   Tue, 13 Oct 2020 17:27:51 +0300
Message-Id: <20201013142751.26228-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201013142751.26228-1-sakari.ailus@linux.intel.com>
References: <20201013142751.26228-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Raw camera sensors connected to parallel or CSI-2 busses need to implement
V4L2_CID_LINK_FREQ control so receiver drivers can configure the hardware
accordingly.

Document this. Also say V4L2_CID_PIXEL_RATE is recommended for such
hardware.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/driver-api/media/camera-sensor.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/driver-api/media/camera-sensor.rst b/Documentation/driver-api/media/camera-sensor.rst
index 4d1ae12b9b4d..ffb0cad8137a 100644
--- a/Documentation/driver-api/media/camera-sensor.rst
+++ b/Documentation/driver-api/media/camera-sensor.rst
@@ -132,3 +132,16 @@ used to obtain device's power state after the power state transition:
 The function returns a non-zero value if it succeeded getting the power count or
 runtime PM was disabled, in either of which cases the driver may proceed to
 access the device.
+
+Controls
+--------
+
+For camera sensors that are connected to a bus where transmitter and receiver
+require common configuration set by drivers, such as CSI-2 or parallel (BT.601
+or BT.656) bus, the ``V4L2_CID_LINK_FREQ`` control is mandatory on transmitter
+drivers. Receiver drivers can use the ``V4L2_CID_LINK_FREQ`` to query the
+frequency used on the bus.
+
+The transmitter drivers should also implement ``V4L2_CID_PIXEL_RATE`` control in
+order to tell the maximum pixel rate to the receiver. This is required on raw
+camera sensors.
-- 
2.27.0

