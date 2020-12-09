Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58764C433FE
	for <linux-media@archiver.kernel.org>; Wed,  9 Dec 2020 11:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDEE233A2
	for <linux-media@archiver.kernel.org>; Wed,  9 Dec 2020 11:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgLILNS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:13:18 -0500
Received: from verein.lst.de ([213.95.11.211]:49749 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729807AbgLILNS (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 9 Dec 2020 06:13:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 51AA868AFE; Wed,  9 Dec 2020 12:12:35 +0100 (CET)
Date:   Wed, 9 Dec 2020 12:12:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@google.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
Message-ID: <20201209111235.GA22806@lst.de>
References: <20201125221917.150463-1-ribalda@chromium.org> <20201130083410.GD32234@lst.de> <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de> <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Dec 08, 2020 at 01:54:00PM +0900, Tomasz Figa wrote:
> >From the media perspective, it would be good to have the vmap
> optional, similarly to the DMA_ATTR_NO_KERNEL_MAPPING attribute for
> coherent allocations. Actually, in the media drivers, the need to have
> a kernel mapping of the DMA buffers corresponds to a minority of the
> drivers. Most of them only need to map them to the userspace.
> 
> Nevertheless, that minority actually happens to be quite widely used,
> e.g. the uvcvideo driver, so we can't go to the other extreme and just
> drop the vmap at all.

My main problem is that the DMA_ATTR_NO_KERNEL_MAPPING makes a mess
of an API.  I'd much rather have low-level API that returns the
discontiguous allocations and another one that vmaps them rather
than starting to overload arguments like in dma_alloc_attrs with
DMA_ATTR_NO_KERNEL_MAPPING.

> 
> In any case, Sergey is going to share a preliminary patch on how the
> current API would be used in the V4L2 videobuf2 framework. That should
> give us more input on how such a helper could look.

Awesome!
