Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF330C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C8F2173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfC1SaY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:30:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54234 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfC1SaX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 14:30:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 169F528227F
Message-ID: <cb9d6645edaf8335f2cdd3094830e80b10ff051f.camel@collabora.com>
Subject: Re: [PATCH v2 06/11] rockchip/vpu: Cleanup JPEG bounce buffer
 management
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
Date:   Thu, 28 Mar 2019 15:30:10 -0300
In-Reply-To: <CAAFQd5DjVDhFMc=WpnvF61yBcPm=BUQhVtBWSyphkkM8QubFzA@mail.gmail.com>
References: <20190304192529.14200-1-ezequiel@collabora.com>
         <20190304192529.14200-7-ezequiel@collabora.com>
         <CAAFQd5DjVDhFMc=WpnvF61yBcPm=BUQhVtBWSyphkkM8QubFzA@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2019-03-28 at 15:15 +0900, Tomasz Figa wrote:
> Hi Ezequiel,
> 
> On Tue, Mar 5, 2019 at 4:26 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > In order to make the code more generic, introduce a pair of start/stop
> > codec operations, and use them to allocate and release the JPEG bounce
> > buffer.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  .../media/rockchip/vpu/rk3288_vpu_hw.c        |  2 ++
> >  .../rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c     |  4 +--
> >  .../media/rockchip/vpu/rk3399_vpu_hw.c        |  2 ++
> >  .../rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c     |  4 +--
> >  .../staging/media/rockchip/vpu/rockchip_vpu.h | 12 ++++----
> >  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 10 +++++--
> >  .../media/rockchip/vpu/rockchip_vpu_enc.c     | 23 +++++----------
> >  .../media/rockchip/vpu/rockchip_vpu_hw.h      | 28 +++++++++++++++++++
> >  .../media/rockchip/vpu/rockchip_vpu_jpeg.c    | 25 +++++++++++++++++
> >  9 files changed, 81 insertions(+), 29 deletions(-)
> > 
> 
> Thanks for the series! Really sorry for late reply...
> 
> [snip]
> 
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > index 1ec2be483e27..76ee24abc141 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > @@ -124,10 +124,7 @@ struct rockchip_vpu_dev {
> >   * @jpeg_quality:      User-specified JPEG compression quality.
> >   *
> >   * @codec_ops:         Set of operations related to codec mode.
> > - *
> > - * @bounce_dma_addr:   Bounce buffer bus address.
> > - * @bounce_buf:                Bounce buffer pointer.
> > - * @bounce_size:       Bounce buffer size.
> > + * @jpeg_enc_ctx:      JPEG-encoding context.
> >   */
> >  struct rockchip_vpu_ctx {
> >         struct rockchip_vpu_dev *dev;
> > @@ -146,9 +143,10 @@ struct rockchip_vpu_ctx {
> > 
> >         const struct rockchip_vpu_codec_ops *codec_ops;
> > 
> > -       dma_addr_t bounce_dma_addr;
> > -       void *bounce_buf;
> > -       size_t bounce_size;
> > +       /* Specific for particular codec modes. */
> > +       union {
> > +               struct rockchip_vpu_jpeg_enc_hw_ctx jpeg_enc_ctx;
> > +       };
> 
> nit: Would it perhaps make it a bit cleaner to call the union "ctx"?
> Then we wouldn't need to repeat "_ctx" in every field.
> 

Well, the struct is already rockchip_vpu_ctx, so access would look like:

   ctx->ctx.jpeg_enc, ctx->ctx.mpeg2_dec

Perhaps we can just drop the _ctx, and so:

   ctx->jpeg_enc, ctx->mpeg2_dec

> >  };
> > 
> >  /**
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > index 5647b0bdac20..1a6dd36c71ab 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > @@ -64,10 +64,16 @@ static void rockchip_vpu_job_finish(struct rockchip_vpu_dev *vpu,
> >         avail_size = vb2_plane_size(&dst->vb2_buf, 0) -
> >                      ctx->vpu_dst_fmt->header_size;
> >         if (bytesused <= avail_size) {
> > -               if (ctx->bounce_buf) {
> > +               /*
> > +                * This works while JPEG is the only encoder this driver
> > +                * supports. We will have to abstract this step, or get
> > +                * rid of the bounce buffer before we can support
> > +                * encoding other codecs.
> 
> Hmm, why wouldn't it work for other encoders, which shouldn't require
> a bounce buffer?
> 

Well, I had a TODO item to remove the bounce buffer for JPEG.

IIRC, the ChromeOS VPU driver doesn't have any bounce buffer,
so I was under the impression we wouldn't need one.

However, we have yet to discuss the encoder implementation.
We might decide to produce the headers for some video coded format,
in which case we might need a bounce buffer.

In any case, this is just a comment to reflect that this piece
of code is just temporary.

> > +                */
> > +               if (ctx->jpeg_enc_ctx.bounce_buffer.cpu) {
> >                         memcpy(vb2_plane_vaddr(&dst->vb2_buf, 0) +
> >                                ctx->vpu_dst_fmt->header_size,
> > -                              ctx->bounce_buf, bytesused);
> > +                              ctx->jpeg_enc_ctx.bounce_buffer.cpu, bytesused);
> >                 }
> >                 dst->vb2_buf.planes[0].bytesused =
> >                         ctx->vpu_dst_fmt->header_size + bytesused;
> 
> [snip]
> 
> >  /**
> >   * struct rockchip_vpu_codec_ops - codec mode specific operations
> >   *
> > + * @start:     If needed, can be used for initialization.
> > + *             Optional and called from process context.
> > + * @stop:      If needed, can be used to undo the .start phase.
> > + *             Optional and called from process context.
> 
> nit: Perhaps .init and .exit could reflect better what these ops do?
> 
> 

Yeah, that'd be better.

Thanks for the feedback,
Eze

