Return-Path: <SRS0=KMyM=EB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFB1C5517A
	for <linux-media@archiver.kernel.org>; Mon, 26 Oct 2020 20:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACC3221FC
	for <linux-media@archiver.kernel.org>; Mon, 26 Oct 2020 20:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKECFo7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgJZU0Y (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:26:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35451 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgJZU0X (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Oct 2020 16:26:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id h22so2722802wmb.0;
        Mon, 26 Oct 2020 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wG7L6k5elcsFTdFccbEBRu2CRJAFTSnK/nWIQ/2axqk=;
        b=BKECFo7tWE7Uuvp/xZqDhJgyFDbg2DxsWPatrwsbVJunmqPCOfdlzPpJr7PFvAU59T
         1l8TW/dvZDoT/EMS5HEVm0w/hmlxD0X25Y7Fb2GcdVKHabbnUyzgpdfW9U0NrY+IUDVo
         f4C2Mx0Bo1kRbDPSqShjfpQgRPyw/hPtUbujYoelq6NkSpfi2jodFHjlWK+2pCQrRLPz
         DIURbjgERLBPaSTEGh5Dv/YLP7Cv7wvoIUnBrLClrehtMBBQWY8BXx3a/uaDhYntUzwd
         VS5Fe43ZVtd4YfsGE6o+wuUpXrw2duyXRB5va0KqPn4cM/uw2SA4Ptx5P/jtKAe9Fs4j
         EFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wG7L6k5elcsFTdFccbEBRu2CRJAFTSnK/nWIQ/2axqk=;
        b=Mq1Ypg4nh6R/uvdQavlzh2lANzW4BvRBzVwjzovnyjjHqJyHvhTNFAc7DxBRXJU7Zn
         rzrMScDpM98NOc/ibRv7pw04QnohoN9bf6Zp8jDpLCq50OL4o8PyghIu5mhNh4RDl5fG
         g/7oaZuRYNNIuZmZAXwF9eAYdY9lks55+IuRVyKxmkDv6oC1wbQIOG0uzC+G8c0jlDBS
         JhoxBOAz3hy+moeiJwkiHbhRSUpuwy7AM7NgIr9oRLt4uitZ9oQYshG/GyG/fgFm67la
         /WNUpPNU2vBGtNBAyxen9aA9hz+qXRkfKcB1hiFZAGWJpyOWxCVF0LZ3kIBukKSS3MWb
         vXsw==
X-Gm-Message-State: AOAM531b3opdEPhEBOYlzOQz13VzvFtUktqWs8UrFRWF8V/Z5r+pQPVb
        G5+voL86rwjuTi3jvyHhoj9USisn9nLz+wnjEGc=
X-Google-Smtp-Source: ABdhPJxH0XD7Qr8WWOT4U+A2t3Ki9NVyS6yGQrbNVPDFqX00bz0auWEM9RMfcgNQn4lKil2Ta4Z7rKh8hoZnQULvjyw=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr18103079wmb.56.1603743981925;
 Mon, 26 Oct 2020 13:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201026181242.76bf3b6gx2yx7hr7@adolin>
In-Reply-To: <20201026181242.76bf3b6gx2yx7hr7@adolin>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Oct 2020 16:26:10 -0400
Message-ID: <CADnq5_NxQwwaxO1KJ5Fnmv_OGiFYyD0xZVCzkbOLGPjFCkECwQ@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] drm/amdgpu: use true and false for bool initialisations
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        outreachy-kernel@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Oct 26, 2020 at 2:14 PM Sumera Priyadarsini
<sylphrenadin@gmail.com> wrote:
>
> Bool initialisation should use 'true' and 'false' values instead of 0
> and 1.
>
> Modify amdgpu_amdkfd_gpuvm.c to initialise variable is_imported
> to false instead of 0.
>
> Issue found with Coccinelle.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 64d4b5ff95d6..ba4bd06bfcc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1288,7 +1288,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>         struct ttm_validate_buffer *bo_list_entry;
>         unsigned int mapped_to_gpu_memory;
>         int ret;
> -       bool is_imported = 0;
> +       bool is_imported = false;
>
>         mutex_lock(&mem->lock);
>         mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
