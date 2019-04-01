Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28406C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 03:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65DA20879
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 03:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MtrJ5gtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfDADwX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:52:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39522 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfDADwW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 31 Mar 2019 23:52:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so7246846otb.6
        for <linux-media@vger.kernel.org>; Sun, 31 Mar 2019 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOXdUHU7+3mCXeD6BPT/cLikfD4GiCk882RvYzrooF4=;
        b=MtrJ5gtSVxkqr/e5kdjHUcpyO74UzFO1mDuZwWUp8cg1knjhapg6UuQCFRhycch2nF
         c+rzIxlo6VrHvZG7GHZCmxTics8V9gZ2RfwUeUMr9lgHllwguJCk5Em7ggidndC+RyQ8
         xCAa7sbt9SDmxUIfdqre7XpMaNf7BVdLAhcpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOXdUHU7+3mCXeD6BPT/cLikfD4GiCk882RvYzrooF4=;
        b=OVqSQ3C1CWKNXX7974cEHZRpCW6S3/bUARYMYJQogcbX7c64g77YUOmERVzj3xILZa
         N+FbsnMLgwDi6iHlEYoDYZrkTImzCi+1ClvRFK1RB8fchM2zpqPjeFNHeRxyL9+ag/ob
         amdJmdxt0FHQa0dIsXlBJuOudNqPREBg1drTrecEg8DcE3Mn+1/yLr+M82DTFSJ8C7Sq
         mY00FSs1Rf7PmSYTcjlocQ8fygV+zA0UT2t2+ZA8MpLM5Ceoaaqa+bWKZ2Y61ZxC129z
         3TpSN5cQhT6Z6+q+q1WqgHdnifxLRt35ICDEvR5dEuEMxo0Gdx1H4BzK0V0/FipC4PiN
         1ARQ==
X-Gm-Message-State: APjAAAV3DqmnDBpjxOAj01MEhZEpja9CCujbGRsWLA5cWDE3R0m0Yj2V
        UDuuI2EwO8YMxx9fpP8ysaeZ0/H6xYg=
X-Google-Smtp-Source: APXvYqxONzWcvKM5dPn3jcF6644E9StE9w0nxN7p6s3g+aQAQxkcGhxkShl0BS0cMOw4ExnFyS2Jbw==
X-Received: by 2002:a9d:644c:: with SMTP id m12mr44460586otl.59.1554090741305;
        Sun, 31 Mar 2019 20:52:21 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id t14sm4195019otj.23.2019.03.31.20.52.20
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 20:52:20 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id j10so7386946otq.0
        for <linux-media@vger.kernel.org>; Sun, 31 Mar 2019 20:52:20 -0700 (PDT)
X-Received: by 2002:a9d:63d5:: with SMTP id e21mr24086166otl.288.1554090739737;
 Sun, 31 Mar 2019 20:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com> <20190304192529.14200-12-ezequiel@collabora.com>
In-Reply-To: <20190304192529.14200-12-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 1 Apr 2019 12:52:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C0-v=ZiOt36ibuO6uo3+0GzD-DBifKsY5v1d6ukvrnfA@mail.gmail.com>
Message-ID: <CAAFQd5C0-v=ZiOt36ibuO6uo3+0GzD-DBifKsY5v1d6ukvrnfA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] rockchip/vpu: Add support for MPEG-2 decoding
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
> From: Jonas Karlman <jonas@kwiboo.se>
>
[snip]
> +
> +#define PICT_TOP_FIELD     1
> +#define PICT_BOTTOM_FIELD  2
> +#define PICT_FRAME         3

These 3 seem to be the standard values applying to some fields of the
MPEG2 controls. Why aren't they defined next to corresponding
structures?

> +
> +static void
> +rk3399_vpu_mpeg2_dec_set_quantization(struct rockchip_vpu_dev *vpu,
> +                                     struct rockchip_vpu_ctx *ctx)
> +{
> +       struct v4l2_ctrl_mpeg2_quantization *quantization;
> +
> +       quantization = rockchip_vpu_get_ctrl(ctx,
> +                               V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);
> +       rockchip_vpu_mpeg2_dec_copy_qtable(ctx->mpeg2_dec_ctx.qtable.cpu, quantization);
> +       vdpu_write_relaxed(vpu, ctx->mpeg2_dec_ctx.qtable.dma, VDPU_REG_QTABLE_BASE);
> +}
> +
> +static void rk3399_vpu_mpeg2_dec_set_buffers(struct rockchip_vpu_dev *vpu,
> +                                            struct rockchip_vpu_ctx *ctx,
> +                                            struct vb2_buffer *src_buf,
> +                                            struct vb2_buffer *dst_buf,
> +                                            const struct v4l2_mpeg2_sequence *sequence,
> +                                            const struct v4l2_mpeg2_picture *picture,
> +                                            const struct v4l2_ctrl_mpeg2_slice_params *slice_params)
> +{
> +       dma_addr_t forward_addr = 0, backward_addr = 0;
> +       dma_addr_t current_addr, addr;
> +       struct vb2_queue *vq;
> +
> +       vq = v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
> +
> +       switch (picture->picture_coding_type) {
> +       case V4L2_MPEG2_PICTURE_CODING_TYPE_B:
> +               backward_addr = rockchip_vpu_get_ref(vq, slice_params->backward_ref_ts);
> +               /* fall-through */
> +       case V4L2_MPEG2_PICTURE_CODING_TYPE_P:
> +               forward_addr = rockchip_vpu_get_ref(vq, slice_params->forward_ref_ts);
> +       }
> +
> +       /* Source bitstream buffer */
> +       addr = vb2_dma_contig_plane_dma_addr(src_buf, 0);
> +       vdpu_write_relaxed(vpu, addr, VDPU_REG_RLC_VLC_BASE);
> +
> +       /* Destination frame buffer */
> +       addr = vb2_dma_contig_plane_dma_addr(dst_buf, 0);
> +       current_addr = addr;
> +
> +       if (picture->picture_structure == PICT_BOTTOM_FIELD)
> +               addr += DIV_ROUND_UP(sequence->horizontal_size, 16) << 4;

Shouldn't this rather use the bytesperline taken from ctx->dst_fmt?

Also, why do we divide it (with rounding up) by 16 and then again
multiply by 16 (=== << 4)? Isn't this just ALIGN(..., 16)?

> +       vdpu_write_relaxed(vpu, addr, VDPU_REG_DEC_OUT_BASE);
> +
> +       if (!forward_addr)
> +               forward_addr = current_addr;
> +       if (!backward_addr)
> +               backward_addr = current_addr;
> +
> +       /* Set forward ref frame (top/bottom field) */
> +       if (picture->picture_structure == PICT_FRAME ||
> +           picture->picture_coding_type == V4L2_MPEG2_PICTURE_CODING_TYPE_B ||
> +           (picture->picture_structure == PICT_TOP_FIELD && picture->top_field_first) ||
> +           (picture->picture_structure == PICT_BOTTOM_FIELD && !picture->top_field_first)) {
> +               vdpu_write_relaxed(vpu, forward_addr, VDPU_REG_REFER0_BASE);
> +               vdpu_write_relaxed(vpu, forward_addr, VDPU_REG_REFER1_BASE);
> +       } else if (picture->picture_structure == PICT_TOP_FIELD) {
> +               vdpu_write_relaxed(vpu, forward_addr, VDPU_REG_REFER0_BASE);
> +               vdpu_write_relaxed(vpu, current_addr, VDPU_REG_REFER1_BASE);
> +       } else if (picture->picture_structure == PICT_BOTTOM_FIELD) {
> +               vdpu_write_relaxed(vpu, current_addr, VDPU_REG_REFER0_BASE);
> +               vdpu_write_relaxed(vpu, forward_addr, VDPU_REG_REFER1_BASE);
> +       }
> +
> +       /* Set backward ref frame (top/bottom field) */
> +       vdpu_write_relaxed(vpu, backward_addr, VDPU_REG_REFER2_BASE);
> +       vdpu_write_relaxed(vpu, backward_addr, VDPU_REG_REFER3_BASE);
> +}
> +
> +void rk3399_vpu_mpeg2_dec_run(struct rockchip_vpu_ctx *ctx)
> +{
> +       struct rockchip_vpu_dev *vpu = ctx->dev;
> +       struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +       const struct v4l2_ctrl_mpeg2_slice_params *slice_params;
> +       const struct v4l2_mpeg2_sequence *sequence;
> +       const struct v4l2_mpeg2_picture *picture;
> +       u32 reg;
> +
> +       src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> +       dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> +
> +       /* Apply request controls if any */
> +       v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
> +                               &ctx->ctrl_handler);
> +
> +       slice_params = rockchip_vpu_get_ctrl(ctx,
> +                               V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS);
> +       if (!slice_params)
> +               return;

Shouldn't we fail the run here (i.e. return the buffers with error
state)? But actually, is this even possible to happen?

> +       sequence = &slice_params->sequence;
> +       picture = &slice_params->picture;
> +
> +       reg = VDPU_REG_DEC_ADV_PRE_DIS(0) |
> +             VDPU_REG_DEC_SCMD_DIS(0) |
> +             VDPU_REG_FILTERING_DIS(1) |
> +             VDPU_REG_DEC_LATENCY(0);
> +       vdpu_write_relaxed(vpu, reg, VDPU_SWREG(50));
> +
> +       reg = VDPU_REG_INIT_QP(1) |
> +             VDPU_REG_STREAM_LEN(slice_params->bit_size >> 3);
> +       vdpu_write_relaxed(vpu, reg, VDPU_SWREG(51));
> +
> +       reg = VDPU_REG_APF_THRESHOLD(8) |
> +             VDPU_REG_STARTMB_X(0) |
> +             VDPU_REG_STARTMB_Y(0);
> +       vdpu_write_relaxed(vpu, reg, VDPU_SWREG(52));
> +
> +       reg = VDPU_REG_DEC_MODE(5);
> +       vdpu_write_relaxed(vpu, reg, VDPU_SWREG(53));
> +
> +       reg = VDPU_REG_DEC_STRENDIAN_E(1) |
> +             VDPU_REG_DEC_STRSWAP32_E(1) |
> +             VDPU_REG_DEC_OUTSWAP32_E(1) |
> +             VDPU_REG_DEC_INSWAP32_E(1) |
> +             VDPU_REG_DEC_OUT_ENDIAN(1) |
> +             VDPU_REG_DEC_IN_ENDIAN(1);
> +       vdpu_write_relaxed(vpu, reg, VDPU_SWREG(54));
> +
> +       reg = VDPU_REG_DEC_DATA_DISC_E(0) |
> +             VDPU_REG_DEC_MAX_BURST(16) |
> +             VDPU_REG_DEC_AXI_WR_ID(0) |
> +             VDPU_REG_DEC_AXI_RD_ID(0);
> +       vdpu_write_relaxed(vpu, reg, VDPU_SWREG(56));
> +
> +       reg = VDPU_REG_RLC_MODE_E(0) |
> +             VDPU_REG_PIC_INTERLACE_E(!sequence->progressive_sequence) |
> +             VDPU_REG_PIC_FIELDMODE_E(picture->picture_structure != PICT_FRAME) |
> +             VDPU_REG_PIC_B_E(picture->picture_coding_type == V4L2_MPEG2_PICTURE_CODING_TYPE_B) |
> +             VDPU_REG_PIC_INTER_E(picture->picture_coding_type != V4L2_MPEG2_PICTURE_CODING_TYPE_I) |
> +             VDPU_REG_PIC_TOPFIELD_E(picture->picture_structure == PICT_TOP_FIELD) |
> +             VDPU_REG_FWD_INTERLACE_E(0) |
> +             VDPU_REG_WRITE_MVS_E(0) |
> +             VDPU_REG_DEC_TIMEOUT_E(1) |
> +             VDPU_REG_DEC_CLK_GATE_E(1);
> +       vdpu_write_relaxed(vpu, reg, VDPU_SWREG(57));
> +
> +       reg = VDPU_REG_PIC_MB_WIDTH(DIV_ROUND_UP(sequence->horizontal_size, 16)) |
> +             VDPU_REG_PIC_MB_HEIGHT_P(DIV_ROUND_UP(sequence->vertical_size, 16)) |

This should also come from the format. (The format should be detected
based on those fields, before allocating buffers, though.)

Best regards,
Tomasz
