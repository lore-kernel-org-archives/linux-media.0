Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A1C64E7C
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 11:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F66E20857
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 11:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgKXLfR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:35:17 -0500
Received: from verein.lst.de ([213.95.11.211]:54112 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbgKXLfP (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 06:35:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94C046736F; Tue, 24 Nov 2020 12:35:12 +0100 (CET)
Date:   Tue, 24 Nov 2020 12:35:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH] WIP! media: uvcvideo: Use dma_alloc_noncontiguos API
Message-ID: <20201124113512.GA21974@lst.de>
References: <20200930160917.1234225-9-hch@lst.de> <20201118142546.170621-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201118142546.170621-1-ribalda@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Nov 18, 2020 at 03:25:46PM +0100, Ricardo Ribalda wrote:
> On architectures where the is no coherent caching such as ARM use the
> dma_alloc_noncontiguos API and handle manually the cache flushing using
> dma_sync_single().
> 
> With this patch on the affected architectures we can measure up to 20x
> performance improvement in uvc_video_copy_data_work().

This has a bunch of crazy long lines, but otherwise looks fine to me.

> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> 
> This patch depends on dma_alloc_contiguous API￼1315351diffmboxseries

How do we want to proceed?  Do the media maintainers want to pick up
that patch?  Should I pick up the media patch in the dma-mapping tree?

Can you respost a combined series to get started?
