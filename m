Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53066C4360F
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8312173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b4qa/MbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfC1HJB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:09:01 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43784 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfC1HJB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:09:01 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D115554D;
        Thu, 28 Mar 2019 08:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756939;
        bh=UMhLOWccjEzyhovNDsNlTfMZx1JIYi5pwl2Y1cR12GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4qa/MbRyAr2SARjUxrwqJEwAZdDWywbcRP0kaHuzDpRrwtVJDH32p4u2/1PxYSAS
         kkHWhD8Y/OjGLV6fklsqSODlrT2ooI9Ul+p0BPi+iN+GcgHJK/uGfXZzDY1EOIRmmo
         vczcNB3I9Ef5W32TpsAGI0qvYrVzhTCdva5QEsfA=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 7/9] drm: rcar-du: Add support for missing 32-bit RGB formats
Date:   Thu, 28 Mar 2019 09:07:21 +0200
Message-Id: <20190328070723.26553-8-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for the DRM_FORMAT_RGBA8888, DRM_FORMAT_RGBX8888,
DRM_FORMAT_ABGR8888 and DRM_FORMAT_XBGR8888 formats to the DU driver.
Those formats are only available on Gen3.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index f8f7fff34dff..4084136af845 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -133,6 +133,26 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
 		.v4l2 = V4L2_PIX_FMT_BGR24,
 		.bpp = 24,
 		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGBA8888,
+		.v4l2 = V4L2_PIX_FMT_BGRA32,
+		.bpp = 32,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGBX8888,
+		.v4l2 = V4L2_PIX_FMT_BGRX32,
+		.bpp = 32,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_ABGR8888,
+		.v4l2 = V4L2_PIX_FMT_RGBA32,
+		.bpp = 32,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_XBGR8888,
+		.v4l2 = V4L2_PIX_FMT_RGBX32,
+		.bpp = 32,
+		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_BGRA8888,
 		.v4l2 = V4L2_PIX_FMT_ARGB32,
-- 
Regards,

Laurent Pinchart

