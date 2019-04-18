Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D81FC282DF
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 12:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D842183E
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LXOeYkU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbfDRMnG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:43:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34812 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRMnG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 08:43:06 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 416AC333;
        Thu, 18 Apr 2019 14:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555591380;
        bh=C3svm1CYtLTrb0ycrWAFg2VzHKvQhoUaXEtz0wJibDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXOeYkU+9WITJtQyvA4Ap1JR3T1i/00is/44t/jw4oGV/EoidQPJwUTn5jh3P67lI
         3g0hxMJubmlVte9LGtQ+2UZDV+3zX+0/IIC8T+dIBFtLuVWQLcCymz8/rupPzGxSgA
         1oXNy5vz0GC9KSKhCV2vn9R4IsVCHtf8hApfIRSA=
Date:   Thu, 18 Apr 2019 15:42:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 5/5] media: vsp1: Provide partition overlap algorithm
Message-ID: <20190418124251.GL4806@pendragon.ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
 <20190411161256.19607-6-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411161256.19607-6-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thu, Apr 11, 2019 at 05:12:56PM +0100, Kieran Bingham wrote:
> To improve image quality, entities involved within the image partition
> algorithm may extend their partition window to account for their input
> requirements and to take consideration of the number of taps in their
> filters.
> 
> Extend the partition algorithm to sweep first backwards, then forwards
> through the entity list. Each entity is given the opportunity to expand
> it's window on the reverse sweep, and clip or increase the offset on the

s/it's/its/

> forwards sweep.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> ---
> v2:
>  - Configure HSTP and HEDP in uds_configure_partition for single partitions
>  - refactored to use individual functions for various phase and position calculations
>  - squashed forwards and backwards propagation work to a single patch
>  - Fixed a few 'off-by-ones'
>  - considerable other changes :)
> 
> v3a:
>  - SRU comments updated
>  - phase function parameter documentation updated
>  - s/uds_left_src_pixel/uds_left_sink_pixel/
>  - s/uds_right_src_pixel/uds_right_sink_pixel/
> 
> v3b:
>  - A full rework to the UDS overlap and phase calculations
>  - Collapse split calculations into the single uds_partition() function
>  - Document UDS calculations following procedure steps as per datasheet
> ---
>  drivers/media/platform/vsp1/vsp1_entity.h |   2 +-
>  drivers/media/platform/vsp1/vsp1_pipe.c   |  40 +++++++-
>  drivers/media/platform/vsp1/vsp1_pipe.h   |   6 ++
>  drivers/media/platform/vsp1/vsp1_rpf.c    |   8 +-
>  drivers/media/platform/vsp1/vsp1_sru.c    |  38 ++++++-
>  drivers/media/platform/vsp1/vsp1_uds.c    | 115 ++++++++++++++++++++--
>  drivers/media/platform/vsp1/vsp1_video.c  |   1 +
>  drivers/media/platform/vsp1/vsp1_wpf.c    |  16 ++-
>  8 files changed, 207 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_entity.h b/drivers/media/platform/vsp1/vsp1_entity.h
> index 97acb7795cf1..772492877764 100644
> --- a/drivers/media/platform/vsp1/vsp1_entity.h
> +++ b/drivers/media/platform/vsp1/vsp1_entity.h
> @@ -88,7 +88,7 @@ struct vsp1_entity_operations {
>  	unsigned int (*max_width)(struct vsp1_entity *, struct vsp1_pipeline *);
>  	void (*partition)(struct vsp1_entity *, struct vsp1_pipeline *,
>  			  struct vsp1_partition *, unsigned int,
> -			  struct vsp1_partition_window *);
> +			  struct vsp1_partition_window *, bool);
>  };
>  
>  struct vsp1_entity {
> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
> index f1bd21a01bcd..137ebe0ecad2 100644
> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> @@ -375,10 +375,32 @@ bool vsp1_pipeline_partitioned(struct vsp1_pipeline *pipe)
>  /*
>   * Propagate the partition calculations through the pipeline
>   *
> - * Work backwards through the pipe, allowing each entity to update the partition
> - * parameters based on its configuration, and the entity connected to its
> - * source. Each entity must produce the partition required for the previous
> - * entity in the pipeline.
> + * Work backwards through the pipe, allowing each entity to update the
> + * partition parameters based on its configuration. Each entity must produce
> + * the partition window required for the previous entity in the pipeline
> + * to generate. This window can be passed through if no changes are necessary.

I find this a bit unclear. I know how the hardware works and can thus
understand what you meant, but for someone with less knowledge of the
device (such as you or me in 6 months :-)) a clearer description would
be good. In particular explaining what happens at the edge of partitions
and why the window needs to be extended would be useful. This should
also document the .partition() operation and the arguments it takes, in
particular what the window refers to (if I remember it stores the
requested window for the output of the entity and returns the required
window for the input, but that should be written explicitly).

The second to last sentence is also quite confusing. "Each entity must
produce" reads like you're talking about the pixels produced by the
entity, while I think you mean the window computed by the .partition()
operation. Maybe something along the line of "Each entity reports the
window it requires at its input to generate the requested output, and
that window is propagated backward along the pipeline from entity to
entity." ?

Explaining the vsp1_partition_window offset field in more details would
be useful too. I initially commented about it below, but I think the
detailed description belongs here, where the comment should state that
the entities in the pipeline will generate incorrect pixels at the edges
due to the use of pixel duplication on the sink, and that those invalid
pixels must be clipped out. We thus start with a clipping offset equal
to zero, and propagate it forward through the pipeline asking each
entity how many invalid pixels it generates on the left side. You should
also explain that we only clip pixels out on the left side as partitions
are processed in the left to right order, so invalid pixels on the right
side will be overwritten by good pixels from the next partition. By the
way, does this hold true when rotating ?

I trust your English skills more than mine to create a coherent text
from all this :-)

> + *
> + * Entities are processed in reverse order:
> + *	DDDD = Destination pixels
> + *	SSSS = Source pixels
> + *	==== = Intermediate pixels
> + *	____ = Disposable pixels
> + *
> + * WPF			    |DDDD|	WPF determines it's required partition

s/it's/its/

"required partition" is also a bit unclear.

> + * SRU			    |====|	Interconnected entities pass through

SRU is a bad example as it takes part in the partition size calculation.

> + * UDS(source)		   |<====>|	UDS Source requests overlap

Same here, "overlap" isn't defined anywhere. It may get clearer once the
documentation above is expanded though.

> + * UDS(sink)		|<-|======|->|	UDS Sink calculates input size
> + * RPF			|__SSSSSSSS__|	RPF provides extra pixels

"Disposable pixels" is also unclear. Those pixels are not disposable,
they are required to compute the destination pixels correctly, but they
don't generate corresponding pixels in the destination for this
partition.

> + *
> + * Then work forwards through the pipe allowing entities to communicate any
> + * clipping required based on any overlap and expansions they may have
> + * generated.
> + *
> + * RPF			|__SSSSSSSS__|	Partition window is propagated forwards
> + * UDS(sink)		|============|
> + * UDS(source)		   |<====>|	UDS Source reports overlap
> + * SRU			   |======|	Interconnected entities are updated
> + * WPF			   |_DDDD_|	WPF handles clipping

It's not clear how this differs from the backward pass :-)

Let's try to come up with a clear and detailed description, it will be
useful for the future. I know documentation is hard, but it's worth it.

>   */
>  void vsp1_pipeline_propagate_partition(struct vsp1_pipeline *pipe,
>  				       struct vsp1_partition *partition,
> @@ -387,10 +409,18 @@ void vsp1_pipeline_propagate_partition(struct vsp1_pipeline *pipe,
>  {
>  	struct vsp1_entity *entity;
>  
> +	/* Move backwards through the pipeline to propagate any expansion. */
>  	list_for_each_entry_reverse(entity, &pipe->entities, list_pipe) {
>  		if (entity->ops->partition)
>  			entity->ops->partition(entity, pipe, partition, index,
> -					       window);
> +					       window, false);
> +	}
> +
> +	/* Move forwards through the pipeline and propagate any updates. */
> +	list_for_each_entry(entity, &pipe->entities, list_pipe) {
> +		if (entity->ops->partition)
> +			entity->ops->partition(entity, pipe, partition, index,
> +					       window, true);
>  	}
>  }
>  
> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.h b/drivers/media/platform/vsp1/vsp1_pipe.h
> index dd8b2cdc6452..3e263a60f79b 100644
> --- a/drivers/media/platform/vsp1/vsp1_pipe.h
> +++ b/drivers/media/platform/vsp1/vsp1_pipe.h
> @@ -58,10 +58,12 @@ enum vsp1_pipeline_state {
>   * @left: horizontal coordinate of the partition start in pixels relative to the
>   *	  left edge of the image
>   * @width: partition width in pixels
> + * @offset: The number of pixels from the left edge of the window to clip
>   */
>  struct vsp1_partition_window {
>  	unsigned int left;
>  	unsigned int width;
> +	unsigned int offset;
>  };
>  
>  /*
> @@ -71,6 +73,8 @@ struct vsp1_partition_window {
>   * @uds_source: The UDS output partition window configuration
>   * @sru: The SRU partition window configuration
>   * @wpf: The WPF partition window configuration
> + * @start_phase: The UDS start phase for this partition
> + * @end_phase: The UDS end phase for this partition
>   */
>  struct vsp1_partition {
>  	struct vsp1_partition_window rpf;
> @@ -78,6 +82,8 @@ struct vsp1_partition {
>  	struct vsp1_partition_window uds_source;
>  	struct vsp1_partition_window sru;
>  	struct vsp1_partition_window wpf;
> +	unsigned int start_phase;
> +	unsigned int end_phase;
>  };
>  
>  /*
> diff --git a/drivers/media/platform/vsp1/vsp1_rpf.c b/drivers/media/platform/vsp1/vsp1_rpf.c
> index ef9bf5dd55a0..46d270644fe2 100644
> --- a/drivers/media/platform/vsp1/vsp1_rpf.c
> +++ b/drivers/media/platform/vsp1/vsp1_rpf.c
> @@ -324,9 +324,13 @@ static void rpf_partition(struct vsp1_entity *entity,
>  			  struct vsp1_pipeline *pipe,
>  			  struct vsp1_partition *partition,
>  			  unsigned int partition_idx,
> -			  struct vsp1_partition_window *window)
> +			  struct vsp1_partition_window *window,
> +			  bool forwards)
>  {
> -	partition->rpf = *window;
> +	if (forwards)
> +		*window = partition->rpf;
> +	else
> +		partition->rpf = *window;
>  }
>  
>  static const struct vsp1_entity_operations rpf_entity_ops = {
> diff --git a/drivers/media/platform/vsp1/vsp1_sru.c b/drivers/media/platform/vsp1/vsp1_sru.c
> index b1617cb1f2b9..5e6be0bbcf36 100644
> --- a/drivers/media/platform/vsp1/vsp1_sru.c
> +++ b/drivers/media/platform/vsp1/vsp1_sru.c
> @@ -327,24 +327,58 @@ static void sru_partition(struct vsp1_entity *entity,
>  			  struct vsp1_pipeline *pipe,
>  			  struct vsp1_partition *partition,
>  			  unsigned int partition_idx,
> -			  struct vsp1_partition_window *window)
> +			  struct vsp1_partition_window *window,
> +			  bool forwards)
>  {
>  	struct vsp1_sru *sru = to_sru(&entity->subdev);
>  	struct v4l2_mbus_framefmt *input;
>  	struct v4l2_mbus_framefmt *output;
> +	int scale_up;

I would either declare this as a bool, or an unsigned int scale_factor
equal to 1 or 2, in which case you could replace *= 2 and /= 2 with *=
scale_factor and /= scale_factor. 

>  
>  	input = vsp1_entity_get_pad_format(&sru->entity, sru->entity.config,
>  					   SRU_PAD_SINK);
>  	output = vsp1_entity_get_pad_format(&sru->entity, sru->entity.config,
>  					    SRU_PAD_SOURCE);
>  
> +	scale_up = (input->width != output->width);
> +
> +	if (forwards) {
> +		/* Propagate the clipping offsets forwards. */
> +		window->offset += partition->sru.offset;

You could write this

		if (window->left != 0)
			window->offset++;

and drop vsp1_partition::sru that is used solely to store the offset.

> +
> +		if (scale_up)
> +			window->offset *= 2;
> +
> +		return;
> +	}
> +

Let's add an overall explanation.

	/*
	 * The SRU has a 3-tap pre-filter that generates the same number of
	 * pixels as it consumes. Edge output pixels are computed using edge
	 * pixel duplication at the input. This results in one incorrect output
	 * pixel on each side of the partition window after the pre-filter. To
	 * compensate for this, require one additional input pixel on each side
	 * before the pre-filter (thus before scaling).
	 *
	 * Additionally, the 2x up-scaler uses a bilinear post-filter and
	 * generates odd pixels from their two neighbours. The rightmost output
	 * pixel is thus computed using edge pixel duplication on the right side
	 * of the input (the leftmost output pixel is an even pixel, aligned
	 * with the leftmost input pixel and thus depends only on the
	 * corresponding pixel after the pre-filter). To compensate for this,
	 * require one additional input pixel on the right side when up-scaling.
	 */

>  	/* Adapt if SRUx2 is enabled. */
> -	if (input->width != output->width) {
> +	if (scale_up) {
> +		/* Clipping offsets are not back-propagated. */
>  		window->width /= 2;
>  		window->left /= 2;
> +
> +		/* SRUx2 requires an extra pixel at the right edge. */
> +		window->width++;
>  	}
>  
> +	/*
> +	 * The partition->sru represents the SRU sink pad configuration.

This should be documented in the vsp1_partition structure, not here (or
not only here). Are all windows in the vsp1_partition structure related
to the sink pad of the corresponding entity ? If so, let's document is
globally (and I hope so, otherwise it would be quite confusing). 

> +	 * However, the SRU is a passive component in the partition algorithm.

What does this mean ?

> +	 */
>  	partition->sru = *window;
> +
> +	/* Expand to the left edge. */
> +	if (window->left != 0) {
> +		window->left--;
> +		window->width++;
> +		partition->sru.offset = 1;
> +	} else {
> +		partition->sru.offset = 0;
> +	}
> +
> +	/* Expand to the right edge. */
> +	window->width++;

Does this also need to be conditioned to avoid an overlofw on the right
side ? Same question for the width++ inside the if (scale_up) above. I
wonder if it wouldn't be easier to remove all these conditions, turn the
window->left field into a signed int, and after the backward pass clamp
it to 0 (adjusting the offset field accordingly) and clamp the width to
the right side of the image. The logic in the entities would be simpler.

>  }
>  
>  static const struct vsp1_entity_operations sru_entity_ops = {
> diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
> index c71c24363d54..33c582aca5a5 100644
> --- a/drivers/media/platform/vsp1/vsp1_uds.c
> +++ b/drivers/media/platform/vsp1/vsp1_uds.c
> @@ -270,6 +270,7 @@ static void uds_configure_stream(struct vsp1_entity *entity,
>  	const struct v4l2_mbus_framefmt *input;
>  	unsigned int hscale;
>  	unsigned int vscale;
> +	bool manual_phase = vsp1_pipeline_partitioned(pipe);
>  	bool multitap;
>  
>  	input = vsp1_entity_get_pad_format(&uds->entity, uds->entity.config,
> @@ -294,7 +295,8 @@ static void uds_configure_stream(struct vsp1_entity *entity,
>  
>  	vsp1_uds_write(uds, dlb, VI6_UDS_CTRL,
>  		       (uds->scale_alpha ? VI6_UDS_CTRL_AON : 0) |
> -		       (multitap ? VI6_UDS_CTRL_BC : 0));
> +		       (multitap ? VI6_UDS_CTRL_BC : 0) |
> +		       (manual_phase ? VI6_UDS_CTRL_AMDSLH : 0));
>  
>  	vsp1_uds_write(uds, dlb, VI6_UDS_PASS_BWIDTH,
>  		       (uds_passband_width(hscale)
> @@ -332,6 +334,12 @@ static void uds_configure_partition(struct vsp1_entity *entity,
>  				<< VI6_UDS_CLIP_SIZE_HSIZE_SHIFT) |
>  		       (output->height
>  				<< VI6_UDS_CLIP_SIZE_VSIZE_SHIFT));
> +
> +	vsp1_uds_write(uds, dlb, VI6_UDS_HPHASE,
> +		       (partition->start_phase
> +				<< VI6_UDS_HPHASE_HSTP_SHIFT) |
> +		       (partition->end_phase
> +				<< VI6_UDS_HPHASE_HEDP_SHIFT));
>  }
>  
>  static unsigned int uds_max_width(struct vsp1_entity *entity,
> @@ -374,11 +382,27 @@ static void uds_partition(struct vsp1_entity *entity,
>  			  struct vsp1_pipeline *pipe,
>  			  struct vsp1_partition *partition,
>  			  unsigned int partition_idx,
> -			  struct vsp1_partition_window *window)
> +			  struct vsp1_partition_window *window,
> +			  bool forwards)
>  {
>  	struct vsp1_uds *uds = to_uds(&entity->subdev);
>  	const struct v4l2_mbus_framefmt *output;
>  	const struct v4l2_mbus_framefmt *input;
> +	unsigned int hscale;
> +	unsigned int margin;
> +

No need for a blank line.

> +	unsigned int mp;
> +	unsigned int src_left;
> +	unsigned int src_right;
> +	unsigned int dst_left;
> +	unsigned int dst_right;
> +	unsigned int remainder;
> +
> +	/* For forwards propagation - simply pass on our output. */

I'd say "simply pass on the output we computed in the backward pass.".

This means we can't support UDS after SRU. I recall you wanted to
experiment with this, should we already prepare by adding the offset
here ? Or would it require more intrusive changes that makes preparation
not worth it ? In the latter case I'd expand the comment to explain that
the offset is copied as-is because the driver ensures the SRU never
comes before the UDS.

> +	if (forwards) {
> +		*window = partition->uds_source;
> +		return;
> +	}
>  
>  	/* Initialise the partition state. */
>  	partition->uds_sink = *window;
> 	partition->uds_source = *window;

This isn't needed anymore.

> 
> 	input = vsp1_entity_get_pad_format(&uds->entity, uds->entity.config,
> 					   UDS_PAD_SINK);
>  	output = vsp1_entity_get_pad_format(&uds->entity, uds->entity.config,
>  					    UDS_PAD_SOURCE);
>  
> -	partition->uds_sink.width = window->width * input->width
> -				  / output->width;
> -	partition->uds_sink.left = window->left * input->width
> -				 / output->width;
> +	/*
> +	 * Quantify the margin required for discontinuous overlap, and expand
> +	 * the window no further than the limits of the image.
> +	 */
> +	hscale = uds_compute_ratio(input->width, output->width);
> +	margin = hscale < 0x200 ? 32 : /* 8 <  scale */
> +		 hscale < 0x400 ? 16 : /* 4 <  scale <= 8 */
> +		 hscale < 0x800 ?  8 : /* 2 <  scale <= 4 */
> +				   4;  /*      scale <= 2 */

Where does this come from ? I thought that the steps 1 to 7 below would
take care of computing the margin ?

> +
> +	dst_left = max_t(int, 0, window->left - margin);
> +	dst_right = min_t(int, output->width - 1,
> +			  window->left + window->width - 1 + margin);
> +
> +	/*
> +	 * Identify the sink positions which represent the required output

s/output/source/ or s/sink/input/
s/which/that/ ?

> +	 * positions. This is done in two parts, first converting destination
> +	 * to input positions, but then converting back to destination to

s/destination/output/ or s/input/source/. Source would be ambiguous here
as it means output in sink/source, and input in source/destination.

> +	 * account for any rounding requirements. Once adjusted, the final
> +	 * source positions are determined.

Which source is this one, the input or the output ? :-)

> +	 */
> +
> +	mp = uds_multiplier(hscale);
> +
> +	/* Step 1: Calculate temporary src_left (src_pos0) position. */
> +	/* Step 2: Calculate temporary dst_left (dst_pos0_pb) position. */
> +	if (partition_idx == 0) {
> +		src_left = 0;
> +		dst_left = 0;

Would this get simplified if we handled the left and right clamp in
vsp1_pipeline_propagate_partition() as proposed above ? The first
partition would end up being slightly smaller though, maybe it's not the
best idea. For the last partition I think it would be less of an issue.

> +	} else {
> +		unsigned int sub_src = mp == 1 ? 1 : 2;
> +
> +		src_left = ((dst_left * hscale) / (4096 * mp) - sub_src) * mp;
> +		dst_left = src_left * 4096 / hscale;
> +	}
> +
> +	/*
> +	 * Step 3: Determine dst_left (dst_pos0_pb) from temporary dst_left.
> +	 *
> +	 * The output must be aligned to a multiple of the pre-filter
> +	 * multiplier.

"Step 3: Pull back dst_left (dst_pos0_pb) to the left to satisfy
alignment restrictions (the input of the bi-cubic filter must be aligned
to a multiple of the pre-filter multiplier)."

It would also be useful to add an explanation of the UDS operation,
similar to the one I wrote above for the SRU, that explains the
pre-filter and the bicubic filter (see figure 32.38).

> +	 */
> +	remainder = (dst_left * hscale) % mp;
> +	if (remainder)
> +		/* Remainder can only be two when mp == 4. */
> +		dst_left = round_down(dst_left, hscale % mp == 2 ? 2 : mp);
> +
> +	/* Step 4: Recalculate src_left from newly adjusted dst_left. */
> +	src_left = DIV_ROUND_UP(dst_left * hscale, 4096 * mp) * mp;
> +
> +	/* Step 5: Calculate src_right (src_pos1). */
> +	if (partition_idx == pipe->partitions - 1)
> +		src_right = input->width - 1;
> +	else
> +		src_right = (((dst_right * hscale) / (mp * 4096)) + 2)
> +			  * mp + (mp / 2);
> +
> +	/* Step 6: Calculate start phase (hstp). */
> +	remainder = (src_left * hscale) % (mp * 4096);
> +	partition->start_phase = remainder ? (4096 - remainder / mp) : 0;

This could also be written

	partition->start_phase = (4096 - remainder / mp) & 4095;

or

	partition->start_phase = (4096 - remainder / mp) % 4096;

Up to you.

> +
> +	/*
> +	 * Step 7: Calculate end phase (hedp).
> +	 *
> +	 * We do not currently use VI6_UDS_CTRL_AMD from VI6_UDS_CTRL.
> +	 * In the event that we enable VI6_UDS_CTRL_AMD, we must set the end
> +	 * phase for the final partition to the phase_edge.
> +	 */
> +	partition->end_phase = 0;
> +
> +	/*
> +	 * Fill in our partition windows with the updated positions, and
> +	 * configure our output offset to allow extraneous pixels to be
> +	 * clipped by later entities.
> +	 */
> +	partition->uds_sink.left = src_left;
> +	partition->uds_sink.width = src_right - src_left + 1;
> +
> +	partition->uds_source.left = dst_left;
> +	partition->uds_source.width = dst_right - dst_left + 1;
> +
> +	partition->uds_source.offset = window->left - dst_left;
>  
> +	/* Pass a copy of our sink down to the previous entity. */
>  	*window = partition->uds_sink;
>  }
>  
> diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
> index d1ecc3d91290..3638a4e9bb19 100644
> --- a/drivers/media/platform/vsp1/vsp1_video.c
> +++ b/drivers/media/platform/vsp1/vsp1_video.c
> @@ -221,6 +221,7 @@ static void vsp1_video_calculate_partition(struct vsp1_pipeline *pipe,
>  	/* Initialise the partition with sane starting conditions. */
>  	window.left = index * div_size;
>  	window.width = div_size;
> +	window.offset = 0;
>  
>  	modulus = format->width % div_size;
>  
> diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
> index 9e8dbf99878b..2e8cc4195c31 100644
> --- a/drivers/media/platform/vsp1/vsp1_wpf.c
> +++ b/drivers/media/platform/vsp1/vsp1_wpf.c
> @@ -371,16 +371,19 @@ static void wpf_configure_partition(struct vsp1_entity *entity,
>  						 RWPF_PAD_SINK);
>  	width = sink_format->width;
>  	height = sink_format->height;
> +	offset = 0;
>  
>  	/*
>  	 * Cropping. The partition algorithm can split the image into
>  	 * multiple slices.
>  	 */
> -	if (vsp1_pipeline_partitioned(pipe))
> +	if (vsp1_pipeline_partitioned(pipe)) {
>  		width = pipe->partition->wpf.width;
> +		offset = pipe->partition->wpf.offset;
> +	}
>  
>  	vsp1_wpf_write(wpf, dlb, VI6_WPF_HSZCLIP, VI6_WPF_SZCLIP_EN |
> -		       (0 << VI6_WPF_SZCLIP_OFST_SHIFT) |
> +		       (offset << VI6_WPF_SZCLIP_OFST_SHIFT) |
>  		       (width << VI6_WPF_SZCLIP_SIZE_SHIFT));
>  	vsp1_wpf_write(wpf, dlb, VI6_WPF_VSZCLIP, VI6_WPF_SZCLIP_EN |
>  		       (0 << VI6_WPF_SZCLIP_OFST_SHIFT) |
> @@ -491,8 +494,15 @@ static void wpf_partition(struct vsp1_entity *entity,
>  			  struct vsp1_pipeline *pipe,
>  			  struct vsp1_partition *partition,
>  			  unsigned int partition_idx,
> -			  struct vsp1_partition_window *window)
> +			  struct vsp1_partition_window *window,
> +			  bool forwards)
>  {
> +	if (forwards) {
> +		/* Only handle incoming cropping requirements. */
> +		partition->wpf.offset = window->offset;
> +		return;
> +	}
> +
>  	partition->wpf = *window;
>  }
>  

-- 
Regards,

Laurent Pinchart
