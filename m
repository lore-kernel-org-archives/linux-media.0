Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A2C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 19:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A651E21773
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 19:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfC1THX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:07:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54374 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfC1THX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 15:07:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 3559828227F
Message-ID: <1709f2c8e16fa4596ed63ab11db7e4819e2b0d14.camel@collabora.com>
Subject: Re: [PATCH v2 08/11] rockchip/vpu: Support the Request API
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
Date:   Thu, 28 Mar 2019 16:07:14 -0300
In-Reply-To: <CAAFQd5C5zo=03-mLh4OztKS+dCjVMUe1Za25ff+dWjxQDLFLng@mail.gmail.com>
References: <20190304192529.14200-1-ezequiel@collabora.com>
         <20190304192529.14200-9-ezequiel@collabora.com>
         <CAAFQd5C5zo=03-mLh4OztKS+dCjVMUe1Za25ff+dWjxQDLFLng@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2019-03-28 at 16:20 +0900, Tomasz Figa wrote:
> On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > Introduce support for the Request API. Although the JPEG encoder
> > does not mandate using the Request API, it's perfectly possible to
> > use it, if the application wants to.
> > 
> > In addition, add helpers that will be used by video decoders.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  .../rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c     |  6 ++++
> >  .../media/rockchip/vpu/rockchip_vpu_common.h  |  3 ++
> >  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 29 ++++++++++++++++++-
> >  .../media/rockchip/vpu/rockchip_vpu_enc.c     | 18 ++++++++++++
> >  4 files changed, 55 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> > index fe92c40d0a84..e11ee152b8ce 100644
> > --- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> > +++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> > @@ -113,11 +113,15 @@ void rk3399_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
> >         struct rockchip_vpu_dev *vpu = ctx->dev;
> >         struct vb2_v4l2_buffer *src_buf, *dst_buf;
> >         struct rockchip_vpu_jpeg_ctx jpeg_ctx;
> > +       struct media_request *src_req;
> >         u32 reg;
> > 
> >         src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> >         dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> > 
> > +       src_req = src_buf->vb2_buf.req_obj.req;
> > +       v4l2_ctrl_request_setup(src_req, &ctx->ctrl_handler);
> > +
> >         memset(&jpeg_ctx, 0, sizeof(jpeg_ctx));
> >         jpeg_ctx.buffer = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
> >         jpeg_ctx.width = ctx->dst_fmt.width;
> > @@ -153,6 +157,8 @@ void rk3399_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
> >                 | VEPU_REG_ENCODE_FORMAT_JPEG
> >                 | VEPU_REG_ENCODE_ENABLE;
> > 
> > +       v4l2_ctrl_request_complete(src_req, &ctx->ctrl_handler);
> > +
> >         /* Kick the watchdog and start encoding */
> >         schedule_delayed_work(&vpu->watchdog_work, msecs_to_jiffies(2000));
> >         vepu_write(vpu, reg, VEPU_REG_ENCODE_START);
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> > index ca77668d9579..ac018136a7bc 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_common.h
> > @@ -26,4 +26,7 @@ void rockchip_vpu_enc_reset_src_fmt(struct rockchip_vpu_dev *vpu,
> >  void rockchip_vpu_enc_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
> >                                     struct rockchip_vpu_ctx *ctx);
> > 
> > +void *rockchip_vpu_get_ctrl(struct rockchip_vpu_ctx *ctx, u32 id);
> > +dma_addr_t rockchip_vpu_get_ref(struct vb2_queue *q, u64 ts);
> > +
> >  #endif /* ROCKCHIP_VPU_COMMON_H_ */
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > index af2481ca2228..937e9cfb4568 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > @@ -36,6 +36,24 @@ module_param_named(debug, rockchip_vpu_debug, int, 0644);
> >  MODULE_PARM_DESC(debug,
> >                  "Debug level - higher value produces more verbose messages");
> > 
> > +void *rockchip_vpu_get_ctrl(struct rockchip_vpu_ctx *ctx, u32 id)
> > +{
> > +       struct v4l2_ctrl *ctrl;
> > +
> > +       ctrl = v4l2_ctrl_find(&ctx->ctrl_handler, id);
> > +       return ctrl ? ctrl->p_cur.p : NULL;
> > +}
> > +
> > +dma_addr_t rockchip_vpu_get_ref(struct vb2_queue *q, u64 ts)
> > +{
> > +       int index;
> > +
> > +       index = vb2_find_timestamp(q, ts, 0);
> > +       if (index >= 0)
> > +               return vb2_dma_contig_plane_dma_addr(q->bufs[index], 0);
> > +       return 0;
> > +}
> > +
> 
> Hmm, I assume these 2 are the "helpers that will be used by video
> decoders"? Probably overly nitpicking, but these are relatively small,
> so why couldn't they be just added in the patch that actually adds the
> code using them? Otherwise, if for some reason we separate the series,
> we end up with dead code.
> 

I can't remember why these are here. It was obviously intentional,
as the commit log shows!

Anyway, yeah, I'll move them to the patch that makes use of it.

> >  static void rockchip_vpu_job_finish(struct rockchip_vpu_dev *vpu,
> >                                     struct rockchip_vpu_ctx *ctx,
> >                                     unsigned int bytesused,
> > @@ -164,6 +182,7 @@ enc_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
> >         src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> >         src_vq->lock = &ctx->dev->vpu_mutex;
> >         src_vq->dev = ctx->dev->v4l2_dev.dev;
> > +       src_vq->supports_requests = true;
> > 
> >         ret = vb2_queue_init(src_vq);
> >         if (ret)
> > @@ -328,6 +347,11 @@ static const struct of_device_id of_rockchip_vpu_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, of_rockchip_vpu_match);
> > 
> > +static const struct media_device_ops rockchip_m2m_media_ops = {
> > +       .req_validate = vb2_request_validate,
> > +       .req_queue = v4l2_m2m_request_queue,
> > +};
> > +
> >  static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu)
> >  {
> >         const struct of_device_id *match;
> > @@ -610,8 +634,11 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
> >         }
> > 
> >         vpu->mdev.dev = vpu->dev;
> > -       strlcpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
> > +       strscpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
> > +       strscpy(vpu->mdev.bus_info, "platform:" DRIVER_NAME,
> > +               sizeof(vpu->mdev.bus_info));
> 
> Unrelated changes?
> 

Totally.

> >         media_device_init(&vpu->mdev);
> > +       vpu->mdev.ops = &rockchip_m2m_media_ops;
> >         vpu->v4l2_dev.mdev = &vpu->mdev;
> > 
> >         ret = rockchip_vpu_video_device_register(vpu);
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> > index 2b28403314bc..1b5a675ef24f 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> > @@ -555,14 +555,32 @@ static void rockchip_vpu_stop_streaming(struct vb2_queue *q)
> >                         vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> >                 if (!vbuf)
> >                         break;
> > +               v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req, &ctx->ctrl_handler);
> >                 v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> >         }
> >  }
> > 
> > +static void rockchip_vpu_buf_request_complete(struct vb2_buffer *vb)
> > +{
> > +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> > +
> > +       v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->ctrl_handler);
> > +}
> > +
> > +static int rockchip_vpu_buf_out_validate(struct vb2_buffer *vb)
> > +{
> > +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> > +
> > +       vbuf->field = V4L2_FIELD_NONE;
> 
> Hmm, "validate" in the name of this callback would suggest that we
> should just check the contents, not change them. Hans, what was the
> intention when adding this callback? Are we missing the const
> specifier in the argument?
> 

Hans already replied to this.

Thanks,
Eze

