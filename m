Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455AEC43460
	for <linux-media@archiver.kernel.org>; Thu, 29 Apr 2021 02:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EFF61450
	for <linux-media@archiver.kernel.org>; Thu, 29 Apr 2021 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhD2CTv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Apr 2021 22:19:51 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41684 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhD2CTu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Apr 2021 22:19:50 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4B71CBC0;
        Thu, 29 Apr 2021 04:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1619662743;
        bh=eb3lCyau21ZSTPrWGEfecS+nTNYs4kg1lproyJwJ4L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aw2gxC/EsqreW2ofZfXExLHOCsyfWnK+1kPdYxJSyPp+Z0AZwEbnM8zPD2r74inE0
         G/MdZ4GCHsAHRBe0lG69fU0+xO8O/y3vTWOfa/wQY13JAMjmtcmX3YUMbQ84penP47
         gupCyVYefMIn2bL5Uj0KFZtngMyoKUyI5/8U7/lE=
Date:   Thu, 29 Apr 2021 05:18:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v6 12/24] media: entity: Add an iterator helper for
 connected pads
Message-ID: <YIoXkYXC+yN7tM1P@pendragon.ideasonboard.com>
References: <20210427124523.990938-1-tomi.valkeinen@ideasonboard.com>
 <20210427124523.990938-13-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210427124523.990938-13-tomi.valkeinen@ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Tue, Apr 27, 2021 at 03:45:11PM +0300, Tomi Valkeinen wrote:
> Add a helper macro for iterating over pads that are connected through
> enabled routes. This can be used to find all the connected pads within an
> entity, for instance starting from the pad which has been obtained during
> the graph walk.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> - Make __media_entity_next_routed_pad() return NULL and adjust the
>   iterator to handle that
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  include/media/media-entity.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> index f8fa952fa38e..42193d6c58e9 100644
> --- a/include/media/media-entity.h
> +++ b/include/media/media-entity.h
> @@ -916,6 +916,34 @@ __must_check int media_graph_walk_init(
>  bool media_entity_has_route(struct media_entity *entity, unsigned int pad0,
>  			    unsigned int pad1);
>  
> +static inline struct media_pad *__media_entity_next_routed_pad(
> +	struct media_pad *start, struct media_pad *iter)
> +{
> +	struct media_entity *entity = start->entity;
> +
> +	for (; iter < &entity->pads[entity->num_pads]; iter++) {
> +		if (media_entity_has_route(entity, start->index, iter->index))
> +			return iter;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * media_entity_for_each_routed_pad - Iterate over entity pads connected by routes
> + *
> + * @start: The starting pad
> + * @iter: The iterator pad
> + *
> + * Iterate over all pads connected through routes from the @start pad
> + * within an entity. The iteration will include the @start pad itself.
> + */

I still think a better name would be, well, better :-) Let's continue
the discussion in the v5 thread to avoid splitting it.

> +#define media_entity_for_each_routed_pad(start, iter)			\
> +	for (iter = __media_entity_next_routed_pad(			\
> +		     start, (start)->entity->pads);			\
> +	     iter != NULL;						\
> +	     iter = __media_entity_next_routed_pad(start, iter + 1))
> +
>  /**
>   * media_graph_walk_cleanup - Release resources used by graph walk.
>   *

-- 
Regards,

Laurent Pinchart
