Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75958C10F06
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CB920811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfC1UFv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:05:51 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56371 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfC1UFv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:05:51 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 76713E0002;
        Thu, 28 Mar 2019 20:05:47 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 06/31] media: entity: Move the pipeline from entity to pads
Date:   Thu, 28 Mar 2019 21:05:43 +0100
Message-Id: <20190328200608.9463-7-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

This moves the pipe and stream_count fields from struct media_entity to
struct media_pad. Effectively streams become pad-specific rather than
being entity specific, allowing several independent streams to traverse a
single entity and an entity to be part of several streams.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

- Update documentation to use 'pads'
- Use the media pad iterator in media_entity.c
- Update rcar-dma.c to use the new per-pad stream count
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/media-entity.c                  | 68 +++++++++++--------
 drivers/media/platform/exynos4-is/fimc-isp.c  |  2 +-
 drivers/media/platform/exynos4-is/fimc-lite.c |  2 +-
 drivers/media/platform/omap3isp/isp.c         |  2 +-
 drivers/media/platform/omap3isp/ispvideo.c    |  2 +-
 drivers/media/platform/omap3isp/ispvideo.h    |  2 +-
 drivers/media/platform/rcar-vin/rcar-core.c   | 16 +++--
 drivers/media/platform/rcar-vin/rcar-dma.c    |  2 +-
 drivers/media/platform/xilinx/xilinx-dma.c    |  2 +-
 drivers/media/platform/xilinx/xilinx-dma.h    |  2 +-
 drivers/staging/media/imx/imx-media-utils.c   |  2 +-
 drivers/staging/media/omap4iss/iss.c          |  2 +-
 drivers/staging/media/omap4iss/iss_video.c    |  2 +-
 drivers/staging/media/omap4iss/iss_video.h    |  2 +-
 include/media/media-entity.h                  | 21 +++---
 15 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/drivers/media/media-entity.c b/drivers/media/media-entity.c
index b092cbf25ebb..9f7d9125b245 100644
--- a/drivers/media/media-entity.c
+++ b/drivers/media/media-entity.c
@@ -431,24 +431,28 @@ __must_check int __media_pipeline_start(struct media_entity *entity,
 
 	while ((pad = media_graph_walk_next(graph))) {
 		struct media_entity *entity = pad->entity;
+		bool skip_validation = pad->pipe;
+		struct media_pad *iter;
 
 		DECLARE_BITMAP(active, MEDIA_ENTITY_MAX_PADS);
 		DECLARE_BITMAP(has_no_links, MEDIA_ENTITY_MAX_PADS);
 
-		entity->stream_count++;
-
-		if (entity->pipe && entity->pipe != pipe) {
-			pr_err("Pipe active for %s. Can't start for %s\n",
-				entity->name,
-				entity_err->name);
-			ret = -EBUSY;
-			goto error;
+		media_entity_for_each_pad(entity, iter) {
+			if (iter->pipe && iter->pipe != pipe) {
+				pr_err("Pipe active for %s. Can't start for %s\n",
+				       entity->name, iter->entity->name);
+				ret = -EBUSY;
+			} else {
+				iter->pipe = pipe;
+			}
+			iter->stream_count++;
 		}
 
-		entity->pipe = pipe;
+		if (ret)
+			goto error;
 
-		/* Already streaming --- no need to check. */
-		if (entity->stream_count > 1)
+		/* Already part of the pipeline, skip validation. */
+		if (skip_validation)
 			continue;
 
 		if (!entity->ops || !entity->ops->link_validate)
@@ -517,20 +521,23 @@ __must_check int __media_pipeline_start(struct media_entity *entity,
 	media_graph_walk_start(graph, pad_err);
 
 	while ((pad_err = media_graph_walk_next(graph))) {
-		struct media_entity *entity_err = pad_err->entity;
-
-		/* Sanity check for negative stream_count */
-		if (!WARN_ON_ONCE(entity_err->stream_count <= 0)) {
-			entity_err->stream_count--;
-			if (entity_err->stream_count == 0)
-				entity_err->pipe = NULL;
+		struct media_entity *entity = pad->entity;
+		struct media_pad *iter;
+
+		media_entity_for_each_pad(entity, iter) {
+			/* Sanity check for negative stream_count */
+			if (!WARN_ON_ONCE(iter->stream_count <= 0)) {
+				--iter->stream_count;
+				if (iter->stream_count == 0)
+					iter->pipe = NULL;
+			}
 		}
 
 		/*
 		 * We haven't increased stream_count further than this
 		 * so we quit here.
 		 */
-		if (pad_err == pad)
+		if (pad_err->entity == pad->entity)
 			break;
 	}
 
@@ -557,7 +564,7 @@ EXPORT_SYMBOL_GPL(media_pipeline_start);
 
 void __media_pipeline_stop(struct media_entity *entity)
 {
-	struct media_pipeline *pipe = entity->pipe;
+	struct media_pipeline *pipe = entity->pads->pipe;
 	struct media_graph *graph = &pipe->graph;
 	struct media_pad *pad;
 
@@ -572,12 +579,15 @@ void __media_pipeline_stop(struct media_entity *entity)
 
 	while ((pad = media_graph_walk_next(graph))) {
 		struct media_entity *entity = pad->entity;
-
-		/* Sanity check for negative stream_count */
-		if (!WARN_ON_ONCE(entity->stream_count <= 0)) {
-			entity->stream_count--;
-			if (entity->stream_count == 0)
-				entity->pipe = NULL;
+		struct media_pad *iter;
+
+		media_entity_for_each_pad(entity, iter) {
+			/* Sanity check for negative stream_count */
+			if (!WARN_ON_ONCE(iter->stream_count <= 0)) {
+				iter->stream_count--;
+				if (iter->stream_count == 0)
+					iter->pipe = NULL;
+			}
 		}
 	}
 
@@ -842,7 +852,7 @@ int __media_entity_setup_link(struct media_link *link, u32 flags)
 {
 	const u32 mask = MEDIA_LNK_FL_ENABLED;
 	struct media_device *mdev;
-	struct media_entity *source, *sink;
+	struct media_pad *source, *sink;
 	int ret = -EBUSY;
 
 	if (link == NULL)
@@ -858,8 +868,8 @@ int __media_entity_setup_link(struct media_link *link, u32 flags)
 	if (link->flags == flags)
 		return 0;
 
-	source = link->source->entity;
-	sink = link->sink->entity;
+	source = link->source;
+	sink = link->sink;
 
 	if (!(link->flags & MEDIA_LNK_FL_DYNAMIC) &&
 	    (source->stream_count || sink->stream_count))
diff --git a/drivers/media/platform/exynos4-is/fimc-isp.c b/drivers/media/platform/exynos4-is/fimc-isp.c
index 9a48c0f69320..79d128a57e87 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp.c
@@ -229,7 +229,7 @@ static int fimc_isp_subdev_set_fmt(struct v4l2_subdev *sd,
 			}
 		}
 	} else {
-		if (sd->entity.stream_count == 0) {
+		if (sd->entity.pads->stream_count == 0) {
 			if (fmt->pad == FIMC_ISP_SD_PAD_SINK) {
 				struct v4l2_subdev_format format = *fmt;
 
diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/exynos4-is/fimc-lite.c
index 96f0a8a0dcae..dbadcba6739a 100644
--- a/drivers/media/platform/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/exynos4-is/fimc-lite.c
@@ -1096,7 +1096,7 @@ static int fimc_lite_subdev_set_fmt(struct v4l2_subdev *sd,
 	mutex_lock(&fimc->lock);
 
 	if ((atomic_read(&fimc->out_path) == FIMC_IO_ISP &&
-	    sd->entity.stream_count > 0) ||
+	    sd->entity.pads->stream_count > 0) ||
 	    (atomic_read(&fimc->out_path) == FIMC_IO_DMA &&
 	    vb2_is_busy(&fimc->vb_queue))) {
 		mutex_unlock(&fimc->lock);
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index bd57174d81a7..322a7ebdaf0d 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -927,7 +927,7 @@ static int isp_pipeline_is_last(struct media_entity *me)
 	struct isp_pipeline *pipe;
 	struct media_pad *pad;
 
-	if (!me->pipe)
+	if (!me->pads->pipe)
 		return 0;
 	pipe = to_isp_pipeline(me);
 	if (pipe->stream_state == ISP_PIPELINE_STREAM_STOPPED)
diff --git a/drivers/media/platform/omap3isp/ispvideo.c b/drivers/media/platform/omap3isp/ispvideo.c
index be364eb64e40..aed6c0a08284 100644
--- a/drivers/media/platform/omap3isp/ispvideo.c
+++ b/drivers/media/platform/omap3isp/ispvideo.c
@@ -1102,7 +1102,7 @@ isp_video_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	/* Start streaming on the pipeline. No link touching an entity in the
 	 * pipeline can be activated or deactivated once streaming is started.
 	 */
-	pipe = video->video.entity.pipe
+	pipe = video->video.entity.pads->pipe
 	     ? to_isp_pipeline(&video->video.entity) : &video->pipe;
 
 	ret = media_entity_enum_init(&pipe->ent_enum, &video->isp->media_dev);
diff --git a/drivers/media/platform/omap3isp/ispvideo.h b/drivers/media/platform/omap3isp/ispvideo.h
index f6a2082b4a0a..8f4146c25a1b 100644
--- a/drivers/media/platform/omap3isp/ispvideo.h
+++ b/drivers/media/platform/omap3isp/ispvideo.h
@@ -103,7 +103,7 @@ struct isp_pipeline {
 };
 
 #define to_isp_pipeline(__e) \
-	container_of((__e)->pipe, struct isp_pipeline, pipe)
+	container_of((__e)->pads->pipe, struct isp_pipeline, pipe)
 
 static inline int isp_pipeline_ready(struct isp_pipeline *pipe)
 {
diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index 64f9cf790445..64519b3097f7 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -132,13 +132,17 @@ static int rvin_group_link_notify(struct media_link *link, u32 flags,
 		return 0;
 
 	/*
-	 * Don't allow link changes if any entity in the graph is
-	 * streaming, modifying the CHSEL register fields can disrupt
-	 * running streams.
+	 * Don't allow link changes if any stream in the graph is active as
+	 * modifying the CHSEL register fields can disrupt running streams.
 	 */
-	media_device_for_each_entity(entity, &group->mdev)
-		if (entity->stream_count)
-			return -EBUSY;
+	media_device_for_each_entity(entity, &group->mdev) {
+		struct media_pad *iter;
+
+		media_entity_for_each_pad(entity, iter) {
+			if (iter->stream_count)
+				return -EBUSY;
+		}
+	}
 
 	mutex_lock(&group->lock);
 
diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index 2207a31d355e..c8437810ebf8 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -1128,7 +1128,7 @@ static int rvin_set_stream(struct rvin_dev *vin, int on)
 	 */
 	mdev = vin->vdev.entity.graph_obj.mdev;
 	mutex_lock(&mdev->graph_mutex);
-	pipe = sd->entity.pipe ? sd->entity.pipe : &vin->vdev.pipe;
+	pipe = sd->entity.pads->pipe ? sd->entity.pads->pipe : &vin->vdev.pipe;
 	ret = __media_pipeline_start(&vin->vdev.entity, pipe);
 	mutex_unlock(&mdev->graph_mutex);
 	if (ret)
diff --git a/drivers/media/platform/xilinx/xilinx-dma.c b/drivers/media/platform/xilinx/xilinx-dma.c
index 66063ccbf84d..08ff171d7aac 100644
--- a/drivers/media/platform/xilinx/xilinx-dma.c
+++ b/drivers/media/platform/xilinx/xilinx-dma.c
@@ -403,7 +403,7 @@ static int xvip_dma_start_streaming(struct vb2_queue *vq, unsigned int count)
 	 * Use the pipeline object embedded in the first DMA object that starts
 	 * streaming.
 	 */
-	pipe = dma->video.entity.pipe
+	pipe = dma->video.entity.pads->pipe
 	     ? to_xvip_pipeline(&dma->video.entity) : &dma->pipe;
 
 	ret = media_pipeline_start(&dma->video.entity, &pipe->pipe);
diff --git a/drivers/media/platform/xilinx/xilinx-dma.h b/drivers/media/platform/xilinx/xilinx-dma.h
index 5aec4d17eb21..45b815e83d69 100644
--- a/drivers/media/platform/xilinx/xilinx-dma.h
+++ b/drivers/media/platform/xilinx/xilinx-dma.h
@@ -47,7 +47,7 @@ struct xvip_pipeline {
 
 static inline struct xvip_pipeline *to_xvip_pipeline(struct media_entity *e)
 {
-	return container_of(e->pipe, struct xvip_pipeline, pipe);
+	return container_of(e->pads->pipe, struct xvip_pipeline, pipe);
 }
 
 /**
diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 1c63a2765a81..cc10f2d5b51b 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -936,7 +936,7 @@ int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
 			__media_pipeline_stop(entity);
 	} else {
 		v4l2_subdev_call(sd, video, s_stream, 0);
-		if (entity->pipe)
+		if (entity->pads->pipe)
 			__media_pipeline_stop(entity);
 	}
 
diff --git a/drivers/staging/media/omap4iss/iss.c b/drivers/staging/media/omap4iss/iss.c
index c8be1db532ab..030808b222cf 100644
--- a/drivers/staging/media/omap4iss/iss.c
+++ b/drivers/staging/media/omap4iss/iss.c
@@ -543,7 +543,7 @@ static int iss_pipeline_is_last(struct media_entity *me)
 	struct iss_pipeline *pipe;
 	struct media_pad *pad;
 
-	if (!me->pipe)
+	if (!me->pads->pipe)
 		return 0;
 	pipe = to_iss_pipeline(me);
 	if (pipe->stream_state == ISS_PIPELINE_STREAM_STOPPED)
diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
index 82095f627d65..2a2f7a7983db 100644
--- a/drivers/staging/media/omap4iss/iss_video.c
+++ b/drivers/staging/media/omap4iss/iss_video.c
@@ -878,7 +878,7 @@ iss_video_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	 * Start streaming on the pipeline. No link touching an entity in the
 	 * pipeline can be activated or deactivated once streaming is started.
 	 */
-	pipe = pad->entity->pipe
+	pipe = pad->pipe
 	     ? to_iss_pipeline(pad->entity) : &video->pipe;
 	pipe->external = NULL;
 	pipe->external_rate = 0;
diff --git a/drivers/staging/media/omap4iss/iss_video.h b/drivers/staging/media/omap4iss/iss_video.h
index f22489edb562..cdea8543b3f9 100644
--- a/drivers/staging/media/omap4iss/iss_video.h
+++ b/drivers/staging/media/omap4iss/iss_video.h
@@ -94,7 +94,7 @@ struct iss_pipeline {
 };
 
 #define to_iss_pipeline(__e) \
-	container_of((__e)->pipe, struct iss_pipeline, pipe)
+	container_of((__e)->pads->pipe, struct iss_pipeline, pipe)
 
 static inline int iss_pipeline_ready(struct iss_pipeline *pipe)
 {
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 76785a6151de..55d48b337b46 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -188,15 +188,24 @@ enum media_pad_signal_type {
  *
  * @graph_obj:	Embedded structure containing the media object common data
  * @entity:	Entity this pad belongs to
+ * @pipe:	Pipeline this pad belongs to.
+ * @stream_count: Stream count for the pad.
  * @index:	Pad index in the entity pads array, numbered from 0 to n
  * @sig_type:	Type of the signal inside a media pad
  * @flags:	Pad flags, as defined in
  *		:ref:`include/uapi/linux/media.h <media_header>`
  *		(seek for ``MEDIA_PAD_FL_*``)
+ * .. note::
+ *
+ *    @stream_count reference count must never be negative, but is a signed
+ *    integer on purpose: a simple ``WARN_ON(<0)`` check can be used to
+ *    detect reference count bugs that would make them negative.
  */
 struct media_pad {
 	struct media_gobj graph_obj;	/* must be first field in struct */
 	struct media_entity *entity;
+	struct media_pipeline *pipe;
+	int stream_count;
 	u16 index;
 	enum media_pad_signal_type sig_type;
 	unsigned long flags;
@@ -274,9 +283,7 @@ enum media_entity_type {
  * @pads:	Pads array with the size defined by @num_pads.
  * @links:	List of data links.
  * @ops:	Entity operations.
- * @stream_count: Stream count for the entity.
  * @use_count:	Use count for the entity.
- * @pipe:	Pipeline this entity belongs to.
  * @info:	Union with devnode information.  Kept just for backward
  *		compatibility.
  * @info.dev:	Contains device major and minor info.
@@ -289,10 +296,9 @@ enum media_entity_type {
  *
  * .. note::
  *
- *    @stream_count and @use_count reference counts must never be
- *    negative, but are signed integers on purpose: a simple ``WARN_ON(<0)``
- *    check can be used to detect reference count bugs that would make them
- *    negative.
+ *    @use_count reference count must never be negative, but is a signed
+ *    integer on purpose: a simple ``WARN_ON(<0)`` check can be used to
+ *    detect reference count bugs that would make them negative.
  */
 struct media_entity {
 	struct media_gobj graph_obj;	/* must be first field in struct */
@@ -311,11 +317,8 @@ struct media_entity {
 
 	const struct media_entity_operations *ops;
 
-	int stream_count;
 	int use_count;
 
-	struct media_pipeline *pipe;
-
 	union {
 		struct {
 			u32 major;
-- 
2.21.0

