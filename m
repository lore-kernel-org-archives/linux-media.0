Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D636C55ABD
	for <linux-media@archiver.kernel.org>; Mon, 16 Nov 2020 18:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97D920575
	for <linux-media@archiver.kernel.org>; Mon, 16 Nov 2020 18:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d8Z/oOw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgKPSwd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:52:33 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51284 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgKPSwc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 16 Nov 2020 13:52:32 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD68ABAC;
        Mon, 16 Nov 2020 19:52:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1605552744;
        bh=0p64Nlh9WYoNr3lXpanXu/k5w+/japfxo8jRG9BH6eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8Z/oOw+vhRkvwbtF0xALwNyi6Cux/35qqKFeBrSkyXgzgOdEfNdke4R8knaF56F/
         BvXwZJP+71L3ZB58y8QCjIzxNXYIf6/23KByW885zmXzY8VAoPAw9Z/BkX53eKIbVA
         XoFtgqLFu3U+ZB1UIq/NMRnhSJCqkEoAwYNJ8zQA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dylan Yip <dylany@xilinx.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: [PATCH v3 11/21] media: doc: pixfmt-packed-yuv: Fill padding bits with 'X'
Date:   Mon, 16 Nov 2020 20:51:57 +0200
Message-Id: <20201116185207.13208-12-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201116185207.13208-1-laurent.pinchart@ideasonboard.com>
References: <20201116185207.13208-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The padding bits are left blank, which look weird in the XYUV format,
and, worse, may lead to the VUYX format to be understand as consuming 3
bytes per pixel. Add 'X' for padding bits as we do for RGB formats.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v2:

- Replace '-' with 'X'
---
 .../media/v4l/pixfmt-packed-yuv.rst           | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
index 8ed1a6aff3a6..fbd9b412388c 100644
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
+      - X\ :sub:`7`
+      - X\ :sub:`6`
+      - X\ :sub:`5`
+      - X\ :sub:`4`
+      - X\ :sub:`3`
+      - X\ :sub:`2`
+      - X\ :sub:`1`
+      - X\ :sub:`0`
 
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
+      - X\ :sub:`7`
+      - X\ :sub:`6`
+      - X\ :sub:`5`
+      - X\ :sub:`4`
+      - X\ :sub:`3`
+      - X\ :sub:`2`
+      - X\ :sub:`1`
+      - X\ :sub:`0`
 
 .. raw:: latex
 
-- 
Regards,

Laurent Pinchart

