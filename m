Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC595C63777
	for <linux-media@archiver.kernel.org>; Mon, 30 Nov 2020 08:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8199E20709
	for <linux-media@archiver.kernel.org>; Mon, 30 Nov 2020 08:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgK3I3L (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Nov 2020 03:29:11 -0500
Received: from verein.lst.de ([213.95.11.211]:43356 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgK3I3K (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Nov 2020 03:29:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32F3768B02; Mon, 30 Nov 2020 09:28:27 +0100 (CET)
Date:   Mon, 30 Nov 2020 09:28:26 +0100
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
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>
Subject: Re: [PATCH 3/6] dma-iommu: remove __iommu_dma_mmap
Message-ID: <20201130082826.GB32234@lst.de>
References: <20201124153845.132207-1-ribalda@chromium.org> <20201124153845.132207-3-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124153845.132207-3-ribalda@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Nov 24, 2020 at 04:38:42PM +0100, Ricardo Ribalda wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The function has a single caller, so open code it there and take
> advantage of the precalculated page count variable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It turns out this isn't really required for the series.  I think it is
a useful cleanup, but it should probably be picked up separately.

Robin, any comments?
