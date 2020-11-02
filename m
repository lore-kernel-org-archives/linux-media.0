Return-Path: <SRS0=t7pd=EI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6CC00A89
	for <linux-media@archiver.kernel.org>; Mon,  2 Nov 2020 22:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D84220786
	for <linux-media@archiver.kernel.org>; Mon,  2 Nov 2020 22:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hjDTQfUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKBWmD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:42:03 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42350 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgKBWmD (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 2 Nov 2020 17:42:03 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 10D93583;
        Mon,  2 Nov 2020 23:41:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1604356918;
        bh=jWAQBYeQufEcQkO0yKqae4vst2kN/lScI542ohUoOCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjDTQfUnXwWIHEzNBB1a9gQQe9LkBaqN1kHhte90BaoMNQGZxI6EffkuIuKWHPa0p
         1ZYIEcLCSGsafNGCiEKpTcQF7aZDSbEYtnekIWpQUCmFgHxXdOKUIWsCEYVqivGObu
         pFKLHefKAAH3hMsWrMdKmQZcKoc70hvUkO2D2VeI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dylan Yip <dylany@xilinx.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: [PATCH v2 09/19] media: doc: pixfmt-packed-yuv: Fill padding bits with '-'
Date:   Tue,  3 Nov 2020 00:40:52 +0200
Message-Id: <20201102224102.30292-10-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102224102.30292-1-laurent.pinchart@ideasonboard.com>
References: <20201102224102.30292-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The padding bits are left blank, which look weird in the XYUV format,
and, worse, may lead to the VUYX format to be understand as consuming 3
bytes per pixel. Add '-' for padding bits as we do for RGB formats.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../media/v4l/pixfmt-packed-yuv.rst           | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
index 8ed1a6aff3a6..38f3d564c134 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
@@ -239,14 +239,14 @@ full triplet of Y, Cb and Cr values.
       - ``V4L2_PIX_FMT_XYUV32``
       - 'XYUV'
 
-      -
-      -
-      -
-      -
-      -
-      -
-      -
-      -
+      - `-`
+      - `-`
+      - `-`
+      - `-`
+      - `-`
+      - `-`
+      - `-`
+      - `-`
 
       - Y'\ :sub:`7`
       - Y'\ :sub:`6`
@@ -348,14 +348,14 @@ full triplet of Y, Cb and Cr values.
       - Y'\ :sub:`1`
       - Y'\ :sub:`0`
 
-      -
-      -
-      -
-      -
-      -
-      -
-      -
-      -
+      - `-`
+      - `-`
+      - `-`
+      - `-`
+      - `-`
+      - `-`
+      - `-`
+      - `-`
 
 .. raw:: latex
 
-- 
Regards,

Laurent Pinchart

