Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E717EC10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20C12083E
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gydWNegc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDKQNH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:13:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35638 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfDKQNH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 12:13:07 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0E621A4D;
        Thu, 11 Apr 2019 18:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554999182;
        bh=LzOqVAj5RUGUVwEHzm3erKAt3wTqoe6iLXst0N1UAwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gydWNegcU6wjNxUel7G8IvuZ2pNdmoJV/4OC7mvY3CktUQYjn1NnG6o0mbV+v8Fmq
         lydIsqeedCEvkd/LIDFkHHRwrosGpxtcJeMVZfJOlEovCDeI9k5880CH/ihwvkP1i4
         Ojp3gVen/6HLElwdwbWSPk2XieQ2JW7YYdukaazc=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3 5/5] media: vsp1: Provide partition overlap algorithm
Date:   Thu, 11 Apr 2019 17:12:56 +0100
Message-Id: <20190411161256.19607-6-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

To improve image quality, entities involved within the image partition
algorithm may extend their partition window to account for their input
requirements and to take consideration of the number of taps in their
filters.

Extend the partition algorithm to sweep first backwards, then forwards
through the entity list. Each entity is given the opportunity to expand
it's window on the reverse sweep, and clip or increase the offset on the
forwards sweep.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---
v2:
 - Configure HSTP and HEDP in uds_configure_partition for single partitions
 - refactored to use individual functions for various phase and position calculations
 - squashed forwards and backwards propagation work to a single patch
 - Fixed a few 'off-by-ones'
 - considerable other changes :)

v3a:
 - SRU comments updated
 - phase function parameter documentation updated
 - s/uds_left_src_pixel/uds_left_sink_pixel/
 - s/uds_right_src_pixel/uds_right_sink_pixel/

v3b:
 - A full rework to the UDS overlap and phase calculations
 - Collapse split calculations into the single uds_partition() function
 - Document UDS calculations following procedure steps as per datasheet
---
 drivers/media/platform/vsp1/vsp1_entity.h |   2 +-
 drivers/media/platform/vsp1/vsp1_pipe.c   |  40 +++++++-
 drivers/media/platform/vsp1/vsp1_pipe.h   |   6 ++
 drivers/media/platform/vsp1/vsp1_rpf.c    |   8 +-
 drivers/media/platform/vsp1/vsp1_sru.c    |  38 ++++++-
 drivers/media/platform/vsp1/vsp1_uds.c    | 115 ++++++++++++++++++++--
 drivers/media/platform/vsp1/vsp1_video.c  |   1 +
 drivers/media/platform/vsp1/vsp1_wpf.c    |  16 ++-
 8 files changed, 207 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_entity.h b/drivers/media/platform/vsp1/vsp1_entity.h
index 97acb7795cf1..772492877764 100644
--- a/drivers/media/platform/vsp1/vsp1_entity.h
+++ b/drivers/media/platform/vsp1/vsp1_entity.h
@@ -88,7 +88,7 @@ struct vsp1_entity_operations {
 	unsigned int (*max_width)(struct vsp1_entity *, struct vsp1_pipeline *);
 	void (*partition)(struct vsp1_entity *, struct vsp1_pipeline *,
 			  struct vsp1_partition *, unsigned int,
-			  struct vsp1_partition_window *);
+			  struct vsp1_partition_window *, bool);
 };
 
 struct vsp1_entity {
diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
index f1bd21a01bcd..137ebe0ecad2 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.c
+++ b/drivers/media/platform/vsp1/vsp1_pipe.c
@@ -375,10 +375,32 @@ bool vsp1_pipeline_partitioned(struct vsp1_pipeline *pipe)
 /*
  * Propagate the partition calculations through the pipeline
  *
- * Work backwards through the pipe, allowing each entity to update the partition
- * parameters based on its configuration, and the entity connected to its
- * source. Each entity must produce the partition required for the previous
- * entity in the pipeline.
+ * Work backwards through the pipe, allowing each entity to update the
+ * partition parameters based on its configuration. Each entity must produce
+ * the partition window required for the previous entity in the pipeline
+ * to generate. This window can be passed through if no changes are necessary.
+ *
+ * Entities are processed in reverse order:
+ *	DDDD = Destination pixels
+ *	SSSS = Source pixels
+ *	==== = Intermediate pixels
+ *	____ = Disposable pixels
+ *
+ * WPF			    |DDDD|	WPF determines it's required partition
+ * SRU			    |====|	Interconnected entities pass through
+ * UDS(source)		   |<====>|	UDS Source requests overlap
+ * UDS(sink)		|<-|======|->|	UDS Sink calculates input size
+ * RPF			|__SSSSSSSS__|	RPF provides extra pixels
+ *
+ * Then work forwards through the pipe allowing entities to communicate any
+ * clipping required based on any overlap and expansions they may have
+ * generated.
+ *
+ * RPF			|__SSSSSSSS__|	Partition window is propagated forwards
+ * UDS(sink)		|============|
+ * UDS(source)		   |<====>|	UDS Source reports overlap
+ * SRU			   |======|	Interconnected entities are updated
+ * WPF			   |_DDDD_|	WPF handles clipping
  */
 void vsp1_pipeline_propagate_partition(struct vsp1_pipeline *pipe,
 				       struct vsp1_partition *partition,
@@ -387,10 +409,18 @@ void vsp1_pipeline_propagate_partition(struct vsp1_pipeline *pipe,
 {
 	struct vsp1_entity *entity;
 
+	/* Move backwards through the pipeline to propagate any expansion. */
 	list_for_each_entry_reverse(entity, &pipe->entities, list_pipe) {
 		if (entity->ops->partition)
 			entity->ops->partition(entity, pipe, partition, index,
-					       window);
+					       window, false);
+	}
+
+	/* Move forwards through the pipeline and propagate any updates. */
+	list_for_each_entry(entity, &pipe->entities, list_pipe) {
+		if (entity->ops->partition)
+			entity->ops->partition(entity, pipe, partition, index,
+					       window, true);
 	}
 }
 
diff --git a/drivers/media/platform/vsp1/vsp1_pipe.h b/drivers/media/platform/vsp1/vsp1_pipe.h
index dd8b2cdc6452..3e263a60f79b 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.h
+++ b/drivers/media/platform/vsp1/vsp1_pipe.h
@@ -58,10 +58,12 @@ enum vsp1_pipeline_state {
  * @left: horizontal coordinate of the partition start in pixels relative to the
  *	  left edge of the image
  * @width: partition width in pixels
+ * @offset: The number of pixels from the left edge of the window to clip
  */
 struct vsp1_partition_window {
 	unsigned int left;
 	unsigned int width;
+	unsigned int offset;
 };
 
 /*
@@ -71,6 +73,8 @@ struct vsp1_partition_window {
  * @uds_source: The UDS output partition window configuration
  * @sru: The SRU partition window configuration
  * @wpf: The WPF partition window configuration
+ * @start_phase: The UDS start phase for this partition
+ * @end_phase: The UDS end phase for this partition
  */
 struct vsp1_partition {
 	struct vsp1_partition_window rpf;
@@ -78,6 +82,8 @@ struct vsp1_partition {
 	struct vsp1_partition_window uds_source;
 	struct vsp1_partition_window sru;
 	struct vsp1_partition_window wpf;
+	unsigned int start_phase;
+	unsigned int end_phase;
 };
 
 /*
diff --git a/drivers/media/platform/vsp1/vsp1_rpf.c b/drivers/media/platform/vsp1/vsp1_rpf.c
index ef9bf5dd55a0..46d270644fe2 100644
--- a/drivers/media/platform/vsp1/vsp1_rpf.c
+++ b/drivers/media/platform/vsp1/vsp1_rpf.c
@@ -324,9 +324,13 @@ static void rpf_partition(struct vsp1_entity *entity,
 			  struct vsp1_pipeline *pipe,
 			  struct vsp1_partition *partition,
 			  unsigned int partition_idx,
-			  struct vsp1_partition_window *window)
+			  struct vsp1_partition_window *window,
+			  bool forwards)
 {
-	partition->rpf = *window;
+	if (forwards)
+		*window = partition->rpf;
+	else
+		partition->rpf = *window;
 }
 
 static const struct vsp1_entity_operations rpf_entity_ops = {
diff --git a/drivers/media/platform/vsp1/vsp1_sru.c b/drivers/media/platform/vsp1/vsp1_sru.c
index b1617cb1f2b9..5e6be0bbcf36 100644
--- a/drivers/media/platform/vsp1/vsp1_sru.c
+++ b/drivers/media/platform/vsp1/vsp1_sru.c
@@ -327,24 +327,58 @@ static void sru_partition(struct vsp1_entity *entity,
 			  struct vsp1_pipeline *pipe,
 			  struct vsp1_partition *partition,
 			  unsigned int partition_idx,
-			  struct vsp1_partition_window *window)
+			  struct vsp1_partition_window *window,
+			  bool forwards)
 {
 	struct vsp1_sru *sru = to_sru(&entity->subdev);
 	struct v4l2_mbus_framefmt *input;
 	struct v4l2_mbus_framefmt *output;
+	int scale_up;
 
 	input = vsp1_entity_get_pad_format(&sru->entity, sru->entity.config,
 					   SRU_PAD_SINK);
 	output = vsp1_entity_get_pad_format(&sru->entity, sru->entity.config,
 					    SRU_PAD_SOURCE);
 
+	scale_up = (input->width != output->width);
+
+	if (forwards) {
+		/* Propagate the clipping offsets forwards. */
+		window->offset += partition->sru.offset;
+
+		if (scale_up)
+			window->offset *= 2;
+
+		return;
+	}
+
 	/* Adapt if SRUx2 is enabled. */
-	if (input->width != output->width) {
+	if (scale_up) {
+		/* Clipping offsets are not back-propagated. */
 		window->width /= 2;
 		window->left /= 2;
+
+		/* SRUx2 requires an extra pixel at the right edge. */
+		window->width++;
 	}
 
+	/*
+	 * The partition->sru represents the SRU sink pad configuration.
+	 * However, the SRU is a passive component in the partition algorithm.
+	 */
 	partition->sru = *window;
+
+	/* Expand to the left edge. */
+	if (window->left != 0) {
+		window->left--;
+		window->width++;
+		partition->sru.offset = 1;
+	} else {
+		partition->sru.offset = 0;
+	}
+
+	/* Expand to the right edge. */
+	window->width++;
 }
 
 static const struct vsp1_entity_operations sru_entity_ops = {
diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
index c71c24363d54..33c582aca5a5 100644
--- a/drivers/media/platform/vsp1/vsp1_uds.c
+++ b/drivers/media/platform/vsp1/vsp1_uds.c
@@ -270,6 +270,7 @@ static void uds_configure_stream(struct vsp1_entity *entity,
 	const struct v4l2_mbus_framefmt *input;
 	unsigned int hscale;
 	unsigned int vscale;
+	bool manual_phase = vsp1_pipeline_partitioned(pipe);
 	bool multitap;
 
 	input = vsp1_entity_get_pad_format(&uds->entity, uds->entity.config,
@@ -294,7 +295,8 @@ static void uds_configure_stream(struct vsp1_entity *entity,
 
 	vsp1_uds_write(uds, dlb, VI6_UDS_CTRL,
 		       (uds->scale_alpha ? VI6_UDS_CTRL_AON : 0) |
-		       (multitap ? VI6_UDS_CTRL_BC : 0));
+		       (multitap ? VI6_UDS_CTRL_BC : 0) |
+		       (manual_phase ? VI6_UDS_CTRL_AMDSLH : 0));
 
 	vsp1_uds_write(uds, dlb, VI6_UDS_PASS_BWIDTH,
 		       (uds_passband_width(hscale)
@@ -332,6 +334,12 @@ static void uds_configure_partition(struct vsp1_entity *entity,
 				<< VI6_UDS_CLIP_SIZE_HSIZE_SHIFT) |
 		       (output->height
 				<< VI6_UDS_CLIP_SIZE_VSIZE_SHIFT));
+
+	vsp1_uds_write(uds, dlb, VI6_UDS_HPHASE,
+		       (partition->start_phase
+				<< VI6_UDS_HPHASE_HSTP_SHIFT) |
+		       (partition->end_phase
+				<< VI6_UDS_HPHASE_HEDP_SHIFT));
 }
 
 static unsigned int uds_max_width(struct vsp1_entity *entity,
@@ -374,11 +382,27 @@ static void uds_partition(struct vsp1_entity *entity,
 			  struct vsp1_pipeline *pipe,
 			  struct vsp1_partition *partition,
 			  unsigned int partition_idx,
-			  struct vsp1_partition_window *window)
+			  struct vsp1_partition_window *window,
+			  bool forwards)
 {
 	struct vsp1_uds *uds = to_uds(&entity->subdev);
 	const struct v4l2_mbus_framefmt *output;
 	const struct v4l2_mbus_framefmt *input;
+	unsigned int hscale;
+	unsigned int margin;
+
+	unsigned int mp;
+	unsigned int src_left;
+	unsigned int src_right;
+	unsigned int dst_left;
+	unsigned int dst_right;
+	unsigned int remainder;
+
+	/* For forwards propagation - simply pass on our output. */
+	if (forwards) {
+		*window = partition->uds_source;
+		return;
+	}
 
 	/* Initialise the partition state. */
 	partition->uds_sink = *window;
@@ -389,11 +413,90 @@ static void uds_partition(struct vsp1_entity *entity,
 	output = vsp1_entity_get_pad_format(&uds->entity, uds->entity.config,
 					    UDS_PAD_SOURCE);
 
-	partition->uds_sink.width = window->width * input->width
-				  / output->width;
-	partition->uds_sink.left = window->left * input->width
-				 / output->width;
+	/*
+	 * Quantify the margin required for discontinuous overlap, and expand
+	 * the window no further than the limits of the image.
+	 */
+	hscale = uds_compute_ratio(input->width, output->width);
+	margin = hscale < 0x200 ? 32 : /* 8 <  scale */
+		 hscale < 0x400 ? 16 : /* 4 <  scale <= 8 */
+		 hscale < 0x800 ?  8 : /* 2 <  scale <= 4 */
+				   4;  /*      scale <= 2 */
+
+	dst_left = max_t(int, 0, window->left - margin);
+	dst_right = min_t(int, output->width - 1,
+			  window->left + window->width - 1 + margin);
+
+	/*
+	 * Identify the sink positions which represent the required output
+	 * positions. This is done in two parts, first converting destination
+	 * to input positions, but then converting back to destination to
+	 * account for any rounding requirements. Once adjusted, the final
+	 * source positions are determined.
+	 */
+
+	mp = uds_multiplier(hscale);
+
+	/* Step 1: Calculate temporary src_left (src_pos0) position. */
+	/* Step 2: Calculate temporary dst_left (dst_pos0_pb) position. */
+	if (partition_idx == 0) {
+		src_left = 0;
+		dst_left = 0;
+	} else {
+		unsigned int sub_src = mp == 1 ? 1 : 2;
+
+		src_left = ((dst_left * hscale) / (4096 * mp) - sub_src) * mp;
+		dst_left = src_left * 4096 / hscale;
+	}
+
+	/*
+	 * Step 3: Determine dst_left (dst_pos0_pb) from temporary dst_left.
+	 *
+	 * The output must be aligned to a multiple of the pre-filter
+	 * multiplier.
+	 */
+	remainder = (dst_left * hscale) % mp;
+	if (remainder)
+		/* Remainder can only be two when mp == 4. */
+		dst_left = round_down(dst_left, hscale % mp == 2 ? 2 : mp);
+
+	/* Step 4: Recalculate src_left from newly adjusted dst_left. */
+	src_left = DIV_ROUND_UP(dst_left * hscale, 4096 * mp) * mp;
+
+	/* Step 5: Calculate src_right (src_pos1). */
+	if (partition_idx == pipe->partitions - 1)
+		src_right = input->width - 1;
+	else
+		src_right = (((dst_right * hscale) / (mp * 4096)) + 2)
+			  * mp + (mp / 2);
+
+	/* Step 6: Calculate start phase (hstp). */
+	remainder = (src_left * hscale) % (mp * 4096);
+	partition->start_phase = remainder ? (4096 - remainder / mp) : 0;
+
+	/*
+	 * Step 7: Calculate end phase (hedp).
+	 *
+	 * We do not currently use VI6_UDS_CTRL_AMD from VI6_UDS_CTRL.
+	 * In the event that we enable VI6_UDS_CTRL_AMD, we must set the end
+	 * phase for the final partition to the phase_edge.
+	 */
+	partition->end_phase = 0;
+
+	/*
+	 * Fill in our partition windows with the updated positions, and
+	 * configure our output offset to allow extraneous pixels to be
+	 * clipped by later entities.
+	 */
+	partition->uds_sink.left = src_left;
+	partition->uds_sink.width = src_right - src_left + 1;
+
+	partition->uds_source.left = dst_left;
+	partition->uds_source.width = dst_right - dst_left + 1;
+
+	partition->uds_source.offset = window->left - dst_left;
 
+	/* Pass a copy of our sink down to the previous entity. */
 	*window = partition->uds_sink;
 }
 
diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index d1ecc3d91290..3638a4e9bb19 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -221,6 +221,7 @@ static void vsp1_video_calculate_partition(struct vsp1_pipeline *pipe,
 	/* Initialise the partition with sane starting conditions. */
 	window.left = index * div_size;
 	window.width = div_size;
+	window.offset = 0;
 
 	modulus = format->width % div_size;
 
diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
index 9e8dbf99878b..2e8cc4195c31 100644
--- a/drivers/media/platform/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/vsp1/vsp1_wpf.c
@@ -371,16 +371,19 @@ static void wpf_configure_partition(struct vsp1_entity *entity,
 						 RWPF_PAD_SINK);
 	width = sink_format->width;
 	height = sink_format->height;
+	offset = 0;
 
 	/*
 	 * Cropping. The partition algorithm can split the image into
 	 * multiple slices.
 	 */
-	if (vsp1_pipeline_partitioned(pipe))
+	if (vsp1_pipeline_partitioned(pipe)) {
 		width = pipe->partition->wpf.width;
+		offset = pipe->partition->wpf.offset;
+	}
 
 	vsp1_wpf_write(wpf, dlb, VI6_WPF_HSZCLIP, VI6_WPF_SZCLIP_EN |
-		       (0 << VI6_WPF_SZCLIP_OFST_SHIFT) |
+		       (offset << VI6_WPF_SZCLIP_OFST_SHIFT) |
 		       (width << VI6_WPF_SZCLIP_SIZE_SHIFT));
 	vsp1_wpf_write(wpf, dlb, VI6_WPF_VSZCLIP, VI6_WPF_SZCLIP_EN |
 		       (0 << VI6_WPF_SZCLIP_OFST_SHIFT) |
@@ -491,8 +494,15 @@ static void wpf_partition(struct vsp1_entity *entity,
 			  struct vsp1_pipeline *pipe,
 			  struct vsp1_partition *partition,
 			  unsigned int partition_idx,
-			  struct vsp1_partition_window *window)
+			  struct vsp1_partition_window *window,
+			  bool forwards)
 {
+	if (forwards) {
+		/* Only handle incoming cropping requirements. */
+		partition->wpf.offset = window->offset;
+		return;
+	}
+
 	partition->wpf = *window;
 }
 
-- 
2.19.1

