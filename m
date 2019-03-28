Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696DBC10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372832173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VYVZtn7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfC1HJR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:09:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43812 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfC1HJR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:09:17 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0EF08569;
        Thu, 28 Mar 2019 08:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756956;
        bh=THS3jz2O3r7VgCcRk8sC7X7s0XU8ooUa4QOGJUrwEiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYVZtn7b+qcEnO00kRU3a+dzUZMq7BRCElXgGxcpxJWTBqYpH9V/B5Whtu5z4KGQh
         SxPM8xrF9d2bhfpqlvYp9CHjVKURSOXplUh8u3ZXza0xRUaS5iaeWreGuskWwQaMsk
         mvK2D/agsxFnNxT9wvn4GIYRkxSDgJoNAQynm/N8=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 9/9] drm: rcar-du: Add support for missing 16-bit RGB1555 formats
Date:   Thu, 28 Mar 2019 09:07:23 +0200
Message-Id: <20190328070723.26553-10-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for the DRM_FORMAT_RGBA5551, DRM_FORMAT_RGBX5551,
DRM_FORMAT_ABGR1555, DRM_FORMAT_XBGR1555, DRM_FORMAT_BGRA5551 and
DRM_FORMAT_BGRX5551 formats to the DU driver. Those formats are only
available on Gen3.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 4aaf623cbcd1..adbc4f5d8fc5 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -153,6 +153,36 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
 		.v4l2 = V4L2_PIX_FMT_BGRX444,
 		.bpp = 16,
 		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGBA5551,
+		.v4l2 = V4L2_PIX_FMT_RGBA555,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGBX5551,
+		.v4l2 = V4L2_PIX_FMT_RGBX555,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_ABGR1555,
+		.v4l2 = V4L2_PIX_FMT_ABGR555,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_XBGR1555,
+		.v4l2 = V4L2_PIX_FMT_XBGR555,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGRA5551,
+		.v4l2 = V4L2_PIX_FMT_BGRA555,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGRX5551,
+		.v4l2 = V4L2_PIX_FMT_BGRX555,
+		.bpp = 16,
+		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_BGR888,
 		.v4l2 = V4L2_PIX_FMT_RGB24,
-- 
Regards,

Laurent Pinchart

