Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C0EC43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C87F2173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BVct/a/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfC1HIp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:08:45 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43754 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HIp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:08:45 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D87A0569;
        Thu, 28 Mar 2019 08:08:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756922;
        bh=KJHaf75uXjNKwbRId/kiiBym+Gs8R8fcvRZIGX9Q7Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVct/a/Re6fl357ixDSd4Fl+JgCigJyN4SBhmccmVwKY0l93VpEV4Wv5Q2gLCrkmx
         E2/Mj4qg3NDQyzIvV+40QCToWrS7lE62LdJ1rfGIvkrrAbfCnymvvQH019Ius/NcmI
         5mJKXcSatlehy31bHUg6S5FvRRpIKveo1O04AuhI=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 5/9] media: vsp1: Add support for missing 16-bit RGB444 formats
Date:   Thu, 28 Mar 2019 09:07:19 +0200
Message-Id: <20190328070723.26553-6-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for the V4L2_PIX_FMT_RGBA444, V4L2_PIX_FMT_RGBX444,
V4L2_PIX_FMT_ABGR444, V4L2_PIX_FMT_XBGR444, V4L2_PIX_FMT_BGRA444 and
V4L2_PIX_FMT_BGRX444 formats to the VSP driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_pipe.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
index 9f08d85e89d7..f6665871aa11 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.c
+++ b/drivers/media/platform/vsp1/vsp1_pipe.c
@@ -42,6 +42,30 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
 	  VI6_FMT_XRGB_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
 	  VI6_RPF_DSWAP_P_WDS,
 	  1, { 16, 0, 0 }, false, false, 1, 1, false },
+	{ V4L2_PIX_FMT_RGBA444, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_RGBA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, true },
+	{ V4L2_PIX_FMT_RGBX444, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_RGBX_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, false },
+	{ V4L2_PIX_FMT_ABGR444, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_ABGR_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, true },
+	{ V4L2_PIX_FMT_XBGR444, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  V4L2_PIX_FMT_ABGR444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, false },
+	{ V4L2_PIX_FMT_BGRA444, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_BGRA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, true },
+	{ V4L2_PIX_FMT_BGRX444, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_BGRA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS,
+	  1, { 16, 0, 0 }, false, false, 1, 1, false },
 	{ V4L2_PIX_FMT_ARGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
 	  VI6_FMT_ARGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
 	  VI6_RPF_DSWAP_P_WDS,
-- 
Regards,

Laurent Pinchart

