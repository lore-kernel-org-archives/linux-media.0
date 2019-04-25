Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFCBC282E3
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5475C21905
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbfDYHMw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:12:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYHMt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 03:12:49 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7FE8F282F3C;
        Thu, 25 Apr 2019 08:12:47 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v4 03/21] rockchip/vpu: Cleanup macroblock alignment
Date:   Thu, 25 Apr 2019 09:12:24 +0200
Message-Id: <20190425071242.18315-4-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425071242.18315-1-boris.brezillon@collabora.com>
References: <20190425071242.18315-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

We need to make the macrobock alignment generic, in order
to support multiple codecs.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes from v3:
* None

Changes from v2:
* None
---
 .../media/rockchip/vpu/rockchip_vpu_enc.c     | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
index 4451bb2dc3d7..ae1ff3d9b9d2 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
@@ -203,8 +203,8 @@ vidioc_try_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
 			       fmt->frmsize.min_height,
 			       fmt->frmsize.max_height);
 	/* Round up to macroblocks. */
-	pix_mp->width = round_up(pix_mp->width, JPEG_MB_DIM);
-	pix_mp->height = round_up(pix_mp->height, JPEG_MB_DIM);
+	pix_mp->width = round_up(pix_mp->width, fmt->frmsize.step_width);
+	pix_mp->height = round_up(pix_mp->height, fmt->frmsize.step_height);
 
 	/*
 	 * For compressed formats the application can specify
@@ -248,8 +248,8 @@ vidioc_try_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
 		       ctx->vpu_dst_fmt->frmsize.min_height,
 		       ctx->vpu_dst_fmt->frmsize.max_height);
 	/* Round up to macroblocks. */
-	width = round_up(width, JPEG_MB_DIM);
-	height = round_up(height, JPEG_MB_DIM);
+	width = round_up(width, ctx->vpu_dst_fmt->frmsize.step_width);
+	height = round_up(height, ctx->vpu_dst_fmt->frmsize.step_height);
 
 	/* Fill remaining fields */
 	v4l2_fill_pixfmt_mp(pix_mp, fmt->fourcc, width, height);
@@ -338,10 +338,8 @@ vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	ctx->dst_fmt.height = pix_mp->height;
 
 	vpu_debug(0, "OUTPUT codec mode: %d\n", ctx->vpu_src_fmt->codec_mode);
-	vpu_debug(0, "fmt - w: %d, h: %d, mb - w: %d, h: %d\n",
-		  pix_mp->width, pix_mp->height,
-		  JPEG_MB_WIDTH(pix_mp->width),
-		  JPEG_MB_HEIGHT(pix_mp->height));
+	vpu_debug(0, "fmt - w: %d, h: %d\n",
+		  pix_mp->width, pix_mp->height);
 	return 0;
 }
 
@@ -380,10 +378,8 @@ vidioc_s_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	ctx->dst_fmt = *pix_mp;
 
 	vpu_debug(0, "CAPTURE codec mode: %d\n", ctx->vpu_dst_fmt->codec_mode);
-	vpu_debug(0, "fmt - w: %d, h: %d, mb - w: %d, h: %d\n",
-		  pix_mp->width, pix_mp->height,
-		  JPEG_MB_WIDTH(pix_mp->width),
-		  JPEG_MB_HEIGHT(pix_mp->height));
+	vpu_debug(0, "fmt - w: %d, h: %d\n",
+		  pix_mp->width, pix_mp->height);
 
 	/*
 	 * Current raw format might have become invalid with newly
-- 
2.20.1

