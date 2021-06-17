Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD055C48BE5
	for <linux-media@archiver.kernel.org>; Thu, 17 Jun 2021 08:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF439613DB
	for <linux-media@archiver.kernel.org>; Thu, 17 Jun 2021 08:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFQIyo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Jun 2021 04:54:44 -0400
Received: from verein.lst.de ([213.95.11.211]:57801 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhFQIyn (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Jun 2021 04:54:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED1A168C4E; Thu, 17 Jun 2021 10:52:33 +0200 (CEST)
Date:   Thu, 17 Jun 2021 10:52:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <20210617085233.GA4702@lst.de>
References: <20210427131344.139443-1-senozhatsky@chromium.org> <20210427131344.139443-9-senozhatsky@chromium.org> <10a0903a-e295-5cba-683a-1eb89a0804ed@xs4all.nl> <YMsAIVs7G2hUDR2F@google.com> <20210617080107.GA1422@lst.de> <CAAFQd5DiPstn-s+yQM3iMd=G9oaag39qCyX483a7-Jrn=gxWCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5DiPstn-s+yQM3iMd=G9oaag39qCyX483a7-Jrn=gxWCA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Jun 17, 2021 at 05:30:11PM +0900, Tomasz Figa wrote:
> We still have use cases for dma_alloc_coherent() and DMA_ATTR_NO_KERNEL_MAPPING.

dma_alloc_coherent does not take a flags argument, so you can't use
DMA_ATTR_NO_KERNEL_MAPPING with it.  What would your use case be here
anyway?  In general DMA_ATTR_NO_KERNEL_MAPPING is rather misnamed, as
usually there is a kernel mapping, just not one that is coherent and
should be used.
