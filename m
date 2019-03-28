Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84754C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 06:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464CB2173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 06:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KB9m8e+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfC1GQE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:16:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46936 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfC1GQE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 02:16:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id s24so7777925otk.13
        for <linux-media@vger.kernel.org>; Wed, 27 Mar 2019 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zO1HkLsganeYgMN8G5PM1e9kz9PLMRRDPRt+Yrs5dwk=;
        b=KB9m8e+sycWS4uk+OPZhwmwmskXg2T174b8JiSW4NIpoPOk/Ua5S4XGAKHUn2zxfrx
         muPiAgMLbP9LaTWYDPXtlOfVKxf8rQ63q5aw+5zFO1XSdkW/ci/+4TjtuyfDBURG/Vna
         XVZrXNXDNylQ/uTy+9k3J37E4zgzUqcb6PMJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zO1HkLsganeYgMN8G5PM1e9kz9PLMRRDPRt+Yrs5dwk=;
        b=bjJNvBFUawOp3apJL7TCnp/8oh9TDiRXH8o7m35BhP2ubs0US+gyYKH5Z29bPCMdzw
         q+e4kxK54/e+Ibc8pQHFcX+h/7y+lkSf5J8pVfzB6baOFxgrCI8CkbJDKcJHK1+7gUPH
         eFl3QrHubMbpGfothyh3KO05iP7ir/oLYRYXfxge0OJ0Pf01MKpeBlIkWm+8LjfHOyBJ
         LB7Cn0QPVjO+wlD+DBjDCPeQVTJe6K2L5hXGAkkI4Z/yt8PKuVeNrITZ/01EoCy8+AHI
         G6CvDMU1O9lRSfoHPJqE9q3Mk2sEAEEGdiK9+lhSc2UmLu+gJPcXVYZUEBdyXxUY3wfs
         tPTQ==
X-Gm-Message-State: APjAAAV2+XEFVocdE23saSfYu4NVF5qkhLvkeBeFLLmk67T6btIw8gcK
        ftjSONF+ycATJVtk/HeaAWm+aCUUJ5I=
X-Google-Smtp-Source: APXvYqyqeBIbR4b7FWH8PgXVr285vOBXDolrvQlsE97D2FeZ8HpRbt4M3UqHNIKGsfkZ727BTAwtOA==
X-Received: by 2002:a05:6830:1345:: with SMTP id r5mr13529954otq.256.1553753762979;
        Wed, 27 Mar 2019 23:16:02 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id e186sm9598964oia.44.2019.03.27.23.16.00
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 23:16:00 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id x188so14872580oia.13
        for <linux-media@vger.kernel.org>; Wed, 27 Mar 2019 23:16:00 -0700 (PDT)
X-Received: by 2002:aca:edc7:: with SMTP id l190mr22495812oih.92.1553753759547;
 Wed, 27 Mar 2019 23:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com> <20190304192529.14200-7-ezequiel@collabora.com>
In-Reply-To: <20190304192529.14200-7-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 28 Mar 2019 15:15:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DjVDhFMc=WpnvF61yBcPm=BUQhVtBWSyphkkM8QubFzA@mail.gmail.com>
Message-ID: <CAAFQd5DjVDhFMc=WpnvF61yBcPm=BUQhVtBWSyphkkM8QubFzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] rockchip/vpu: Cleanup JPEG bounce buffer management
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ezequiel,

On Tue, Mar 5, 2019 at 4:26 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> In order to make the code more generic, introduce a pair of start/stop
> codec operations, and use them to allocate and release the JPEG bounce
> buffer.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  .../media/rockchip/vpu/rk3288_vpu_hw.c        |  2 ++
>  .../rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c     |  4 +--
>  .../media/rockchip/vpu/rk3399_vpu_hw.c        |  2 ++
>  .../rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c     |  4 +--
>  .../staging/media/rockchip/vpu/rockchip_vpu.h | 12 ++++----
>  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 10 +++++--
>  .../media/rockchip/vpu/rockchip_vpu_enc.c     | 23 +++++----------
>  .../media/rockchip/vpu/rockchip_vpu_hw.h      | 28 +++++++++++++++++++
>  .../media/rockchip/vpu/rockchip_vpu_jpeg.c    | 25 +++++++++++++++++
>  9 files changed, 81 insertions(+), 29 deletions(-)
>

Thanks for the series! Really sorry for late reply...

[snip]

> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> index 1ec2be483e27..76ee24abc141 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> @@ -124,10 +124,7 @@ struct rockchip_vpu_dev {
>   * @jpeg_quality:      User-specified JPEG compression quality.
>   *
>   * @codec_ops:         Set of operations related to codec mode.
> - *
> - * @bounce_dma_addr:   Bounce buffer bus address.
> - * @bounce_buf:                Bounce buffer pointer.
> - * @bounce_size:       Bounce buffer size.
> + * @jpeg_enc_ctx:      JPEG-encoding context.
>   */
>  struct rockchip_vpu_ctx {
>         struct rockchip_vpu_dev *dev;
> @@ -146,9 +143,10 @@ struct rockchip_vpu_ctx {
>
>         const struct rockchip_vpu_codec_ops *codec_ops;
>
> -       dma_addr_t bounce_dma_addr;
> -       void *bounce_buf;
> -       size_t bounce_size;
> +       /* Specific for particular codec modes. */
> +       union {
> +               struct rockchip_vpu_jpeg_enc_hw_ctx jpeg_enc_ctx;
> +       };

nit: Would it perhaps make it a bit cleaner to call the union "ctx"?
Then we wouldn't need to repeat "_ctx" in every field.

>  };
>
>  /**
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> index 5647b0bdac20..1a6dd36c71ab 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> @@ -64,10 +64,16 @@ static void rockchip_vpu_job_finish(struct rockchip_vpu_dev *vpu,
>         avail_size = vb2_plane_size(&dst->vb2_buf, 0) -
>                      ctx->vpu_dst_fmt->header_size;
>         if (bytesused <= avail_size) {
> -               if (ctx->bounce_buf) {
> +               /*
> +                * This works while JPEG is the only encoder this driver
> +                * supports. We will have to abstract this step, or get
> +                * rid of the bounce buffer before we can support
> +                * encoding other codecs.

Hmm, why wouldn't it work for other encoders, which shouldn't require
a bounce buffer?

> +                */
> +               if (ctx->jpeg_enc_ctx.bounce_buffer.cpu) {
>                         memcpy(vb2_plane_vaddr(&dst->vb2_buf, 0) +
>                                ctx->vpu_dst_fmt->header_size,
> -                              ctx->bounce_buf, bytesused);
> +                              ctx->jpeg_enc_ctx.bounce_buffer.cpu, bytesused);
>                 }
>                 dst->vb2_buf.planes[0].bytesused =
>                         ctx->vpu_dst_fmt->header_size + bytesused;

[snip]

>  /**
>   * struct rockchip_vpu_codec_ops - codec mode specific operations
>   *
> + * @start:     If needed, can be used for initialization.
> + *             Optional and called from process context.
> + * @stop:      If needed, can be used to undo the .start phase.
> + *             Optional and called from process context.

nit: Perhaps .init and .exit could reflect better what these ops do?

Best regards,
Tomasz
