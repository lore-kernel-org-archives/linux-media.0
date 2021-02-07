Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C946C433DB
	for <linux-media@archiver.kernel.org>; Sun,  7 Feb 2021 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31B464E31
	for <linux-media@archiver.kernel.org>; Sun,  7 Feb 2021 18:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBGStm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:49:42 -0500
Received: from verein.lst.de ([213.95.11.211]:38953 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhBGStj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 7 Feb 2021 13:49:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5DE7D68B02; Sun,  7 Feb 2021 19:48:55 +0100 (CET)
Date:   Sun, 7 Feb 2021 19:48:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: add a new dma_alloc_noncontiguous API v2
Message-ID: <20210207184855.GA27553@lst.de>
References: <20210202095110.1215346-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202095110.1215346-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Any comments?

On Tue, Feb 02, 2021 at 10:51:03AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds the new noncontiguous DMA allocation API requested by
> various media driver maintainers.
> 
> Changes since v1:
>  - document that flush_kernel_vmap_range and invalidate_kernel_vmap_range
>    must be called once an allocation is mapped into KVA
>  - add dma-debug support
>  - remove the separate dma_handle argument, and instead create fully formed
>    DMA mapped scatterlists
>  - use a directional allocation in uvcvideo
>  - call invalidate_kernel_vmap_range from uvcvideo
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
