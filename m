Return-Path: <SRS0=tLen=TO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB11C04AB4
	for <linux-media@archiver.kernel.org>; Tue, 14 May 2019 20:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5665C20881
	for <linux-media@archiver.kernel.org>; Tue, 14 May 2019 20:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557864838;
	bh=kEqEwBowI7nDJuhmdAl92Ff5deY50reZOh2Ooyo6aY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u1dOlZZYJou+ofnRthLrYlqqVl2HY9Q9Sn1LbAPQiPeesN3jLnRg0HTxA9HVihfdA
	 UXIsPlO9KlsMIREYr0RvozLy5WJn3R6wIAvSk4hP5r+rKkYYA+UvaaApol978QUFw9
	 p98bknQSDtkK1wColwgIumI7tu7pj7KlBjJM7OgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfENUN5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 May 2019 16:13:57 -0400
Received: from casper.infradead.org ([85.118.1.10]:60916 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfENUN5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 May 2019 16:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BNb+dV3NVpUitMb6wFKSfOap4u//6ZgcL7PxAt1hGgM=; b=cUAo4R4KvqkBuxHKSI8Kf/Hhm0
        wUYUAwxBl6TyMpXtWEPOncwMKrpQFMH6J5Smf/byp+HYh/JvpD67SR03utNaQ6qFDVyTDvE6dVIbP
        99stx++2OBX0wBaqQhHqh75qi970yTv6dUlyURvZS2JY/BDmuum/5BDFnOVyEsh0++NvjqtH0SZbc
        rWKF7oKOvLEO1jgPWDG0Z2VE+oWvulOl/SWi7iiPobLGhz/o3MJlFwMfyw4G2c7fwQoBoVlCgdRpu
        4/TGw+LreWUkY9YtaMrDcX9ozSpmAMN/6fEwy9cwkFuUqIaXNDGNecMjTus3o0o64bVcaTbX2qZUY
        Lj9oyujA==;
Received: from [179.179.44.200] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQdo2-0008VW-0t; Tue, 14 May 2019 20:13:46 +0000
Date:   Tue, 14 May 2019 17:13:40 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        jacopo+renesas@jmondi.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 09/13] media: tvp5150: add s_power callback
Message-ID: <20190514171340.444ce55b@coco.lan>
In-Reply-To: <20190415124413.18456-10-m.felsch@pengutronix.de>
References: <20190415124413.18456-1-m.felsch@pengutronix.de>
        <20190415124413.18456-10-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 15 Apr 2019 14:44:09 +0200
Marco Felsch <m.felsch@pengutronix.de> escreveu:

> Don't en-/disable the interrupts during s_stream because someone can
> disable the stream but wants to get informed if the stream is locked
> again. So keep the interrupts enabled the whole time the pipeline is
> opened.

Not testing on any tvp5150 hardware, looks ok to me.

> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/media/i2c/tvp5150.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
> index 305a5e256b31..cd54715eb641 100644
> --- a/drivers/media/i2c/tvp5150.c
> +++ b/drivers/media/i2c/tvp5150.c
> @@ -1370,11 +1370,26 @@ static const struct media_entity_operations tvp5150_sd_media_ops = {
>  /****************************************************************************
>  			I2C Command
>   ****************************************************************************/
> +static int tvp5150_s_power(struct  v4l2_subdev *sd, int on)
> +{
> +	struct tvp5150 *decoder = to_tvp5150(sd);
> +	unsigned int val = 0;
> +
> +	if (on)
> +		val = TVP5150_INT_A_LOCK;
> +
> +	if (decoder->irq)
> +		/* Enable / Disable lock interrupt */
> +		regmap_update_bits(decoder->regmap, TVP5150_INT_ENABLE_REG_A,
> +				   TVP5150_INT_A_LOCK, val);
> +
> +	return 0;
> +}
>  
>  static int tvp5150_s_stream(struct v4l2_subdev *sd, int enable)
>  {
>  	struct tvp5150 *decoder = to_tvp5150(sd);
> -	unsigned int mask, val = 0, int_val = 0;
> +	unsigned int mask, val = 0;
>  
>  	mask = TVP5150_MISC_CTL_YCBCR_OE | TVP5150_MISC_CTL_SYNC_OE |
>  	       TVP5150_MISC_CTL_CLOCK_OE;
> @@ -1387,15 +1402,10 @@ static int tvp5150_s_stream(struct v4l2_subdev *sd, int enable)
>  			val = decoder->lock ? decoder->oe : 0;
>  		else
>  			val = decoder->oe;
> -		int_val = TVP5150_INT_A_LOCK;
>  		v4l2_subdev_notify_event(&decoder->sd, &tvp5150_ev_fmt);
>  	}
>  
>  	regmap_update_bits(decoder->regmap, TVP5150_MISC_CTL, mask, val);
> -	if (decoder->irq)
> -		/* Enable / Disable lock interrupt */
> -		regmap_update_bits(decoder->regmap, TVP5150_INT_ENABLE_REG_A,
> -				   TVP5150_INT_A_LOCK, int_val);
>  
>  	return 0;
>  }
> @@ -1586,6 +1596,7 @@ static const struct v4l2_subdev_core_ops tvp5150_core_ops = {
>  	.g_register = tvp5150_g_register,
>  	.s_register = tvp5150_s_register,
>  #endif
> +	.s_power = tvp5150_s_power,
>  };
>  
>  static const struct v4l2_subdev_tuner_ops tvp5150_tuner_ops = {



Thanks,
Mauro
