Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3EFC2D0E4
	for <linux-media@archiver.kernel.org>; Mon, 23 Nov 2020 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68B42075A
	for <linux-media@archiver.kernel.org>; Mon, 23 Nov 2020 14:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OKDZQ6Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgKWOT2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Nov 2020 09:19:28 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:46572 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgKWOT2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Nov 2020 09:19:28 -0500
Received: from [192.168.0.20] (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 407B02A4;
        Mon, 23 Nov 2020 15:19:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1606141165;
        bh=9Zf3Ky7qi7Zqo+wk/9Giqhh6k3x7irvOrLPUr8Bcz1I=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OKDZQ6PnGpemyoJDHbp2p50zJtq+8TTYCOZYHZIMvy07AJagUWJbGo6aRcb2H9Gqv
         6/qIigqENZDh4wzK0XtC5Ja5xo4tPfketTRKQgLVSekn20T8erBDmCM1WSURgWSQEj
         rpOBrb9TkAS2Qx7YyR3akfjO6QGA/TAV5021sTlQ=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 2/2] media: rdacm20: Enable GPIO1 explicitly
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201120161529.236447-1-jacopo+renesas@jmondi.org>
 <20201120161529.236447-3-jacopo+renesas@jmondi.org>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <639206d5-ccd6-4819-3372-4850fc734204@ideasonboard.com>
Date:   Mon, 23 Nov 2020 14:19:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120161529.236447-3-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On 20/11/2020 16:15, Jacopo Mondi wrote:
> The MAX9271 GPIO1 line that controls the sensor reset is by default
> enabled after a serializer chip reset.
> 
> As rdacm20 does not go through an explicit serializer reset, make sure
> GPIO1 is enabled to make the camera module driver more robust.
> 
> Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Looks helpful to ensure a GPIO is enabled before toggling ;-)

Reading the datasheet, GPIO1EN defaults to enabled, so I assume this was
already working - however I think being explicit is a good thing anyway.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


> ---
>  drivers/media/i2c/rdacm20.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> index 1ed928c4ca70..16bcb764b0e0 100644
> --- a/drivers/media/i2c/rdacm20.c
> +++ b/drivers/media/i2c/rdacm20.c
> @@ -487,9 +487,18 @@ static int rdacm20_initialize(struct rdacm20_device *dev)
>  	 * Reset the sensor by cycling the OV10635 reset signal connected to the
>  	 * MAX9271 GPIO1 and verify communication with the OV10635.
>  	 */
> -	max9271_clear_gpios(dev->serializer, MAX9271_GPIO1OUT);
> +	ret = max9271_enable_gpios(dev->serializer, MAX9271_GPIO1OUT);
> +	if (ret)
> +		return ret;
> +
> +	ret = max9271_clear_gpios(dev->serializer, MAX9271_GPIO1OUT);
> +	if (ret)
> +		return ret;
>  	usleep_range(10000, 15000);
> -	max9271_set_gpios(dev->serializer, MAX9271_GPIO1OUT);
> +
> +	ret = max9271_set_gpios(dev->serializer, MAX9271_GPIO1OUT);
> +	if (ret)
> +		return ret;
>  	usleep_range(10000, 15000);
> 
>  again:
> --
> 2.29.1
> 

