Return-Path: <SRS0=EymB=74=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF94CC433E0
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E55120768
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JBm878kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgFOACL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:02:11 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33330 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFOACJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 20:02:09 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B1312148;
        Mon, 15 Jun 2020 02:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592179258;
        bh=ZQWmNj5+FdtWgHMEg1LfshC//QKiy3Cb558iF8cmpdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBm878kYVF1Juh7ZYTJPoz0R9p7RguKOU6TjJwl86+EvSmYK8Z2tnKNOviKLuzUTo
         sxe2iv6L7tA6UrNU3Jv0GDVj21JXzMC+KN/NrnMaf0XgEJo8z4iPo3b25Cbuu5ruX4
         BKCtKzqw9WZpdA+qG6WIDLckcX9xiFlMhiPQPbYU=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v1 099/107] media: ti-vpe: cal: Drop V4L2_CAP_READWRITE
Date:   Mon, 15 Jun 2020 02:59:36 +0300
Message-Id: <20200614235944.17716-100-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
References: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The V4L2 read/write API is inefficient and makes little sense for
devices that handle frame-based formats. Applications shouldn't use it,
drop its support from the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal-video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
index 7eec0a57b141..775ed2fd9f1e 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -595,8 +595,7 @@ static const struct video_device cal_videodev = {
 	.ioctl_ops	= &cal_ioctl_ops,
 	.minor		= -1,
 	.release	= video_device_release_empty,
-	.device_caps	= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
-			  V4L2_CAP_READWRITE,
+	.device_caps	= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING,
 };
 
 static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
@@ -731,7 +730,7 @@ int cal_ctx_v4l2_init(struct cal_ctx *ctx)
 
 	/* Initialize the vb2 queue. */
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ;
+	q->io_modes = VB2_MMAP | VB2_DMABUF;
 	q->drv_priv = ctx;
 	q->buf_struct_size = sizeof(struct cal_buffer);
 	q->ops = &cal_video_qops;
-- 
Regards,

Laurent Pinchart

