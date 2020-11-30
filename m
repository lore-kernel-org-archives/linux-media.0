Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF7BC63777
	for <linux-media@archiver.kernel.org>; Mon, 30 Nov 2020 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65052074A
	for <linux-media@archiver.kernel.org>; Mon, 30 Nov 2020 08:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgK3Ice (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Nov 2020 03:32:34 -0500
Received: from verein.lst.de ([213.95.11.211]:43381 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgK3Ice (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Nov 2020 03:32:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D34C68AFE; Mon, 30 Nov 2020 09:31:51 +0100 (CET)
Date:   Mon, 30 Nov 2020 09:31:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
Message-ID: <20201130083150.GC32234@lst.de>
References: <20201125221917.150463-1-ribalda@chromium.org> <20201126114450.GB3723071@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126114450.GB3723071@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Nov 26, 2020 at 08:44:50PM +0900, Sergey Senozhatsky wrote:
> > +	uvc_urb->buffer = vmap(uvc_urb->pages,
> > +			       PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT,
> > +			       VM_DMA_COHERENT, PAGE_KERNEL);
> 
> This is not related to Ricardo's patch, just a side note:
> 
>   I think VM_DMA_COHERENT needs to be renamed. I found it a bit confusing
>   to see DMA_COHERENT mapping being dma_sync-ed. It turned out that the
>   flag has different meaning.

s/renamed/removed/.  This is a normal VM_MAP mapping as far as the
core vmalloc/vmap code is concerned.  VM_DMA_COHERENT is only for
internal use in the core DMA code.
