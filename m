Return-Path: <SRS0=54rz=5Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B406EC2BA2B
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E59820753
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 12:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Le1xWe34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgDHMLw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:11:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59532 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDHMLv (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 8 Apr 2020 08:11:51 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1631522;
        Wed,  8 Apr 2020 14:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586347911;
        bh=fNEHkv4xWj5my99Zm2nOYGlrKzbKQK6rzkcnqArw/pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Le1xWe346japdrekjXGwc3WU9B8DnCFkULxYUXAE2JxZv+vKXcglsE3x22+nk97MT
         QlYhC/ZjWGSFkbSkiPEH1LLMLQOXYHFmyQK4BP7OcF7Y4iQbMpHbHBhg7ebJnCgZqK
         dd4HyG6pNwkoIZdkm1REfd/67kMPiOKsAZbQC6Xg=
Date:   Wed, 8 Apr 2020 15:11:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-media@vger.kernel.org, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org
Subject: Re: [PATCH v3 5/6] media: staging: rkisp1: cap: support uv swapped
 plane formats
Message-ID: <20200408121141.GG4881@pendragon.ideasonboard.com>
References: <20200408114822.27360-1-dafna.hirschfeld@collabora.com>
 <20200408114822.27360-6-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408114822.27360-6-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Apr 08, 2020 at 01:48:21PM +0200, Dafna Hirschfeld wrote:
> Plane formats with the u and v planes swapped can be

s/Plane/Planar/

> supported by swapping the address of the cb and cr buffers.
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  drivers/staging/media/rkisp1/rkisp1-capture.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/media/rkisp1/rkisp1-capture.c b/drivers/staging/media/rkisp1/rkisp1-capture.c
> index 257799a7d865..9f0a3c407286 100644
> --- a/drivers/staging/media/rkisp1/rkisp1-capture.c
> +++ b/drivers/staging/media/rkisp1/rkisp1-capture.c
> @@ -743,6 +743,14 @@ static void rkisp1_vb2_buf_queue(struct vb2_buffer *vb)
>  			rkisp1_pixfmt_comp_size(pixm, RKISP1_PLANE_CB);
>  	}
>  
> +	/*
> +	 * uv swap can be supported for plane formats by switching

s/plane/planar/

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	 * the address of cb and cr
> +	 */
> +	if (cap->pix.info->comp_planes == 3 && cap->pix.cfg->uv_swap)
> +		swap(ispbuf->buff_addr[RKISP1_PLANE_CR],
> +		     ispbuf->buff_addr[RKISP1_PLANE_CB]);
> +
>  	spin_lock_irqsave(&cap->buf.lock, flags);
>  
>  	/*

-- 
Regards,

Laurent Pinchart
