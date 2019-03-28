Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34BAC10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D4B2173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Xv6BJHiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfC1HI2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:08:28 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43728 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HI1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:08:27 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E76E354D;
        Thu, 28 Mar 2019 08:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756905;
        bh=WapGCi9T/Df+l2nWIOycx6/EVKoG7qusmmDNeabgnxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xv6BJHiT9egCqxTyGRHNuEYduGjMLi/khszWm+SVA9/bzNDEsGmFbuljcMmFdRl0Z
         IENjvliMj6NBV+L5BZYPGWT4Xi+9yssuYmwjQM6IHWZYMp4BiB6ORfQ9/y1mwmDGZ1
         qeRzjmx0WfjUw4uZ4lAqIKv8FGC8zhN+Wr8v0KGc=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 3/9] v4l: Add definitions for missing 16-bit RGB555 formats
Date:   Thu, 28 Mar 2019 09:07:17 +0200
Message-Id: <20190328070723.26553-4-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The V4L2 API is missing the 16-bit RGB555 formats for the RGBA, RGBX,
ABGR, XBGR, BGRA and BGRX component orders. Add them, using the same
4CCs as DRM.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 138 ++++++++++++++++++
 include/uapi/linux/videodev2.h                |   6 +
 2 files changed, 144 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
index b475cbba492f..9a9c1993b0fd 100644
--- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
@@ -323,6 +323,144 @@ next to each other in memory.
       - g\ :sub:`4`
       - g\ :sub:`3`
       -
+    * .. _V4L2-PIX-FMT-RGBA555:
+
+      - ``V4L2_PIX_FMT_RGBA555``
+      - 'RA15'
+
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - a
+
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      -
+    * .. _V4L2-PIX-FMT-RGBX555:
+
+      - ``V4L2_PIX_FMT_RGBX555``
+      - 'RX15'
+
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      -
+
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      -
+    * .. _V4L2-PIX-FMT-ABGR555:
+
+      - ``V4L2_PIX_FMT_ABGR555``
+      - 'AB15'
+
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+
+      - a
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      -
+    * .. _V4L2-PIX-FMT-XBGR555:
+
+      - ``V4L2_PIX_FMT_XBGR555``
+      - 'XB15'
+
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+
+      -
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      -
+    * .. _V4L2-PIX-FMT-BGRA555:
+
+      - ``V4L2_PIX_FMT_BGRA555``
+      - 'BA15'
+
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - a
+
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      -
+    * .. _V4L2-PIX-FMT-BGRX555:
+
+      - ``V4L2_PIX_FMT_BGRX555``
+      - 'BX15'
+
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      -
+
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      -
     * .. _V4L2-PIX-FMT-RGB565:
 
       - ``V4L2_PIX_FMT_RGB565``
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index df9fa78a6ab7..fb6f01a7c91c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -523,6 +523,12 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_RGB555  v4l2_fourcc('R', 'G', 'B', 'O') /* 16  RGB-5-5-5     */
 #define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
 #define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
+#define V4L2_PIX_FMT_RGBA555 v4l2_fourcc('R', 'A', '1', '5') /* 16  RGBA-5-5-5-1  */
+#define V4L2_PIX_FMT_RGBX555 v4l2_fourcc('R', 'X', '1', '5') /* 16  RGBX-5-5-5-1  */
+#define V4L2_PIX_FMT_ABGR555 v4l2_fourcc('A', 'B', '1', '5') /* 16  ABGR-1-5-5-5  */
+#define V4L2_PIX_FMT_XBGR555 v4l2_fourcc('X', 'B', '1', '5') /* 16  XBGR-1-5-5-5  */
+#define V4L2_PIX_FMT_BGRA555 v4l2_fourcc('B', 'A', '1', '5') /* 16  BGRA-5-5-5-1  */
+#define V4L2_PIX_FMT_BGRX555 v4l2_fourcc('B', 'X', '1', '5') /* 16  BGRX-5-5-5-1  */
 #define V4L2_PIX_FMT_RGB565  v4l2_fourcc('R', 'G', 'B', 'P') /* 16  RGB-5-6-5     */
 #define V4L2_PIX_FMT_RGB555X v4l2_fourcc('R', 'G', 'B', 'Q') /* 16  RGB-5-5-5 BE  */
 #define V4L2_PIX_FMT_ARGB555X v4l2_fourcc_be('A', 'R', '1', '5') /* 16  ARGB-5-5-5 BE */
-- 
Regards,

Laurent Pinchart

