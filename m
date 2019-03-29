Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7021C4360F
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68D5218A5
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553875493;
	bh=PKHssmANXKmVnkiwPlyjxwiMe2dj8LXB6caUVMv4zTw=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=QB7/ltuJvIDzMj0cmkFoDlArSDJ6po+eKi4McH1vy7/9x2pkB0cZvdfznogs3ZL5w
	 8xCZn4t/3fa43d/RB0aqV3n0BG4bVZktWS7Q6dNb/ITybxjj7YT07DPsBAAecfpUIg
	 iIuNeSxbNS4s3TuKRsd3jgQhwp7trxH1Vdxwm27A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfC2QEw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:04:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbfC2QEv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 12:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zbz9QsvRhymcdO/Jyv14aAiByt+jY7NbPxJsdy08+DU=; b=P9+aiIXYfRnBOq34/64tO1BGT
        zgj3EXRcKQDmiQjjwWMF1iCZbTf7MoC6SGvIcEoACilBclffdWVNK5Vikcc221DNOY/PIpAUzfaTz
        MSH7orvlVeOu+ftCiuBEt6gSS3uX8ffKpN99NOTPZ2bYzffgFH0+hjXa/tWlrfRUUNaUFXluofDtr
        lz84DUaoOya/0aEfvRUZpvJMtcBF0mDnXsZwz361AUmM5vaJ/4GY9rkV7Fst7bpsVUkVyLo1vByNi
        7nJl45kmUTPABd/wSqu3yD5f4y75GXcIpJ2MBpLzA8mO5c5clBMRqXPyftWaV5ZmZYAKg0Rt/mDSy
        lbzLq8wYg==;
Received: from [179.95.36.211] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9tzu-0003Po-Vx; Fri, 29 Mar 2019 16:04:51 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1h9tzr-00018u-Gk; Fri, 29 Mar 2019 12:04:47 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] media: pixfmt-packed-yuv.rst: fix PDF output
Date:   Fri, 29 Mar 2019 12:04:46 -0400
Message-Id: <07f6590e6ed365bfe0bf5770c3a1e987fa32a657.1553875482.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Some lines inside this table has more than 34 columns, with is what
it is expected, according with .. tabularcolumns:: definition.

That causes the PDF output to fail.

This patch ensures that all columns will have exactly the same
size, merging the unused ones using :cpan:

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../media/uapi/v4l/pixfmt-packed-yuv.rst      | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst b/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
index 7fcee1c11ac4..9d2b281f06a2 100644
--- a/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
@@ -44,6 +44,7 @@ component of each pixel in one 16 or 32 bit word.
       - :cspan:`7` Byte 2
 
       - :cspan:`7` Byte 3
+
     * -
       -
       - 7
@@ -81,6 +82,7 @@ component of each pixel in one 16 or 32 bit word.
       - 2
       - 1
       - 0
+
     * .. _V4L2-PIX-FMT-YUV444:
 
       - ``V4L2_PIX_FMT_YUV444``
@@ -103,7 +105,9 @@ component of each pixel in one 16 or 32 bit word.
       - Y'\ :sub:`2`
       - Y'\ :sub:`1`
       - Y'\ :sub:`0`
-      -
+
+      -  :cspan:`15`
+
     * .. _V4L2-PIX-FMT-YUV555:
 
       - ``V4L2_PIX_FMT_YUV555``
@@ -126,7 +130,8 @@ component of each pixel in one 16 or 32 bit word.
       - Y'\ :sub:`0`
       - Cb\ :sub:`4`
       - Cb\ :sub:`3`
-      -
+
+      -  :cspan:`15`
     * .. _V4L2-PIX-FMT-YUV565:
 
       - ``V4L2_PIX_FMT_YUV565``
@@ -149,7 +154,9 @@ component of each pixel in one 16 or 32 bit word.
       - Cb\ :sub:`5`
       - Cb\ :sub:`4`
       - Cb\ :sub:`3`
-      -
+
+      -  :cspan:`15`
+
     * .. _V4L2-PIX-FMT-YUV32:
 
       - ``V4L2_PIX_FMT_YUV32``
@@ -190,7 +197,7 @@ component of each pixel in one 16 or 32 bit word.
       - Cr\ :sub:`2`
       - Cr\ :sub:`1`
       - Cr\ :sub:`0`
-      -
+
     * .. _V4L2-PIX-FMT-AYUV32:
 
       - ``V4L2_PIX_FMT_AYUV32``
@@ -231,7 +238,7 @@ component of each pixel in one 16 or 32 bit word.
       - Cr\ :sub:`2`
       - Cr\ :sub:`1`
       - Cr\ :sub:`0`
-      -
+
     * .. _V4L2-PIX-FMT-XYUV32:
 
       - ``V4L2_PIX_FMT_XYUV32``
@@ -272,7 +279,7 @@ component of each pixel in one 16 or 32 bit word.
       - Cr\ :sub:`2`
       - Cr\ :sub:`1`
       - Cr\ :sub:`0`
-      -
+
     * .. _V4L2-PIX-FMT-VUYA32:
 
       - ``V4L2_PIX_FMT_VUYA32``
@@ -313,7 +320,7 @@ component of each pixel in one 16 or 32 bit word.
       - a\ :sub:`2`
       - a\ :sub:`1`
       - a\ :sub:`0`
-      -
+
     * .. _V4L2-PIX-FMT-VUYX32:
 
       - ``V4L2_PIX_FMT_VUYX32``
-- 
2.20.1

