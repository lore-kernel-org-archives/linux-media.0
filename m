Return-Path: <SRS0=wnq3=EF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D22DC4741F
	for <linux-media@archiver.kernel.org>; Fri, 30 Oct 2020 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8AD2151B
	for <linux-media@archiver.kernel.org>; Fri, 30 Oct 2020 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Db7ytI3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgJ3TWs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 30 Oct 2020 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbgJ3TVb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 30 Oct 2020 15:21:31 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F09FC0613CF
        for <linux-media@vger.kernel.org>; Fri, 30 Oct 2020 12:21:31 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x203so7708870oia.10
        for <linux-media@vger.kernel.org>; Fri, 30 Oct 2020 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB/MV5GLyjNu8UDfEZUP2zhFQAq8WaUlOhnxP+WLczo=;
        b=Db7ytI3QoTKyC/bdolNU5gUWVNc46g31IGOBQ+DmMtde88iG8cUlKjZYe/983DcDhn
         qWnPuTHZ07E448vG3lG+8TfAGGOQd/Jm+diYaoq9lWNhWlQTZDObhaVr11DeKQPSRu3W
         1IzJaZ+F4GaDe5nt4o+U+ipzq/tCk5aVUlkQ1hQ9GbzA75QiCnd1NtwKBpjDeP1LXYu7
         6zyALkTqMti7sDAEJd9kNDwzPsAHerX6lJAKeHIa/BiD8rOEEL+QaRtbibbexyRGctUK
         s5lYr7r+FNoH2J9GqIvX/vZjg6fd5Jqy+Z9MJKi30pPMjpI1mcCXIa4RAqk66i/gDyNa
         2WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB/MV5GLyjNu8UDfEZUP2zhFQAq8WaUlOhnxP+WLczo=;
        b=htkLV/JHCw+Xc2UWhL92Vyx2l2ihxkRkbzAzn2hYHfKopg0vIBXXJsqtacwwt1RlVF
         yWbsk0l1WYqVN3tmJ22g93LUV0cSF7La69YjGoiCCSbHEnHgHFjrp6mBCYbCPFqWpGjB
         e8ZY1FLWySpZ2PEIhTlCiw7EqvXc5vx1C2E1reayDemMsjtIxvZhO74a9vm0kZIBjEpm
         qI9rPneV1BMtIArfYIPy8nptvRlWSHHHEkWlzuf3PzOn4K/nETWe7rK4G4J0H2dHpqus
         gcHU8NHxByac0aUhqiFoan5oElua32eEE0j7iRBpBsE2rIXteaqe503szZq/oMPlsksk
         SOXg==
X-Gm-Message-State: AOAM533UcSIjpYRMlTxdTWJTQZ2gRP5xbZ6oMVd7oK8JZamHPCPusMhk
        TBsA2vo4Ek909s85/Nx0di1Xet6B7G1FZ4hmRTkWmA==
X-Google-Smtp-Source: ABdhPJyJXImIHpK83wwAip/CxzfDZ/jrYC8xy+ZEw+XNXk7wfku+ojOsZNj7E08ou2/Gb2qDLKqgTDw+df7YmNTNNJE=
X-Received: by 2002:a05:6808:578:: with SMTP id j24mr2827168oig.10.1604085690947;
 Fri, 30 Oct 2020 12:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201030075023.3250-1-hdanton@sina.com>
In-Reply-To: <20201030075023.3250-1-hdanton@sina.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 30 Oct 2020 12:21:18 -0700
Message-ID: <CALAqxLXVMnnoRDt8=_qD=ipipC69u35fqDv+vmJ2JWnZtxCG7g@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] dma-buf: system_heap: Add a system-uncached heap
 re-using the system heap
To:     Hillf Danton <hdanton@sina.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        Christoph Hellwig <hch@infradead.org>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Oct 30, 2020 at 12:51 AM Hillf Danton <hdanton@sina.com> wrote:
> On Thu, 29 Oct 2020 21:04:30 -0700 John Stultz wrote:
> >
> > But I'll try to share my thoughts:
> >
> > So the system heap allows for allocation of non-contiguous buffers
> > (currently allocated from page_alloc), which we keep track using
> > sglists.
> > Since the resulting dmabufs are shared between multiple devices, we
> > want to provide a *specific type of memory* (in this case
> > non-contiguous system memory), rather than what the underlying
> > dma_alloc_attr() allocates for a specific device.
>
> If the memory slice(just a page for simple case) from
> dma_alloc_attr(for device-A) does not work for device-B, nor can
> page_alloc do the job imho.

Right. That's why userland chooses which heap to allocate from, as
it's the only one that knows the path the buffer will take.

thanks
-john
