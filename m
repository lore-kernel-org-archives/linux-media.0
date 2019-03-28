Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9629C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 09:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EA52177E
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 09:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhBo3s20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfC1J6D (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:58:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46196 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfC1J6C (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 05:58:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id x188so15261100oia.13
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMdwPbiP/YEr2ad0uUHOTijvFl4/8rqlWIxZmOkRmS0=;
        b=RhBo3s20Y3EVEpPErMJSjaHOSRrxwn2fiUpARi1D9PcXEDHs/kzHiQqyf/4BjbmP/d
         V4V0S/Au8hriXkpEeFl1UfhPHDmpMzAV5bMhiJ11+ciRUSg7onIfi8q/U5cLTDunApzs
         LrEjYybo4wh0aSAE/roVZROqbMa4C/MGKQGcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMdwPbiP/YEr2ad0uUHOTijvFl4/8rqlWIxZmOkRmS0=;
        b=CRsIheGSgvCOd0luaUxZaUgP0TDpeezmKa72jUSichiR/QbaSodT4fCxkhR/UJWGYJ
         gd5BNCET6Hs88wHBJACMLVCer3BIKcEG0qvCyiXYRPli72y/MQ3GVJE0EH05QDWFHCmB
         8YE5GxCvgPCELbcqZE9UC40TMvOggMbGFKtYA8NrAF5tuVyk4TOhrl0G9eKrkuTJUyQr
         YgANMrUSULfO7GTKNTc8CHeJrfF34/RZDjucG52tAdEimTVkTPqar2zdUrchbxBI1j59
         a3ML+WpAnNrOSHISue7GHSpA/z5mXR4+6LPRiOMqYimpRpWH5UEI0yTgUm+qBNXOI5hQ
         sZ3A==
X-Gm-Message-State: APjAAAUPCyUVOPjdJWqkOu+V/u8JmxUor0qqbaACaD9B8UGt9ZsPZU0k
        sLsw/6sKsgk6VXnDI8YRTVqEMp12ed5asQ==
X-Google-Smtp-Source: APXvYqwIOH0o+9m1CrYwFq+ULWrSZa/kYhk04YNAE1jrgOD2hpMlzIIS28FxIbL/CZHFy5cm5SZohg==
X-Received: by 2002:aca:c483:: with SMTP id u125mr21183757oif.148.1553767080814;
        Thu, 28 Mar 2019 02:58:00 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id k25sm4261392otj.72.2019.03.28.02.57.59
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 02:57:59 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id k21so16369185otf.1
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 02:57:59 -0700 (PDT)
X-Received: by 2002:a9d:63d5:: with SMTP id e21mr9487252otl.288.1553767079070;
 Thu, 28 Mar 2019 02:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com> <20190304192529.14200-10-ezequiel@collabora.com>
In-Reply-To: <20190304192529.14200-10-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 28 Mar 2019 18:57:47 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AWJj5wY6jOf2hC4t8kU1XQ3y6H_YKGaZgRVCHrUvfPXQ@mail.gmail.com>
Message-ID: <CAAFQd5AWJj5wY6jOf2hC4t8kU1XQ3y6H_YKGaZgRVCHrUvfPXQ@mail.gmail.com>
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

On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
[snip]
> +static const struct rockchip_vpu_fmt *
> +rockchip_vpu_find_format(struct rockchip_vpu_ctx *ctx, u32 fourcc)
> +{
> +       struct rockchip_vpu_dev *dev = ctx->dev;
> +       const struct rockchip_vpu_fmt *formats;
> +       unsigned int num_fmts, i;
> +
> +       formats = dev->variant->dec_fmts;
> +       num_fmts = dev->variant->num_dec_fmts;
> +       for (i = 0; i < num_fmts; i++)
> +               if (formats[i].fourcc == fourcc)
> +                       return &formats[i];
> +       return NULL;
> +}
> +
> +static const struct rockchip_vpu_fmt *
> +rockchip_vpu_get_default_fmt(struct rockchip_vpu_ctx *ctx, bool bitstream)
> +{
> +       struct rockchip_vpu_dev *dev = ctx->dev;
> +       const struct rockchip_vpu_fmt *formats;
> +       unsigned int num_fmts, i;
> +
> +       formats = dev->variant->dec_fmts;
> +       num_fmts = dev->variant->num_dec_fmts;
> +       for (i = 0; i < num_fmts; i++)
> +               if (bitstream == (formats[i].codec_mode != RK_VPU_MODE_NONE))
> +                       return &formats[i];
> +       return NULL;
> +}
> +
> +static int vidioc_querycap(struct file *file, void *priv,
> +                          struct v4l2_capability *cap)
> +{
> +       struct rockchip_vpu_dev *vpu = video_drvdata(file);
> +
> +       strlcpy(cap->driver, vpu->dev->driver->name, sizeof(cap->driver));
> +       strlcpy(cap->card, vpu->vfd_dec->name, sizeof(cap->card));
> +       snprintf(cap->bus_info, sizeof(cap->bus_info), "platform: %s",
> +                vpu->dev->driver->name);
> +       return 0;
> +}
> +
> +static int vidioc_enum_framesizes(struct file *file, void *priv,
> +                                 struct v4l2_frmsizeenum *fsize)
> +{
> +       struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
> +       const struct rockchip_vpu_fmt *fmt;
> +
> +       if (fsize->index != 0) {
> +               vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
> +                               fsize->index);
> +               return -EINVAL;
> +       }
> +
> +       fmt = rockchip_vpu_find_format(ctx, fsize->pixel_format);
> +       if (!fmt) {
> +               vpu_debug(0, "unsupported bitstream format (%08x)\n",
> +                               fsize->pixel_format);
> +               return -EINVAL;
> +       }
> +
> +       /* This only makes sense for codec formats */

"coded formats"

> +       if (fmt->codec_mode == RK_VPU_MODE_NONE)
> +               return -EINVAL;
> +
> +       fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
> +       fsize->stepwise = fmt->frmsize;
> +
> +       return 0;
> +}
> +
> +static int vidioc_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
> +                                         struct v4l2_fmtdesc *f)
> +{
> +       struct rockchip_vpu_dev *dev = video_drvdata(file);
> +       const struct rockchip_vpu_fmt *fmt;
> +       const struct rockchip_vpu_fmt *formats;
> +       int num_fmts, i, j = 0;
> +
> +       formats = dev->variant->dec_fmts;
> +       num_fmts = dev->variant->num_dec_fmts;
> +       for (i = 0; i < num_fmts; i++) {
> +               /* Skip compressed formats */
> +               if (formats[i].codec_mode != RK_VPU_MODE_NONE)
> +                       continue;
> +               if (j == f->index) {
> +                       fmt = &formats[i];
> +                       f->pixelformat = fmt->fourcc;
> +                       return 0;
> +               }
> +               ++j;
> +       }
> +       return -EINVAL;
> +}
> +
> +static int vidioc_enum_fmt_vid_out_mplane(struct file *file, void *priv,
> +                                         struct v4l2_fmtdesc *f)
> +{
> +       struct rockchip_vpu_dev *dev = video_drvdata(file);
> +       const struct rockchip_vpu_fmt *formats;
> +       const struct rockchip_vpu_fmt *fmt;
> +       int num_fmts, i, j = 0;
> +
> +       formats = dev->variant->dec_fmts;
> +       num_fmts = dev->variant->num_dec_fmts;
> +       for (i = 0; i < num_fmts; i++) {
> +               if (formats[i].codec_mode == RK_VPU_MODE_NONE)
> +                       continue;
> +               if (j == f->index) {
> +                       fmt = &formats[i];
> +                       f->pixelformat = fmt->fourcc;
> +                       return 0;
> +               }
> +               ++j;
> +       }
> +       return -EINVAL;
> +}

All the functions above can be trivially generalized to be used for
both encoder and decoder. Moreover,
vidioc_enum_fmt_vid_{cap,out}_mplane() can be trivially merged into
one function to cover both buffer types.

> +
> +static int vidioc_g_fmt_out_mplane(struct file *file, void *priv,
> +                                  struct v4l2_format *f)
> +{
> +       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +       struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
> +
> +       vpu_debug(4, "f->type = %d\n", f->type);
> +
> +       *pix_mp = ctx->src_fmt;
> +
> +       return 0;
> +}
> +
> +static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
> +                                  struct v4l2_format *f)
> +{
> +       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +       struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
> +
> +       vpu_debug(4, "f->type = %d\n", f->type);
> +
> +       *pix_mp = ctx->dst_fmt;
> +
> +       return 0;
> +}
> +
> +static int
> +vidioc_try_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +       struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
> +       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +       const struct rockchip_vpu_fmt *fmt;
> +       unsigned int width, height;
> +
> +       vpu_debug(4, "%c%c%c%c\n",
> +                 (pix_mp->pixelformat & 0x7f),
> +                 (pix_mp->pixelformat >> 8) & 0x7f,
> +                 (pix_mp->pixelformat >> 16) & 0x7f,
> +                 (pix_mp->pixelformat >> 24) & 0x7f);
> +
> +       fmt = rockchip_vpu_find_format(ctx, pix_mp->pixelformat);
> +       if (!fmt) {
> +               fmt = rockchip_vpu_get_default_fmt(ctx, false);
> +               f->fmt.pix.pixelformat = fmt->fourcc;
> +       }
> +
> +       pix_mp->field = V4L2_FIELD_NONE;
> +       width = clamp(pix_mp->width,
> +                     ctx->vpu_src_fmt->frmsize.min_width,
> +                     ctx->vpu_src_fmt->frmsize.max_width);
> +       height = clamp(pix_mp->height,
> +                      ctx->vpu_src_fmt->frmsize.min_height,
> +                      ctx->vpu_src_fmt->frmsize.max_height);
> +       /* Round up to macroblocks. */
> +       width = round_up(width, ctx->vpu_src_fmt->frmsize.step_width);
> +       height = round_up(height, ctx->vpu_src_fmt->frmsize.step_height);
> +
> +       /* Fill remaining fields */
> +       v4l2_fill_pixfmt_mp(pix_mp, fmt->fourcc, width, height);
> +       return 0;
> +}
> +
> +static int
> +vidioc_try_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +       struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
> +       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +       const struct rockchip_vpu_fmt *fmt;
> +
> +       fmt = rockchip_vpu_find_format(ctx, pix_mp->pixelformat);
> +       if (!fmt) {
> +               fmt = rockchip_vpu_get_default_fmt(ctx, true);
> +               f->fmt.pix.pixelformat = fmt->fourcc;
> +       }
> +
> +       pix_mp->num_planes = 1;
> +       pix_mp->field = V4L2_FIELD_NONE;
> +       pix_mp->width = clamp(pix_mp->width,
> +                               fmt->frmsize.min_width,
> +                               fmt->frmsize.max_width);
> +       pix_mp->height = clamp(pix_mp->height,
> +                               fmt->frmsize.min_height,
> +                               fmt->frmsize.max_height);
> +       /* Round up to macroblocks. */
> +       pix_mp->width = round_up(pix_mp->width, fmt->frmsize.step_width);
> +       pix_mp->height = round_up(pix_mp->height, fmt->frmsize.step_height);
> +
> +       /*
> +        * For compressed formats the application can specify
> +        * sizeimage. If the application passes a zero sizeimage,
> +        * let's default to the maximum frame size.
> +        */
> +       if (!pix_mp->plane_fmt[0].sizeimage)
> +               pix_mp->plane_fmt[0].sizeimage = fmt->header_size +
> +                       pix_mp->width * pix_mp->height * fmt->max_depth;
> +       return 0;
> +}
> +
> +void rockchip_vpu_dec_reset_dst_fmt(struct rockchip_vpu_dev *vpu,
> +                               struct rockchip_vpu_ctx *ctx)
> +{
> +       struct v4l2_pix_format_mplane *fmt = &ctx->dst_fmt;
> +       unsigned int width, height;
> +
> +       ctx->vpu_dst_fmt = rockchip_vpu_get_default_fmt(ctx, false);
> +
> +       memset(fmt, 0, sizeof(*fmt));
> +
> +       width = clamp(fmt->width, ctx->vpu_src_fmt->frmsize.min_width,
> +                     ctx->vpu_src_fmt->frmsize.max_width);
> +       height = clamp(fmt->height, ctx->vpu_src_fmt->frmsize.min_height,
> +                      ctx->vpu_src_fmt->frmsize.max_height);
> +       fmt->field = V4L2_FIELD_NONE;
> +       fmt->colorspace = V4L2_COLORSPACE_JPEG,
> +       fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> +       fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
> +       fmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
> +
> +       v4l2_fill_pixfmt_mp(fmt, ctx->vpu_dst_fmt->fourcc, width, height);

Rather than duplicating most of the work already done in
vidioc_try_fmt_*(), could we just call it here?

> +}
> +
> +void rockchip_vpu_dec_reset_src_fmt(struct rockchip_vpu_dev *vpu,
> +                               struct rockchip_vpu_ctx *ctx)
> +{
> +       struct v4l2_pix_format_mplane *fmt = &ctx->src_fmt;
> +
> +       ctx->vpu_src_fmt = rockchip_vpu_get_default_fmt(ctx, true);
> +
> +       memset(fmt, 0, sizeof(*fmt));
> +
> +       fmt->num_planes = 1;
> +       fmt->width = clamp(fmt->width, ctx->vpu_src_fmt->frmsize.min_width,
> +                     ctx->vpu_src_fmt->frmsize.max_width);
> +       fmt->height = clamp(fmt->height, ctx->vpu_src_fmt->frmsize.min_height,
> +                      ctx->vpu_src_fmt->frmsize.max_height);
> +       fmt->pixelformat = ctx->vpu_src_fmt->fourcc;
> +       fmt->field = V4L2_FIELD_NONE;
> +       fmt->colorspace = V4L2_COLORSPACE_JPEG,
> +       fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> +       fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
> +       fmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
> +
> +       fmt->plane_fmt[0].sizeimage = ctx->vpu_src_fmt->header_size +
> +               fmt->width * fmt->height * ctx->vpu_src_fmt->max_depth;

Ditto.

> +}
> +
> +static int
> +vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +       struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
> +       struct rockchip_vpu_dev *vpu = ctx->dev;
> +       struct vb2_queue *vq, *peer_vq;
> +       int ret;
> +
> +       /* Change not allowed if queue is streaming. */
> +       vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> +       if (vb2_is_streaming(vq))
> +               return -EBUSY;
> +
> +       /*
> +        * Since format change on the OUTPUT queue will reset
> +        * the CAPTURE queue, we can't allow doing so
> +        * when the CAPTURE queue has buffers allocated.
> +        */
> +       peer_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> +                                 V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +       if (vb2_is_busy(peer_vq) &&
> +           (pix_mp->pixelformat != ctx->src_fmt.pixelformat ||
> +            pix_mp->height != ctx->src_fmt.height ||
> +            pix_mp->width != ctx->src_fmt.width))
> +               return -EBUSY;

I'd say that in general we don't want any S_FMT(OUT) to be allowed if
CAP has buffers allocated, so maybe just checking vb2_is_busy(peer_vq)
is enough?

> +
> +       ret = vidioc_try_fmt_out_mplane(file, priv, f);
> +       if (ret)
> +               return ret;
> +
> +       ctx->vpu_src_fmt = rockchip_vpu_find_format(ctx, pix_mp->pixelformat);
> +       ctx->src_fmt = *pix_mp;
> +
> +       vpu_debug(0, "OUTPUT codec mode: %d\n", ctx->vpu_src_fmt->codec_mode);
> +       vpu_debug(0, "fmt - w: %d, h: %d\n",
> +                 pix_mp->width, pix_mp->height);
> +
> +       rockchip_vpu_dec_reset_dst_fmt(vpu, ctx);
> +       return 0;
> +}
> +
> +static int
> +vidioc_s_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +       struct rockchip_vpu_ctx *ctx = fh_to_ctx(priv);
> +       struct vb2_queue *vq;
> +       int ret;
> +
> +       /* Change not allowed if queue is streaming. */
> +       vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> +       if (vb2_is_streaming(vq))
> +               return -EBUSY;
> +
> +       ret = vidioc_try_fmt_cap_mplane(file, priv, f);
> +       if (ret)
> +               return ret;
> +
> +       ctx->vpu_dst_fmt = rockchip_vpu_find_format(ctx, pix_mp->pixelformat);
> +       ctx->dst_fmt = *pix_mp;
> +
> +       vpu_debug(0, "CAPTURE codec mode: %d\n", ctx->vpu_dst_fmt->codec_mode);
> +       vpu_debug(0, "fmt - w: %d, h: %d\n",
> +                 pix_mp->width, pix_mp->height);
> +       return 0;
> +}
> +
> +const struct v4l2_ioctl_ops rockchip_vpu_dec_ioctl_ops = {
> +       .vidioc_querycap = vidioc_querycap,
> +       .vidioc_enum_framesizes = vidioc_enum_framesizes,
> +
> +       .vidioc_try_fmt_vid_cap_mplane = vidioc_try_fmt_cap_mplane,
> +       .vidioc_try_fmt_vid_out_mplane = vidioc_try_fmt_out_mplane,
> +       .vidioc_s_fmt_vid_out_mplane = vidioc_s_fmt_out_mplane,
> +       .vidioc_s_fmt_vid_cap_mplane = vidioc_s_fmt_cap_mplane,
> +       .vidioc_g_fmt_vid_out_mplane = vidioc_g_fmt_out_mplane,
> +       .vidioc_g_fmt_vid_cap_mplane = vidioc_g_fmt_cap_mplane,
> +       .vidioc_enum_fmt_vid_out_mplane = vidioc_enum_fmt_vid_out_mplane,
> +       .vidioc_enum_fmt_vid_cap_mplane = vidioc_enum_fmt_vid_cap_mplane,
> +
> +       .vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
> +       .vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
> +       .vidioc_qbuf = v4l2_m2m_ioctl_qbuf,
> +       .vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
> +       .vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
> +       .vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
> +       .vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
> +
> +       .vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
> +       .vidioc_unsubscribe_event = v4l2_event_unsubscribe,
> +
> +       .vidioc_streamon = v4l2_m2m_ioctl_streamon,
> +       .vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
> +};
> +
> +static int rockchip_vpu_queue_setup(struct vb2_queue *vq,
> +                                 unsigned int *num_buffers,
> +                                 unsigned int *num_planes,
> +                                 unsigned int sizes[],
> +                                 struct device *alloc_devs[])
> +{
> +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vq);
> +       struct v4l2_pix_format_mplane *pixfmt;
> +       int i;
> +
> +       switch (vq->type) {
> +       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> +               pixfmt = &ctx->dst_fmt;
> +               break;
> +       case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> +               pixfmt = &ctx->src_fmt;
> +               break;
> +       default:
> +               vpu_err("invalid queue type: %d\n", vq->type);
> +               return -EINVAL;
> +       }

Hmm, would it make sense to have separate vb2_queue_ops for each queue
and create helper functions, which take the necessary queue-specific
data as arguments, if appropriate?

> +
> +       if (*num_planes) {
> +               if (*num_planes != pixfmt->num_planes)
> +                       return -EINVAL;
> +               for (i = 0; i < pixfmt->num_planes; ++i)
> +                       if (sizes[i] < pixfmt->plane_fmt[i].sizeimage)
> +                               return -EINVAL;
> +               return 0;
> +       }
> +
> +       *num_planes = pixfmt->num_planes;
> +       for (i = 0; i < pixfmt->num_planes; ++i)
> +               sizes[i] = pixfmt->plane_fmt[i].sizeimage;
> +       return 0;
> +}
> +
> +static int rockchip_vpu_buf_prepare(struct vb2_buffer *vb)
> +{
> +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +       struct vb2_queue *vq = vb->vb2_queue;
> +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vq);
> +       const struct rockchip_vpu_fmt *vpu_fmt;
> +       struct v4l2_pix_format_mplane *pixfmt;
> +       unsigned int sz;
> +       int ret = 0;
> +       int i;
> +
> +       switch (vq->type) {
> +       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> +               vpu_fmt = ctx->vpu_dst_fmt;
> +               pixfmt = &ctx->dst_fmt;
> +               break;
> +       case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> +               vpu_fmt = ctx->vpu_src_fmt;
> +               pixfmt = &ctx->src_fmt;
> +
> +               if (vbuf->field == V4L2_FIELD_ANY)
> +                       vbuf->field = V4L2_FIELD_NONE;
> +               if (vbuf->field != V4L2_FIELD_NONE) {
> +                       vpu_debug(4, "field %d not supported\n",
> +                                 vbuf->field);
> +                       return -EINVAL;
> +               }
> +               break;
> +       default:
> +               vpu_err("invalid queue type: %d\n", vq->type);
> +               return -EINVAL;
> +       }
> +
> +       for (i = 0; i < pixfmt->num_planes; ++i) {
> +               sz = pixfmt->plane_fmt[i].sizeimage;
> +               vpu_debug(4, "plane %d size: %ld, sizeimage: %u\n",
> +                         i, vb2_plane_size(vb, i), sz);
> +               if (vb2_plane_size(vb, i) < sz) {
> +                       vpu_err("plane %d is too small for output\n", i);
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static void rockchip_vpu_buf_queue(struct vb2_buffer *vb)
> +{
> +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +
> +       v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
> +}
> +
> +static int rockchip_vpu_start_streaming(struct vb2_queue *q, unsigned int count)
> +{
> +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(q);
> +       enum rockchip_vpu_codec_mode codec_mode;
> +       int ret = 0;
> +
> +       if (V4L2_TYPE_IS_OUTPUT(q->type))
> +               ctx->sequence_out = 0;
> +       else
> +               ctx->sequence_cap = 0;
> +
> +       codec_mode = ctx->vpu_src_fmt->codec_mode;
> +
> +       vpu_debug(4, "Codec mode = %d\n", codec_mode);
> +       ctx->codec_ops = &ctx->dev->variant->codec_ops[codec_mode];

Codec mode should be a function of the OUT queue, so I think this
should be also under if (V4L2_TYPE_IS_OUTPUT()). This would make most
of the code in this function specific to the OUT queue and possibly a
good argument for the comment about having separate vb2 queue ops I
posted above.

> +
> +       if (V4L2_TYPE_IS_OUTPUT(q->type))
> +               if (ctx->codec_ops && ctx->codec_ops->start)
> +                       ret = ctx->codec_ops->start(ctx);
> +       return ret;
> +}
> +
> +static void rockchip_vpu_stop_streaming(struct vb2_queue *q)
> +{
> +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(q);
> +
> +       if (V4L2_TYPE_IS_OUTPUT(q->type))
> +               if (ctx->codec_ops && ctx->codec_ops->stop)
> +                       ctx->codec_ops->stop(ctx);
> +
> +       /* The mem2mem framework calls v4l2_m2m_cancel_job before

CodingStyle: Multiline comments should start with one empty line.

> +        * .stop_streaming, so there isn't any job running and
> +        * it is safe to return all the buffers.
> +        */
> +       for (;;) {
> +               struct vb2_v4l2_buffer *vbuf;
> +
> +               if (V4L2_TYPE_IS_OUTPUT(q->type))
> +                       vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +               else
> +                       vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +               if (!vbuf)
> +                       break;
> +               v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req, &ctx->ctrl_handler);
> +               v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +       }
> +}
> +
> +static void rockchip_vpu_buf_request_complete(struct vb2_buffer *vb)
> +{
> +       struct rockchip_vpu_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> +
> +       v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->ctrl_handler);
> +}
> +
> +static int rockchip_vpu_buf_out_validate(struct vb2_buffer *vb)
> +{
> +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +
> +       vbuf->field = V4L2_FIELD_NONE;

Similar comment as in earlier patch. Is validate expected to correct
the values or just check?

> +       return 0;
> +}
> +
> +const struct vb2_ops rockchip_vpu_dec_queue_ops = {
> +       .queue_setup = rockchip_vpu_queue_setup,
> +       .buf_prepare = rockchip_vpu_buf_prepare,
> +       .buf_queue = rockchip_vpu_buf_queue,
> +       .buf_out_validate = rockchip_vpu_buf_out_validate,
> +       .buf_request_complete = rockchip_vpu_buf_request_complete,
> +       .start_streaming = rockchip_vpu_start_streaming,
> +       .stop_streaming = rockchip_vpu_stop_streaming,
> +       .wait_prepare = vb2_ops_wait_prepare,
> +       .wait_finish = vb2_ops_wait_finish,
> +};
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> index 937e9cfb4568..27a9da86f1d0 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> @@ -36,6 +36,11 @@ module_param_named(debug, rockchip_vpu_debug, int, 0644);
>  MODULE_PARM_DESC(debug,
>                  "Debug level - higher value produces more verbose messages");
>
> +enum rockchip_vpu_type {
> +       RK_VPU_ENCODER,
> +       RK_VPU_DECODER,
> +};

Given that we already have ctx->is_enc, any reason not to have this
represented in the same way everywhere?

> +
>  void *rockchip_vpu_get_ctrl(struct rockchip_vpu_ctx *ctx, u32 id)
>  {
>         struct v4l2_ctrl *ctrl;
> @@ -81,7 +86,11 @@ static void rockchip_vpu_job_finish(struct rockchip_vpu_dev *vpu,
>
>         avail_size = vb2_plane_size(&dst->vb2_buf, 0) -
>                      ctx->vpu_dst_fmt->header_size;
> -       if (bytesused <= avail_size) {
> +       /* For decoders set bytesused as per the output picture. */
> +       if (!ctx->is_enc) {
> +               dst->vb2_buf.planes[0].bytesused =
> +                       ctx->dst_fmt.plane_fmt[0].sizeimage;
> +       } else if (bytesused <= avail_size) {
>                 /*
>                  * This works while JPEG is the only encoder this driver
>                  * supports. We will have to abstract this step, or get

avail_size is specific for the encoder. How about clearly separating
decoder and encoder code with a separate if? It would introduce one
more level of nesting, but IMHO it would be more readable, due to
better separation of code paths. (Or going one step further, encoder
and decoder-specific code could be moved to separate functions.)

if (ctx->is_enc) {
  size_t avail_size = ...;
  // encoder code
  if (bytesused <= avail_size) {
    //
  } else {
    //
  }
} else {
  // decoder code
}

> @@ -159,6 +168,44 @@ static struct v4l2_m2m_ops vpu_m2m_ops = {
>         .device_run = device_run,
>  };
>
> +static int
> +dec_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
> +{
> +       struct rockchip_vpu_ctx *ctx = priv;
> +       int ret;
> +
> +       src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +       src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +       src_vq->drv_priv = ctx;
> +       src_vq->ops = &rockchip_vpu_dec_queue_ops;
> +       src_vq->mem_ops = &vb2_dma_contig_memops;
> +       src_vq->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES |
> +                           DMA_ATTR_NO_KERNEL_MAPPING;
> +       src_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
> +       src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +       src_vq->lock = &ctx->dev->vpu_mutex;
> +       src_vq->dev = ctx->dev->v4l2_dev.dev;
> +       src_vq->supports_requests = true;
> +
> +       ret = vb2_queue_init(src_vq);
> +       if (ret)
> +               return ret;
> +
> +       dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +       dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +       dst_vq->drv_priv = ctx;
> +       dst_vq->bidirectional = true;
> +       dst_vq->ops = &rockchip_vpu_dec_queue_ops;
> +       dst_vq->mem_ops = &vb2_dma_contig_memops;
> +       dst_vq->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES;

Any need for kernel mapping of decoder output?

Best regards,
Tomasz
