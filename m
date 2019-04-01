Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05463C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 03:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A754D2086C
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 03:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CmOwg1eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbfDADOz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:14:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38720 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbfDADOy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 31 Mar 2019 23:14:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so7202089ote.5
        for <linux-media@vger.kernel.org>; Sun, 31 Mar 2019 20:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SgzuMLllQAzMrQKf6AZuFWHBJKbzOjHfsjYCeSliz0=;
        b=CmOwg1eFNp1M75J6Aw9ySXWCIq5YVLypJgJtpJgl+AVLCZ/5G3uA+oPBqvCZn2iy3j
         9CC/MUbrIQbQi1LVnB5l0ED0v4J9j6aHW0JaxM5bAUbxB3A5elPY2PLIUOulrsnxvWvh
         yVmj+JEfqZ8N1oAVqXIpQMx484tUZXw/YZlDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SgzuMLllQAzMrQKf6AZuFWHBJKbzOjHfsjYCeSliz0=;
        b=C7w/koS5MEi9DKEtzb5waOwL280V84zQDSwjAoYhXHXQaZ8cO4bOKQ7QVDX7loT7OV
         LIJITLyhOeONNjtHR6irgPmtpWEUv+JCTzs6vcbbVhwZzD6NaQQf4vzC//ZXmlruaHxr
         kUwcEwhjr1LYmJ+egkkUf0x4Ev6vZj8c9TBuv94j5wgr/EO6ZIcFkud6iv9AFMboqZv9
         uabaiYoAIWetFPpDxoFcytaENRXpMGv+1mua361/e8UrsKCKfgTWQkTUuIcGrvVS/72+
         3C1liOSUx5NWl+HvWv16ardZriT/ApGw2ACB+HiJ590J5C5M6ojpM2+d6p0QVv6z5Ukf
         s+qw==
X-Gm-Message-State: APjAAAU0mfOEVMdDMmTxEqeoOabS0xdqBNxPWKRfoaFXY96DV1HcjyXh
        jCUMV0y9AkLkoy85+GswkM8dp6kNEKM=
X-Google-Smtp-Source: APXvYqyHp4i14XK7pc/86vxDAmBm2OTiJP5ThVCglNcFK7LkZUIRUUQ0EvF0fh5UOgNH+bZEPB5NGQ==
X-Received: by 2002:a9d:6ad1:: with SMTP id m17mr42077296otq.108.1554088493210;
        Sun, 31 Mar 2019 20:14:53 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id r190sm3656987oie.43.2019.03.31.20.14.52
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 20:14:52 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id a6so2673417oie.5
        for <linux-media@vger.kernel.org>; Sun, 31 Mar 2019 20:14:52 -0700 (PDT)
X-Received: by 2002:aca:d8d5:: with SMTP id p204mr11558997oig.26.1554088491520;
 Sun, 31 Mar 2019 20:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com> <20190304192529.14200-11-ezequiel@collabora.com>
In-Reply-To: <20190304192529.14200-11-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 1 Apr 2019 12:14:40 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ApNfr-t-HfWP-6JKJUgMwkr6oXWFgOhUqzj46JO2AS8Q@mail.gmail.com>
Message-ID: <CAAFQd5ApNfr-t-HfWP-6JKJUgMwkr6oXWFgOhUqzj46JO2AS8Q@mail.gmail.com>
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

On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Rework the way controls are registered by the driver,
> so it can support non-standard controls, such as those
> used by stateless codecs.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  .../media/rockchip/vpu/rk3288_vpu_hw.c        |  2 +-
>  .../media/rockchip/vpu/rk3399_vpu_hw.c        |  2 +-
>  .../staging/media/rockchip/vpu/rockchip_vpu.h | 24 ++++++-
>  .../media/rockchip/vpu/rockchip_vpu_common.h  |  1 +
>  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 65 +++++++++++++++++--
>  5 files changed, 84 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> index 056ee017c798..630eded99c68 100644
> --- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> +++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> @@ -112,7 +112,7 @@ const struct rockchip_vpu_variant rk3288_vpu_variant = {
>         .enc_fmts = rk3288_vpu_enc_fmts,
>         .num_enc_fmts = ARRAY_SIZE(rk3288_vpu_enc_fmts),
>         .codec_ops = rk3288_vpu_codec_ops,
> -       .codec = RK_VPU_CODEC_JPEG,
> +       .codec = RK_VPU_JPEG_ENCODER,
>         .vepu_irq = rk3288_vepu_irq,
>         .init = rk3288_vpu_hw_init,
>         .clk_names = {"aclk", "hclk"},
> diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> index 0263584e616d..9eae1e6f1393 100644
> --- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> +++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> @@ -129,7 +129,7 @@ const struct rockchip_vpu_variant rk3399_vpu_variant = {
>         .enc_offset = 0x0,
>         .enc_fmts = rk3399_vpu_enc_fmts,
>         .num_enc_fmts = ARRAY_SIZE(rk3399_vpu_enc_fmts),
> -       .codec = RK_VPU_CODEC_JPEG,
> +       .codec = RK_VPU_JPEG_ENCODER,
>         .codec_ops = rk3399_vpu_codec_ops,
>         .vepu_irq = rk3399_vepu_irq,
>         .vdpu_irq = rk3399_vdpu_irq,
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> index b383c89ecc17..a90fc2dfae99 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> @@ -25,6 +25,7 @@
>
>  #include "rockchip_vpu_hw.h"
>
> +#define ROCKCHIP_VPU_MAX_CTRLS          32
>  #define ROCKCHIP_VPU_MAX_CLOCKS                4
>
>  #define JPEG_MB_DIM                    16
> @@ -34,7 +35,10 @@
>  struct rockchip_vpu_ctx;
>  struct rockchip_vpu_codec_ops;
>
> -#define RK_VPU_CODEC_JPEG BIT(0)
> +#define RK_VPU_JPEG_ENCODER    BIT(0)
> +#define RK_VPU_ENCODERS                0x0000ffff
> +
> +#define RK_VPU_DECODERS                0xffff0000
>
>  /**
>   * struct rockchip_vpu_variant - information about VPU hardware variant
> @@ -79,6 +83,20 @@ enum rockchip_vpu_codec_mode {
>         RK_VPU_MODE_JPEG_ENC,
>  };
>
> +/*
> + * struct rockchip_vpu_ctrl - helper type to declare supported controls
> + * @id:                V4L2 control ID (V4L2_CID_xxx)
> + * @is_std:    boolean to distinguish standard from customs control.
> + * @codec:     codec id this control belong to (RK_VPU_JPEG_ENCODER, etc.)
> + * @cfg:       control configuration
> + */
> +struct rockchip_vpu_ctrl {
> +       unsigned int id;
> +       unsigned int is_std;

Perhaps is_custom would make more sense? I'd expect most, if not all,
of the controls to be standard. (Actually I wonder why the MPEG2
controls are not standard.)

> +       unsigned int codec;
> +       struct v4l2_ctrl_config cfg;
> +};
> +
>  /*
>   * struct rockchip_vpu_mc - media controller data
>   *
> @@ -169,6 +187,8 @@ struct rockchip_vpu_dev {
>   * @dst_fmt:           V4L2 pixel format of active destination format.
>   *
>   * @ctrl_handler:      Control handler used to register controls.
> + * @ctrls:             Array of supported controls.
> + * @num_ctrls:         Number of controls populated in the array.
>   * @jpeg_quality:      User-specified JPEG compression quality.
>   *
>   * @codec_ops:         Set of operations related to codec mode.
> @@ -188,6 +208,8 @@ struct rockchip_vpu_ctx {
>         struct v4l2_pix_format_mplane dst_fmt;
>
>         struct v4l2_ctrl_handler ctrl_handler;
> +       struct v4l2_ctrl *ctrls[ROCKCHIP_VPU_MAX_CTRLS];
> +       unsigned int num_ctrls;
>         int jpeg_quality;
>
>         const struct rockchip_vpu_codec_ops *codec_ops;
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> index 7e5fce3bf215..70b8ac1c7503 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> @@ -23,6 +23,7 @@ extern const struct v4l2_ioctl_ops rockchip_vpu_dec_ioctl_ops;
>  extern const struct vb2_ops rockchip_vpu_enc_queue_ops;
>  extern const struct vb2_ops rockchip_vpu_dec_queue_ops;
>
> +void *rockchip_vpu_find_control_data(struct rockchip_vpu_ctx *ctx, unsigned int id);
>  void rockchip_vpu_enc_reset_src_fmt(struct rockchip_vpu_dev *vpu,
>                                     struct rockchip_vpu_ctx *ctx);
>  void rockchip_vpu_enc_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> index 27a9da86f1d0..f5c941f34c90 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> @@ -276,26 +276,77 @@ static int rockchip_vpu_s_ctrl(struct v4l2_ctrl *ctrl)
>         return 0;
>  }
>
> +void *rockchip_vpu_find_control_data(struct rockchip_vpu_ctx *ctx, unsigned int id)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < ctx->num_ctrls; i++) {
> +               if (!ctx->ctrls[i])
> +                       continue;
> +               if (ctx->ctrls[i]->id == id)
> +                       return ctx->ctrls[i]->p_cur.p;
> +       }
> +       return NULL;
> +}
> +

Couldn't we just use v4l2_ctrl_find() to get the control from the
handler and then read the value from it?

>  static const struct v4l2_ctrl_ops rockchip_vpu_ctrl_ops = {
>         .s_ctrl = rockchip_vpu_s_ctrl,
>  };
>
> +static struct rockchip_vpu_ctrl controls[] = {
> +       {
> +               .id = V4L2_CID_JPEG_COMPRESSION_QUALITY,
> +               .codec = RK_VPU_JPEG_ENCODER,
> +               .is_std = 1,
> +               .cfg = {
> +                       .min = 5,
> +                       .max = 100,
> +                       .step = 1,
> +                       .def = 50,
> +               },
> +       },
> +};
> +
>  static int rockchip_vpu_ctrls_setup(struct rockchip_vpu_dev *vpu,
>                                     struct rockchip_vpu_ctx *ctx)
>  {
> -       v4l2_ctrl_handler_init(&ctx->ctrl_handler, 1);
> -       if (vpu->variant->codec & RK_VPU_CODEC_JPEG) {
> -               v4l2_ctrl_new_std(&ctx->ctrl_handler, &rockchip_vpu_ctrl_ops,
> -                                 V4L2_CID_JPEG_COMPRESSION_QUALITY,
> -                                 5, 100, 1, 50);
> +       int j, i, num_ctrls = ARRAY_SIZE(controls);
> +       int allowed_codecs;
> +
> +       if (ctx->is_enc)
> +               allowed_codecs = vpu->variant->codec & RK_VPU_ENCODERS;
> +       else
> +               allowed_codecs = vpu->variant->codec & RK_VPU_DECODERS;
> +
> +       if (num_ctrls > ARRAY_SIZE(ctx->ctrls)) {
> +               vpu_err("context control array not large enough\n");
> +               return -EINVAL;
> +       }
> +
> +       v4l2_ctrl_handler_init(&ctx->ctrl_handler, num_ctrls);
> +
> +       for (i = 0, j = 0; i < num_ctrls; i++) {
> +               if (!(allowed_codecs & controls[i].codec))
> +                       continue;
> +               if (controls[i].is_std) {
> +                       v4l2_ctrl_new_std(&ctx->ctrl_handler, &rockchip_vpu_ctrl_ops,
> +                                         controls[i].id, controls[i].cfg.min, controls[i].cfg.max,
> +                                         controls[i].cfg.step, controls[i].cfg.def);

No need to save the control pointer to ctx->ctrls[]? (Actually, with
my comment above, we wouldn't need ctx->ctrls[] at all.)

> +               } else {
> +                       controls[i].cfg.id = controls[i].id;
> +                       ctx->ctrls[j++] = v4l2_ctrl_new_custom(&ctx->ctrl_handler,
> +                                                              &controls[i].cfg, NULL);
> +               }
> +
>                 if (ctx->ctrl_handler.error) {
> -                       vpu_err("Adding JPEG control failed %d\n",
> +                       vpu_err("Adding control (%d) failed %d\n",
> +                               controls[i].id,
>                                 ctx->ctrl_handler.error);
>                         v4l2_ctrl_handler_free(&ctx->ctrl_handler);
>                         return ctx->ctrl_handler.error;
>                 }
>         }
> -
> +       ctx->num_ctrls = j;
>         return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
>  }

Best regards,
Tomasz
