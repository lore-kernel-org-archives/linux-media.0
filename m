Return-Path: <SRS0=4cU9=WR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B703C3A59E
	for <linux-media@archiver.kernel.org>; Wed, 21 Aug 2019 16:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7539722DD3
	for <linux-media@archiver.kernel.org>; Wed, 21 Aug 2019 16:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfHUQVK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-media@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:21:10 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:54698 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727120AbfHUQVK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 21 Aug 2019 12:21:10 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18216842-1500050 
        for multiple; Wed, 21 Aug 2019 17:21:05 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From:   Chris Wilson <chris@chris-wilson.co.uk>
User-Agent: alot/0.6
To:     =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        sumit.semwal@linaro.org
References: <20190821123147.110736-1-christian.koenig@amd.com>
 <20190821123147.110736-9-christian.koenig@amd.com>
In-Reply-To: <20190821123147.110736-9-christian.koenig@amd.com>
Message-ID: <156640446349.20466.1523574549056596842@skylake-alporthouse-com>
Subject: Re: [PATCH 08/10] dma-buf/resv: replace shared fence with new fences
 container
Date:   Wed, 21 Aug 2019 17:21:03 +0100
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Quoting Christian König (2019-08-21 13:31:45)
> @@ -528,20 +352,9 @@ void dma_resv_prune_fences(struct dma_resv *obj)
>                 dma_fence_put(fence);
>         }
>  
> -       list = dma_resv_get_list(obj);
> -       if (!list)
> -               return;
> -
> -       for (i = 0; i < list->shared_count; ++i) {
> -               fence = rcu_dereference_protected(list->shared[i],
> -                                                 dma_resv_held(obj));
> -
> -               if (!dma_fence_is_signaled(fence))
> -                       continue;
> -
> -               RCU_INIT_POINTER(list->shared[i], dma_fence_get_stub());
> -               dma_fence_put(fence);
> -       }
> +       fence = dma_resv_fences_deref(obj, &obj->readers);
> +       if (dma_fence_is_signaled(fence))
> +               dma_resv_fences_set(obj, &obj->readers, NULL);

Needs fence==NULL safeguards.

It's not as pruny as it was before. Or did you add some magic to
fence-array?
-Chris
