Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB75C10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8EF2173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lY2Fp7ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfC1HIx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:08:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43770 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HIx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:08:53 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5CB2854D;
        Thu, 28 Mar 2019 08:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756931;
        bh=EijYYgR5XXYASKkOXkrqaVq1wkaS8FSv7BlAfsgFBtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lY2Fp7kofAyRX5WibubbNgZ7+byIi0k8dfQ3RQsqcmcIFKoZyg+damvBNrSeQqE1s
         gHuEAYMj7eSaMJYEW3uw/ang6rqBI6Nynnc12TbyDf4BRCSVU+PDnnfmIuKSJfC+s2
         BwJNI/hK9YGwIt6X/lpCKPASrElBRV6SXmIYo+VM=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 6/9] media: vsp1: Add support for missing 16-bit RGB555 formats
Date:   Thu, 28 Mar 2019 09:07:20 +0200
Message-Id: <20190328070723.26553-7-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for the V4L2_PIX_FMT_RGBA555, V4L2_PIX_FMT_RGBX555,
V4L2_PIX_FMT_ABGR555, V4L2_PIX_FMT_XBGR555, V4L2_PIX_FMT_BGRA555 and
V4L2_PIX_FMT_BGRX555 formats to the VSP driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_pipe.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
index f6665871aa11..92f71dec99c5 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.c
+++ b/drivers/media/platform/vsp1/vsp1_pipe.c
@@ -66,14 +66,46 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
 	  VI6_FMT_BGRA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
 	  VI6_RPF_DSWAP_P_WDS,
 	  1, { 16, 0, 0 }, false, false, 1, 1, false },
+#define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
 	{ V4L2_PIX_FMT_ARGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
 	  VI6_FMT_ARGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
 	  VI6_RPF_DSWAP_P_WDS,
 	  1, { 16, 0, 0 }, false, false, 1, 1, true },
+#define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
 	{ V4L2_PIX_FMT_XRGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
 	  VI6_FMT_XRGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
 	  VI6_RPF_DSWAP_P_WDS,
 	  1, { 16, 0, 0 }, false, false, 1, 1, false },
+#define V4L2_PIX_FMT_RGBA555 v4l2_fourcc('R', 'A', '1', '5') /* 16  RGBA-5-5-5-1  */
+	{ V4L2_PIX_FMT_RGBA555, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_RGBA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, true },
+#define V4L2_PIX_FMT_RGBX555 v4l2_fourcc('R', 'X', '1', '5') /* 16  RGBX-5-5-5-1  */
+	{ V4L2_PIX_FMT_RGBX555, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_RGBX_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, false },
+#define V4L2_PIX_FMT_ABGR555 v4l2_fourcc('A', 'B', '1', '5') /* 16  ABGR-1-5-5-5  */
+	{ V4L2_PIX_FMT_ABGR555, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_ABGR_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, true },
+#define V4L2_PIX_FMT_XBGR555 v4l2_fourcc('X', 'B', '1', '5') /* 16  XBGR-1-5-5-5  */
+	{ V4L2_PIX_FMT_XBGR555, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_ABGR_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, false },
+#define V4L2_PIX_FMT_BGRA555 v4l2_fourcc('B', 'A', '1', '5') /* 16  BGRA-5-5-5-1  */
+	{ V4L2_PIX_FMT_BGRA555, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_BGRA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, true },
+#define V4L2_PIX_FMT_BGRX555 v4l2_fourcc('B', 'X', '1', '5') /* 16  BGRX-5-5-5-1  */
+	{ V4L2_PIX_FMT_BGRX555, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_BGRA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, false },
 	{ V4L2_PIX_FMT_RGB565, MEDIA_BUS_FMT_ARGB8888_1X32,
 	  VI6_FMT_RGB_565, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
 	  VI6_RPF_DSWAP_P_WDS,
-- 
Regards,

Laurent Pinchart

