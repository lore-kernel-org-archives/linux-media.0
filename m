Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21265C433E0
	for <linux-media@archiver.kernel.org>; Wed, 10 Mar 2021 07:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E286864FDE
	for <linux-media@archiver.kernel.org>; Wed, 10 Mar 2021 07:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhCJHuM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Mar 2021 02:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhCJHty (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Mar 2021 02:49:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83312C06174A;
        Tue,  9 Mar 2021 23:49:54 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A4BBF3;
        Wed, 10 Mar 2021 08:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615362592;
        bh=YgKt8m7oB1wqNJ5FwJ0SwR0cY4QWuOoPNs+HQQGJ21M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XoOh7apvvgLBbsYv7nd3ObReGqgEfdY4JGntBf/MNpkAWeZOPhfo3BIAjmhHO2+eW
         jrgf4mOiniZHrl2+UbEtcsGSeZb7VM9gfqb/nabFcYfjJikp+fArrglk0VtWuwkY6N
         9Whu7B1gGJ1tiS/+FW1TIofsIbpN6T5WmKpPynx4=
Date:   Wed, 10 Mar 2021 09:49:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] media: videobuf2: Fix integer overrun in allocation
Message-ID: <YEh6AIQPa75MzP+8@pendragon.ideasonboard.com>
References: <20210309234317.1021588-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309234317.1021588-1-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Wed, Mar 10, 2021 at 12:43:17AM +0100, Ricardo Ribalda wrote:
> The plane_length is an unsigned integer. So, if we have a size of
> 0xffffffff bytes we incorrectly allocate 0 bytes instead of 1 << 32.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7f8414594e47 ("[media] media: videobuf2: fix the length check for mmap")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 02281d13505f..543da515c761 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -223,8 +223,10 @@ static int __vb2_buf_mem_alloc(struct vb2_buffer *vb)
>  	 * NOTE: mmapped areas should be page aligned
>  	 */
>  	for (plane = 0; plane < vb->num_planes; ++plane) {
> +		unsigned long size = vb->planes[plane].length;

unsigned long is still 32-bit on 32-bit platforms.

> +
>  		/* Memops alloc requires size to be page aligned. */
> -		unsigned long size = PAGE_ALIGN(vb->planes[plane].length);
> +		size = PAGE_ALIGN(size);
>  
>  		/* Did it wrap around? */
>  		if (size < vb->planes[plane].length)

Doesn't this address the issue already ?


-- 
Regards,

Laurent Pinchart
