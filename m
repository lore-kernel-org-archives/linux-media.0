Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1AEC10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 04:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1E620825
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 04:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GWuAxtwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfDOEHs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 00:07:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33667 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfDOEHs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 00:07:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id e5so12627543oii.0
        for <linux-media@vger.kernel.org>; Sun, 14 Apr 2019 21:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzgi4/F9tNAGhDN4xQRXqDMALgWnD45WlDLQ8mfxxvg=;
        b=GWuAxtwvvX+OBASJDcXUJc9tUicNeHTURlSJIEg1fvDPHuA8WBPKQX2WrxAV0xICIw
         dR/psu64WEjhY7JOwCbzZsh2FM+G1u0oG/iWyvuqraXbshAl2ZYV3EYlBoUpTtxpxBZF
         fuHtfaAFD5kgXL6jXN++LoWHPMjW3LfYZqsdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzgi4/F9tNAGhDN4xQRXqDMALgWnD45WlDLQ8mfxxvg=;
        b=cruaDjDnQQtpSDBnwuEY6/KsEr3emMaXCZCiqEAGkS41wAY2azUVK2+4VIzWJ8vPV+
         47PYn6qM5ciI52g4iNEI5IWXOmx6efWGPiCU4ccqguSEcM87hmmLqxZaQpgxwsmnx2Tl
         ubLhBXYdq2Za0vctX7qkbGGA36sSctv4LXNBsOSQNDUmtYg9N0RL1vtXtjpkhfVYSx2H
         ItKOZYcvAc2lzqDcAGoqYK/4TeP0lXX5kkGzUwElfjhS4WRdQgIMu82mz4vRpqXHUYav
         HXz/+5tCgkjhK6+1s7OafhOpN6CedT6eWRS1YnRYrWVD60KSN19tIEKBykBxFT+ZcQ8G
         oMlQ==
X-Gm-Message-State: APjAAAV0QekImTi3WwOE2zh8RF1pVaaBcuenq2BgRJ/5/RTrVLMWtyuK
        xSETPZ1mb/kRmjlVrCoKKd7M6qqoUZM=
X-Google-Smtp-Source: APXvYqytd8sJG6N23kGBS+fUr4Ikz/OyJw+c4Q0lkMxP4tL6Kp2kPduE+SxUl7KbAWE/CeWFuaBdsg==
X-Received: by 2002:aca:3504:: with SMTP id c4mr17763617oia.74.1555301267190;
        Sun, 14 Apr 2019 21:07:47 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id h8sm18722323oti.64.2019.04.14.21.07.45
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 21:07:46 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id e5so12627491oii.0
        for <linux-media@vger.kernel.org>; Sun, 14 Apr 2019 21:07:45 -0700 (PDT)
X-Received: by 2002:aca:d8d5:: with SMTP id p204mr18693766oig.26.1555301265270;
 Sun, 14 Apr 2019 21:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com>
 <20190304192529.14200-11-ezequiel@collabora.com> <CAAFQd5ApNfr-t-HfWP-6JKJUgMwkr6oXWFgOhUqzj46JO2AS8Q@mail.gmail.com>
 <a4e3c32c7b6357803122a304fe70ac8a3f829c58.camel@collabora.com>
In-Reply-To: <a4e3c32c7b6357803122a304fe70ac8a3f829c58.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 15 Apr 2019 13:07:34 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CcJ=hAwLn7WxBO86MyLG7UM_2wqTs6qtNB2cgrsa9Guw@mail.gmail.com>
Message-ID: <CAAFQd5CcJ=hAwLn7WxBO86MyLG7UM_2wqTs6qtNB2cgrsa9Guw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] rockchip/vpu: Add support for non-standard controls
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

On Sat, Apr 13, 2019 at 4:25 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> On Mon, 2019-04-01 at 12:14 +0900, Tomasz Figa wrote:
> > On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > Rework the way controls are registered by the driver,
> > > so it can support non-standard controls, such as those
> > > used by stateless codecs.
> > >
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > ---
> > >  .../media/rockchip/vpu/rk3288_vpu_hw.c        |  2 +-
> > >  .../media/rockchip/vpu/rk3399_vpu_hw.c        |  2 +-
> > >  .../staging/media/rockchip/vpu/rockchip_vpu.h | 24 ++++++-
> > >  .../media/rockchip/vpu/rockchip_vpu_common.h  |  1 +
> > >  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 65 +++++++++++++++++--
> > >  5 files changed, 84 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> > > index 056ee017c798..630eded99c68 100644
> > > --- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> > > +++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> > > @@ -112,7 +112,7 @@ const struct rockchip_vpu_variant rk3288_vpu_variant = {
> > >         .enc_fmts = rk3288_vpu_enc_fmts,
> > >         .num_enc_fmts = ARRAY_SIZE(rk3288_vpu_enc_fmts),
> > >         .codec_ops = rk3288_vpu_codec_ops,
> > > -       .codec = RK_VPU_CODEC_JPEG,
> > > +       .codec = RK_VPU_JPEG_ENCODER,
> > >         .vepu_irq = rk3288_vepu_irq,
> > >         .init = rk3288_vpu_hw_init,
> > >         .clk_names = {"aclk", "hclk"},
> > > diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> > > index 0263584e616d..9eae1e6f1393 100644
> > > --- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> > > +++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> > > @@ -129,7 +129,7 @@ const struct rockchip_vpu_variant rk3399_vpu_variant = {
> > >         .enc_offset = 0x0,
> > >         .enc_fmts = rk3399_vpu_enc_fmts,
> > >         .num_enc_fmts = ARRAY_SIZE(rk3399_vpu_enc_fmts),
> > > -       .codec = RK_VPU_CODEC_JPEG,
> > > +       .codec = RK_VPU_JPEG_ENCODER,
> > >         .codec_ops = rk3399_vpu_codec_ops,
> > >         .vepu_irq = rk3399_vepu_irq,
> > >         .vdpu_irq = rk3399_vdpu_irq,
> > > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > > index b383c89ecc17..a90fc2dfae99 100644
> > > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > > @@ -25,6 +25,7 @@
> > >
> > >  #include "rockchip_vpu_hw.h"
> > >
> > > +#define ROCKCHIP_VPU_MAX_CTRLS          32
> > >  #define ROCKCHIP_VPU_MAX_CLOCKS                4
> > >
> > >  #define JPEG_MB_DIM                    16
> > > @@ -34,7 +35,10 @@
> > >  struct rockchip_vpu_ctx;
> > >  struct rockchip_vpu_codec_ops;
> > >
> > > -#define RK_VPU_CODEC_JPEG BIT(0)
> > > +#define RK_VPU_JPEG_ENCODER    BIT(0)
> > > +#define RK_VPU_ENCODERS                0x0000ffff
> > > +
> > > +#define RK_VPU_DECODERS                0xffff0000
> > >
> > >  /**
> > >   * struct rockchip_vpu_variant - information about VPU hardware variant
> > > @@ -79,6 +83,20 @@ enum rockchip_vpu_codec_mode {
> > >         RK_VPU_MODE_JPEG_ENC,
> > >  };
> > >
> > > +/*
> > > + * struct rockchip_vpu_ctrl - helper type to declare supported controls
> > > + * @id:                V4L2 control ID (V4L2_CID_xxx)
> > > + * @is_std:    boolean to distinguish standard from customs control.
> > > + * @codec:     codec id this control belong to (RK_VPU_JPEG_ENCODER, etc.)
> > > + * @cfg:       control configuration
> > > + */
> > > +struct rockchip_vpu_ctrl {
> > > +       unsigned int id;
> > > +       unsigned int is_std;
> >
> > Perhaps is_custom would make more sense? I'd expect most, if not all,
> > of the controls to be standard. (Actually I wonder why the MPEG2
> > controls are not standard.)
> >
>
> Maybe is_std is misleading. The idea was just to distinguish
> controls that can be registered with v4l2_ctrl_new_std,
> from those that need v4l2_ctrl_new_custom, not because the control
> is non-standard, but because it takes a custom v4l2_ctrl_config.
>
> Maybe the is_std flag can be completely removed, and instead
> use cfg.elem_size to distinguish the two type of controls.
>

I see. Then I guess the flag makes sense, but perhaps it could be
inverted and renamed to "has_custom_cfg"?

Best regards,
Tomasz
