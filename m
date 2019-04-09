Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0DFC10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 10:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFBE2084F
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 10:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDIKSO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:18:14 -0400
Received: from retiisi.org.uk ([95.216.213.190]:37234 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbfDIKSO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 9 Apr 2019 06:18:14 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id DB5C6634C7B;
        Tue,  9 Apr 2019 13:17:11 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     bingbu.cao@intel.com
Subject: [PATCH 1/1] ipu3-imgu: Use %u for formatting unsigned values (not %d)
Date:   Tue,  9 Apr 2019 13:18:10 +0300
Message-Id: <20190409101810.17002-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The driver used %d for formatting unsigned values. Use %u instead.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index be818c29620f..3bb08af83dfe 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -66,7 +66,7 @@ static int imgu_subdev_s_stream(struct v4l2_subdev *sd, int enable)
 	struct imgu_css_pipe *css_pipe = &imgu->css.pipes[pipe];
 	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
 
-	dev_dbg(dev, "%s %d for pipe %d", __func__, enable, pipe);
+	dev_dbg(dev, "%s %d for pipe %u", __func__, enable, pipe);
 	/* grab ctrl after streamon and return after off */
 	v4l2_ctrl_grab(imgu_sd->ctrl, enable);
 
@@ -101,7 +101,7 @@ static int imgu_subdev_s_stream(struct v4l2_subdev *sd, int enable)
 	else
 		css_pipe->pipe_id = IPU3_CSS_PIPE_ID_CAPTURE;
 
-	dev_dbg(dev, "IPU3 pipe %d pipe_id %d", pipe, css_pipe->pipe_id);
+	dev_dbg(dev, "IPU3 pipe %u pipe_id %u", pipe, css_pipe->pipe_id);
 
 	rects[IPU3_CSS_RECT_EFFECTIVE] = &imgu_sd->rect.eff;
 	rects[IPU3_CSS_RECT_BDS] = &imgu_sd->rect.bds;
@@ -109,7 +109,7 @@ static int imgu_subdev_s_stream(struct v4l2_subdev *sd, int enable)
 
 	r = imgu_css_fmt_set(&imgu->css, fmts, rects, pipe);
 	if (r) {
-		dev_err(dev, "failed to set initial formats pipe %d with (%d)",
+		dev_err(dev, "failed to set initial formats pipe %u with (%d)",
 			pipe, r);
 		return r;
 	}
@@ -157,7 +157,7 @@ static int imgu_subdev_set_fmt(struct v4l2_subdev *sd,
 	u32 pad = fmt->pad;
 	unsigned int pipe = imgu_sd->pipe;
 
-	dev_dbg(&imgu->pci_dev->dev, "set subdev %d pad %d fmt to [%dx%d]",
+	dev_dbg(&imgu->pci_dev->dev, "set subdev %u pad %u fmt to [%ux%u]",
 		pipe, pad, fmt->format.width, fmt->format.height);
 
 	imgu_pipe = &imgu->imgu_pipe[pipe];
@@ -233,7 +233,7 @@ static int imgu_subdev_set_selection(struct v4l2_subdev *sd,
 	struct v4l2_rect *rect, *try_sel;
 
 	dev_dbg(&imgu->pci_dev->dev,
-		 "set subdev %d sel which %d target 0x%4x rect [%dx%d]",
+		 "set subdev %u sel which %u target 0x%4x rect [%ux%u]",
 		 imgu_sd->pipe, sel->which, sel->target,
 		 sel->r.width, sel->r.height);
 
@@ -279,7 +279,7 @@ static int imgu_link_setup(struct media_entity *entity,
 
 	WARN_ON(pad >= IMGU_NODE_NUM);
 
-	dev_dbg(&imgu->pci_dev->dev, "pipe %d pad %d is %s", pipe, pad,
+	dev_dbg(&imgu->pci_dev->dev, "pipe %u pad %u is %s", pipe, pad,
 		 flags & MEDIA_LNK_FL_ENABLED ? "enabled" : "disabled");
 
 	imgu_pipe = &imgu->imgu_pipe[pipe];
@@ -294,7 +294,7 @@ static int imgu_link_setup(struct media_entity *entity,
 	else
 		__clear_bit(pipe, imgu->css.enabled_pipes);
 
-	dev_dbg(&imgu->pci_dev->dev, "pipe %d is %s", pipe,
+	dev_dbg(&imgu->pci_dev->dev, "pipe %u is %s", pipe,
 		 flags & MEDIA_LNK_FL_ENABLED ? "enabled" : "disabled");
 
 	return 0;
@@ -370,7 +370,7 @@ static void imgu_vb2_buf_queue(struct vb2_buffer *vb)
 	if (imgu->streaming)
 		imgu_queue_buffers(imgu, false, node->pipe);
 
-	dev_dbg(&imgu->pci_dev->dev, "%s for pipe %d node %d", __func__,
+	dev_dbg(&imgu->pci_dev->dev, "%s for pipe %u node %u", __func__,
 		node->pipe, node->id);
 }
 
@@ -421,7 +421,7 @@ static bool imgu_all_nodes_streaming(struct imgu_device *imgu,
 	pipe = except->pipe;
 	if (!test_bit(pipe, imgu->css.enabled_pipes)) {
 		dev_warn(&imgu->pci_dev->dev,
-			 "pipe %d link is not ready yet", pipe);
+			 "pipe %ulink is not ready yet", pipe);
 		return false;
 	}
 
@@ -465,7 +465,7 @@ static int imgu_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 	int r;
 	unsigned int pipe;
 
-	dev_dbg(dev, "%s node name %s pipe %d id %u", __func__,
+	dev_dbg(dev, "%s node name %s pipe %u id %u", __func__,
 		node->name, node->pipe, node->id);
 
 	if (imgu->streaming) {
@@ -525,7 +525,7 @@ static void imgu_vb2_stop_streaming(struct vb2_queue *vq)
 	WARN_ON(!node->enabled);
 
 	pipe = node->pipe;
-	dev_dbg(dev, "Try to stream off node [%d][%d]", pipe, node->id);
+	dev_dbg(dev, "Try to stream off node [%u][%u]", pipe, node->id);
 	imgu_pipe = &imgu->imgu_pipe[pipe];
 	r = v4l2_subdev_call(&imgu_pipe->imgu_sd.subdev, video, s_stream, 0);
 	if (r)
@@ -659,10 +659,10 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
 	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
 	struct imgu_v4l2_subdev *imgu_sd = &imgu_pipe->imgu_sd;
 
-	dev_dbg(dev, "set fmt node [%u][%u](try = %d)", pipe, node, try);
+	dev_dbg(dev, "set fmt node [%u][%u](try = %u)", pipe, node, try);
 
 	for (i = 0; i < IMGU_NODE_NUM; i++)
-		dev_dbg(dev, "IMGU pipe %d node %d enabled = %d",
+		dev_dbg(dev, "IMGU pipe %u node %u enabled = %u",
 			pipe, i, imgu_pipe->nodes[i].enabled);
 
 	if (imgu_pipe->nodes[IMGU_NODE_VF].enabled)
@@ -673,7 +673,7 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
 	else
 		css_pipe->pipe_id = IPU3_CSS_PIPE_ID_CAPTURE;
 
-	dev_dbg(dev, "IPU3 pipe %d pipe_id = %d", pipe, css_pipe->pipe_id);
+	dev_dbg(dev, "IPU3 pipe %u pipe_id = %u", pipe, css_pipe->pipe_id);
 
 	for (i = 0; i < IPU3_CSS_QUEUES; i++) {
 		unsigned int inode = imgu_map_node(imgu, i);
@@ -777,7 +777,7 @@ static int imgu_vidioc_try_fmt(struct file *file, void *fh,
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	int r;
 
-	dev_dbg(dev, "%s [%ux%u] for node %d\n", __func__,
+	dev_dbg(dev, "%s [%ux%u] for node %u\n", __func__,
 		pix_mp->width, pix_mp->height, node->id);
 
 	r = imgu_try_fmt(file, fh, f);
@@ -795,7 +795,7 @@ static int imgu_vidioc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	int r;
 
-	dev_dbg(dev, "%s [%ux%u] for node %d\n", __func__,
+	dev_dbg(dev, "%s [%ux%u] for node %u\n", __func__,
 		pix_mp->width, pix_mp->height, node->id);
 
 	r = imgu_try_fmt(file, fh, f);
@@ -1018,7 +1018,7 @@ static int imgu_sd_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct imgu_device *imgu = v4l2_get_subdevdata(&imgu_sd->subdev);
 	struct device *dev = &imgu->pci_dev->dev;
 
-	dev_dbg(dev, "set val %d to ctrl 0x%8x for subdev %d",
+	dev_dbg(dev, "set val %d to ctrl 0x%8x for subdev %u",
 		ctrl->val, ctrl->id, imgu_sd->pipe);
 
 	switch (ctrl->id) {
@@ -1118,7 +1118,7 @@ static int imgu_v4l2_subdev_register(struct imgu_device *imgu,
 	imgu_sd->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE |
 				V4L2_SUBDEV_FL_HAS_EVENTS;
 	snprintf(imgu_sd->subdev.name, sizeof(imgu_sd->subdev.name),
-		 "%s %d", IMGU_NAME, pipe);
+		 "%s %u", IMGU_NAME, pipe);
 	v4l2_set_subdevdata(&imgu_sd->subdev, imgu);
 	atomic_set(&imgu_sd->running_mode, IPU3_RUNNING_MODE_VIDEO);
 	v4l2_ctrl_handler_init(hdl, 1);
@@ -1236,7 +1236,7 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 	}
 
 	/* Initialize vdev */
-	snprintf(vdev->name, sizeof(vdev->name), "%s %d %s",
+	snprintf(vdev->name, sizeof(vdev->name), "%s %u %s",
 		 IMGU_NAME, pipe, node->name);
 	vdev->release = video_device_release_empty;
 	vdev->fops = &imgu_v4l2_fops;
@@ -1331,7 +1331,7 @@ static int imgu_v4l2_register_pipes(struct imgu_device *imgu)
 		r = imgu_v4l2_subdev_register(imgu, &imgu_pipe->imgu_sd, i);
 		if (r) {
 			dev_err(&imgu->pci_dev->dev,
-				"failed to register subdev%d ret (%d)\n", i, r);
+				"failed to register subdev%u ret (%d)\n", i, r);
 			goto pipes_cleanup;
 		}
 		r = imgu_v4l2_nodes_setup_pipe(imgu, i);
-- 
2.11.0

