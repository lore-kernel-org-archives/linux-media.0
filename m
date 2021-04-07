Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84C0C433ED
	for <linux-media@archiver.kernel.org>; Wed,  7 Apr 2021 06:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C132613D0
	for <linux-media@archiver.kernel.org>; Wed,  7 Apr 2021 06:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbhDGGKO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:10:14 -0400
Received: from verein.lst.de ([213.95.11.211]:57552 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhDGGKN (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 7 Apr 2021 02:10:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 10DD168B05; Wed,  7 Apr 2021 08:10:01 +0200 (CEST)
Date:   Wed, 7 Apr 2021 08:10:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] lib/scatterlist: Fix NULL pointer deference
Message-ID: <20210407061000.GA19527@lst.de>
References: <20210406160435.206115-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406160435.206115-1-ribalda@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
