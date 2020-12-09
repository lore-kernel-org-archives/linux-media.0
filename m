Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F4EC433FE
	for <linux-media@archiver.kernel.org>; Wed,  9 Dec 2020 13:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FB823BC7
	for <linux-media@archiver.kernel.org>; Wed,  9 Dec 2020 13:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbgLINHq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:07:46 -0500
Received: from foss.arm.com ([217.140.110.172]:34310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbgLINGH (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 9 Dec 2020 08:06:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D4AC31B;
        Wed,  9 Dec 2020 05:05:16 -0800 (PST)
Received: from [10.57.61.6] (unknown [10.57.61.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3F73F66B;
        Wed,  9 Dec 2020 05:05:14 -0800 (PST)
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To:     Christoph Hellwig <hch@lst.de>, Tomasz Figa <tfiga@chromium.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@google.com>
References: <20201125221917.150463-1-ribalda@chromium.org>
 <20201130083410.GD32234@lst.de> <20201201033658.GE3723071@google.com>
 <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
 <20201209111235.GA22806@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b34596d-34c4-bd99-c5a7-5a4742c5b886@arm.com>
Date:   Wed, 9 Dec 2020 13:05:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209111235.GA22806@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 2020-12-09 11:12, Christoph Hellwig wrote:
> On Tue, Dec 08, 2020 at 01:54:00PM +0900, Tomasz Figa wrote:
>> >From the media perspective, it would be good to have the vmap
>> optional, similarly to the DMA_ATTR_NO_KERNEL_MAPPING attribute for
>> coherent allocations. Actually, in the media drivers, the need to have
>> a kernel mapping of the DMA buffers corresponds to a minority of the
>> drivers. Most of them only need to map them to the userspace.
>>
>> Nevertheless, that minority actually happens to be quite widely used,
>> e.g. the uvcvideo driver, so we can't go to the other extreme and just
>> drop the vmap at all.
> 
> My main problem is that the DMA_ATTR_NO_KERNEL_MAPPING makes a mess
> of an API.  I'd much rather have low-level API that returns the
> discontiguous allocations and another one that vmaps them rather
> than starting to overload arguments like in dma_alloc_attrs with
> DMA_ATTR_NO_KERNEL_MAPPING.

Agreed - if iommu-dma's dma_alloc_coherent() ends up as little more than 
a thin wrapper around those two functions I think that would be a good 
sign. It also seems like it might be a good idea for this API to use 
scatterlists rather than page arrays as it's fundamental format, to help 
reduce impedance with dma-buf - if we can end up with a wider redesign 
that also gets rid of dma_get_sgtable(), all the better!

Robin.
