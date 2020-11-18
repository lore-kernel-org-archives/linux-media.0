Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA64C63697
	for <linux-media@archiver.kernel.org>; Wed, 18 Nov 2020 20:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366CB246C2
	for <linux-media@archiver.kernel.org>; Wed, 18 Nov 2020 20:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="POAM8CEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgKRUpz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgKRUpz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 18 Nov 2020 15:45:55 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A37C0613D4
        for <linux-media@vger.kernel.org>; Wed, 18 Nov 2020 12:45:54 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id v202so596295oia.9
        for <linux-media@vger.kernel.org>; Wed, 18 Nov 2020 12:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRPkDyzCqRByOXhTjo3usOS1Qkyhu3yxVJohFl57gbU=;
        b=POAM8CEpthyWOgv7n2Cam+k8aZ63689AnJSPscpz0kIzbVVeNznPr8qT/UvXWgB9MZ
         cD8WtkQeI/99Il/D8u4BLiOEail5+xKoNZ7KrUIo5K3CCypZejuE2AMUtl/v74YE6bAF
         5fWCRUveMbgmBRC6EGtsBjzTNDqJe9VwgfCJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRPkDyzCqRByOXhTjo3usOS1Qkyhu3yxVJohFl57gbU=;
        b=ez8ZEdngbdl1549j9CN8emsS14DhMYIyS89l6ygSvaYoHaoh4pQSqJ1ZK6pkrDuypy
         LBGT8QxKsGtkpP5leqp9ZnSzTtQBKPrVnMY020k9Gw1tSVvfkQBl9Xjm7LTauKHrhO6w
         ldEryVDIdrjsV2yBBNR9TZZQfVdi4CQrblO3ptR40AqgQAv9RaKq21u9L4IPO+wgZ0Zn
         TyC+DFcz8nOLLXN+GcaM9kLQl4cG0SN0js+SPKG4PgXsiDS/3zsctzJvl+K3ANlkG/EK
         ueYcWEUfxoSrpbZoJJkQ5wTnsukVogDeTSsrBpVDmF6JmYzWgeDoOK3Ior358SHkYZOU
         zDsA==
X-Gm-Message-State: AOAM532ZOqZwDAfqbmj7wf5qjB2csCZgOjauwjhE5bJlFk54TStpjmyG
        ge0aNzpUrzyw4rIYT4l//WVzGlS6kFvYZGX8m1s7lw==
X-Google-Smtp-Source: ABdhPJyClksd5RL8dptSeKf8UhYQ+Z4aGj7yfu+0LS7uJZDxZ7NecbiBLYr9OGL10xzVog9mrX/gOkhp0ZklNFe7Zbc=
X-Received: by 2002:aca:1713:: with SMTP id j19mr624914oii.101.1605732353482;
 Wed, 18 Nov 2020 12:45:53 -0800 (PST)
MIME-Version: 1.0
References: <1605205643-12746-1-git-send-email-veeras@codeaurora.org> <56c9f6721234666dea40d316e0dd24b6@codeaurora.org>
In-Reply-To: <56c9f6721234666dea40d316e0dd24b6@codeaurora.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Nov 2020 21:45:42 +0100
Message-ID: <CAKMK7uFu+nRRqw=Su66xUUbsH9hmajDUX-M_AHkH2crqPKL8rw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] dma-fence: allow signaling drivers to set
 fence timestamp
To:     Veera Sundaram Sankaran <veeras@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Dave Airlie <airlied@linux.ie>,
        "Clark, Rob" <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        pdhaval@codeaurora.org, Abhinav Kumar <abhinavk@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Nov 18, 2020 at 9:28 PM <veeras@codeaurora.org> wrote:
>
> On 2020-11-12 10:27, Veera Sundaram Sankaran wrote:
> > Some drivers have hardware capability to get the precise timestamp of
> > certain events based on which the fences are triggered. This allows it
> > to set accurate timestamp factoring out any software and IRQ latencies.
> > Move the timestamp parameter out of union in dma_fence struct to allow
> > signaling drivers to set it. If the parameter is not set, ktime_get is
> > used to set the current time to fence timestamp during
> > dma_fence_signal.
> >
>
> @Sumit Semwal / @Gustavo Padovan,
> Can you please help in reviewing this change as it falls in dma-fence
> files.

Please answer my question on the 2nd patch. This is new uabi
behaviour, we have a bunch of requirements for this kind of work:

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements

Thanks, Daniel

> Thanks,
> Veera
>
> > Signed-off-by: Veera Sundaram Sankaran <veeras@codeaurora.org>
> > ---
> >  drivers/dma-buf/dma-fence.c | 18 ++++++++++--------
> >  include/linux/dma-fence.h   | 15 +++------------
> >  2 files changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 43624b4..7cef49a 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -4,6 +4,7 @@
> >   *
> >   * Copyright (C) 2012 Canonical Ltd
> >   * Copyright (C) 2012 Texas Instruments
> > + * Copyright (c) 2020 The Linux Foundation. All rights reserved.
> >   *
> >   * Authors:
> >   * Rob Clark <robdclark@gmail.com>
> > @@ -329,7 +330,6 @@ void __dma_fence_might_wait(void)
> >  int dma_fence_signal_locked(struct dma_fence *fence)
> >  {
> >       struct dma_fence_cb *cur, *tmp;
> > -     struct list_head cb_list;
> >
> >       lockdep_assert_held(fence->lock);
> >
> > @@ -337,16 +337,18 @@ int dma_fence_signal_locked(struct dma_fence
> > *fence)
> >                                     &fence->flags)))
> >               return -EINVAL;
> >
> > -     /* Stash the cb_list before replacing it with the timestamp */
> > -     list_replace(&fence->cb_list, &cb_list);
> > -
> > -     fence->timestamp = ktime_get();
> > +     /* set current time, if not set by signaling driver */
> > +     if (!fence->timestamp)
> > +             fence->timestamp = ktime_get();
> >       set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
> >       trace_dma_fence_signaled(fence);
> >
> > -     list_for_each_entry_safe(cur, tmp, &cb_list, node) {
> > -             INIT_LIST_HEAD(&cur->node);
> > -             cur->func(fence, cur);
> > +     if (!list_empty(&fence->cb_list)) {
> > +             list_for_each_entry_safe(cur, tmp, &fence->cb_list, node) {
> > +                     INIT_LIST_HEAD(&cur->node);
> > +                     cur->func(fence, cur);
> > +             }
> > +             INIT_LIST_HEAD(&fence->cb_list);
> >       }
> >
> >       return 0;
> > diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> > index 09e23ad..a9eebaf 100644
> > --- a/include/linux/dma-fence.h
> > +++ b/include/linux/dma-fence.h
> > @@ -4,6 +4,7 @@
> >   *
> >   * Copyright (C) 2012 Canonical Ltd
> >   * Copyright (C) 2012 Texas Instruments
> > + * Copyright (c) 2020 The Linux Foundation. All rights reserved.
> >   *
> >   * Authors:
> >   * Rob Clark <robdclark@gmail.com>
> > @@ -70,26 +71,16 @@ struct dma_fence {
> >        * release the fence it is unused. No one should be adding to the
> >        * cb_list that they don't themselves hold a reference for.
> >        *
> > -      * The lifetime of the timestamp is similarly tied to both the
> > -      * rcu freelist and the cb_list. The timestamp is only set upon
> > -      * signaling while simultaneously notifying the cb_list. Ergo, we
> > -      * only use either the cb_list of timestamp. Upon destruction,
> > -      * neither are accessible, and so we can use the rcu. This means
> > -      * that the cb_list is *only* valid until the signal bit is set,
> > -      * and to read either you *must* hold a reference to the fence,
> > -      * and not just the rcu_read_lock.
> > -      *
> >        * Listed in chronological order.
> >        */
> >       union {
> >               struct list_head cb_list;
> > -             /* @cb_list replaced by @timestamp on dma_fence_signal() */
> > -             ktime_t timestamp;
> > -             /* @timestamp replaced by @rcu on dma_fence_release() */
> > +             /* @cb_list replaced by @rcu on dma_fence_release() */
> >               struct rcu_head rcu;
> >       };
> >       u64 context;
> >       u64 seqno;
> > +     ktime_t timestamp;
> >       unsigned long flags;
> >       struct kref refcount;
> >       int error;



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
