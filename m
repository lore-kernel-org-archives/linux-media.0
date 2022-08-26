Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE3FECAAA3
	for <linux-media@archiver.kernel.org>; Fri, 26 Aug 2022 10:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbiHZKY5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Aug 2022 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343626AbiHZKYw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Aug 2022 06:24:52 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5313F3D;
        Fri, 26 Aug 2022 03:24:50 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 2C01E24000B;
        Fri, 26 Aug 2022 10:24:48 +0000 (UTC)
Date:   Fri, 26 Aug 2022 12:24:47 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: Fix repeated word in comments
Message-ID: <20220826102447.kpwpj2n5mta4k3xi@uno.localdomain>
References: <20220826100052.22945-22-jmaselbas@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826100052.22945-22-jmaselbas@kalray.eu>
X-GND-Spam-Score: 200
X-GND-Status: SPAM
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jules

  thanks, but as reported in patchwork and lore
https://patchwork.linuxtv.org/project/linux-media/list/?series=&submitter=&state=*&q=mt9v111&archive=both&delegate=
https://lore.kernel.org/all/20220824135433.h2udwtnub7mlmtam@uno.localdomain/

This is the 4th patch to fix the same repeated word in a comment.

As I asked to Jilin, are you submitting this as part of a new
contributor program ?

Thanks
   j

On Fri, Aug 26, 2022 at 12:00:50PM +0200, Jules Maselbas wrote:
> Remove redundant word `the`.
>
> CC: Jacopo Mondi <jacopo@jmondi.org>
> CC: linux-media@vger.kernel.org
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
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
> 2.17.1
>
