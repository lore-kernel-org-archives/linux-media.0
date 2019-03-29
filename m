Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B879C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 03:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFB621850
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 03:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RLkEszvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfC2DWB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:22:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41181 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfC2DWB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 23:22:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id 64so751551otb.8
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 20:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qx85BhNBs4lgpq6jan8z+YOxpRrKxwpWVyXm5M3OW0=;
        b=RLkEszvR5Ak/JXezN2fuPlBuXJ0pASf28/tHsyZnKGJdeo2IkzHYG34WXwui9eYeq6
         qBg9GKuMT9FxvzABa8CfkfahKMltqfzd7Xp18NJcMcLcpuWD4KKaU4Ve2Vm7R8SnkOkP
         IaBtC478fgYQN+R9jda2j87ymW/0SxwBw8gTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qx85BhNBs4lgpq6jan8z+YOxpRrKxwpWVyXm5M3OW0=;
        b=kyuAM9VOhrv/aJyHskVUllA/0P7qo/E4Bd3cG2W/cjk5HcKLQpSSlz5lWwu9WooQs1
         qOdLmHFaNw4V2R1Az9gzX72nZIHgTuvzU2MqTqhPff319nEYff2DUT8nMzLI4kunLEWX
         9d6WintU4zEqtr6CnrblElERTwm3bZOw6nPY5rBJGXry3ANiHM4rWciZfPW77KhHtKYE
         04zhls8a60WHK96S/1dfqEKIkkESYtHc5T0KNS9JpR/ei0l/wMPKe856xU7DoNtB4r0b
         9IjKBsu0CpCctkh9JORjiUTxKPXQz6xM8I06irVektEBZ2a4QcoAjU1pJrMkoVGIPy0j
         D1mA==
X-Gm-Message-State: APjAAAWCuhDYn+kxuoZjeEv4vhEDCrpDjMAMQe8cUiycCsG0BWoWT1bB
        +OdynNacWhsO1DdNHkbkieyzeh90+MHsFw==
X-Google-Smtp-Source: APXvYqxS7drMW0MU3HaPrYammCIE270yyTrnfPILlQwlkAswxSCh3fq2hDlIEpS9xmT5UXe8xKbjhg==
X-Received: by 2002:a9d:22a4:: with SMTP id y33mr29994543ota.218.1553829720141;
        Thu, 28 Mar 2019 20:22:00 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id k25sm322038otj.72.2019.03.28.20.21.59
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:21:59 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id j132so609710oib.2
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 20:21:59 -0700 (PDT)
X-Received: by 2002:aca:4b03:: with SMTP id y3mr2214046oia.21.1553829718532;
 Thu, 28 Mar 2019 20:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com>
 <20190304192529.14200-7-ezequiel@collabora.com> <CAAFQd5DjVDhFMc=WpnvF61yBcPm=BUQhVtBWSyphkkM8QubFzA@mail.gmail.com>
 <cb9d6645edaf8335f2cdd3094830e80b10ff051f.camel@collabora.com>
In-Reply-To: <cb9d6645edaf8335f2cdd3094830e80b10ff051f.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 29 Mar 2019 12:21:47 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Dd29Jmv7dgBrkX8DLN9+MJ5cbpNnK4rU9K+upxer7RfQ@mail.gmail.com>
Message-ID: <CAAFQd5Dd29Jmv7dgBrkX8DLN9+MJ5cbpNnK4rU9K+upxer7RfQ@mail.gmail.com>
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

On Fri, Mar 29, 2019 at 3:30 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> On Thu, 2019-03-28 at 15:15 +0900, Tomasz Figa wrote:
> > Hi Ezequiel,
> >
> > On Tue, Mar 5, 2019 at 4:26 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > In order to make the code more generic, introduce a pair of start/stop
> > > codec operations, and use them to allocate and release the JPEG bounce
> > > buffer.
> > >
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > ---
> > >  .../media/rockchip/vpu/rk3288_vpu_hw.c        |  2 ++
> > >  .../rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c     |  4 +--
> > >  .../media/rockchip/vpu/rk3399_vpu_hw.c        |  2 ++
> > >  .../rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c     |  4 +--
> > >  .../staging/media/rockchip/vpu/rockchip_vpu.h | 12 ++++----
> > >  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 10 +++++--
> > >  .../media/rockchip/vpu/rockchip_vpu_enc.c     | 23 +++++----------
> > >  .../media/rockchip/vpu/rockchip_vpu_hw.h      | 28 +++++++++++++++++++
> > >  .../media/rockchip/vpu/rockchip_vpu_jpeg.c    | 25 +++++++++++++++++
> > >  9 files changed, 81 insertions(+), 29 deletions(-)
> > >
> >
> > Thanks for the series! Really sorry for late reply...
> >
> > [snip]
> >
> > > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > > index 1ec2be483e27..76ee24abc141 100644
> > > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > > @@ -124,10 +124,7 @@ struct rockchip_vpu_dev {
> > >   * @jpeg_quality:      User-specified JPEG compression quality.
> > >   *
> > >   * @codec_ops:         Set of operations related to codec mode.
> > > - *
> > > - * @bounce_dma_addr:   Bounce buffer bus address.
> > > - * @bounce_buf:                Bounce buffer pointer.
> > > - * @bounce_size:       Bounce buffer size.
> > > + * @jpeg_enc_ctx:      JPEG-encoding context.
> > >   */
> > >  struct rockchip_vpu_ctx {
> > >         struct rockchip_vpu_dev *dev;
> > > @@ -146,9 +143,10 @@ struct rockchip_vpu_ctx {
> > >
> > >         const struct rockchip_vpu_codec_ops *codec_ops;
> > >
> > > -       dma_addr_t bounce_dma_addr;
> > > -       void *bounce_buf;
> > > -       size_t bounce_size;
> > > +       /* Specific for particular codec modes. */
> > > +       union {
> > > +               struct rockchip_vpu_jpeg_enc_hw_ctx jpeg_enc_ctx;
> > > +       };
> >
> > nit: Would it perhaps make it a bit cleaner to call the union "ctx"?
> > Then we wouldn't need to repeat "_ctx" in every field.
> >
>
> Well, the struct is already rockchip_vpu_ctx, so access would look like:
>
>    ctx->ctx.jpeg_enc, ctx->ctx.mpeg2_dec
>
> Perhaps we can just drop the _ctx, and so:
>
>    ctx->jpeg_enc, ctx->mpeg2_dec
>

Even better, thanks.

> > >  };
> > >
> > >  /**
> > > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > > index 5647b0bdac20..1a6dd36c71ab 100644
> > > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > > @@ -64,10 +64,16 @@ static void rockchip_vpu_job_finish(struct rockchip_vpu_dev *vpu,
> > >         avail_size = vb2_plane_size(&dst->vb2_buf, 0) -
> > >                      ctx->vpu_dst_fmt->header_size;
> > >         if (bytesused <= avail_size) {
> > > -               if (ctx->bounce_buf) {
> > > +               /*
> > > +                * This works while JPEG is the only encoder this driver
> > > +                * supports. We will have to abstract this step, or get
> > > +                * rid of the bounce buffer before we can support
> > > +                * encoding other codecs.
> >
> > Hmm, why wouldn't it work for other encoders, which shouldn't require
> > a bounce buffer?
> >
>
> Well, I had a TODO item to remove the bounce buffer for JPEG.
>
> IIRC, the ChromeOS VPU driver doesn't have any bounce buffer,
> so I was under the impression we wouldn't need one.
>
> However, we have yet to discuss the encoder implementation.
> We might decide to produce the headers for some video coded format,
> in which case we might need a bounce buffer.

We don't really need a bounce buffer to handle headers, we can do a
memmove() instead, as we did for the VP8 encoder [1]. However, it was
more like a loopback - the driver would just copy the header that the
userspace set through a control, so we decided to drop it and move
completely to the userspace [2] for H.264.

[1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/5bc4e95afddd1300368d0552b228824252bd789f/drivers/media/platform/rk3288-vpu/rk3288_vpu_hw_vp8e.c#52
[2] https://chromium.googlesource.com/chromiumos/third_party/libv4lplugins/+/5e6034258146af6be973fb6a5bb6b9d6e7489437/libv4l-rockchip_v2/libvepu/h264e/h264e.c#591

>
> In any case, this is just a comment to reflect that this piece
> of code is just temporary.
>

My point is that the comment suggests that other encoders would be
affected by this, which I don't believe is true, because the code
explicitly checks if the bounce buffer pointer is non-NULL and for
other encoders it would be NULL.

/*
 * The bounce buffer is only for the JPEG encoder.
 * TODO: Rework the JPEG encoder to eliminate the need
 * for a bounce buffer.
 */

Best regards,
Tomasz
