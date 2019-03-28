Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A350C10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598F92173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iM1UB/1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfC1HIS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:08:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43714 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HIS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:08:18 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A607154D;
        Thu, 28 Mar 2019 08:08:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756896;
        bh=nti/cxEaJeh9hX60Hp2nKemkubXolrV6VpFDk7m7YXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iM1UB/1HvTRtV7JBZST7+UekdkooJiZlxDmB20s0QW0/1BjFuAvCibwoP48NLu67K
         3p1zGPbYGDdWC4wuy1U346XV/3p9gAvRltTElCY4gNUQiRzjBgrw73O+vNWYAEF/6W
         YdGvYWGIq8pFIIa4uTtNDkd0NSdOIVEGiXv1NsjI=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 2/9] v4l: Add definitions for missing 16-bit RGB4444 formats
Date:   Thu, 28 Mar 2019 09:07:16 +0200
Message-Id: <20190328070723.26553-3-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The V4L2 API is missing the 16-bit RGB4444 formats for the RGBA, RGBX,
ABGR, XBGR, BGRA and BGRX component orders. Add them, using the same
4CCs as DRM.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 138 ++++++++++++++++++
 include/uapi/linux/videodev2.h                |   6 +
 2 files changed, 144 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
index 055f9c89e787..b475cbba492f 100644
--- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
@@ -139,6 +139,144 @@ next to each other in memory.
       - r\ :sub:`1`
       - r\ :sub:`0`
       -
+    * .. _V4L2-PIX-FMT-RGBA444:
+
+      - ``V4L2_PIX_FMT_RGBA444``
+      - 'RA12'
+
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - a\ :sub:`3`
+      - a\ :sub:`2`
+      - a\ :sub:`1`
+      - a\ :sub:`0`
+
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      -
+    * .. _V4L2-PIX-FMT-RGBX444:
+
+      - ``V4L2_PIX_FMT_RGBX444``
+      - 'RX12'
+
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      -
+      -
+      -
+      -
+
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      -
+    * .. _V4L2-PIX-FMT-ABGR444:
+
+      - ``V4L2_PIX_FMT_ABGR444``
+      - 'AB12'
+
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+
+      - a\ :sub:`3`
+      - a\ :sub:`2`
+      - a\ :sub:`1`
+      - a\ :sub:`0`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      -
+    * .. _V4L2-PIX-FMT-XBGR444:
+
+      - ``V4L2_PIX_FMT_XBGR444``
+      - 'XB12'
+
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+
+      -
+      -
+      -
+      -
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      -
+    * .. _V4L2-PIX-FMT-BGRA444:
+
+      - ``V4L2_PIX_FMT_BGRA444``
+      - 'BA12'
+
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - a\ :sub:`3`
+      - a\ :sub:`2`
+      - a\ :sub:`1`
+      - a\ :sub:`0`
+
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      -
+    * .. _V4L2-PIX-FMT-BGRX444:
+
+      - ``V4L2_PIX_FMT_BGRX444``
+      - 'BX12'
+
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      -
+      -
+      -
+      -
+
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      -
     * .. _V4L2-PIX-FMT-ARGB555:
 
       - ``V4L2_PIX_FMT_ARGB555``
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 4e5222726719..df9fa78a6ab7 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -514,6 +514,12 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_RGB444  v4l2_fourcc('R', '4', '4', '4') /* 16  xxxxrrrr ggggbbbb */
 #define V4L2_PIX_FMT_ARGB444 v4l2_fourcc('A', 'R', '1', '2') /* 16  aaaarrrr ggggbbbb */
 #define V4L2_PIX_FMT_XRGB444 v4l2_fourcc('X', 'R', '1', '2') /* 16  xxxxrrrr ggggbbbb */
+#define V4L2_PIX_FMT_RGBA444 v4l2_fourcc('R', 'A', '1', '2') /* 16  rrrrgggg bbbbaaaa */
+#define V4L2_PIX_FMT_RGBX444 v4l2_fourcc('R', 'X', '1', '2') /* 16  rrrrgggg bbbbxxxx */
+#define V4L2_PIX_FMT_ABGR444 v4l2_fourcc('A', 'B', '1', '2') /* 16  aaaabbbb ggggrrrr */
+#define V4L2_PIX_FMT_XBGR444 v4l2_fourcc('X', 'B', '1', '2') /* 16  xxxxbbbb ggggrrrr */
+#define V4L2_PIX_FMT_BGRA444 v4l2_fourcc('B', 'A', '1', '2') /* 16  bbbbgggg rrrraaaa */
+#define V4L2_PIX_FMT_BGRX444 v4l2_fourcc('B', 'X', '1', '2') /* 16  bbbbgggg rrrrxxxx */
 #define V4L2_PIX_FMT_RGB555  v4l2_fourcc('R', 'G', 'B', 'O') /* 16  RGB-5-5-5     */
 #define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
 #define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
-- 
Regards,

Laurent Pinchart

