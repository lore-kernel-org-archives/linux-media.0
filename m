Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5F7C433FE
	for <linux-media@archiver.kernel.org>; Wed, 23 Nov 2022 10:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiKWKXu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Nov 2022 05:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiKWKWK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Nov 2022 05:22:10 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49138BB
        for <linux-media@vger.kernel.org>; Wed, 23 Nov 2022 02:08:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9BB188F;
        Wed, 23 Nov 2022 11:08:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669198116;
        bh=P9zzVEhV/ZjDZBNFNDBLgQFvvJcoaX/s0i3MBpV5eGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eh4VO+hBbjIdnQyB18aaZyod5UgzTh5efne6L5MxNTMBBtTUmGu1i7icb+wb9HLy0
         zLm85Xq9Fm3ocFmp0wnFWP29aA8sbhfx6qeltkOncmwThoRak5k+L+aBM6fzVdStB7
         PwaELERDECmsS9Ti13IfBMMVorqSkg1YSRqqRGYo=
Date:   Wed, 23 Nov 2022 12:08:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v1 03/15] media: i2c: imx290: Factor out control update
 code to a function
Message-ID: <Y33xFBpPPRQHuEDx@pendragon.ideasonboard.com>
References: <20221122223250.21233-1-laurent.pinchart@ideasonboard.com>
 <20221122223250.21233-4-laurent.pinchart@ideasonboard.com>
 <4763239.GXAFRqVoOG@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4763239.GXAFRqVoOG@steina-w>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Alexander,

On Wed, Nov 23, 2022 at 08:51:24AM +0100, Alexander Stein wrote:
> Am Dienstag, 22. November 2022, 23:32:38 CET schrieb Laurent Pinchart:
> > Move the control update code to a separate function to group it with all
> > the control-related code and make imx290_set_fmt() more readable.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/media/i2c/imx290.c | 36 ++++++++++++++++--------------------
> >  1 file changed, 16 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> > index 4dbf218e7a63..eb295502d0c3 100644
> > --- a/drivers/media/i2c/imx290.c
> > +++ b/drivers/media/i2c/imx290.c
> > @@ -639,6 +639,21 @@ static const char * const imx290_test_pattern_menu[] =
> > { "000/555h Toggle Pattern",
> >  };
> > 
> > +static void imx290_ctrl_update(struct imx290 *imx290,
> > +			       const struct imx290_mode *mode)
> > +{
> > +	unsigned int hblank = mode->hmax - mode->width;
> > +	unsigned int vblank = IMX290_VMAX_DEFAULT - mode->height;
> > +
> > +	__v4l2_ctrl_s_ctrl(imx290->link_freq,
> > +			   imx290_get_link_freq_index(imx290));
> > +	__v4l2_ctrl_s_ctrl_int64(imx290->pixel_rate,
> > +				 imx290_calc_pixel_rate(imx290));
> 
> I do not know the details, but I assume that imx290_ctrl_init already detects, 
> using imx290->ctrls.error, if one of those controls have _not_ been created.

No, there's a bug here. It's fixed in latter patches in the series I
think, but this breaks bisection. I'll fix it.

> If so:
> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> > +
> > +	__v4l2_ctrl_modify_range(imx290->hblank, hblank, hblank, 1, hblank);
> > +	__v4l2_ctrl_modify_range(imx290->vblank, vblank, vblank, 1, vblank);
> > +}
> > +
> >  static int imx290_ctrl_init(struct imx290 *imx290)
> >  {
> >  	struct v4l2_fwnode_device_properties props;
> > @@ -904,26 +919,7 @@ static int imx290_set_fmt(struct v4l2_subdev *sd,
> >  		imx290->current_mode = mode;
> >  		imx290->bpp = imx290_formats[i].bpp;
> > 
> > -		if (imx290->link_freq)
> > -			__v4l2_ctrl_s_ctrl(imx290->link_freq,
> > -					   imx290_get_link_freq_index(imx290));
> > -		if (imx290->pixel_rate)
> > -			__v4l2_ctrl_s_ctrl_int64(imx290->pixel_rate,
> > -					imx290_calc_pixel_rate(imx290));
> > -
> > -		if (imx290->hblank) {
> > -			unsigned int hblank = mode->hmax - mode->width;
> > -
> > -			__v4l2_ctrl_modify_range(imx290->hblank, hblank, hblank,
> > -						 1, hblank);
> > -		}
> > -
> > -		if (imx290->vblank) {
> > -			unsigned int vblank = IMX290_VMAX_DEFAULT - mode->height;
> > -
> > -			__v4l2_ctrl_modify_range(imx290->vblank, vblank, vblank,
> > -						 1, vblank);
> > -		}
> > +		imx290_ctrl_update(imx290, mode);
> >  	}
> > 
> >  	*format = fmt->format;

-- 
Regards,

Laurent Pinchart
