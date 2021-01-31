Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C48C433DB
	for <linux-media@archiver.kernel.org>; Sun, 31 Jan 2021 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E5064E24
	for <linux-media@archiver.kernel.org>; Sun, 31 Jan 2021 20:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhAaULT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:11:19 -0500
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:54868 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231764AbhAaUJM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 31 Jan 2021 15:09:12 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 18F5A181CB158;
        Sun, 31 Jan 2021 17:39:54 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D3FA018006AE7;
        Sun, 31 Jan 2021 17:39:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: box41_5e0a4fe275bb
X-Filterd-Recvd-Size: 2345
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 31 Jan 2021 17:39:52 +0000 (UTC)
Message-ID: <004fa2c0c74bb26d6144198552c8bae33a57be2e.camel@perches.com>
Subject: Re: [PATCH 08/29] dma-buf: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jiri Kosina <trivial@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Date:   Sun, 31 Jan 2021 09:39:51 -0800
In-Reply-To: <4d5891b7-ea87-974e-d260-f78c3af326bc@amd.com>
References: <cover.1598331148.git.joe@perches.com>
         <990bf6f33ccaf73ad56eb4bea8bd2c0db5e90a31.1598331148.git.joe@perches.com>
         <a87b95d11c22d997ebc423bba71cabef15ca0bac.camel@perches.com>
         <4d5891b7-ea87-974e-d260-f78c3af326bc@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 2021-02-03 at 14:26 +0100, Christian König wrote:
> Am 30.01.21 um 19:47 schrieb Joe Perches:
> > On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> > > Use semicolons and braces.
> > Ping?
> > > Signed-off-by: Joe Perches <joe@perches.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Do you have commit rights to drm-misc-next?

No.

> > > ---
> > >   drivers/dma-buf/st-dma-fence.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
> > > index e593064341c8..c8a12d7ad71a 100644
> > > --- a/drivers/dma-buf/st-dma-fence.c
> > > +++ b/drivers/dma-buf/st-dma-fence.c
> > > @@ -471,8 +471,11 @@ static int thread_signal_callback(void *arg)
> > >   			dma_fence_signal(f1);
> > > 
> > >   		smp_store_mb(cb.seen, false);
> > > -		if (!f2 || dma_fence_add_callback(f2, &cb.cb, simple_callback))
> > > -			miss++, cb.seen = true;
> > > +		if (!f2 ||
> > > +		    dma_fence_add_callback(f2, &cb.cb, simple_callback)) {
> > > +			miss++;
> > > +			cb.seen = true;
> > > +		}
> > > 
> > >   		if (!t->before)
> > >   			dma_fence_signal(f1);
> > 
> 


