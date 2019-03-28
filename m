Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FE4C10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B792173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EEYfm3nK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfC1HJJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:09:09 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43798 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfC1HJJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:09:09 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE754569;
        Thu, 28 Mar 2019 08:09:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756947;
        bh=WV9B8Aqwtmshu+CHimnT7BZ1PKgPb1g+G2p5LNbz4uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEYfm3nKIx5nSfkOA0BjuETVf2kGLkABxdRAcBsqy3QI4Tlx4YBZf92aVQk0NgpnP
         qOmCUbL/Lb/VhpoFNEOrUozOxSUAWtTpLrkppXK1i8JvKsWJ0pjUudUn4eqRGMKsWM
         RT4U/YtX8YuXVfhGtg2lq59B8FjiUTV4BDaMlWPc=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 8/9] drm: rcar-du: Add support for missing 16-bit RGB4444 formats
Date:   Thu, 28 Mar 2019 09:07:22 +0200
Message-Id: <20190328070723.26553-9-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for the DRM_FORMAT_RGBA4444, DRM_FORMAT_RGBX4444,
DRM_FORMAT_ABGR4444, DRM_FORMAT_XBGR4444, DRM_FORMAT_BGRA4444 and
DRM_FORMAT_BGRX4444 formats to the DU driver. Those formats are only
available on Gen3.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 4084136af845..4aaf623cbcd1 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -123,6 +123,36 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
 		.v4l2 = V4L2_PIX_FMT_XRGB444,
 		.bpp = 16,
 		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGBA4444,
+		.v4l2 = V4L2_PIX_FMT_RGBA444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGBX4444,
+		.v4l2 = V4L2_PIX_FMT_RGBX444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_ABGR4444,
+		.v4l2 = V4L2_PIX_FMT_ABGR444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_XBGR4444,
+		.v4l2 = V4L2_PIX_FMT_XBGR444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGRA4444,
+		.v4l2 = V4L2_PIX_FMT_BGRA444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGRX4444,
+		.v4l2 = V4L2_PIX_FMT_BGRX444,
+		.bpp = 16,
+		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_BGR888,
 		.v4l2 = V4L2_PIX_FMT_RGB24,
-- 
Regards,

Laurent Pinchart

