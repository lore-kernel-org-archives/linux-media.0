Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D62C433F5
	for <linux-media@archiver.kernel.org>; Sun,  1 May 2022 23:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378102AbiEAXD3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 1 May 2022 19:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiEAXD2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 1 May 2022 19:03:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31618483B2;
        Sun,  1 May 2022 16:00:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F6CCA46;
        Mon,  2 May 2022 00:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651445997;
        bh=MRWisMUeM29h2xFjIiLMSuO4mNMpnsXW7jxf3zvDG7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnYemCpRbsolGkTv+ZNf5PsT16YG9ykZGLdj6kmq3EcotxP4KcvzLKRGK2ZIF7GXp
         sATQSKG3GA2Tb3jgBfIyIAhRfFz0Y56D0YtQj8S6DbmDbwrFeeji2UvEmVrAipcA6r
         rQNJpabheArMOUaE/vbNdpz8NvDScBBJqgQ4t3Yw=
Date:   Mon, 2 May 2022 01:59:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov5645: Remove unneeded of_match_ptr macro
Message-ID: <Ym8Q7QhoT2aqMrJr@pendragon.ideasonboard.com>
References: <20220429222754.11333-1-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429222754.11333-1-mosescb.dev@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Moses,

Thank you for the patch.

On Sat, Apr 30, 2022 at 12:27:54AM +0200, Moses Christopher Bollavarapu wrote:
> of_match_ptr isn't required as CONFIG_OF is already a dependency in Kconfig

And the .of_match_table field hasn't been conditional on CONFIG_OF for a
long time now.

> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov5645.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index 368fa21e675e..ea73c060514d 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -1283,7 +1283,7 @@ MODULE_DEVICE_TABLE(of, ov5645_of_match);
>  
>  static struct i2c_driver ov5645_i2c_driver = {
>  	.driver = {
> -		.of_match_table = of_match_ptr(ov5645_of_match),
> +		.of_match_table = ov5645_of_match,
>  		.name  = "ov5645",
>  	},
>  	.probe_new = ov5645_probe,

-- 
Regards,

Laurent Pinchart
