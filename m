Return-Path: <SRS0=gF/f=XR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B2C3A5A2
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A945D208C0
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 12:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfIVMR3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Sep 2019 08:17:29 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:59658 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728824AbfIVMR2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Sep 2019 08:17:28 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18576281-1500050 
        for multiple; Sun, 22 Sep 2019 13:17:22 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190922074900.853-1-yuq825@gmail.com>
Cc:     lima@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Qiang Yu <yuq825@gmail.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
References: <20190922074900.853-1-yuq825@gmail.com>
Message-ID: <156915463935.21369.4938801884938429332@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] dma-buf/resv: fix exclusive fence get
Date:   Sun, 22 Sep 2019 13:17:19 +0100
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Quoting Qiang Yu (2019-09-22 08:49:00)
> This causes kernel crash when testing lima driver.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Fixes: b8c036dfc66f ("dma-buf: simplify reservation_object_get_fences_rcu a bit")
> Signed-off-by: Qiang Yu <yuq825@gmail.com>
> ---
>  drivers/dma-buf/dma-resv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index 42a8f3f11681..709002515550 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -471,7 +471,7 @@ int dma_resv_get_fences_rcu(struct dma_resv *obj,
>         if (pfence_excl)
>                 *pfence_excl = fence_excl;
>         else if (fence_excl)
> -               shared[++shared_count] = fence_excl;
> +               shared[shared_count++] = fence_excl;

Oops.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
