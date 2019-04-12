Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CFBC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 19:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F9C20850
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 19:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDLTZw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:25:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36020 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLTZw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 15:25:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 8788726A02A
Message-ID: <a4e3c32c7b6357803122a304fe70ac8a3f829c58.camel@collabora.com>
Subject: Re: [PATCH v2 10/11] rockchip/vpu: Add support for non-standard
 controls
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
Date:   Fri, 12 Apr 2019 16:25:40 -0300
In-Reply-To: <CAAFQd5ApNfr-t-HfWP-6JKJUgMwkr6oXWFgOhUqzj46JO2AS8Q@mail.gmail.com>
References: <20190304192529.14200-1-ezequiel@collabora.com>
         <20190304192529.14200-11-ezequiel@collabora.com>
         <CAAFQd5ApNfr-t-HfWP-6JKJUgMwkr6oXWFgOhUqzj46JO2AS8Q@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 2019-04-01 at 12:14 +0900, Tomasz Figa wrote:
> On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > Rework the way controls are registered by the driver,
> > so it can support non-standard controls, such as those
> > used by stateless codecs.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  .../media/rockchip/vpu/rk3288_vpu_hw.c        |  2 +-
> >  .../media/rockchip/vpu/rk3399_vpu_hw.c        |  2 +-
> >  .../staging/media/rockchip/vpu/rockchip_vpu.h | 24 ++++++-
> >  .../media/rockchip/vpu/rockchip_vpu_common.h  |  1 +
> >  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 65 +++++++++++++++++--
> >  5 files changed, 84 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> > index 056ee017c798..630eded99c68 100644
> > --- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> > +++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw.c
> > @@ -112,7 +112,7 @@ const struct rockchip_vpu_variant rk3288_vpu_variant = {
> >         .enc_fmts = rk3288_vpu_enc_fmts,
> >         .num_enc_fmts = ARRAY_SIZE(rk3288_vpu_enc_fmts),
> >         .codec_ops = rk3288_vpu_codec_ops,
> > -       .codec = RK_VPU_CODEC_JPEG,
> > +       .codec = RK_VPU_JPEG_ENCODER,
> >         .vepu_irq = rk3288_vepu_irq,
> >         .init = rk3288_vpu_hw_init,
> >         .clk_names = {"aclk", "hclk"},
> > diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> > index 0263584e616d..9eae1e6f1393 100644
> > --- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> > +++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw.c
> > @@ -129,7 +129,7 @@ const struct rockchip_vpu_variant rk3399_vpu_variant = {
> >         .enc_offset = 0x0,
> >         .enc_fmts = rk3399_vpu_enc_fmts,
> >         .num_enc_fmts = ARRAY_SIZE(rk3399_vpu_enc_fmts),
> > -       .codec = RK_VPU_CODEC_JPEG,
> > +       .codec = RK_VPU_JPEG_ENCODER,
> >         .codec_ops = rk3399_vpu_codec_ops,
> >         .vepu_irq = rk3399_vepu_irq,
> >         .vdpu_irq = rk3399_vdpu_irq,
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > index b383c89ecc17..a90fc2dfae99 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > @@ -25,6 +25,7 @@
> > 
> >  #include "rockchip_vpu_hw.h"
> > 
> > +#define ROCKCHIP_VPU_MAX_CTRLS          32
> >  #define ROCKCHIP_VPU_MAX_CLOCKS                4
> > 
> >  #define JPEG_MB_DIM                    16
> > @@ -34,7 +35,10 @@
> >  struct rockchip_vpu_ctx;
> >  struct rockchip_vpu_codec_ops;
> > 
> > -#define RK_VPU_CODEC_JPEG BIT(0)
> > +#define RK_VPU_JPEG_ENCODER    BIT(0)
> > +#define RK_VPU_ENCODERS                0x0000ffff
> > +
> > +#define RK_VPU_DECODERS                0xffff0000
> > 
> >  /**
> >   * struct rockchip_vpu_variant - information about VPU hardware variant
> > @@ -79,6 +83,20 @@ enum rockchip_vpu_codec_mode {
> >         RK_VPU_MODE_JPEG_ENC,
> >  };
> > 
> > +/*
> > + * struct rockchip_vpu_ctrl - helper type to declare supported controls
> > + * @id:                V4L2 control ID (V4L2_CID_xxx)
> > + * @is_std:    boolean to distinguish standard from customs control.
> > + * @codec:     codec id this control belong to (RK_VPU_JPEG_ENCODER, etc.)
> > + * @cfg:       control configuration
> > + */
> > +struct rockchip_vpu_ctrl {
> > +       unsigned int id;
> > +       unsigned int is_std;
> 
> Perhaps is_custom would make more sense? I'd expect most, if not all,
> of the controls to be standard. (Actually I wonder why the MPEG2
> controls are not standard.)
> 

Maybe is_std is misleading. The idea was just to distinguish
controls that can be registered with v4l2_ctrl_new_std,
from those that need v4l2_ctrl_new_custom, not because the control
is non-standard, but because it takes a custom v4l2_ctrl_config.

Maybe the is_std flag can be completely removed, and instead
use cfg.elem_size to distinguish the two type of controls.
 
> > +       unsigned int codec;
> > +       struct v4l2_ctrl_config cfg;
> > +};
> > +
> >  /*
> >   * struct rockchip_vpu_mc - media controller data
> >   *
> > @@ -169,6 +187,8 @@ struct rockchip_vpu_dev {
> >   * @dst_fmt:           V4L2 pixel format of active destination format.
> >   *
> >   * @ctrl_handler:      Control handler used to register controls.
> > + * @ctrls:             Array of supported controls.
> > + * @num_ctrls:         Number of controls populated in the array.
> >   * @jpeg_quality:      User-specified JPEG compression quality.
> >   *
> >   * @codec_ops:         Set of operations related to codec mode.
> > @@ -188,6 +208,8 @@ struct rockchip_vpu_ctx {
> >         struct v4l2_pix_format_mplane dst_fmt;
> > 
> >         struct v4l2_ctrl_handler ctrl_handler;
> > +       struct v4l2_ctrl *ctrls[ROCKCHIP_VPU_MAX_CTRLS];
> > +       unsigned int num_ctrls;
> >         int jpeg_quality;
> > 
> >         const struct rockchip_vpu_codec_ops *codec_ops;
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> > index 7e5fce3bf215..70b8ac1c7503 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> > @@ -23,6 +23,7 @@ extern const struct v4l2_ioctl_ops rockchip_vpu_dec_ioctl_ops;
> >  extern const struct vb2_ops rockchip_vpu_enc_queue_ops;
> >  extern const struct vb2_ops rockchip_vpu_dec_queue_ops;
> > 
> > +void *rockchip_vpu_find_control_data(struct rockchip_vpu_ctx *ctx, unsigned int id);
> >  void rockchip_vpu_enc_reset_src_fmt(struct rockchip_vpu_dev *vpu,
> >                                     struct rockchip_vpu_ctx *ctx);
> >  void rockchip_vpu_enc_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > index 27a9da86f1d0..f5c941f34c90 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > @@ -276,26 +276,77 @@ static int rockchip_vpu_s_ctrl(struct v4l2_ctrl *ctrl)
> >         return 0;
> >  }
> > 
> > +void *rockchip_vpu_find_control_data(struct rockchip_vpu_ctx *ctx, unsigned int id)
> > +{
> > +       unsigned int i;
> > +
> > +       for (i = 0; i < ctx->num_ctrls; i++) {
> > +               if (!ctx->ctrls[i])
> > +                       continue;
> > +               if (ctx->ctrls[i]->id == id)
> > +                       return ctx->ctrls[i]->p_cur.p;
> > +       }
> > +       return NULL;
> > +}
> > +
> 
> Couldn't we just use v4l2_ctrl_find() to get the control from the
> handler and then read the value from it?
> 

Actually, this helper is no longer in use, it's just left over code.

> >  static const struct v4l2_ctrl_ops rockchip_vpu_ctrl_ops = {
> >         .s_ctrl = rockchip_vpu_s_ctrl,
> >  };
> > 
> > +static struct rockchip_vpu_ctrl controls[] = {
> > +       {
> > +               .id = V4L2_CID_JPEG_COMPRESSION_QUALITY,
> > +               .codec = RK_VPU_JPEG_ENCODER,
> > +               .is_std = 1,
> > +               .cfg = {
> > +                       .min = 5,
> > +                       .max = 100,
> > +                       .step = 1,
> > +                       .def = 50,
> > +               },
> > +       },
> > +};
> > +
> >  static int rockchip_vpu_ctrls_setup(struct rockchip_vpu_dev *vpu,
> >                                     struct rockchip_vpu_ctx *ctx)
> >  {
> > -       v4l2_ctrl_handler_init(&ctx->ctrl_handler, 1);
> > -       if (vpu->variant->codec & RK_VPU_CODEC_JPEG) {
> > -               v4l2_ctrl_new_std(&ctx->ctrl_handler, &rockchip_vpu_ctrl_ops,
> > -                                 V4L2_CID_JPEG_COMPRESSION_QUALITY,
> > -                                 5, 100, 1, 50);
> > +       int j, i, num_ctrls = ARRAY_SIZE(controls);
> > +       int allowed_codecs;
> > +
> > +       if (ctx->is_enc)
> > +               allowed_codecs = vpu->variant->codec & RK_VPU_ENCODERS;
> > +       else
> > +               allowed_codecs = vpu->variant->codec & RK_VPU_DECODERS;
> > +
> > +       if (num_ctrls > ARRAY_SIZE(ctx->ctrls)) {
> > +               vpu_err("context control array not large enough\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       v4l2_ctrl_handler_init(&ctx->ctrl_handler, num_ctrls);
> > +
> > +       for (i = 0, j = 0; i < num_ctrls; i++) {
> > +               if (!(allowed_codecs & controls[i].codec))
> > +                       continue;
> > +               if (controls[i].is_std) {
> > +                       v4l2_ctrl_new_std(&ctx->ctrl_handler, &rockchip_vpu_ctrl_ops,
> > +                                         controls[i].id, controls[i].cfg.min, controls[i].cfg.max,
> > +                                         controls[i].cfg.step, controls[i].cfg.def);
> 
> No need to save the control pointer to ctx->ctrls[]? (Actually, with
> my comment above, we wouldn't need ctx->ctrls[] at all.)
> 

Right.

> > +               } else {
> > +                       controls[i].cfg.id = controls[i].id;
> > +                       ctx->ctrls[j++] = v4l2_ctrl_new_custom(&ctx->ctrl_handler,
> > +                                                              &controls[i].cfg, NULL);
> > +               }
> > +
> >                 if (ctx->ctrl_handler.error) {
> > -                       vpu_err("Adding JPEG control failed %d\n",
> > +                       vpu_err("Adding control (%d) failed %d\n",
> > +                               controls[i].id,
> >                                 ctx->ctrl_handler.error);
> >                         v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> >                         return ctx->ctrl_handler.error;
> >                 }
> >         }
> > -
> > +       ctx->num_ctrls = j;
> >         return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
> >  }
> 
> Best regards,
> Tomasz

Thanks,
Ezequiel


