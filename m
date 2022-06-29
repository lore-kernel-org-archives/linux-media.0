Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701BFC433EF
	for <linux-media@archiver.kernel.org>; Wed, 29 Jun 2022 08:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiF2IEu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiF2IEn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 29 Jun 2022 04:04:43 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503E23B554;
        Wed, 29 Jun 2022 01:04:40 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id C922710000F;
        Wed, 29 Jun 2022 08:04:36 +0000 (UTC)
Date:   Wed, 29 Jun 2022 10:04:34 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] media: ov5693: rename ov5693_check_hwcfg into
 ov5693_get_hwcfg
Message-ID: <20220629080434.aqihub7ridzg3st3@uno.localdomain>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
 <20220627150453.220292-6-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627150453.220292-6-tommaso.merciai@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Jun 27, 2022 at 05:04:51PM +0200, Tommaso Merciai wrote:
> Function ov5693_check_hwcfg don't only check the hw configuration but

s/don't/doesn't/ ?

> also get the hw configuration. Is better better to rename this into ov5693_get_hwcfg

The concept of "getting" the hw configuration vs "checking" it is
debatable. The function does many other things as far as I can tell.

However, this is also a little arbitrary but I guess it doesn't hurt ?

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
>  drivers/media/i2c/ov5693.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index d5a934ace597..273caef467fe 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -1339,7 +1339,7 @@ static int ov5693_get_regulators(struct ov5693_device *ov5693)
>  				       ov5693->supplies);
>  }
>
> -static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
> +static int ov5693_get_hwcfg(struct ov5693_device *ov5693)
>  {
>  	struct fwnode_handle *fwnode = dev_fwnode(ov5693->dev);
>  	struct v4l2_fwnode_endpoint bus_cfg = {
> @@ -1431,7 +1431,7 @@ static int ov5693_probe(struct i2c_client *client)
>  	ov5693->client = client;
>  	ov5693->dev = &client->dev;
>
> -	ret = ov5693_check_hwcfg(ov5693);
> +	ret = ov5693_get_hwcfg(ov5693);
>  	if (ret)
>  		return ret;
>
> --
> 2.25.1
>
