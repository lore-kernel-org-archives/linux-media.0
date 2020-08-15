Return-Path: <SRS0=xPRW=BZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B88C433DF
	for <linux-media@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82902053B
	for <linux-media@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="Jh/QcNG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgHOVzG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgHOVwZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F431C061369
        for <linux-media@vger.kernel.org>; Fri, 14 Aug 2020 20:04:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so8253302eds.2
        for <linux-media@vger.kernel.org>; Fri, 14 Aug 2020 20:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQxrH2bO/NJ0aDrFkDf6zxmw410k4uG/ojP6CEQt11o=;
        b=Jh/QcNG7MiIoQ6ctk5ILvIkYVGMh122DgVSCyHzYIZt3SpgGkZz7s/L0PjKzHsKlfK
         atKdwKpVg2uzOp27aW83yzPghBb1xUNOMPpHApJ3vNjsplD7je7tXOV/MRl5ndGVAMxV
         s9yPO7WM5x799+WhYMh+xBCDFBUE2/oKC3JSHcP3R/S7MZuiR6MgSTBt6xsMVerVCZ0O
         uEt0VeW/pE/NoiVPdLJVUwDIXdx7TVMpbKGvgdr4sz+fvumqlchYD25tdOCIeDc/jadl
         DG4qn3mPvHo8sCAWzCFEJrUV8ZMT5T0Z6hh/XJQ01TnFuB5FmBHEHcMpsQF0qaRLpzJR
         AmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQxrH2bO/NJ0aDrFkDf6zxmw410k4uG/ojP6CEQt11o=;
        b=EksHxQh1rY8XE5rIbVQY5XeN7ukHGsu5Xs6eIuyk/9DQehaDiAp50zMn9a4JT5Yi3O
         1c6TRksbPbwhcQOaqmIC36VOAzehVVZm0D5/CR71TAqFW4WdjSNq0zptHA2IZQ0GpTia
         c9VvMsULvyhgl9gIdc8ijjscZwNZFcwX68UGS+10rPtaoEMWwJSVwNCWeb5I4n99SkWK
         I0hgB5ysl2W0GbEfHrrPAsN3kb1i30OcnTH2/0KKeUc/KaGei3N+Dd0vwevCv9WUltAZ
         yYJhulblPm595xh074HW8NU1L05WIVN65t+V9QlFnf2naZYlb1MJHXsDP2Ub3Aj9y473
         mItw==
X-Gm-Message-State: AOAM530IUiQ6kwiVpqb6G26BM3NH6M/+fkfrADXNJiN+5sq4aUBwVmvv
        mVPxSbl1uCC0OolYHqyQAvEZHumZFiMqbDD7463vGQ==
X-Google-Smtp-Source: ABdhPJzu3orbYkICYstELHkjjr8NzSTEFqXWN0XO7KRL3CgSHw/6s/CVfJ13Yf61PifEZfxCSO0nwdcPtdSXnCqd7Uk=
X-Received: by 2002:a05:6402:1587:: with SMTP id c7mr5269572edv.213.1597460679796;
 Fri, 14 Aug 2020 20:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200814142516.148934-1-ezequiel@collabora.com> <CALAqxLWytSnPugPH2Ux5=C_bzC0DLGKQyB+Szcp4LOVfhKPFqg@mail.gmail.com>
In-Reply-To: <CALAqxLWytSnPugPH2Ux5=C_bzC0DLGKQyB+Szcp4LOVfhKPFqg@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 15 Aug 2020 00:04:28 -0300
Message-ID: <CAAEAJfCEkhD8jcsmE4R+G7nv+8+N0+u1cUxW_ivUZVSxm_eHAg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heap-helpers: Set dma-buf exporter name
To:     John Stultz <john.stultz@linaro.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F . Davis" <afd@ti.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laura Abbott <labbott@kernel.org>, kernel@collabora.com,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 14 Aug 2020 at 23:20, John Stultz <john.stultz@linaro.org> wrote:
>
> On Fri, Aug 14, 2020 at 7:25 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> >
> > Currently the heap helper uses DEFINE_DMA_BUF_EXPORT_INFO,
> > which uses KBUILD_MODNAME for the dma_buf_export_info.exp_name.
> >
> > This effectively makes all dma-bufs exported by the heap
> > helper as coming from "heap-helpers", instead of the actual heap name
> > (cma, system, etc).
> >
> > Fix this by adding a dma-heap name getter, and then setting
> > dma_buf_export_info.exp_name.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>
> Untested, but looks sane to me.
>
> Acked-by: John Stultz <john.stultz@linaro.org>
>

Cool.

> On a slightly related note, I'm starting to regret the current
> heap-helpers approach (Andrew probably gets an "I told you so" there
> :). While it avoids a lot of duplication, it's really an all or
> nothing approach, and doesn't really compare well to other drm style
> helper functions.  I may eventually try to break the system and cma
> implementations out of the helper code and try to consider a different
> approach to avoid the duplication.
>

Fully agreed :-) It definitely looks too rigid right now.

Cheers,
Ezequiel
