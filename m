Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D039C433DB
	for <linux-media@archiver.kernel.org>; Tue,  9 Feb 2021 08:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C2C64E85
	for <linux-media@archiver.kernel.org>; Tue,  9 Feb 2021 08:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBIIW7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Feb 2021 03:22:59 -0500
Received: from verein.lst.de ([213.95.11.211]:45400 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhBIIW5 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 9 Feb 2021 03:22:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDE8E67373; Tue,  9 Feb 2021 09:22:13 +0100 (CET)
Date:   Tue, 9 Feb 2021 09:22:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: add a new dma_alloc_noncontiguous API v2
Message-ID: <20210209082213.GA31902@lst.de>
References: <20210202095110.1215346-1-hch@lst.de> <20210207184855.GA27553@lst.de> <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Feb 08, 2021 at 08:33:50PM +0900, Tomasz Figa wrote:
> Sorry for the delay. The whole series looks very good to me. Thanks a lot.
> 
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Thanks.

Ricardo, do the uvcvideo changes look good to you?  I'd like to queue
the series up for this merge window.
