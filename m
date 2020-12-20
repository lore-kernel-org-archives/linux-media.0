Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E2C4361B
	for <linux-media@archiver.kernel.org>; Sun, 20 Dec 2020 21:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2BC22CA2
	for <linux-media@archiver.kernel.org>; Sun, 20 Dec 2020 21:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgLTVst (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 20 Dec 2020 16:48:49 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53684 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgLTVss (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 20 Dec 2020 16:48:48 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C7E2031A;
        Sun, 20 Dec 2020 22:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608500887;
        bh=gb3cdIvFX5C3h/8mHD8OH09C7vKc7BsxyHIwkcxRVy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oim3xO946htwvFJz8vlDzr6j1ZLrFmu5MQpZdNi4c9O/d8ssD9w1M+b62iceQEmOu
         QBIdlL3xH+YOzcltKrstYYB/IbxKX6zl3rwDOikC3eSmFjgFw65sjOzvqz2VHXy5tD
         lPI9QDPQ9cQce62LZmOCe+HvMzkraT5iOud/26WQ=
Date:   Sun, 20 Dec 2020 23:47:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 1/1] v4l: ioctl: Use kmalloc to allocate a small chunk of
 memory
Message-ID: <X9/Gj4g/f5DD2Sp8@pendragon.ideasonboard.com>
References: <20201220213012.16671-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201220213012.16671-1-sakari.ailus@linux.intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sajari,

Thank you for the patch.

On Sun, Dec 20, 2020 at 11:30:12PM +0200, Sakari Ailus wrote:
> kvmalloc() was used to release the temporary memory buffer that was used
> to contain both the IOCTL argument as well as a possible array argument
> that could have been large. Now that the two are separated, the IOCTL
> argument is known to be small in size. Use kmalloc to allocate it instead
> of kvmalloc. Similarly for releasing it.
> 
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 9906b41004e9b..8d5d9c39c1622 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -3300,7 +3300,7 @@ video_usercopy(struct file *file, unsigned int orig_cmd, unsigned long arg,
>  			parg = sbuf;
>  		} else {
>  			/* too big to allocate from stack */
> -			mbuf = kvmalloc(ioc_size, GFP_KERNEL);
> +			mbuf = kmalloc(ioc_size, GFP_KERNEL);
>  			if (NULL == mbuf)
>  				return -ENOMEM;
>  			parg = mbuf;
> @@ -3377,7 +3377,7 @@ video_usercopy(struct file *file, unsigned int orig_cmd, unsigned long arg,
>  		err = -EFAULT;
>  out:
>  	kvfree(array_buf);
> -	kvfree(mbuf);
> +	kfree(mbuf);
>  	return err;
>  }
>  

-- 
Regards,

Laurent Pinchart
