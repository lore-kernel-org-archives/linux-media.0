Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D825C433E0
	for <linux-media@archiver.kernel.org>; Fri,  8 Jan 2021 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B37623AAA
	for <linux-media@archiver.kernel.org>; Fri,  8 Jan 2021 19:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbhAHT41 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAHT41 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 8 Jan 2021 14:56:27 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3880EC061380
        for <linux-media@vger.kernel.org>; Fri,  8 Jan 2021 11:55:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o19so25779886lfo.1
        for <linux-media@vger.kernel.org>; Fri, 08 Jan 2021 11:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJMq4objzVNcUblV8NE/DuldZCBKwJF/PtAQRpfJPNc=;
        b=vrBhrVXkMEbApDOfPouVo3hQgeMClLDDFTrQJuG42kKnLbo4UQvyEmnpXNVNMFotwC
         ndG6SVmWvpz1z2eiJmqH68y4K1/FZGQAdrZbDWLyWd47B7Oc0ty8OKSFmNiWl31EHMoD
         xAOfpJ1UbzfW2NnPJ0565Fqxjf8CLMH1bbI9QMDi54+CvunHBzvshWLRUPiRW+mMcy7+
         PwKs2pMhwxRvQSj4xkPHasXVtQnWrOQnhYal5iGmFa83CxIvJ2pmCtU1Mo0hbNQTgtJ2
         MBJc8C/3f609xACEZU8d0oVj0cxZHV77L1zBK/2XC6zJkoYOHa8YOdvH3JWni4Z8Dn07
         dtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJMq4objzVNcUblV8NE/DuldZCBKwJF/PtAQRpfJPNc=;
        b=rV3jgwkNFhGL5DAd9/6+AKZK/r+e6CuAphdNn003rdTjV2hWMi+O3f8eTqgRFhfAqI
         sittAT+hPkWJbm7YqRu3FZ7iTyc1smRxf0Ct2mTNJI9RgxSrAHcGeJX3eh/cCagkeeao
         7JbrvOUKamnGxgNQklYiUzRRz+CCQeoaON/qTpA2XZ+DYZZv9QUJvHQhG5dwCkIIoe0g
         yF4oHFPFi2udvaPZ0UKdrbkod8fDy1RFAkyJJG+KKgWnqcYP8liMLVYnaeLWN5XZ7yR1
         WSyFxIC6Dhj5JG1tiqQuaeKFLjeNXmTUsAGSTQllm5cn7ECEBz8li5eYWElOd9lJ3k+S
         13LA==
X-Gm-Message-State: AOAM531vxW7iPBmtyJ4+HO2soR9QJof9u8ciIS+udD/t+XeyiZpWgLQw
        Xe67m+juvBGF2qiXRJPXgo0oaxqyW6wV5gVobiTdNA==
X-Google-Smtp-Source: ABdhPJxTt/pq9Ctby6LYdcBcM6+wiAiQOmcWinms2iB1gVmjDc1A/yv94xhmvmRI7G2lqD56lARAFOaf9ejrNHPsLnM=
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr2121481lfm.508.1610135745778;
 Fri, 08 Jan 2021 11:55:45 -0800 (PST)
MIME-Version: 1.0
References: <1609962554-13872-1-git-send-email-veeras@codeaurora.org>
In-Reply-To: <1609962554-13872-1-git-send-email-veeras@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 8 Jan 2021 11:55:34 -0800
Message-ID: <CALAqxLVyCuQmEKYh+TBo7k5igP8piz8mAsFt4cChF9q=qmh8XQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] dma-fence: allow signaling drivers to set
 fence timestamp
To:     Veera Sundaram Sankaran <veeras@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media <linux-media@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, abhinavk@codeaurora.org,
        pdhaval@codeaurora.org, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Jan 7, 2021 at 12:53 AM Veera Sundaram Sankaran
<veeras@codeaurora.org> wrote:
>
> Some drivers have hardware capability to get the precise timestamp of
> certain events based on which the fences are triggered. This allows it to
> set accurate timestamp factoring out any software and IRQ latencies. Add
> a timestamp variant of fence signal function, dma_fence_signal_timestamp
> to allow drivers to update the precise timestamp for fences.
>

So, on quick review, this seems mostly sane. Though, it might be good
to add some more detail about how the hardware timestamping fits into
the kernel's CLOCK_MONOTONIC time domain.

I just want to make sure this interface isn't abused to jam raw
hardware-domain timestamps into the fence->timestamp, causing the
meaning or time-domain of the fence->timestamp to be unclear or
inconsistent.

It may be useful to add an additional patch to the documentation
around the dma_fence structure to make the timestamp field semantics
more explicit and avoid confusion?

thanks
-john
