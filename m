Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFCFC433DB
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 15:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6A222BE8
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 15:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbhAEPfb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbhAEPfb (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 5 Jan 2021 10:35:31 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596EC061793
        for <linux-media@vger.kernel.org>; Tue,  5 Jan 2021 07:34:50 -0800 (PST)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D8C61879;
        Tue,  5 Jan 2021 16:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609860597;
        bh=MHdimxs68/ATRwx8aJhqK2npwSLmCmSJpcb7WY2w9io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3WpBSDQ5TtDCsCIe0Y69gvpvV9SYvOCwyAxszTtrepo2Qo04TEV7IaKGgsdzrS/L
         IkPlF4Rppm/Q2V9UTDXm4w66mrGR+zT/CanMAHzsgwmMPXRUSrIylKRhZH67OCO5D0
         OewAqU5Q9wYdCiua290/M0MW07GLm54fjVJ+fGPE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 34/75] media: imx: imx7-media-csi: Create immutable link to capture device
Date:   Tue,  5 Jan 2021 17:28:11 +0200
Message-Id: <20210105152852.5733-35-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
References: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The i.MX7 camera pipeline is simple, with the CSI connected directly to
the capture device without any other option. There's thus no need to
allow link configurable by userspace. Make it immutable.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 60202f56343e..6f39f81274b5 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -166,8 +166,6 @@ struct imx7_csi {
 
 	struct v4l2_subdev *src_sd;
 
-	struct media_entity *sink;
-
 	struct v4l2_mbus_framefmt format_mbus[IMX7_CSI_PADS_NUM];
 	const struct imx_media_pixfmt *cc[IMX7_CSI_PADS_NUM];
 	struct v4l2_fract frame_interval[IMX7_CSI_PADS_NUM];
@@ -450,19 +448,6 @@ static int imx7_csi_link_setup(struct media_entity *entity,
 		} else {
 			csi->src_sd = NULL;
 		}
-
-		goto unlock;
-	}
-
-	/* source pad */
-	if (flags & MEDIA_LNK_FL_ENABLED) {
-		if (csi->sink) {
-			ret = -EBUSY;
-			goto unlock;
-		}
-		csi->sink = remote->entity;
-	} else {
-		csi->sink = NULL;
 	}
 
 unlock:
@@ -831,7 +816,7 @@ static int imx7_csi_s_stream(struct v4l2_subdev *sd, int enable)
 
 	mutex_lock(&csi->lock);
 
-	if (!csi->src_sd || !csi->sink) {
+	if (!csi->src_sd) {
 		ret = -EPIPE;
 		goto out_unlock;
 	}
@@ -1080,7 +1065,7 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
 	if (IS_ERR(csi->vdev))
 		return PTR_ERR(csi->vdev);
 
-	ret = imx_media_capture_device_register(csi->vdev, false);
+	ret = imx_media_capture_device_register(csi->vdev, true);
 	if (ret)
 		imx_media_capture_device_remove(csi->vdev);
 
-- 
Regards,

Laurent Pinchart

