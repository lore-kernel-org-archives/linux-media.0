Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC691C433E0
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 15:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A005322B45
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 15:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbhAEPeX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:34:23 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38064 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbhAEPeW (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 5 Jan 2021 10:34:22 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 172B3121A;
        Tue,  5 Jan 2021 16:29:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609860594;
        bh=yCL5AMsjFgtR2opII7CHWTvd7leYdoI532c9g6x7zEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muctHKwF/2T1XFil5Lxcnst1QZpIWXhxITBYmiemN9X8reaw8vdRgmSCtdio2yHLI
         1zle17dU4TT1Hlo5tMdpiES6cweDQHXlKGG0PZB8vwP5CTMdm8IXhUCVhrwKIEao4H
         lnYiMcE60row29m2VYAUxRW6mIzy9n8GeN+HJSBY=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 29/75] media: imx: capture: Expose V4L2_CAP_IO_MC for the MC-centric API
Date:   Tue,  5 Jan 2021 17:28:06 +0200
Message-Id: <20210105152852.5733-30-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
References: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Report to userspace that the MC-centric API is MC-centric by exposing
the V4L2_CAP_IO_MC. This requires adding support for mbus code filtering
in format enumeration, as required by V4L2_CAP_IO_MC.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx-media-capture.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index f8c1f48d5d4c..04eb612ff1fa 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -96,7 +96,7 @@ static int capture_enum_fmt_vid_cap(struct file *file, void *fh,
 				    struct v4l2_fmtdesc *f)
 {
 	return imx_media_enum_pixel_formats(&f->pixelformat, f->index,
-					    PIXFMT_SEL_ANY, 0);
+					    PIXFMT_SEL_ANY, f->mbus_code);
 }
 
 static int capture_enum_framesizes(struct file *file, void *fh,
@@ -992,7 +992,8 @@ imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
 	vfd->release = video_device_release;
 	vfd->vfl_dir = VFL_DIR_RX;
 	vfd->tvnorms = V4L2_STD_NTSC | V4L2_STD_PAL | V4L2_STD_SECAM;
-	vfd->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	vfd->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING
+			 | (!legacy_api ? V4L2_CAP_IO_MC : 0);
 	vfd->lock = &priv->mutex;
 	vfd->queue = &priv->q;
 
-- 
Regards,

Laurent Pinchart

