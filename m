Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B89C38145
	for <linux-media@archiver.kernel.org>; Thu,  8 Sep 2022 04:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIHEIw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHEIv (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 8 Sep 2022 00:08:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AEDC2F93
        for <linux-media@vger.kernel.org>; Wed,  7 Sep 2022 21:08:50 -0700 (PDT)
Received: from pyrite.rasen.tech (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BBABF6CC;
        Thu,  8 Sep 2022 06:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662610128;
        bh=xytu6v2Xi81ivPxyDBrYOkiIuyBsSHAye/WinoGMrmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ev7s+mnmb4iUTmJeRs9wOx56QYt5pGTkJKJdWcNYJvaPqtzjcELb6PMVctiNTGiia
         n0YxocGFU3JvIilIiklxRQ0TumwNcQsNwbM61E8Ts4pIqvfH2wAwXLHoWIKjhbHFxf
         HXYzTsoKO/ZkexYrpv2k62FZI51kDiQUfO/KRzbw=
Date:   Thu, 8 Sep 2022 13:08:40 +0900
From:   paul.elder@ideasonboard.com
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH 3/6] staging: media: imx: Drop imx_media_subdev_bound()
Message-ID: <20220908040840.GG1140330@pyrite.rasen.tech>
References: <20220907200424.32136-1-laurent.pinchart@ideasonboard.com>
 <20220907200424.32136-4-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907200424.32136-4-laurent.pinchart@ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Sep 07, 2022 at 11:04:21PM +0300, Laurent Pinchart wrote:
> The imx_media_subdev_bound() function is a no-op, and the async notifier
> .bound() operation is optional. Drop it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>

> ---
>  drivers/staging/media/imx/imx-media-dev-common.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-dev-common.c b/drivers/staging/media/imx/imx-media-dev-common.c
> index e6d6ed3b1161..8f7ced3a9cca 100644
> --- a/drivers/staging/media/imx/imx-media-dev-common.c
> +++ b/drivers/staging/media/imx/imx-media-dev-common.c
> @@ -19,18 +19,6 @@ static inline struct imx_media_dev *notifier2dev(struct v4l2_async_notifier *n)
>  	return container_of(n, struct imx_media_dev, notifier);
>  }
>  
> -/* async subdev bound notifier */
> -static int imx_media_subdev_bound(struct v4l2_async_notifier *notifier,
> -				  struct v4l2_subdev *sd,
> -				  struct v4l2_async_subdev *asd)
> -{
> -	struct imx_media_dev *imxmd = notifier2dev(notifier);
> -
> -	dev_dbg(imxmd->md.dev, "subdev %s bound\n", sd->name);
> -
> -	return 0;
> -}
> -
>  /*
>   * Create the missing media links from the CSI-2 receiver.
>   * Called after all async subdevs have bound.
> @@ -337,7 +325,6 @@ static void imx_media_notify(struct v4l2_subdev *sd, unsigned int notification,
>  }
>  
>  static const struct v4l2_async_notifier_operations imx_media_notifier_ops = {
> -	.bound = imx_media_subdev_bound,
>  	.complete = imx_media_probe_complete,
>  };
>  
