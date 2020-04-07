Return-Path: <SRS0=K/Uv=5X=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28046C2BB55
	for <linux-media@archiver.kernel.org>; Tue,  7 Apr 2020 16:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB442072A
	for <linux-media@archiver.kernel.org>; Tue,  7 Apr 2020 16:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgDGQfj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:35:39 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47691 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgDGQfj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 7 Apr 2020 12:35:39 -0400
X-Originating-IP: 2.224.242.101
Received: from localhost.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 51D7640012;
        Tue,  7 Apr 2020 16:35:36 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@google.com, pavel@ucw.cz
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), libcamera-devel@lists.libcamera.org
Subject: [PATCH v8 04/11] media: v4l2-ctrl: Document V4L2_CID_CAMERA_SENSOR_ROTATION
Date:   Tue,  7 Apr 2020 18:38:18 +0200
Message-Id: <20200407163825.1766483-5-jacopo@jmondi.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407163825.1766483-1-jacopo@jmondi.org>
References: <20200407163825.1766483-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add documentation for the V4L2_CID_CAMERA_SENSOR_ROTATION camera
control. The newly added read-only control reports the rotation
correction to be applied to images before displaying them to the user.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 .../media/uapi/v4l/ext-ctrls-camera.rst       | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
index b151c016256c..0fab9b004015 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
@@ -542,6 +542,127 @@ enum v4l2_scene_mode -
 
 
 
+``V4L2_CID_CAMERA_SENSOR_ROTATION (integer)``
+    This read-only control describes the rotation correction in degrees in the
+    counter-clockwise direction to be applied to the captured images once
+    captured to memory to compensate for the camera sensor mounting rotation.
+
+    For a precise definition of the sensor mounting rotation refer to the
+    extensive description of the 'rotation' properties in the device tree
+    bindings file 'video-interfaces.txt'.
+
+    A few examples are below reported, using a shark swimming from left to
+    right in front of the user as the example scene to capture. ::
+
+                 0               X-axis
+               0 +------------------------------------->
+                 !
+                 !
+                 !
+                 !           |\____)\___
+                 !           ) _____  __`<
+                 !           |/     )/
+                 !
+                 !
+                 !
+                 V
+               Y-axis
+
+    Example one - Webcam
+
+    Assuming you can bring your laptop with you while swimming with sharks,
+    the camera module of the laptop is installed on the user facing part of a
+    laptop screen casing, and is typically used for video calls. The captured
+    images are meant to be displayed in landscape mode (width > height) on the
+    laptop screen.
+
+    The camera is typically mounted upside-down to compensate the lens optical
+    inversion effect. In this case the value of the
+    V4L2_CID_CAMERA_SENSOR_ROTATION control is 0, no rotation is required to
+    display images correctly to the user.
+
+    If the camera sensor is not mounted upside-down it is required to compensate
+    the lens optical inversion effect and the value of the
+    V4L2_CID_CAMERA_SENSOR_ROTATION control is 180 degrees, as images will
+    result rotated when captured to memory. ::
+
+                 +--------------------------------------+
+                 !                                      !
+                 !                                      !
+                 !                                      !
+                 !              __/(_____/|             !
+                 !            >.___  ____ (             !
+                 !                 \(    \|             !
+                 !                                      !
+                 !                                      !
+                 !                                      !
+                 +--------------------------------------+
+
+    A software rotation correction of 180 degrees has to be applied to correctly
+    display the image on the user screen. ::
+
+                 +--------------------------------------+
+                 !                                      !
+                 !                                      !
+                 !                                      !
+                 !             |\____)\___              !
+                 !             ) _____  __`<            !
+                 !             |/     )/                !
+                 !                                      !
+                 !                                      !
+                 !                                      !
+                 +--------------------------------------+
+
+    Example two - Phone camera
+
+    It is more handy to go and swim with sharks with only your mobile phone
+    with you and take pictures with the camera that is installed on the back
+    side of the device, facing away from the user. The captured images are meant
+    to be displayed in portrait mode (height > width) to match the device screen
+    orientation and the device usage orientation used when taking the picture.
+
+    The camera sensor is typically mounted with its pixel array longer side
+    aligned to the device longer side, upside-down mounted to compensate for
+    the lens optical inversion effect.
+
+    The images once captured to memory will be rotated and the value of the
+    V4L2_CID_CAMERA_SENSOR_ROTATION will report a 90 degree rotation. ::
+
+
+                 +-------------------------------------+
+                 |                 _ _                 |
+                 |                \   /                |
+                 |                 | |                 |
+                 |                 | |                 |
+                 |                 |  >                |
+                 |                <  |                 |
+                 |                 | |                 |
+                 |                   .                 |
+                 |                  V                  |
+                 +-------------------------------------+
+
+    A correction of 90 degrees in counter-clockwise direction has to be
+    applied to correctly display the image in portrait mode on the device
+    screen. ::
+
+                          +--------------------+
+                          |                    |
+                          |                    |
+                          |                    |
+                          |                    |
+                          |                    |
+                          |                    |
+                          |   |\____)\___      |
+                          |   ) _____  __`<    |
+                          |   |/     )/        |
+                          |                    |
+                          |                    |
+                          |                    |
+                          |                    |
+                          |                    |
+                          +--------------------+
+
+
 .. [#f1]
    This control may be changed to a menu control in the future, if more
    options are required.
-- 
2.26.0

