Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A29BC433B4
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0210261411
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhD1GPi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:15:38 -0400
Received: from verein.lst.de ([213.95.11.211]:47960 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhD1GPi (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Apr 2021 02:15:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D529168B05; Wed, 28 Apr 2021 08:14:51 +0200 (CEST)
Date:   Wed, 28 Apr 2021 08:14:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <20210428061451.GB5084@lst.de>
References: <20210427131344.139443-1-senozhatsky@chromium.org> <20210427131344.139443-9-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427131344.139443-9-senozhatsky@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Apr 27, 2021 at 10:13:43PM +0900, Sergey Senozhatsky wrote:
> This adds support for new noncontiguous DMA API, which
> requires allocators to have two execution branches: one
> for the current API, and one for the new one.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> [hch: untested conversion to the ne API]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I think you can skip my signoff and the note here for the trivial
conversion.

The code looks fine to me from the DMA API perspective:

Acked-by: Christoph Hellwig <hch@lst.de>
