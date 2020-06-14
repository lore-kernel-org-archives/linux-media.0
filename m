Return-Path: <SRS0=EymB=74=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40222C433E1
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D37B20747
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vehyK4X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgFOAAP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:00:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33330 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgFOAAP (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 20:00:15 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B21398D;
        Mon, 15 Jun 2020 02:00:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592179211;
        bh=BK+PPv4NedoLVyVXRX7EHaHY1AJbKDH0AuI7Tbr89q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vehyK4X6aA57Ki3JymAhlVDh8EHay/58M+zZUKP1fp0MbdAruaqUjvQpfHJFev+mV
         Z8WEhelBykCeDLher+UzWT2Wx9w16Wk7t0uxLVKEv8cFoRA+zS4q4SYLpMyL9mPFQ0
         Gp/aU8RngOOSSqzSku7X6YY9J5bVEGe3b5ODck+s=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v1 002/107] media: ti-vpe: cal: Avoid function forward declaration
Date:   Mon, 15 Jun 2020 02:57:59 +0300
Message-Id: <20200614235944.17716-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
References: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Move the cal_complete_ctx() function earlier in the file to avoid a
foward declaration. There is no functional change.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c | 111 ++++++++++++++--------------
 1 file changed, 55 insertions(+), 56 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 19425248bd63..88fed930ed50 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1852,7 +1852,61 @@ static const struct video_device cal_videodev = {
  *	Initialization and module stuff
  * ------------------------------------------------------------------
  */
-static int cal_complete_ctx(struct cal_ctx *ctx);
+
+static int cal_complete_ctx(struct cal_ctx *ctx)
+{
+	struct video_device *vfd;
+	struct vb2_queue *q;
+	int ret;
+
+	ctx->timeperframe = tpf_default;
+	ctx->external_rate = 192000000;
+
+	/* initialize locks */
+	spin_lock_init(&ctx->slock);
+	mutex_init(&ctx->mutex);
+
+	/* initialize queue */
+	q = &ctx->vb_vidq;
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ;
+	q->drv_priv = ctx;
+	q->buf_struct_size = sizeof(struct cal_buffer);
+	q->ops = &cal_video_qops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock = &ctx->mutex;
+	q->min_buffers_needed = 3;
+	q->dev = ctx->v4l2_dev.dev;
+
+	ret = vb2_queue_init(q);
+	if (ret)
+		return ret;
+
+	/* init video dma queues */
+	INIT_LIST_HEAD(&ctx->vidq.active);
+
+	vfd = &ctx->vdev;
+	*vfd = cal_videodev;
+	vfd->v4l2_dev = &ctx->v4l2_dev;
+	vfd->queue = q;
+
+	/*
+	 * Provide a mutex to v4l2 core. It will be used to protect
+	 * all fops and v4l2 ioctls.
+	 */
+	vfd->lock = &ctx->mutex;
+	video_set_drvdata(vfd, ctx);
+
+	ret = video_register_device(vfd, VFL_TYPE_VIDEO, video_nr);
+	if (ret < 0)
+		return ret;
+
+	v4l2_info(&ctx->v4l2_dev, "V4L2 device registered as %s\n",
+		  video_device_node_name(vfd));
+
+	return 0;
+}
 
 static int cal_async_bound(struct v4l2_async_notifier *notifier,
 			   struct v4l2_subdev *subdev,
@@ -1948,61 +2002,6 @@ static const struct v4l2_async_notifier_operations cal_async_ops = {
 	.complete = cal_async_complete,
 };
 
-static int cal_complete_ctx(struct cal_ctx *ctx)
-{
-	struct video_device *vfd;
-	struct vb2_queue *q;
-	int ret;
-
-	ctx->timeperframe = tpf_default;
-	ctx->external_rate = 192000000;
-
-	/* initialize locks */
-	spin_lock_init(&ctx->slock);
-	mutex_init(&ctx->mutex);
-
-	/* initialize queue */
-	q = &ctx->vb_vidq;
-	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ;
-	q->drv_priv = ctx;
-	q->buf_struct_size = sizeof(struct cal_buffer);
-	q->ops = &cal_video_qops;
-	q->mem_ops = &vb2_dma_contig_memops;
-	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->lock = &ctx->mutex;
-	q->min_buffers_needed = 3;
-	q->dev = ctx->v4l2_dev.dev;
-
-	ret = vb2_queue_init(q);
-	if (ret)
-		return ret;
-
-	/* init video dma queues */
-	INIT_LIST_HEAD(&ctx->vidq.active);
-
-	vfd = &ctx->vdev;
-	*vfd = cal_videodev;
-	vfd->v4l2_dev = &ctx->v4l2_dev;
-	vfd->queue = q;
-
-	/*
-	 * Provide a mutex to v4l2 core. It will be used to protect
-	 * all fops and v4l2 ioctls.
-	 */
-	vfd->lock = &ctx->mutex;
-	video_set_drvdata(vfd, ctx);
-
-	ret = video_register_device(vfd, VFL_TYPE_VIDEO, video_nr);
-	if (ret < 0)
-		return ret;
-
-	v4l2_info(&ctx->v4l2_dev, "V4L2 device registered as %s\n",
-		  video_device_node_name(vfd));
-
-	return 0;
-}
-
 static struct device_node *
 of_get_next_port(const struct device_node *parent,
 		 struct device_node *prev)
-- 
Regards,

Laurent Pinchart

