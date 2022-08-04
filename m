Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980EEC19F2A
	for <linux-media@archiver.kernel.org>; Thu,  4 Aug 2022 13:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiHDNiZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiHDNiY (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Aug 2022 09:38:24 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C303D5B5;
        Thu,  4 Aug 2022 06:38:23 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 0CE8E100002;
        Thu,  4 Aug 2022 13:38:20 +0000 (UTC)
Date:   Thu, 4 Aug 2022 15:38:18 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mt9v111: Fix comment typo
Message-ID: <20220804133818.ysc3dj62mn3hlyoe@uno.localdomain>
References: <20220804115924.54296-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804115924.54296-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Jason

On Thu, Aug 04, 2022 at 07:59:24PM +0800, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Thanks, but this has been already fixed by
https://patchwork.kernel.org/project/linux-media/patch/20220722015211.63609-1-slark_xiao@163.com/

> ---
>  drivers/media/i2c/mt9v111.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
> index 2dc4a0f24ce8..7beca0b70b72 100644
> --- a/drivers/media/i2c/mt9v111.c
> +++ b/drivers/media/i2c/mt9v111.c
> @@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
>
>  	/*
>  	 * Set pixel integration time to the whole frame time.
> -	 * This value controls the the shutter delay when running with AE
> +	 * This value controls the shutter delay when running with AE
>  	 * disabled. If longer than frame time, it affects the output
>  	 * frame rate.
>  	 */
> --
> 2.35.1
>
