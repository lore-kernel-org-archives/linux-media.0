Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15CEC433E6
	for <linux-media@archiver.kernel.org>; Mon,  1 Mar 2021 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F7C64DF2
	for <linux-media@archiver.kernel.org>; Mon,  1 Mar 2021 08:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhCAINJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:13:09 -0500
Received: from verein.lst.de ([213.95.11.211]:52733 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232787AbhCAIMf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Mar 2021 03:12:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F71068BEB; Mon,  1 Mar 2021 09:11:52 +0100 (CET)
Date:   Mon, 1 Mar 2021 09:11:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH 6/7] dma-iommu: implement ->alloc_noncontiguous
Message-ID: <20210301081151.GA28023@lst.de>
References: <20210202095110.1215346-1-hch@lst.de> <20210202095110.1215346-7-hch@lst.de> <CAAFQd5BXAWeB2h4RvqsF1q8ip-Rhew80c7y1_og22-x3rS8KOQ@mail.gmail.com> <20210216084947.GA23897@lst.de> <YDyVFi26RPz5RrJB@google.com> <20210301072128.GA27039@lst.de> <YDyfo9OKkRHxd89O@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDyfo9OKkRHxd89O@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Mar 01, 2021 at 05:02:43PM +0900, Sergey Senozhatsky wrote:
> > I plan to resend the whole series with the comments very soon.
> 
> Oh, OK.
> 
> I thought the series was in linux-next already so a single patch
> would do.

It was, with an emphasys on was.  I hadn't realized I need an ack
from Laurent for uvcvideo, and he didn't have time to review it by the
time we noticed.  So I'll repost it with him in the receipients list and
the small fixups accumulated now that -rc1 is out.
