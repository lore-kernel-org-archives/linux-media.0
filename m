Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84497C001DC
	for <linux-media@archiver.kernel.org>; Mon, 31 Jul 2023 11:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjGaLWa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjGaLWT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 31 Jul 2023 07:22:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C31BDB;
        Mon, 31 Jul 2023 04:22:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EB0367373; Mon, 31 Jul 2023 13:21:56 +0200 (CEST)
Date:   Mon, 31 Jul 2023 13:21:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pintu Kumar <quic_pintu@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux.dev, pintu.ping@gmail.com,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma
 region
Message-ID: <20230731112155.GA3662@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Pintu,

On Sat, Jul 29, 2023 at 08:05:15AM +0530, Pintu Kumar wrote:
> The current global cma region name defined as "reserved"
> which is misleading, creates confusion and too generic.
> 
> Also, the default cma allocation happens from global cma region,
> so, if one has to figure out all allocations happening from
> global cma region, this seems easier.
> 
> Thus, change the name from "reserved" to "global-cma-region".

I agree that reserved is not a very useful name.  Unfortuately the
name of the region leaks to userspace through cma_heap.

So I think we need prep patches to hardcode "reserved" in
add_default_cma_heap first, and then remove the cma_get_name
first.
