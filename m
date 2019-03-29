Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2266C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1472082F
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 07:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L8TIG9A2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfC2Hky (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:40:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37246 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfC2Hkx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 03:40:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so1275584otn.4
        for <linux-media@vger.kernel.org>; Fri, 29 Mar 2019 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhYj/lrhxiroDpcd0asYbHp4LogSQ2VyTZCqXN+aYwg=;
        b=L8TIG9A2IbfltOYsEPa5Bx9rxUNxZ1C3VPLXXte6T1fkFD0NcdYD27cUSXlto+NIDJ
         lVF+auMgAxTlzDpRvqxoLcpwhhNEkp7xcX3zZvd8f2ianjsOx2Z420dJVOUz7O+Xeu9g
         zltxJcZZ7UKMoasfq4tXIgTsdqUKi+e6z7IzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhYj/lrhxiroDpcd0asYbHp4LogSQ2VyTZCqXN+aYwg=;
        b=BknVjOuxRqa5pkd0DXvpZhp4MjxOU6MqIMUNilooHhqPWfpLOp2vRR6N2hJ0f/R1t9
         P03GwoQM44A9jcOMbSlNEjipOB2XYOeTg/Rem8jKi8wrhNU8trRirRexJJc7LYa3DAQj
         5XdIhvhcyHfLVVx+3RvH25ZN6tN2LSJ02DZOfnpcRykXtR6An3LEttA6lpBRNHKWxK0N
         pqp9F0aArWQxz/UULRiP2ftoDJF3Dwt7p8HsPJDKDP77/ybdIatx9RK06C7w3TxeYlaB
         n9Lrp8bNSpFafp604AtFP2Tb3KGDIwQi1AGP6mBotZzZcg220IMo27VU8VEsnLlxYuY8
         jbGw==
X-Gm-Message-State: APjAAAVXB6sS8YsH4n9ZqzXNkFyFzi9FqABIBqc3xKc7G0J+gkyxfgGO
        RvJq3UVZX0fuyloJTdj9f76htlXcrKBqSg==
X-Google-Smtp-Source: APXvYqw7sVy/shnOMUGa0fy/YhSi5vsQlUdMN8/flq8qCTdowAsBqoQVITkQo4udYf0JNaooeE/uRA==
X-Received: by 2002:a05:6830:1216:: with SMTP id r22mr8225949otp.198.1553845252287;
        Fri, 29 Mar 2019 00:40:52 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id e67sm664636ote.13.2019.03.29.00.40.51
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 00:40:51 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id m10so1286466otp.2
        for <linux-media@vger.kernel.org>; Fri, 29 Mar 2019 00:40:51 -0700 (PDT)
X-Received: by 2002:a9d:3f24:: with SMTP id m33mr32444285otc.147.1553845250738;
 Fri, 29 Mar 2019 00:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com>
 <20190304192529.14200-10-ezequiel@collabora.com> <CAAFQd5AWJj5wY6jOf2hC4t8kU1XQ3y6H_YKGaZgRVCHrUvfPXQ@mail.gmail.com>
 <3dc357b3be2ebe787b79817384c59bba25ff57ad.camel@collabora.com>
In-Reply-To: <3dc357b3be2ebe787b79817384c59bba25ff57ad.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 29 Mar 2019 16:40:39 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DEyu7TSc=Cv3T94aTdfZbgS4J8HN_nZA=BL8HkFW-Z-Q@mail.gmail.com>
Message-ID: <CAAFQd5DEyu7TSc=Cv3T94aTdfZbgS4J8HN_nZA=BL8HkFW-Z-Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] rockchip/vpu: Add decoder boilerplate
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

On Fri, Mar 29, 2019 at 4:23 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Hey Tomasz,
>
> Thanks for taking the time to review this carefully!
>
> On Thu, 2019-03-28 at 18:57 +0900, Tomasz Figa wrote:
> > On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
[snip]
> > > +}
> > > +
> > > +static int
> > > +vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
> > > +{
> > > +       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> > > +       struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
> > > +       struct rockchip_vpu_dev *vpu = ctx->dev;
> > > +       struct vb2_queue *vq, *peer_vq;
> > > +       int ret;
> > > +
> > > +       /* Change not allowed if queue is streaming. */
> > > +       vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> > > +       if (vb2_is_streaming(vq))
> > > +               return -EBUSY;
> > > +
> > > +       /*
> > > +        * Since format change on the OUTPUT queue will reset
> > > +        * the CAPTURE queue, we can't allow doing so
> > > +        * when the CAPTURE queue has buffers allocated.
> > > +        */
> > > +       peer_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > > +                                 V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> > > +       if (vb2_is_busy(peer_vq) &&
> > > +           (pix_mp->pixelformat != ctx->src_fmt.pixelformat ||
> > > +            pix_mp->height != ctx->src_fmt.height ||
> > > +            pix_mp->width != ctx->src_fmt.width))
> > > +               return -EBUSY;
> >
> > I'd say that in general we don't want any S_FMT(OUT) to be allowed if
> > CAP has buffers allocated, so maybe just checking vb2_is_busy(peer_vq)
> > is enough?
> >
>
> Hm, this has been confusing to no end for me. This check comes from s_fmt_cap
> in rockchip_vpu_enc.c, at the time we came to the conclusion that
> vb2_is_busy(peer_queue) wasn't enough.

Hmm, yeah, this is confusing indeed, especially considering that we
shouldn't need width and height on the CAP queue of an encoder.

>
> Taking a step back, the S_FMT order is first encoded format, then raw format.
>
> So for encoders the user is expected to do first S_FMT(CAP), second S_FMT(OUT).
> For decoders, first S_FMT(OUT), second S_FMT(CAP)... and that's why we are interested
> on a strict vb2_is_busy check.
>
> The question is how we came to a different conclusion on the encoder.
>

I loosely recollect it having something to do with JPEG specifically, hmm...

[snip]

> > > +
> > > +       if (V4L2_TYPE_IS_OUTPUT(q->type))
> > > +               if (ctx->codec_ops && ctx->codec_ops->start)
> > > +                       ret = ctx->codec_ops->start(ctx);
> > > +       return ret;
> > > +}
> > > +
> > > +static void rockchip_vpu_stop_streaming(struct vb2_queue *q)
> > > +{
> > > +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(q);
> > > +
> > > +       if (V4L2_TYPE_IS_OUTPUT(q->type))
> > > +               if (ctx->codec_ops && ctx->codec_ops->stop)
> > > +                       ctx->codec_ops->stop(ctx);
> > > +
> > > +       /* The mem2mem framework calls v4l2_m2m_cancel_job before
> >
> > CodingStyle: Multiline comments should start with one empty line.
> >
>
> Oops. Seems I have a tendency for this!
>

Actually, some subsystems use that style, e.g. net/.

> > > +        * .stop_streaming, so there isn't any job running and
> > > +        * it is safe to return all the buffers.
> > > +        */
> > > +       for (;;) {
> > > +               struct vb2_v4l2_buffer *vbuf;
> > > +
> > > +               if (V4L2_TYPE_IS_OUTPUT(q->type))
> > > +                       vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> > > +               else
> > > +                       vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> > > +               if (!vbuf)
> > > +                       break;
> > > +               v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req, &ctx->ctrl_handler);
> > > +               v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> > > +       }
> > > +}
> > > +
> > > +static void rockchip_vpu_buf_request_complete(struct vb2_buffer *vb)
> > > +{
> > > +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> > > +
> > > +       v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->ctrl_handler);
> > > +}
> > > +
> > > +static int rockchip_vpu_buf_out_validate(struct vb2_buffer *vb)
> > > +{
> > > +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> > > +
> > > +       vbuf->field = V4L2_FIELD_NONE;
> >
> > Similar comment as in earlier patch. Is validate expected to correct
> > the values or just check?
> >
>
> See Hans' reply.

Ack.

>
> > > +       return 0;
> > > +}
> > > +
> > > +const struct vb2_ops rockchip_vpu_dec_queue_ops = {
> > > +       .queue_setup = rockchip_vpu_queue_setup,
> > > +       .buf_prepare = rockchip_vpu_buf_prepare,
> > > +       .buf_queue = rockchip_vpu_buf_queue,
> > > +       .buf_out_validate = rockchip_vpu_buf_out_validate,
> > > +       .buf_request_complete = rockchip_vpu_buf_request_complete,
> > > +       .start_streaming = rockchip_vpu_start_streaming,
> > > +       .stop_streaming = rockchip_vpu_stop_streaming,
> > > +       .wait_prepare = vb2_ops_wait_prepare,
> > > +       .wait_finish = vb2_ops_wait_finish,
> > > +};
> > > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > > index 937e9cfb4568..27a9da86f1d0 100644
> > > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > > @@ -36,6 +36,11 @@ module_param_named(debug, rockchip_vpu_debug, int, 0644);
> > >  MODULE_PARM_DESC(debug,
> > >                  "Debug level - higher value produces more verbose messages");
> > >
> > > +enum rockchip_vpu_type {
> > > +       RK_VPU_ENCODER,
> > > +       RK_VPU_DECODER,
> > > +};
> >
> > Given that we already have ctx->is_enc, any reason not to have this
> > represented in the same way everywhere?
> >
>
> The reason is that I'd rather have:
>
> rockchip_vpu_video_device_register(vpu, RK_VPU_ENCODER);
>
> Than:
>
> rockchip_vpu_video_device_register(vpu, true);
>
> We could have a vpu_type field instead of that is_enc boolean.
> I think the code would be even cleaner.
>

Sounds good to me!

Best regards,
Tomasz
