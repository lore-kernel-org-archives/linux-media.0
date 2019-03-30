Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A095C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 00:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A34520643
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553906341;
	bh=T4wL2Xm461B2MlwuTE5lvFaNHPi9WM1DthPIm4/QEqE=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=n4RykBn91CunDERoAuKvMzX5708kxcuQA6F4oEqirQY1ybUHBTSe9soFaWd2Fs0Wz
	 KZMS+TXlZshPT0l/QAVLsu8V2WngYoNNmhbZk9amYYFTFYWMn9o1piPXEgTDJm5efR
	 lAau8lzrIxQuceYFxhRIz0C2bUHq60qc8ge+ON5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfC3AjA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:39:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfC3AjA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 20:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=brqcF72z6OkuLIUWs3GHtrCBcw2Gs/fnIpfZvM9ogL4=; b=aWIoSmfTpV4G5oQYFEs4veHI+
        fFbyC8hsVBQ3fBtHWLzdnP6Tqnzpsv6c0undxsld67MHMfS0mB4FY9PJ9HWbrdZMFf677i5oa8HdH
        +rckASzhlSHTdxDVCqWZ2Hkmfo0N+d4NTHbV7xlKmrVa/lihS7EiS7rfi5R+r47dScbXvw1KRgEA/
        QvV8Gz76E7VnpZjikRKWda67FcruWiVlaZVEf29NJW/4ezvCsPfQLw2CqMnVBvHPwgklJsKtLDRDp
        8rhuWlPwFw9X/zASG4VNqZNggw/OwQ8y1k88QRtykdfyuz0BhkgImpj0vWce2WTNBCtJhTuHvt8UI
        iV9mjyy1g==;
Received: from [179.95.36.211] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hA21O-0006j1-BR; Sat, 30 Mar 2019 00:38:54 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hA21K-00053a-D5; Fri, 29 Mar 2019 20:38:50 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2] media: pdf docs: adjust several tables for better display
Date:   Fri, 29 Mar 2019 20:38:49 -0400
Message-Id: <94fa831e3b359f24c01b9936de33b84c38caacbb.1553906274.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Avoid cell overlapping by changing some sizes, and changing the
font sizes when needed.

Tested with Sphinx 1.7.8.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/media/uapi/v4l/buffer.rst       | 19 ++--
 .../media/uapi/v4l/colorspaces-defs.rst       |  4 +-
 Documentation/media/uapi/v4l/colorspaces.rst  |  4 +-
 Documentation/media/uapi/v4l/dev-raw-vbi.rst  |  4 +-
 Documentation/media/uapi/v4l/dev-rds.rst      |  2 +-
 .../media/uapi/v4l/dev-sliced-vbi.rst         | 22 ++---
 Documentation/media/uapi/v4l/dev-subdev.rst   | 82 ++++++++++++-----
 .../media/uapi/v4l/ext-ctrls-camera.rst       | 17 +++-
 .../media/uapi/v4l/ext-ctrls-codec.rst        | 91 ++++++++++++++++---
 .../media/uapi/v4l/ext-ctrls-detect.rst       |  2 +-
 Documentation/media/uapi/v4l/ext-ctrls-dv.rst |  2 +-
 .../media/uapi/v4l/ext-ctrls-flash.rst        |  4 +-
 .../media/uapi/v4l/ext-ctrls-jpeg.rst         |  2 +-
 Documentation/media/uapi/v4l/field-order.rst  |  4 +-
 .../media/uapi/v4l/pixfmt-meta-d4xx.rst       |  9 +-
 .../media/uapi/v4l/pixfmt-meta-vsp1-hgt.rst   |  9 ++
 .../media/uapi/v4l/pixfmt-packed-hsv.rst      |  2 +-
 .../media/uapi/v4l/pixfmt-packed-rgb.rst      |  4 +-
 .../media/uapi/v4l/pixfmt-packed-yuv.rst      |  2 +-
 .../media/uapi/v4l/pixfmt-srggb10p.rst        |  2 +-
 .../media/uapi/v4l/pixfmt-srggb12p.rst        |  3 +-
 .../media/uapi/v4l/pixfmt-srggb14p.rst        | 24 ++++-
 .../media/uapi/v4l/pixfmt-v4l2-mplane.rst     | 17 ++--
 Documentation/media/uapi/v4l/pixfmt-y10p.rst  | 10 ++
 .../media/uapi/v4l/subdev-formats.rst         |  6 +-
 25 files changed, 259 insertions(+), 88 deletions(-)

diff --git a/Documentation/media/uapi/v4l/buffer.rst b/Documentation/media/uapi/v4l/buffer.rst
index b9a2e9dc707c..1cbd9cde57f3 100644
--- a/Documentation/media/uapi/v4l/buffer.rst
+++ b/Documentation/media/uapi/v4l/buffer.rst
@@ -165,7 +165,7 @@ of appropriately sized buffers for each use case).
 struct v4l2_buffer
 ==================
 
-.. tabularcolumns:: |p{2.8cm}|p{2.5cm}|p{1.3cm}|p{10.5cm}|
+.. tabularcolumns:: |p{2.8cm}|p{2.5cm}|p{1.6cm}|p{10.2cm}|
 
 .. cssclass:: longtable
 
@@ -420,7 +420,7 @@ enum v4l2_buf_type
 
 .. cssclass:: longtable
 
-.. tabularcolumns:: |p{7.2cm}|p{0.6cm}|p{9.7cm}|
+.. tabularcolumns:: |p{7.8cm}|p{0.6cm}|p{9.1cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -482,7 +482,11 @@ enum v4l2_buf_type
 Buffer Flags
 ============
 
-.. tabularcolumns:: |p{7.0cm}|p{2.2cm}|p{8.3cm}|
+.. raw:: latex
+
+    \small
+
+.. tabularcolumns:: |p{7.0cm}|p{2.1cm}|p{8.4cm}|
 
 .. cssclass:: longtable
 
@@ -681,6 +685,9 @@ Buffer Flags
 	exposure of the frame has begun. This is only valid for the
 	``V4L2_BUF_TYPE_VIDEO_CAPTURE`` buffer type.
 
+.. raw:: latex
+
+    \normalsize
 
 
 .. c:type:: v4l2_memory
@@ -688,7 +695,7 @@ Buffer Flags
 enum v4l2_memory
 ================
 
-.. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
+.. tabularcolumns:: |p{5.0cm}|p{0.8cm}|p{11.7cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -724,7 +731,7 @@ The :c:type:`v4l2_buffer_timecode` structure is designed to hold a
 struct v4l2_timecode
 --------------------
 
-.. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.7cm}|
+.. tabularcolumns:: |p{1.4cm}|p{2.8cm}|p{12.3cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -761,7 +768,7 @@ struct v4l2_timecode
 Timecode Types
 --------------
 
-.. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
+.. tabularcolumns:: |p{5.6cm}|p{0.8cm}|p{11.1cm}|
 
 .. flat-table::
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/colorspaces-defs.rst b/Documentation/media/uapi/v4l/colorspaces-defs.rst
index c4e8fc620379..e122bbe3d799 100644
--- a/Documentation/media/uapi/v4l/colorspaces-defs.rst
+++ b/Documentation/media/uapi/v4l/colorspaces-defs.rst
@@ -39,7 +39,7 @@ whole range, 0-255, dividing the angular value by 1.41. The enum
    colorspaces except for BT.2020 which uses limited range R'G'B'
    quantization.
 
-.. tabularcolumns:: |p{6.0cm}|p{11.5cm}|
+.. tabularcolumns:: |p{6.7cm}|p{10.8cm}|
 
 .. c:type:: v4l2_colorspace
 
@@ -112,7 +112,7 @@ whole range, 0-255, dividing the angular value by 1.41. The enum
 
 .. c:type:: v4l2_ycbcr_encoding
 
-.. tabularcolumns:: |p{6.5cm}|p{11.0cm}|
+.. tabularcolumns:: |p{7.2cm}|p{10.3cm}|
 
 .. flat-table:: V4L2 Y'CbCr Encodings
     :header-rows:  1
diff --git a/Documentation/media/uapi/v4l/colorspaces.rst b/Documentation/media/uapi/v4l/colorspaces.rst
index c5a560f0c13d..4f6c82fa057f 100644
--- a/Documentation/media/uapi/v4l/colorspaces.rst
+++ b/Documentation/media/uapi/v4l/colorspaces.rst
@@ -56,9 +56,9 @@ The Y value in the CIE XYZ colorspace corresponds to luminance. Often
 the CIE XYZ colorspace is transformed to the normalized CIE xyY
 colorspace:
 
-x = X / (X + Y + Z)
+	x = X / (X + Y + Z)
 
-y = Y / (X + Y + Z)
+	y = Y / (X + Y + Z)
 
 The x and y values are the chromaticity coordinates and can be used to
 define a color without the luminance component Y. It is very confusing
diff --git a/Documentation/media/uapi/v4l/dev-raw-vbi.rst b/Documentation/media/uapi/v4l/dev-raw-vbi.rst
index d6a707f0b24f..e06b03ca2ab2 100644
--- a/Documentation/media/uapi/v4l/dev-raw-vbi.rst
+++ b/Documentation/media/uapi/v4l/dev-raw-vbi.rst
@@ -106,7 +106,7 @@ VBI devices must implement both the :ref:`VIDIOC_G_FMT <VIDIOC_G_FMT>` and
 and always returns default parameters as :ref:`VIDIOC_G_FMT <VIDIOC_G_FMT>` does.
 :ref:`VIDIOC_TRY_FMT <VIDIOC_G_FMT>` is optional.
 
-.. tabularcolumns:: |p{2.4cm}|p{4.4cm}|p{10.7cm}|
+.. tabularcolumns:: |p{1.6cm}|p{4.2cm}|p{11.7cm}|
 
 .. c:type:: v4l2_vbi_format
 
@@ -190,7 +190,7 @@ and always returns default parameters as :ref:`VIDIOC_G_FMT <VIDIOC_G_FMT>` does
 	applications must set it to zero.
 
 
-.. tabularcolumns:: |p{4.0cm}|p{1.5cm}|p{12.0cm}|
+.. tabularcolumns:: |p{4.4cm}|p{1.5cm}|p{11.6cm}|
 
 .. _vbifmt-flags:
 
diff --git a/Documentation/media/uapi/v4l/dev-rds.rst b/Documentation/media/uapi/v4l/dev-rds.rst
index 624d6f95b842..64a724ef58f5 100644
--- a/Documentation/media/uapi/v4l/dev-rds.rst
+++ b/Documentation/media/uapi/v4l/dev-rds.rst
@@ -146,7 +146,7 @@ RDS datastructures
 
 .. _v4l2-rds-block-codes:
 
-.. tabularcolumns:: |p{5.6cm}|p{2.0cm}|p{1.5cm}|p{7.0cm}|
+.. tabularcolumns:: |p{6.4cm}|p{2.0cm}|p{1.2cm}|p{7.9cm}|
 
 .. flat-table:: Block defines
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/dev-sliced-vbi.rst b/Documentation/media/uapi/v4l/dev-sliced-vbi.rst
index 0aa6cb8a272b..e86346f66017 100644
--- a/Documentation/media/uapi/v4l/dev-sliced-vbi.rst
+++ b/Documentation/media/uapi/v4l/dev-sliced-vbi.rst
@@ -118,7 +118,7 @@ struct v4l2_sliced_vbi_format
     \scriptsize
     \setlength{\tabcolsep}{2pt}
 
-.. tabularcolumns:: |p{.75cm}|p{3.3cm}|p{3.4cm}|p{3.4cm}|p{3.4cm}|
+.. tabularcolumns:: |p{.85cm}|p{3.3cm}|p{4.4cm}|p{4.4cm}|p{4.4cm}|
 
 .. cssclass:: longtable
 
@@ -223,7 +223,7 @@ Sliced VBI services
 
 .. raw:: latex
 
-    \footnotesize
+    \scriptsize
 
 .. tabularcolumns:: |p{4.1cm}|p{1.1cm}|p{2.4cm}|p{2.0cm}|p{7.3cm}|
 
@@ -541,7 +541,7 @@ Magic Constants for struct v4l2_mpeg_vbi_fmt_ivtv magic field
 structs v4l2_mpeg_vbi_itv0 and v4l2_mpeg_vbi_ITV0
 -------------------------------------------------
 
-.. tabularcolumns:: |p{4.9cm}|p{2.4cm}|p{10.2cm}|
+.. tabularcolumns:: |p{5.2cm}|p{2.4cm}|p{9.9cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -561,12 +561,12 @@ structs v4l2_mpeg_vbi_itv0 and v4l2_mpeg_vbi_ITV0
 
 	::
 
-	    linemask[0] b0:     line  6     first field
-	    linemask[0] b17:    line 23     first field
-	    linemask[0] b18:    line  6     second field
-	    linemask[0] b31:    line 19     second field
-	    linemask[1] b0:     line 20     second field
-	    linemask[1] b3:     line 23     second field
+	    linemask[0] b0:     line  6  first field
+	    linemask[0] b17:    line 23  first field
+	    linemask[0] b18:    line  6  second field
+	    linemask[0] b31:    line 19  second field
+	    linemask[1] b0:     line 20  second field
+	    linemask[1] b3:     line 23  second field
 	    linemask[1] b4-b31: unused and set to 0
     * - struct
 	:c:type:`v4l2_mpeg_vbi_itv0_line`
@@ -590,7 +590,7 @@ structs v4l2_mpeg_vbi_itv0 and v4l2_mpeg_vbi_ITV0
 struct v4l2_mpeg_vbi_ITV0
 -------------------------
 
-.. tabularcolumns:: |p{4.9cm}|p{4.4cm}|p{8.2cm}|
+.. tabularcolumns:: |p{5.2cm}|p{2.4cm}|p{9.9cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -635,7 +635,7 @@ struct v4l2_mpeg_vbi_itv0_line
 Line Identifiers for struct v4l2_mpeg_vbi_itv0_line id field
 ------------------------------------------------------------
 
-.. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
+.. tabularcolumns:: |p{7.0cm}|p{1.8cm}|p{8.7cm}|
 
 .. flat-table::
     :header-rows:  1
diff --git a/Documentation/media/uapi/v4l/dev-subdev.rst b/Documentation/media/uapi/v4l/dev-subdev.rst
index 2c2768c7343b..029bb2d9928a 100644
--- a/Documentation/media/uapi/v4l/dev-subdev.rst
+++ b/Documentation/media/uapi/v4l/dev-subdev.rst
@@ -211,7 +211,7 @@ list entity names and pad numbers).
 
 .. raw:: latex
 
-    \tiny
+    \scriptsize
 
 .. tabularcolumns:: |p{2.0cm}|p{2.3cm}|p{2.3cm}|p{2.3cm}|p{2.3cm}|p{2.3cm}|p{2.3cm}|
 
@@ -223,40 +223,80 @@ list entity names and pad numbers).
     :widths: 5 5 5 5 5 5 5
 
     * -
-      - Sensor/0 format
-      - Frontend/0 format
-      - Frontend/1 format
-      - Scaler/0 format
-      - Scaler/0 compose selection rectangle
-      - Scaler/1 format
+      - Sensor/0
+
+        format
+      - Frontend/0
+
+        format
+      - Frontend/1
+
+        format
+      - Scaler/0
+
+        format
+      - Scaler/0
+
+        compose selection rectangle
+      - Scaler/1
+
+        format
     * - Initial state
-      - 2048x1536/SGRBG8_1X8
+      - 2048x1536
+
+        SGRBG8_1X8
       - (default)
       - (default)
       - (default)
       - (default)
       - (default)
     * - Configure frontend sink format
-      - 2048x1536/SGRBG8_1X8
-      - *2048x1536/SGRBG8_1X8*
-      - *2046x1534/SGRBG8_1X8*
+      - 2048x1536
+
+        SGRBG8_1X8
+      - *2048x1536*
+
+        *SGRBG8_1X8*
+      - *2046x1534*
+
+        *SGRBG8_1X8*
       - (default)
       - (default)
       - (default)
     * - Configure scaler sink format
-      - 2048x1536/SGRBG8_1X8
-      - 2048x1536/SGRBG8_1X8
-      - 2046x1534/SGRBG8_1X8
-      - *2046x1534/SGRBG8_1X8*
+      - 2048x1536
+
+        SGRBG8_1X8
+      - 2048x1536
+
+        SGRBG8_1X8
+      - 2046x1534
+
+        SGRBG8_1X8
+      - *2046x1534*
+
+        *SGRBG8_1X8*
       - *0,0/2046x1534*
-      - *2046x1534/SGRBG8_1X8*
+      - *2046x1534*
+
+        *SGRBG8_1X8*
     * - Configure scaler sink compose selection
-      - 2048x1536/SGRBG8_1X8
-      - 2048x1536/SGRBG8_1X8
-      - 2046x1534/SGRBG8_1X8
-      - 2046x1534/SGRBG8_1X8
+      - 2048x1536
+
+        SGRBG8_1X8
+      - 2048x1536
+
+        SGRBG8_1X8
+      - 2046x1534
+
+        SGRBG8_1X8
+      - 2046x1534
+
+        SGRBG8_1X8
       - *0,0/1280x960*
-      - *1280x960/SGRBG8_1X8*
+      - *1280x960*
+
+        *SGRBG8_1X8*
 
 .. raw:: latex
 
diff --git a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
index d3a553cd86c9..51c1d5c9eb00 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
@@ -88,7 +88,7 @@ enum v4l2_exposure_metering -
     Determines how the camera measures the amount of light available for
     the frame exposure. Possible values are:
 
-.. tabularcolumns:: |p{8.5cm}|p{9.0cm}|
+.. tabularcolumns:: |p{8.7cm}|p{8.8cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -180,7 +180,7 @@ enum v4l2_exposure_metering -
     control may stop updates of the ``V4L2_CID_AUTO_FOCUS_STATUS``
     control value.
 
-.. tabularcolumns:: |p{6.5cm}|p{11.0cm}|
+.. tabularcolumns:: |p{6.7cm}|p{10.8cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -206,7 +206,7 @@ enum v4l2_exposure_metering -
 enum v4l2_auto_focus_range -
     Determines auto focus distance range for which lens may be adjusted.
 
-.. tabularcolumns:: |p{6.5cm}|p{11.0cm}|
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -281,7 +281,7 @@ enum v4l2_auto_n_preset_white_balance -
     representation. The following white balance presets are listed in
     order of increasing color temperature.
 
-.. tabularcolumns:: |p{7.0 cm}|p{10.5cm}|
+.. tabularcolumns:: |p{7.2 cm}|p{10.3cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -387,7 +387,11 @@ enum v4l2_scene_mode -
     to ``V4L2_SCENE_MODE_NONE`` to make sure the other possibly related
     controls are accessible. The following scene programs are defined:
 
-.. tabularcolumns:: |p{6.0cm}|p{11.5cm}|
+.. raw:: latex
+
+    \small
+
+.. tabularcolumns:: |p{5.9cm}|p{11.5cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -459,6 +463,9 @@ enum v4l2_scene_mode -
 	may be switched to close-up mode and this setting may also involve
 	some lens-distortion correction.
 
+.. raw:: latex
+
+    \normalsize
 
 
 ``V4L2_CID_3A_LOCK (bitmask)``
diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
index 0aaee04f81dd..67a122339c0e 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
@@ -105,7 +105,7 @@ enum v4l2_mpeg_stream_vbi_fmt -
 
 
 
-.. tabularcolumns:: |p{6 cm}|p{11.5cm}|
+.. tabularcolumns:: |p{6.6 cm}|p{10.9cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -477,7 +477,7 @@ enum v4l2_mpeg_audio_dec_playback -
 
 
 
-.. tabularcolumns:: |p{9.0cm}|p{8.5cm}|
+.. tabularcolumns:: |p{9.8cm}|p{7.7cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -888,7 +888,7 @@ enum v4l2_mpeg_video_multi_slice_mode -
 
 
 
-.. tabularcolumns:: |p{8.7cm}|p{8.8cm}|
+.. tabularcolumns:: |p{9.6cm}|p{7.9cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -923,9 +923,11 @@ enum v4l2_mpeg_video_multi_slice_mode -
 enum v4l2_mpeg_video_h264_loop_filter_mode -
     Loop filter mode for H264 encoder. Possible values are:
 
+.. raw:: latex
 
+    \small
 
-.. tabularcolumns:: |p{14.0cm}|p{3.5cm}|
+.. tabularcolumns:: |p{13.6cm}|p{3.9cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -938,6 +940,9 @@ enum v4l2_mpeg_video_h264_loop_filter_mode -
     * - ``V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY``
       - Loop filter is disabled at the slice boundary.
 
+.. raw:: latex
+
+    \normalsize
 
 
 ``V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA (integer)``
@@ -964,6 +969,8 @@ enum v4l2_mpeg_video_h264_entropy_mode -
     encoder. Possible values are:
 
 
+.. tabularcolumns:: |p{9.0cm}|p{8.5cm}|
+
 
 .. flat-table::
     :header-rows:  0
@@ -1129,7 +1136,9 @@ enum v4l2_mpeg_video_header_mode -
     it returned together with the first frame. Applicable to encoders.
     Possible values are:
 
+.. raw:: latex
 
+    \small
 
 .. tabularcolumns:: |p{10.3cm}|p{7.2cm}|
 
@@ -1143,6 +1152,9 @@ enum v4l2_mpeg_video_header_mode -
       - The stream header is returned together with the first encoded
 	frame.
 
+.. raw:: latex
+
+    \normalsize
 
 
 ``V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER (boolean)``
@@ -1181,6 +1193,10 @@ enum v4l2_mpeg_video_h264_sei_fp_arrangement_type -
     Frame packing arrangement type for H264 SEI. Applicable to the H264
     encoder. Possible values are:
 
+.. raw:: latex
+
+    \small
+
 .. tabularcolumns:: |p{12cm}|p{5.5cm}|
 
 .. flat-table::
@@ -1200,6 +1216,10 @@ enum v4l2_mpeg_video_h264_sei_fp_arrangement_type -
     * - ``V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_TEMPORAL``
       - One view per frame.
 
+.. raw:: latex
+
+    \normalsize
+
 
 
 ``V4L2_CID_MPEG_VIDEO_H264_FMO (boolean)``
@@ -1217,6 +1237,10 @@ enum v4l2_mpeg_video_h264_fmo_map_type -
     patterns of macroblocks. Applicable to the H264 encoder. Possible
     values are:
 
+.. raw:: latex
+
+    \small
+
 .. tabularcolumns:: |p{12.5cm}|p{5.0cm}|
 
 .. flat-table::
@@ -1240,6 +1264,10 @@ enum v4l2_mpeg_video_h264_fmo_map_type -
     * - ``V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_EXPLICIT``
       - User defined map type.
 
+.. raw:: latex
+
+    \normalsize
+
 
 
 ``V4L2_CID_MPEG_VIDEO_H264_FMO_SLICE_GROUP (integer)``
@@ -1361,6 +1389,8 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
 
 .. cssclass:: longtable
 
+.. tabularcolumns:: |p{5.8cm}|p{4.8cm}|p{6.6cm}|
+
 .. flat-table:: struct v4l2_ctrl_mpeg2_slice_params
     :header-rows:  0
     :stub-columns: 0
@@ -1402,6 +1432,8 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
 
 .. cssclass:: longtable
 
+.. tabularcolumns:: |p{1.5cm}|p{6.3cm}|p{9.4cm}|
+
 .. flat-table:: struct v4l2_mpeg2_sequence
     :header-rows:  0
     :stub-columns: 0
@@ -1433,6 +1465,8 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
 
 .. cssclass:: longtable
 
+.. tabularcolumns:: |p{1.5cm}|p{6.3cm}|p{9.4cm}|
+
 .. flat-table:: struct v4l2_mpeg2_picture
     :header-rows:  0
     :stub-columns: 0
@@ -1492,6 +1526,12 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
 
 .. cssclass:: longtable
 
+.. tabularcolumns:: |p{1.2cm}|p{8.0cm}|p{7.4cm}|
+
+.. raw:: latex
+
+    \small
+
 .. flat-table:: struct v4l2_ctrl_mpeg2_quantization
     :header-rows:  0
     :stub-columns: 0
@@ -1545,6 +1585,11 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
     Quantization parameter for a P frame for FWHT. Valid range: from 1
     to 31.
 
+.. raw:: latex
+
+    \normalsize
+
+
 MFC 5.1 MPEG Controls
 =====================
 
@@ -1652,7 +1697,11 @@ enum v4l2_mpeg_mfc51_video_frame_skip_mode -
     are:
 
 
-.. tabularcolumns:: |p{9.0cm}|p{8.5cm}|
+.. tabularcolumns:: |p{9.2cm}|p{8.3cm}|
+
+.. raw:: latex
+
+    \small
 
 .. flat-table::
     :header-rows:  0
@@ -1667,7 +1716,9 @@ enum v4l2_mpeg_mfc51_video_frame_skip_mode -
       - Frame skip mode enabled and buffer limit is set by the VBV
 	(MPEG1/2/4) or CPB (H264) buffer size control.
 
+.. raw:: latex
 
+    \normalsize
 
 ``V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT (integer)``
     Enable rate-control with fixed target bit. If this setting is
@@ -1690,7 +1741,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type -
     Force a frame type for the next queued buffer. Applicable to
     encoders. Possible values are:
 
-
+.. tabularcolumns:: |p{9.5cm}|p{8.0cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -1720,6 +1771,8 @@ enum v4l2_mpeg_mfc51_video_force_frame_type -
 
 .. cssclass:: longtable
 
+.. tabularcolumns:: |p{1.4cm}|p{4.3cm}|p{11.8cm}|
+
 .. flat-table:: struct v4l2_ctrl_fwht_params
     :header-rows:  0
     :stub-columns: 0
@@ -1763,10 +1816,11 @@ enum v4l2_mpeg_mfc51_video_force_frame_type -
 
 FWHT Flags
 ============
-.. tabularcolumns:: |p{7.0cm}|p{2.2cm}|p{8.3cm}|
 
 .. cssclass:: longtable
 
+.. tabularcolumns:: |p{6.8cm}|p{2.4cm}|p{8.3cm}|
+
 .. flat-table::
     :header-rows:  0
     :stub-columns: 0
@@ -1869,10 +1923,12 @@ enum v4l2_mpeg_cx2341x_video_luma_spatial_filter_type -
     Select the algorithm to use for the Luma Spatial Filter (default
     ``1D_HOR``). Possible values:
 
-
-
 .. tabularcolumns:: |p{14.5cm}|p{3.0cm}|
 
+.. raw:: latex
+
+    \small
+
 .. flat-table::
     :header-rows:  0
     :stub-columns: 0
@@ -1888,6 +1944,10 @@ enum v4l2_mpeg_cx2341x_video_luma_spatial_filter_type -
     * - ``V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_2D_SYM_NON_SEPARABLE``
       - Two-dimensional symmetrical non-separable
 
+.. raw:: latex
+
+    \normalsize
+
 
 
 .. _chroma-spatial-filter-type:
@@ -1900,6 +1960,7 @@ enum v4l2_mpeg_cx2341x_video_chroma_spatial_filter_type -
     ``1D_HOR``). Possible values are:
 
 
+.. tabularcolumns:: |p{14.0cm}|p{3.5cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -2042,6 +2103,10 @@ enum v4l2_vp8_num_ref_frames -
 
 .. tabularcolumns:: |p{7.9cm}|p{9.6cm}|
 
+.. raw:: latex
+
+    \small
+
 .. flat-table::
     :header-rows:  0
     :stub-columns: 0
@@ -2056,6 +2121,10 @@ enum v4l2_vp8_num_ref_frames -
       - The last encoded frame, the golden frame and the altref frame will
 	be searched.
 
+.. raw:: latex
+
+    \normalsize
+
 
 
 ``V4L2_CID_MPEG_VIDEO_VPX_FILTER_LEVEL (integer)``
@@ -2085,7 +2154,7 @@ enum v4l2_vp8_golden_frame_sel -
 
 .. raw:: latex
 
-    \footnotesize
+    \scriptsize
 
 .. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
 
@@ -2407,7 +2476,7 @@ enum v4l2_mpeg_video_hevc_loop_filter_mode -
 
     \footnotesize
 
-.. tabularcolumns:: |p{10.7cm}|p{6.3cm}|
+.. tabularcolumns:: |p{12.1cm}|p{5.4cm}|
 
 .. flat-table::
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/ext-ctrls-detect.rst b/Documentation/media/uapi/v4l/ext-ctrls-detect.rst
index 8a45ce642829..80981d0cff42 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-detect.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-detect.rst
@@ -30,7 +30,7 @@ Detect Control IDs
 ``V4L2_CID_DETECT_MD_MODE (menu)``
     Sets the motion detection mode.
 
-.. tabularcolumns:: |p{7.5cm}|p{10.0cm}|
+.. tabularcolumns:: |p{7.7cm}|p{9.8cm}|
 
 .. flat-table::
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/ext-ctrls-dv.rst b/Documentation/media/uapi/v4l/ext-ctrls-dv.rst
index 57edf211875c..5c70ac98f710 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-dv.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-dv.rst
@@ -106,7 +106,7 @@ enum v4l2_dv_it_content_type -
     or an analog source. The enum v4l2_dv_it_content_type defines
     the possible content types:
 
-.. tabularcolumns:: |p{7.0cm}|p{10.5cm}|
+.. tabularcolumns:: |p{7.3cm}|p{10.4cm}|
 
 .. flat-table::
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/ext-ctrls-flash.rst b/Documentation/media/uapi/v4l/ext-ctrls-flash.rst
index 5f30791c35b5..eff056b17167 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-flash.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-flash.rst
@@ -87,7 +87,7 @@ Flash Control IDs
 ``V4L2_CID_FLASH_STROBE_SOURCE (menu)``
     Defines the source of the flash LED strobe.
 
-.. tabularcolumns:: |p{7.0cm}|p{10.5cm}|
+.. tabularcolumns:: |p{7.5cm}|p{10.0cm}|
 
 .. flat-table::
     :header-rows:  0
@@ -146,7 +146,7 @@ Flash Control IDs
     an effect is chip dependent. Reading the faults resets the control
     and returns the chip to a usable state if possible.
 
-.. tabularcolumns:: |p{8.0cm}|p{9.5cm}|
+.. tabularcolumns:: |p{8.4cm}|p{9.1cm}|
 
 .. flat-table::
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/ext-ctrls-jpeg.rst b/Documentation/media/uapi/v4l/ext-ctrls-jpeg.rst
index cf9cd8a9f9b4..60ce3f949319 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-jpeg.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-jpeg.rst
@@ -37,7 +37,7 @@ JPEG Control IDs
     how Cb and Cr components are downsampled after converting an input
     image from RGB to Y'CbCr color space.
 
-.. tabularcolumns:: |p{7.0cm}|p{10.5cm}|
+.. tabularcolumns:: |p{7.5cm}|p{10.0cm}|
 
 .. flat-table::
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/field-order.rst b/Documentation/media/uapi/v4l/field-order.rst
index 8415268d439c..3fb473e3b8e2 100644
--- a/Documentation/media/uapi/v4l/field-order.rst
+++ b/Documentation/media/uapi/v4l/field-order.rst
@@ -64,7 +64,9 @@ enum v4l2_field
 
 .. c:type:: v4l2_field
 
-.. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
+.. tabularcolumns:: |p{5.8cm}|p{0.6cm}|p{11.1cm}|
+
+.. cssclass:: longtable
 
 .. flat-table::
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst b/Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst
index 862e1f327150..87e8fd7d5d02 100644
--- a/Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst
@@ -36,13 +36,16 @@ per frame, therefore their headers cannot be larger than 255 bytes.
 Below are proprietary Microsoft style metadata types, used by D4xx cameras,
 where all fields are in little endian order:
 
+.. tabularcolumns:: |p{5.0cm}|p{12.5cm}|
+
+
 .. flat-table:: D4xx metadata
-    :widths: 1 4
+    :widths: 1 2
     :header-rows:  1
     :stub-columns: 0
 
-    * - Field
-      - Description
+    * - **Field**
+      - **Description**
     * - :cspan:`1` *Depth Control*
     * - __u32 ID
       - 0x80000000
diff --git a/Documentation/media/uapi/v4l/pixfmt-meta-vsp1-hgt.rst b/Documentation/media/uapi/v4l/pixfmt-meta-vsp1-hgt.rst
index 2ebccdcca95d..d1a341af9c48 100644
--- a/Documentation/media/uapi/v4l/pixfmt-meta-vsp1-hgt.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-meta-vsp1-hgt.rst
@@ -41,6 +41,10 @@ The Hue position **m** (0 - 5) of the bucket in the matrix depends on
 how the HGT Hue areas are configured. There are 6 user configurable Hue
 Areas which can be configured to cover overlapping Hue values:
 
+.. raw:: latex
+
+    \small
+
 ::
 
          Area 0       Area 1       Area 2       Area 3       Area 4       Area 5
@@ -53,6 +57,11 @@ Areas which can be configured to cover overlapping Hue values:
   5U   0L      0U   1L      1U   2L      2U   3L      3U   4L      4U   5L      5U   0L
         <0..............................Hue Value............................255>
 
+
+.. raw:: latex
+
+    \normalsize
+
 When two consecutive areas don't overlap (n+1L is equal to nU) the boundary
 value is considered as part of the lower area.
 
diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-hsv.rst b/Documentation/media/uapi/v4l/pixfmt-packed-hsv.rst
index 38b1895a509f..dfc4a8367b3d 100644
--- a/Documentation/media/uapi/v4l/pixfmt-packed-hsv.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-packed-hsv.rst
@@ -31,7 +31,7 @@ The values are packed in 24 or 32 bit formats.
     \tiny
     \setlength{\tabcolsep}{2pt}
 
-.. tabularcolumns:: |p{2.0cm}|p{0.54cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
+.. tabularcolumns:: |p{2.6cm}|p{0.8cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
 
 .. _packed-hsv-formats:
 
diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
index 6b3781c04dd5..4766a6f47222 100644
--- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
@@ -27,7 +27,7 @@ next to each other in memory.
     \tiny
     \setlength{\tabcolsep}{2pt}
 
-.. tabularcolumns:: |p{2.3cm}|p{1.6cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
+.. tabularcolumns:: |p{2.8cm}|p{2.0cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
 
 
 .. _rgb-formats:
@@ -656,7 +656,7 @@ either the corresponding ARGB or XRGB format, depending on the driver.
     \tiny
     \setlength{\tabcolsep}{2pt}
 
-.. tabularcolumns:: |p{2.2cm}|p{0.60cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
+.. tabularcolumns:: |p{2.6cm}|p{0.70cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
 
 .. _rgb-formats-deprecated:
 
diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst b/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
index 9d2b281f06a2..41b60fae703a 100644
--- a/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
@@ -28,7 +28,7 @@ component of each pixel in one 16 or 32 bit word.
 
 .. _packed-yuv-formats:
 
-.. tabularcolumns:: |p{2.0cm}|p{0.67cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|
+.. tabularcolumns:: |p{2.5cm}|p{0.69cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|
 
 .. flat-table:: Packed YUV Image Formats
     :header-rows:  2
diff --git a/Documentation/media/uapi/v4l/pixfmt-srggb10p.rst b/Documentation/media/uapi/v4l/pixfmt-srggb10p.rst
index cdb70ac26126..fd32660a3766 100644
--- a/Documentation/media/uapi/v4l/pixfmt-srggb10p.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-srggb10p.rst
@@ -40,7 +40,7 @@ of a small V4L2_PIX_FMT_SBGGR10P image:
 **Byte Order.**
 Each cell is one byte.
 
-.. tabularcolumns:: |p{2.0cm}|p{1.0cm}|p{1.0cm}|p{1.0cm}|p{1.0cm}|p{5.4cm}|
+.. tabularcolumns:: |p{2.4cm}|p{1.4cm}|p{1.2cm}|p{1.2cm}|p{1.2cm}|p{6.4cm}|
 
 .. flat-table::
     :header-rows:  0
diff --git a/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst b/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
index 01413be12916..960851275f23 100644
--- a/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
@@ -18,6 +18,7 @@ V4L2_PIX_FMT_SRGGB12P ('pRAA'), V4L2_PIX_FMT_SGRBG12P ('pgAA'), V4L2_PIX_FMT_SGB
 
 
 12-bit packed Bayer formats
+---------------------------
 
 
 Description
@@ -37,7 +38,7 @@ Below is an example of a small V4L2_PIX_FMT_SBGGR12P image:
 **Byte Order.**
 Each cell is one byte.
 
-.. tabularcolumns:: |p{2.0cm}|p{1.0cm}|p{1.0cm}|p{2.7cm}|p{1.0cm}|p{1.0cm}|p{2.7cm}|
+.. tabularcolumns:: |p{2.2cm}|p{1.2cm}|p{1.2cm}|p{3.1cm}|p{1.2cm}|p{1.2cm}|p{3.1cm}|
 
 
 .. flat-table::
diff --git a/Documentation/media/uapi/v4l/pixfmt-srggb14p.rst b/Documentation/media/uapi/v4l/pixfmt-srggb14p.rst
index b583531c2853..1a988d7e7ff8 100644
--- a/Documentation/media/uapi/v4l/pixfmt-srggb14p.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-srggb14p.rst
@@ -41,17 +41,21 @@ of one of these formats:
 **Byte Order.**
 Each cell is one byte.
 
+.. raw:: latex
 
+    \footnotesize
+
+.. tabularcolumns:: |p{1.8cm}|p{1.0cm}|p{1.0cm}|p{1.0cm}|p{1.1cm}|p{3.3cm}|p{3.3cm}|p{3.3cm}|
 
 .. flat-table::
     :header-rows:  0
     :stub-columns: 0
-    :widths:       2 1 1 1 1 1 1 1
+    :widths:       2 1 1 1 1 3 3 3
 
 
     -  .. row 1
 
-       -  start + 0:
+       -  start + 0
 
        -  B\ :sub:`00high`
 
@@ -62,17 +66,20 @@ Each cell is one byte.
        -  G\ :sub:`03high`
 
        -  G\ :sub:`01low bits 1--0`\ (bits 7--6)
+
 	  B\ :sub:`00low bits 5--0`\ (bits 5--0)
 
        -  R\ :sub:`02low bits 3--0`\ (bits 7--4)
+
 	  G\ :sub:`01low bits 5--2`\ (bits 3--0)
 
        -  G\ :sub:`03low bits 5--0`\ (bits 7--2)
+
 	  R\ :sub:`02low bits 5--4`\ (bits 1--0)
 
     -  .. row 2
 
-       -  start + 7:
+       -  start + 7
 
        -  G\ :sub:`00high`
 
@@ -83,12 +90,15 @@ Each cell is one byte.
        -  R\ :sub:`03high`
 
        -  R\ :sub:`01low bits 1--0`\ (bits 7--6)
+
 	  G\ :sub:`00low bits 5--0`\ (bits 5--0)
 
        -  G\ :sub:`02low bits 3--0`\ (bits 7--4)
+
 	  R\ :sub:`01low bits 5--2`\ (bits 3--0)
 
        -  R\ :sub:`03low bits 5--0`\ (bits 7--2)
+
 	  G\ :sub:`02low bits 5--4`\ (bits 1--0)
 
     -  .. row 3
@@ -104,12 +114,15 @@ Each cell is one byte.
        -  G\ :sub:`23high`
 
        -  G\ :sub:`21low bits 1--0`\ (bits 7--6)
+
 	  B\ :sub:`20low bits 5--0`\ (bits 5--0)
 
        -  R\ :sub:`22low bits 3--0`\ (bits 7--4)
+
 	  G\ :sub:`21low bits 5--2`\ (bits 3--0)
 
        -  G\ :sub:`23low bits 5--0`\ (bits 7--2)
+
 	  R\ :sub:`22low bits 5--4`\ (bits 1--0)
 
     -  .. row 4
@@ -132,3 +145,8 @@ Each cell is one byte.
 
        -  R\ :sub:`33low bits 5--0`\ (bits 7--2)
 	  G\ :sub:`32low bits 5--4`\ (bits 1--0)
+
+.. raw:: latex
+
+    \normalsize
+
diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
index 7f82dad9013a..5688c816e334 100644
--- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
@@ -19,6 +19,7 @@ array of struct :c:type:`v4l2_plane_pix_format` structures,
 describing all planes of that format.
 
 
+
 .. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.7cm}|
 
 .. c:type:: v4l2_plane_pix_format
@@ -41,6 +42,10 @@ describing all planes of that format.
 	applications.
 
 
+.. raw:: latex
+
+    \small
+
 .. tabularcolumns:: |p{4.4cm}|p{5.6cm}|p{7.5cm}|
 
 .. c:type:: v4l2_pix_format_mplane
@@ -82,9 +87,7 @@ describing all planes of that format.
     * - __u8
       - ``flags``
       - Flags set by the application or driver, see :ref:`format-flags`.
-    * - union {
-      - (anonymous)
-      -
+    * - :cspan:`2` union { (anonymous)
     * - __u8
       - ``ycbcr_enc``
       - Y'CbCr encoding, from enum :c:type:`v4l2_ycbcr_encoding`.
@@ -97,9 +100,7 @@ describing all planes of that format.
         This information supplements the ``colorspace`` and must be set by
 	the driver for capture streams and by the application for output
 	streams, see :ref:`colorspaces`.
-    * - }
-      -
-      -
+    * - :cspan:`2` }
     * - __u8
       - ``quantization``
       - Quantization range, from enum :c:type:`v4l2_quantization`.
@@ -116,3 +117,7 @@ describing all planes of that format.
       - ``reserved[7]``
       - Reserved for future extensions. Should be zeroed by drivers and
 	applications.
+
+.. raw:: latex
+
+    \normalsize
diff --git a/Documentation/media/uapi/v4l/pixfmt-y10p.rst b/Documentation/media/uapi/v4l/pixfmt-y10p.rst
index 7893642faee3..39cd789dcb59 100644
--- a/Documentation/media/uapi/v4l/pixfmt-y10p.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-y10p.rst
@@ -27,6 +27,12 @@ in the same order.
 
 **Bit-packed representation.**
 
+.. raw:: latex
+
+    \small
+
+.. tabularcolumns:: |p{1.2cm}||p{1.2cm}||p{1.2cm}||p{1.2cm}|p{3.2cm}|p{3.2cm}|
+
 .. flat-table::
     :header-rows:  0
     :stub-columns: 0
@@ -38,3 +44,7 @@ in the same order.
       - Y'\ :sub:`03[9:2]`
       - Y'\ :sub:`03[1:0]`\ (bits 7--6) Y'\ :sub:`02[1:0]`\ (bits 5--4)
 	Y'\ :sub:`01[1:0]`\ (bits 3--2) Y'\ :sub:`00[1:0]`\ (bits 1--0)
+
+.. raw:: latex
+
+    \normalsize
diff --git a/Documentation/media/uapi/v4l/subdev-formats.rst b/Documentation/media/uapi/v4l/subdev-formats.rst
index f5440d55d510..bf1dbb68eebc 100644
--- a/Documentation/media/uapi/v4l/subdev-formats.rst
+++ b/Documentation/media/uapi/v4l/subdev-formats.rst
@@ -7414,7 +7414,7 @@ The following table lists existing HSV/HSL formats.
     \tiny
     \setlength{\tabcolsep}{2pt}
 
-.. tabularcolumns:: |p{3.0cm}|p{0.60cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
+.. tabularcolumns:: |p{3.9cm}|p{0.73cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
 
 .. _v4l2-mbus-pixelcode-hsv:
 
@@ -7524,7 +7524,7 @@ The following table lists existing JPEG compressed formats.
 
 .. _v4l2-mbus-pixelcode-jpeg:
 
-.. tabularcolumns:: |p{5.4cm}|p{1.4cm}|p{10.7cm}|
+.. tabularcolumns:: |p{6.0cm}|p{1.4cm}|p{10.1cm}|
 
 .. flat-table:: JPEG Formats
     :header-rows:  1
@@ -7557,7 +7557,7 @@ formats.
 
 .. _v4l2-mbus-pixelcode-vendor-specific:
 
-.. tabularcolumns:: |p{6.8cm}|p{1.4cm}|p{9.3cm}|
+.. tabularcolumns:: |p{8.0cm}|p{1.4cm}|p{7.7cm}|
 
 .. flat-table:: Vendor and device specific formats
     :header-rows:  1
-- 
2.20.1

