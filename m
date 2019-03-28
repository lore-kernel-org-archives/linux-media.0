Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DCFC4360F
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157D421773
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rU522Z0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfC1HIg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:08:36 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43742 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HIg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:08:36 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E7CB454D;
        Thu, 28 Mar 2019 08:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756914;
        bh=RFKQz28/Q6OEeN5uUavN3yCCzrt0XykkkN8ofK/CzXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rU522Z0S2057I5N4lGmYQqw+EIYgiPRIAHlE90Ll7P0ZTqGeQqcTpWeBHxNcJZcb2
         onb3z1GLMQxTZGhoeYDCwa3+RsamDJuFJ0sSrz8Ptc/0kjvzjDLer2+19UWrbsdv0n
         2rpeorVOyMWYfw7T9BUi5hR5LecozDmpp9JPzd94=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4/9] media: vsp1: Add support for missing 32-bit RGB formats
Date:   Thu, 28 Mar 2019 09:07:18 +0200
Message-Id: <20190328070723.26553-5-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for the V4L2_PIX_FMT_BGRA32, V4L2_PIX_FMT_BGRX32,
V4L2_PIX_FMT_RGBA32 and V4L2_PIX_FMT_RGBX32 formats to the VSP driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_pipe.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
index 54ff539ffea0..9f08d85e89d7 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.c
+++ b/drivers/media/platform/vsp1/vsp1_pipe.c
@@ -68,6 +68,20 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
 	{ V4L2_PIX_FMT_XBGR32, MEDIA_BUS_FMT_ARGB8888_1X32,
 	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
 	  1, { 32, 0, 0 }, false, false, 1, 1, false },
+	{ V4L2_PIX_FMT_BGRA32, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
+	  1, { 32, 0, 0 }, false, false, 1, 1, true },
+	{ V4L2_PIX_FMT_BGRX32, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
+	  1, { 32, 0, 0 }, false, false, 1, 1, false },
+	{ V4L2_PIX_FMT_RGBA32, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
+	  1, { 32, 0, 0 }, false, false, 1, 1, true },
+	{ V4L2_PIX_FMT_RGBX32, MEDIA_BUS_FMT_ARGB8888_1X32,
+	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
+	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
+	  1, { 32, 0, 0 }, false, false, 1, 1, false },
 	{ V4L2_PIX_FMT_ARGB32, MEDIA_BUS_FMT_ARGB8888_1X32,
 	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
 	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
-- 
Regards,

Laurent Pinchart

