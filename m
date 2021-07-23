Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A972FC4338F
	for <linux-media@archiver.kernel.org>; Fri, 23 Jul 2021 05:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9014C60E96
	for <linux-media@archiver.kernel.org>; Fri, 23 Jul 2021 05:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGWE2d (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 23 Jul 2021 00:28:33 -0400
Received: from verein.lst.de ([213.95.11.211]:36922 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhGWE2c (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 23 Jul 2021 00:28:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B43C68AFE; Fri, 23 Jul 2021 07:09:03 +0200 (CEST)
Date:   Fri, 23 Jul 2021 07:09:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>, kernel@collabora.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Fix leak in non-contiguous API
Message-ID: <20210723050902.GA31187@lst.de>
References: <20210723010552.50969-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723010552.50969-1-ezequiel@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

> As a side note, it appears the struct dma_sgt_handle type is exposed
> to users of the DMA-API by linux/dma-map-ops.h, but is has no users
> or functions returning the type explicitly.
> 
> This may indicate it's a good idea to move the struct dma_sgt_handle type
> to drivers/iommu/dma-iommu.c. The decision is left to maintainers :-)

linux/dma-map-ops.h is a helper header for the dma_ops implementations,
not for users of the DMA API.  sgt_handle, which references
dma_sgt_handle is used in kernel/dma/mapping.c
