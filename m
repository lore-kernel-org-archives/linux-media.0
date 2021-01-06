Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D1C433E0
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7442311B
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAFOVi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbhAFOVh (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 6 Jan 2021 09:21:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F78C061362
        for <linux-media@vger.kernel.org>; Wed,  6 Jan 2021 06:21:05 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kx9gN-0006XV-Am; Wed, 06 Jan 2021 15:21:03 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kx9gM-0001wx-P6; Wed, 06 Jan 2021 15:21:02 +0100
Message-ID: <ad43a3121a7e3edf067a5f184fca490ce82f653a.camel@pengutronix.de>
Subject: Re: [PATCH 01/75] media: imx: Drop dependency on I2C
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Date:   Wed, 06 Jan 2021 15:21:02 +0100
In-Reply-To: <20210105152852.5733-2-laurent.pinchart@ideasonboard.com>
References: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
         <20210105152852.5733-2-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 2021-01-05 at 17:27 +0200, Laurent Pinchart wrote:
> The i.MX staging media drivers don't depend on I2C. Drop the dependency
> from Kconfig.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/staging/media/imx/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
> index f555aac8a9d5..4782f7cfb709 100644
> --- a/drivers/staging/media/imx/Kconfig
> +++ b/drivers/staging/media/imx/Kconfig
> @@ -18,14 +18,14 @@ menu "i.MX5/6/7 Media Sub devices"
>  
>  config VIDEO_IMX_CSI
>  	tristate "i.MX5/6 Camera Sensor Interface driver"
> -	depends on VIDEO_IMX_MEDIA && VIDEO_DEV && I2C
> +	depends on VIDEO_IMX_MEDIA && VIDEO_DEV
>  	default y
>  	help
>  	  A video4linux camera sensor interface driver for i.MX5/6.
>  
>  config VIDEO_IMX7_CSI
>  	tristate "i.MX6UL/L / i.MX7 Camera Sensor Interface driver"
> -	depends on VIDEO_IMX_MEDIA && VIDEO_DEV && I2C
> +	depends on VIDEO_IMX_MEDIA && VIDEO_DEV
>  	default y
>  	help
>  	  Enable support for video4linux camera sensor interface driver for

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
