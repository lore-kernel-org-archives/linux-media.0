Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18E6C433E9
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06762311F
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 14:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbhAFOWy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbhAFOWx (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 6 Jan 2021 09:22:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050ECC061362
        for <linux-media@vger.kernel.org>; Wed,  6 Jan 2021 06:22:13 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kx9hS-0006Za-Uj; Wed, 06 Jan 2021 15:22:10 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kx9hN-0001yn-LR; Wed, 06 Jan 2021 15:22:05 +0100
Message-ID: <314915e069557481b2b05dbff81dd6c17d168759.camel@pengutronix.de>
Subject: Re: [PATCH 03/75] media: imx: Drop manual dependency on
 VIDEO_IMX_MEDIA
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Date:   Wed, 06 Jan 2021 15:22:05 +0100
In-Reply-To: <20210105152852.5733-4-laurent.pinchart@ideasonboard.com>
References: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
         <20210105152852.5733-4-laurent.pinchart@ideasonboard.com>
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
> The VIDEO_IMX_CSI and VIDEO_IMX7_CSI symbols are defined in a section
> guarded by VIDEO_IMX_MEDIA. There's no need to duplicate that with a
> "depends on" statement. Drop it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/staging/media/imx/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
> index 76a9111c189c..ce270627a7c4 100644
> --- a/drivers/staging/media/imx/Kconfig
> +++ b/drivers/staging/media/imx/Kconfig
> @@ -19,14 +19,12 @@ menu "i.MX5/6/7 Media Sub devices"
>  
>  config VIDEO_IMX_CSI
>  	tristate "i.MX5/6 Camera Sensor Interface driver"
> -	depends on VIDEO_IMX_MEDIA
>  	default y
>  	help
>  	  A video4linux camera sensor interface driver for i.MX5/6.
>  
>  config VIDEO_IMX7_CSI
>  	tristate "i.MX6UL/L / i.MX7 Camera Sensor Interface driver"
> -	depends on VIDEO_IMX_MEDIA
>  	default y
>  	help
>  	  Enable support for video4linux camera sensor interface driver for

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
