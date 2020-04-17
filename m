Return-Path: <SRS0=fNsq=6B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16505C2D0EF
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AD1208E4
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 12:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgDQMiX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:38:23 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43589 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgDQMiX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 17 Apr 2020 08:38:23 -0400
X-Originating-IP: 87.13.136.104
Received: from uno.homenet.telecomitalia.it (unknown [87.13.136.104])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5DC8D6001A;
        Fri, 17 Apr 2020 12:38:17 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@google.com, pavel@ucw.cz
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), libcamera-devel@lists.libcamera.org
Subject: [PATCH v9 02/11] media: v4l2-ctrl: Document V4L2_CID_CAMERA_SENSOR_LOCATION
Date:   Fri, 17 Apr 2020 14:41:01 +0200
Message-Id: <20200417124110.72313-3-jacopo@jmondi.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417124110.72313-1-jacopo@jmondi.org>
References: <20200417124110.72313-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add documentation for the V4L2_CID_CAMERA_SENSOR_LOCATION camera
control. The newly added read-only control reports the camera device
mounting position.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 .../media/v4l/ext-ctrls-camera.rst            | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index e39f84d2447f..01a9042d53a6 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -510,6 +510,38 @@ enum v4l2_scene_mode -
     value down. A value of zero stops the motion if one is in progress
     and has no effect otherwise.
 
+``V4L2_CID_CAMERA_SENSOR_LOCATION (integer)``
+    This read-only control describes the camera sensor location by reporting
+    its mounting position on the device where the camera is installed. The
+    control value is constant and not modifiable by software. This control is
+    particularly meaningful for devices which have a well defined orientation,
+    such as phones, laptops and portable devices since the camera location is
+    expressed as a position relative to the device's intended usage orientation.
+    For example, a camera sensor installed on the user-facing side of a phone,
+    a tablet or a laptop device is said to be installed in the
+    ``V4L2_LOCATION_FRONT`` location while camera sensors installed on the side
+    opposite the front one are said to be installed in the
+    ``V4L2_LOCATION_BACK`` location. Camera sensors not directly attached to
+    the device or attached in a way that allows them to move freely, such as
+    webcams and digital cameras, are said to have the ``V4L2_LOCATION_EXTERNAL``
+    location.
+
+
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LOCATION_FRONT``
+      - The camera sensor is located on the front side of the device.
+    * - ``V4L2_LOCATION_BACK``
+      - The camera sensor is located on the back side of the device.
+    * - ``V4L2_LOCATION_EXTERNAL``
+      - The camera sensor is not directly attached to the device and is
+        freely movable.
+
+
+
 .. [#f1]
    This control may be changed to a menu control in the future, if more
    options are required.
-- 
2.26.1

