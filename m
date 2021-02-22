Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD225C433DB
	for <linux-media@archiver.kernel.org>; Mon, 22 Feb 2021 01:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D62564EC3
	for <linux-media@archiver.kernel.org>; Mon, 22 Feb 2021 01:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBVBHe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 21 Feb 2021 20:07:34 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54446 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhBVBHd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 21 Feb 2021 20:07:33 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90EAF517;
        Mon, 22 Feb 2021 02:06:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613956010;
        bh=jNbNj5a4VeClhaJnrkKKAr7eFN6l98/8cYmw+xeTqCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMVYcZLyG06zegvLb44IDrDKnn9r6AzqRPFfYa9lawOOtnKL4SzgOphoim31vSxdk
         k1geVNkyXhr/hOjYQPtg83XRhZDzJHmkdqtfoRSZM913TYIbhb3gIXj2J3WnTVNmYT
         xVuyjG73lUeE5M3HkZ6PY0hCK1UPEjkIkwMAQIBM=
Date:   Mon, 22 Feb 2021 03:06:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     kieran.bingham+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] media: i2c: rdacm20: Report camera module name
Message-ID: <YDMDj8+qm+8pfbyV@pendragon.ideasonboard.com>
References: <20210216174146.106639-1-jacopo+renesas@jmondi.org>
 <20210216174146.106639-5-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210216174146.106639-5-jacopo+renesas@jmondi.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Tue, Feb 16, 2021 at 06:41:34PM +0100, Jacopo Mondi wrote:
> When the device is identified the driver currently reports the
> names of the chips embedded in the camera module.
> 
> Report the name of the camera module itself instead.
> Cosmetic change only.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/rdacm20.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> index 6504ed0bd3bc..56406d82b5ac 100644
> --- a/drivers/media/i2c/rdacm20.c
> +++ b/drivers/media/i2c/rdacm20.c
> @@ -532,7 +532,7 @@ static int rdacm20_initialize(struct rdacm20_device *dev)
>  	if (ret)
>  		return ret;
>  
> -	dev_info(dev->dev, "Identified MAX9271 + OV10635 device\n");
> +	dev_info(dev->dev, "Identified RDACM20 camera module\n");
>  
>  	/*
>  	 * Set reverse channel high threshold to increase noise immunity.

-- 
Regards,

Laurent Pinchart
