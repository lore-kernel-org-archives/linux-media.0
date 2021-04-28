Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F45C433ED
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDD96143B
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbhD1RSp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Apr 2021 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhD1RSp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Apr 2021 13:18:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A103C061573;
        Wed, 28 Apr 2021 10:18:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BE1851F42B88
Message-ID: <e5eeffbbad6ee90204cb3928cfd6774efb6174f3.camel@collabora.com>
Subject: Re: [PATCH v4 79/79] media: hantro: do a PM resume earlier
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Date:   Wed, 28 Apr 2021 14:17:50 -0300
In-Reply-To: <569838d406dde80dcc64989a663882817a54cbb2.1619621413.git.mchehab+huawei@kernel.org>
References: <cover.1619621413.git.mchehab+huawei@kernel.org>
         <569838d406dde80dcc64989a663882817a54cbb2.1619621413.git.mchehab+huawei@kernel.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Thanks a lot for taking care of this.

On Wed, 2021-04-28 at 16:52 +0200, Mauro Carvalho Chehab wrote:
> The device_run() first enables the clock and then
> tries to resume PM runtime, checking for errors.
> 
> Well, if for some reason the pm_runtime can not resume,
> it would be better to detect it beforehand.
> 
> So, change the order inside device_run().
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Clocks could be behind power-domains, IIRC, so this change
is fixing that.

However, this has ever been a problem for this driver,
so I don't think it makes sense to bother with Fixes tag.

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks,
Ezequiel

> ---
>  drivers/staging/media/hantro/hantro_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 25fa36e7e773..67de6b15236d 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -160,14 +160,14 @@ static void device_run(void *priv)
>         src = hantro_get_src_buf(ctx);
>         dst = hantro_get_dst_buf(ctx);
>  
> -       ret = clk_bulk_enable(ctx->dev->variant->num_clocks, ctx->dev->clocks);
> -       if (ret)
> -               goto err_cancel_job;
> -
>         ret = pm_runtime_resume_and_get(ctx->dev->dev);
>         if (ret < 0)
>                 goto err_cancel_job;
>  
> +       ret = clk_bulk_enable(ctx->dev->variant->num_clocks, ctx->dev->clocks);
> +       if (ret)
> +               goto err_cancel_job;
> +
>         v4l2_m2m_buf_copy_metadata(src, dst, true);
>  
>         ctx->codec_ops->run(ctx);


