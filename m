Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F11C433DB
	for <linux-media@archiver.kernel.org>; Sat, 30 Jan 2021 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A9864E11
	for <linux-media@archiver.kernel.org>; Sat, 30 Jan 2021 18:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhA3Sr4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Jan 2021 13:47:56 -0500
Received: from smtprelay0049.hostedemail.com ([216.40.44.49]:46318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229620AbhA3Srz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Jan 2021 13:47:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EBCFD181D341E;
        Sat, 30 Jan 2021 18:47:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cork01_33057cb275b3
X-Filterd-Recvd-Size: 1933
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 18:47:11 +0000 (UTC)
Message-ID: <a87b95d11c22d997ebc423bba71cabef15ca0bac.camel@perches.com>
Subject: Re: [PATCH 08/29] dma-buf: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Date:   Sat, 30 Jan 2021 10:47:10 -0800
In-Reply-To: <990bf6f33ccaf73ad56eb4bea8bd2c0db5e90a31.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <990bf6f33ccaf73ad56eb4bea8bd2c0db5e90a31.1598331148.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

Ping?
 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/dma-buf/st-dma-fence.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
> index e593064341c8..c8a12d7ad71a 100644
> --- a/drivers/dma-buf/st-dma-fence.c
> +++ b/drivers/dma-buf/st-dma-fence.c
> @@ -471,8 +471,11 @@ static int thread_signal_callback(void *arg)
>  			dma_fence_signal(f1);
>  
> 
>  		smp_store_mb(cb.seen, false);
> -		if (!f2 || dma_fence_add_callback(f2, &cb.cb, simple_callback))
> -			miss++, cb.seen = true;
> +		if (!f2 ||
> +		    dma_fence_add_callback(f2, &cb.cb, simple_callback)) {
> +			miss++;
> +			cb.seen = true;
> +		}
>  
> 
>  		if (!t->before)
>  			dma_fence_signal(f1);


