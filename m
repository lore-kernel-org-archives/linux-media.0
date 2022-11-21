Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF4C433FE
	for <linux-media@archiver.kernel.org>; Mon, 21 Nov 2022 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKULj6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKULjk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Nov 2022 06:39:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D48CBBC
        for <linux-media@vger.kernel.org>; Mon, 21 Nov 2022 03:38:25 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D40EE660035C;
        Mon, 21 Nov 2022 11:38:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669030704;
        bh=Yojmru/MsLAhPUrRrdBJaOOTpvTJoGFNW62gzDPqFoQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NWdDmS99Zf+/dwPXgO8hETCKk3JJQ5MKqP2vG4c1zHZ+CfyIqDL4pv4LKRwGEPohf
         FEjegL3r+JtbvpARuqmltpRGSWA/Db7uEtBvLOsQLv9RxkiJxXzZA+ZA55mPuXuryS
         BlI0rx4T0tmHR2C5ir3L6Ibs/0j5xJHiIBlVwtt5D0tJKcDqdigxFQJU+mVEbS1GV/
         odZS6yHo5k9eXlB/MLRutDic+PLljwig8c8NQ379ILv0Q41BaNU2knyhaYcViaaG6V
         qJaPf2R//wPpEGSuTtbnbipkIQR+ZSelWS87ae50n9EosRJcSHNYuUnotC7K3aFDS3
         AbfDUB+Xc5yjg==
Message-ID: <64375ff4-dbbb-3d5b-eaf6-32d6780fd496@collabora.com>
Date:   Mon, 21 Nov 2022 12:38:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] media: videobuf2-dma-sg: use v{un,}map instead of
 vm_{un,}map_ram
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-media@vger.kernel.org
Cc:     tfiga@chromium.org, m.szyprowski@samsung.com, kernel@pengutronix.de
References: <20221120234441.550908-1-m.grzeschik@pengutronix.de>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20221120234441.550908-1-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Michael,

W dniu 21.11.2022 o 00:44, Michael Grzeschik pisze:
> The comments before the vm_map_ram function state that it should be used
> for up to 256 KB only, and video buffers are definitely much larger. It
> recommends using vmap in that case.
> 

The comment is:

/**
  * vm_map_ram - map pages linearly into kernel virtual address (vmalloc space)
  * @pages: an array of pointers to the pages to be mapped
  * @count: number of pages
  * @node: prefer to allocate data structures on this node
  *
  * If you use this function for less than VMAP_MAX_ALLOC pages, it could be
  * faster than vmap so it's good.  But if you mix long-life and short-life
  * objects with vm_map_ram(), it could consume lots of address space through
  * fragmentation (especially on a 32bit machine).  You could see failures in
  * the end.  Please use this function for short-lived objects.
  *
  * Returns: a pointer to the address that has been mapped, or %NULL on failure
  */

As far as I understand the comment means:

- for allocations smaller than VMAP_MAX_ALLOC vm_map_ram() can be faster than
vmap()
- for larger allocations we don't know, maybe vmap() is faster, but the
comment doesn't say that vm_map_ram() cannot be used
- mixing long-life and short-life objects can have side effect of creating
fragmentation (which ultimately can lead to failures)
- the comment requests that the function is used for short-lived objects only
(which maybe is not the same thing as "large objects")

Can you expand your commit message?

Regards,

Andrzej


> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>   drivers/media/common/videobuf2/videobuf2-dma-sg.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> index dcb8de5ab3e84a..e86621fba350f3 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -188,7 +188,7 @@ static void vb2_dma_sg_put(void *buf_priv)
>   		dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir,
>   				  DMA_ATTR_SKIP_CPU_SYNC);
>   		if (buf->vaddr)
> -			vm_unmap_ram(buf->vaddr, buf->num_pages);
> +			vunmap(buf->vaddr);
>   		sg_free_table(buf->dma_sgt);
>   		while (--i >= 0)
>   			__free_page(buf->pages[i]);
> @@ -289,7 +289,7 @@ static void vb2_dma_sg_put_userptr(void *buf_priv)
>   	       __func__, buf->num_pages);
>   	dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
>   	if (buf->vaddr)
> -		vm_unmap_ram(buf->vaddr, buf->num_pages);
> +		vunmap(buf->vaddr);
>   	sg_free_table(buf->dma_sgt);
>   	if (buf->dma_dir == DMA_FROM_DEVICE ||
>   	    buf->dma_dir == DMA_BIDIRECTIONAL)
> @@ -312,7 +312,8 @@ static void *vb2_dma_sg_vaddr(struct vb2_buffer *vb, void *buf_priv)
>   			ret = dma_buf_vmap(buf->db_attach->dmabuf, &map);
>   			buf->vaddr = ret ? NULL : map.vaddr;
>   		} else {
> -			buf->vaddr = vm_map_ram(buf->pages, buf->num_pages, -1);
> +			buf->vaddr = vmap(buf->pages, buf->num_pages, VM_MAP,
> +					  PAGE_KERNEL);
>   		}
>   	}
>   

