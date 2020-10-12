Return-Path: <SRS0=qt09=DT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2A9C433DF
	for <linux-media@archiver.kernel.org>; Mon, 12 Oct 2020 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA74620878
	for <linux-media@archiver.kernel.org>; Mon, 12 Oct 2020 18:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aL9cr3Vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgJLSdX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:33:23 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46270 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgJLSdX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Oct 2020 14:33:23 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A9B7EA42;
        Mon, 12 Oct 2020 20:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1602527600;
        bh=GuA3IROdEImERkc2urJPmwvU3sz4mhpuoSJLvg6M6So=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aL9cr3Vu+8YzjYQOFqeGIuy3Eh7GeMdUDNT+m/VVhgdTRK7H1fgfazQ3vZI9GxZME
         4n1CY6+dtd/Ixy8PrgOI3fGnUq+PZ55GmBzrRoqw37BGpzdf7wcs68dPoPeIQ92/4s
         aWr8WHDt36y9XA4bqkhlcT0RNsTbHRhc/YsAVFCQ=
Date:   Mon, 12 Oct 2020 21:32:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        bingbu.cao@intel.com, Yong Zhi <yong.zhi@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: Re: [PATCH v3 7/8] ipu3-cio2: Rename CIO2_IMAGE_MAX_LENGTH as
 CIO2_IMAGE_MAX_HEIGHT
Message-ID: <20201012183235.GA740@pendragon.ideasonboard.com>
References: <20201012180414.11579-1-sakari.ailus@linux.intel.com>
 <20201012180414.11579-8-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012180414.11579-8-sakari.ailus@linux.intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sakari,

Thank you for the patch.

On Mon, Oct 12, 2020 at 09:04:13PM +0300, Sakari Ailus wrote:
> CIO2_IMAGE_MAX_LENGTH is the maximum width of the image. Rename it as

I assume you mean maximum height :-) With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> "CIO2_IMAGE_MAX_HEIGHT" in order to better describe what it is.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c | 6 +++---
>  drivers/media/pci/intel/ipu3/ipu3-cio2.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> index e42177f8c426..d9baa8bfe54f 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> @@ -1094,8 +1094,8 @@ static int cio2_v4l2_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
>  	/* Only supports up to 4224x3136 */
>  	if (mpix->width > CIO2_IMAGE_MAX_WIDTH)
>  		mpix->width = CIO2_IMAGE_MAX_WIDTH;
> -	if (mpix->height > CIO2_IMAGE_MAX_LENGTH)
> -		mpix->height = CIO2_IMAGE_MAX_LENGTH;
> +	if (mpix->height > CIO2_IMAGE_MAX_HEIGHT)
> +		mpix->height = CIO2_IMAGE_MAX_HEIGHT;
>  
>  	mpix->num_planes = 1;
>  	mpix->pixelformat = fmt->fourcc;
> @@ -1283,7 +1283,7 @@ static int cio2_subdev_set_fmt(struct v4l2_subdev *sd,
>  	}
>  
>  	fmt->format.width = min(fmt->format.width, CIO2_IMAGE_MAX_WIDTH);
> -	fmt->format.height = min(fmt->format.height, CIO2_IMAGE_MAX_LENGTH);
> +	fmt->format.height = min(fmt->format.height, CIO2_IMAGE_MAX_HEIGHT);
>  	fmt->format.field = V4L2_FIELD_NONE;
>  
>  	mutex_lock(&q->subdev_lock);
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> index 7650d7998a3f..ccf0b85ae36f 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> @@ -14,7 +14,7 @@
>  #define CIO2_DMA_MASK					DMA_BIT_MASK(39)
>  
>  #define CIO2_IMAGE_MAX_WIDTH				4224U
> -#define CIO2_IMAGE_MAX_LENGTH				3136U
> +#define CIO2_IMAGE_MAX_HEIGHT				3136U
>  
>  /* 32MB = 8xFBPT_entry */
>  #define CIO2_MAX_LOPS					8

-- 
Regards,

Laurent Pinchart
