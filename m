Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE60E7D240
	for <linux-media@archiver.kernel.org>; Tue, 26 Sep 2023 06:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjIZGvz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZGvy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 26 Sep 2023 02:51:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241EE6;
        Mon, 25 Sep 2023 23:51:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6488C67373; Tue, 26 Sep 2023 08:51:44 +0200 (CEST)
Date:   Tue, 26 Sep 2023 08:51:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, Fang Hui <hui.fang@nxp.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, anle.pan@nxp.com, xuegang.liu@nxp.com
Subject: Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Message-ID: <20230926065143.GB5606@lst.de>
References: <20230914145812.12851-1-hui.fang@nxp.com> <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com> <353919fd-932e-5d81-6ac5-7b51117366cd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353919fd-932e-5d81-6ac5-7b51117366cd@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Sep 20, 2023 at 05:54:26PM +0100, Robin Murphy wrote:
> As I mentioned before, I think it might make the most sense to make the 
> whole thing into a "proper" dma_alloc_sgtable() function, which can then be 
> used with dma_sync_sgtable_*() as dma_alloc_pages() is used with 
> dma_sync_single_*() (and then dma_alloc_noncontiguous() clearly falls as 
> the special in-between case).

Why not just use dma_alloc_noncontiguous if the caller wants an sgtable
anyway?
