Return-Path: <SRS0=i92q=25=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59694C33CA1
	for <linux-media@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4CF20705
	for <linux-media@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgAHPIf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:08:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57694 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgAHPIe (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 8 Jan 2020 10:08:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id DBC04292E56
Message-ID: <1118f946572b3da0562fa1c0347fceaeda93f38f.camel@collabora.com>
Subject: Re: [PATCH] media: hantro: remove a pointless NULL check
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
Date:   Wed, 08 Jan 2020 12:08:21 -0300
In-Reply-To: <20200108053534.6rwxk2httwoflbgv@kili.mountain>
References: <20200108053534.6rwxk2httwoflbgv@kili.mountain>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dan,

Thanks for the patch.

On Wed, 2020-01-08 at 08:35 +0300, Dan Carpenter wrote:
> This can't be NULL and we've already dereferenced it so let's remove
> the check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/staging/media/hantro/hantro_v4l2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index 85af1b96fd34..0198bcda26b7 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -688,7 +688,7 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
>  	return ret;
>  
>  err_codec_exit:
> -	if (ctx->codec_ops && ctx->codec_ops->exit)
> +	if (ctx->codec_ops->exit)

Since you are here, can you remove the other unneeded
checks in the driver?

We are assuming ctx->codec_op is non-NULL, so perhaps
a check in .probe, to check it explicitly would be better.

Thanks,
Ezequiel

