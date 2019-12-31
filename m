Return-Path: <SRS0=JS7/=2V=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A4C2D0DD
	for <linux-media@archiver.kernel.org>; Tue, 31 Dec 2019 09:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFE72072A
	for <linux-media@archiver.kernel.org>; Tue, 31 Dec 2019 09:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLaJhf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:37:35 -0500
Received: from gofer.mess.org ([88.97.38.141]:52489 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfLaJhf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Dec 2019 04:37:35 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 1A73711A001; Tue, 31 Dec 2019 09:37:34 +0000 (GMT)
Date:   Tue, 31 Dec 2019 09:37:33 +0000
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] [media] af9035: issue an error message when i2c stuff
 fails
Message-ID: <20191231093733.GC24469@gofer.mess.org>
References: <20190707205933.23059-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190707205933.23059-1-uwe@kleine-koenig.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Uwe,

First apologies for taking so long to get to your patch.

On Sun, Jul 07, 2019 at 10:59:33PM +0200, Uwe Kleine-König wrote:
> Instead of failing silent give a hint what went wrong.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  drivers/media/usb/dvb-usb-v2/af9035.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
> index de52309eaaab..f5701fab192c 100644
> --- a/drivers/media/usb/dvb-usb-v2/af9035.c
> +++ b/drivers/media/usb/dvb-usb-v2/af9035.c
> @@ -211,13 +211,19 @@ static int af9035_add_i2c_dev(struct dvb_usb_device *d, const char *type,
>  
>  	/* register I2C device */
>  	client = i2c_new_device(adapter, &board_info);
> -	if (client == NULL || client->dev.driver == NULL) {
> +	if (client == NULL) {
> +		dev_err(&intf->dev, "failed to register i2c device\n");
> +		ret = -ENODEV;
> +		goto err;
> +	} else if (client->dev.driver == NULL) {
> +		dev_err(&intf->dev, "no driver for i2c device (type=%s)\n", type);
>  		ret = -ENODEV;
>  		goto err;
>  	}

i2c_new_device() calls i2c_new_client_device(), which in every error path
does a dev_err(). I suspect that this patch has become obsolete because
of fixes in i2c.

Thanks,

Sean

>  
>  	/* increase I2C driver usage count */
>  	if (!try_module_get(client->dev.driver->owner)) {
> +		dev_err(&intf->dev, "failed to get module for i2c driver\n");
>  		i2c_unregister_device(client);
>  		ret = -ENODEV;
>  		goto err;
> -- 
> 2.20.1
