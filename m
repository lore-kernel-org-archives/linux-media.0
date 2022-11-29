Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DA2C4321E
	for <linux-media@archiver.kernel.org>; Tue, 29 Nov 2022 12:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiK2Mwp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiK2Mwk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 29 Nov 2022 07:52:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51295F44
        for <linux-media@vger.kernel.org>; Tue, 29 Nov 2022 04:52:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5AE44E6;
        Tue, 29 Nov 2022 13:52:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669726356;
        bh=iqAvU19yjhCd0COEPZIeUGGpMPM+ulAzKD18mAhyV4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3IoPKMh0tn0DN0XR9/OCGLPcqD4IKiahDn8nFVvhd2f7U8mfaVnVyCCFfRu4s1Fx
         Po/JCgEGPXFMqr/wadgJi26J0PSiFfUTPIK9fuJQc0Ma1cfWuQr0kbvQ3nZvD9QvhN
         VohyF5TEuwTKWC0MfDXwpjz9dKdG5VuBBqRsuKmM=
Date:   Tue, 29 Nov 2022 14:52:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     bparrot@ti.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: ti: cal: fix possible memory leak in
 cal_ctx_create()
Message-ID: <Y4YAhGKOyaK4JFA/@pendragon.ideasonboard.com>
References: <20221129110159.1541522-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129110159.1541522-1-cuigaosheng1@huawei.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Gaosheng,

Thank you for the patch.

On Tue, Nov 29, 2022 at 07:01:59PM +0800, Gaosheng Cui wrote:
> The memory of ctx is allocated in cal_ctx_create(), but it will
> not be freed when cal_ctx_v4l2_init() fails, so add kfree() when
> cal_ctx_v4l2_init() fails to fix it.
> 
> Fixes: d68a94e98a89 ("media: ti-vpe: cal: Split video device initialization and registration")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/ti/cal/cal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/ti/cal/cal.c b/drivers/media/platform/ti/cal/cal.c
> index 56b61c0583cf..1236215ec70e 100644
> --- a/drivers/media/platform/ti/cal/cal.c
> +++ b/drivers/media/platform/ti/cal/cal.c
> @@ -1050,8 +1050,10 @@ static struct cal_ctx *cal_ctx_create(struct cal_dev *cal, int inst)
>  	ctx->cport = inst;
>  
>  	ret = cal_ctx_v4l2_init(ctx);
> -	if (ret)
> +	if (ret) {
> +		kfree(ctx);
>  		return NULL;
> +	}
>  
>  	return ctx;
>  }

-- 
Regards,

Laurent Pinchart
