Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3CC43331
	for <linux-media@archiver.kernel.org>; Wed, 17 Feb 2021 20:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AED64E79
	for <linux-media@archiver.kernel.org>; Wed, 17 Feb 2021 20:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhBQUd3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbhBQUcX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Feb 2021 15:32:23 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21476C061788;
        Wed, 17 Feb 2021 12:31:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 2B31F1F449DA
Message-ID: <339018869585eb2eb92cf16b765724a047eaef53.camel@collabora.com>
Subject: Re: [PATCH v1 10/18] media: hantro: Add helper functions for buffer
 information
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@siol.net, krzk@kernel.org, shengjiu.wang@nxp.com,
        adrian.ratiu@collabora.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        Anson.Huang@nxp.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel@collabora.com
Date:   Wed, 17 Feb 2021 17:31:30 -0300
In-Reply-To: <20210217080306.157876-11-benjamin.gaignard@collabora.com>
References: <20210217080306.157876-1-benjamin.gaignard@collabora.com>
         <20210217080306.157876-11-benjamin.gaignard@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Benjamin,

On Wed, 2021-02-17 at 09:02 +0100, Benjamin Gaignard wrote:
> Add help functions to retrieve buffer address and size.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  drivers/staging/media/hantro/hantro.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 2523c0d010df..a9b80b2c9124 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -430,6 +430,22 @@ hantro_get_dec_buf_addr(struct hantro_ctx *ctx, struct vb2_buffer *vb)
>         return vb2_dma_contig_plane_dma_addr(vb, 0);
>  }
>  
> +static inline size_t
> +hantro_get_dec_buf_size(struct hantro_ctx *ctx, struct vb2_buffer *vb)
> +{
> +       if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
> +               return ctx->postproc.dec_q[vb->index].size;
> +       return vb2_plane_size(vb, 0);
> +}
> +
> +static inline void *
> +hantro_get_dec_buf(struct hantro_ctx *ctx, struct vb2_buffer *vb)
> +{
> +       if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
> +               return ctx->postproc.dec_q[vb->index].cpu;
> +       return vb2_plane_vaddr(vb, 0);
> +}
> +

It may sound like a nitpick but I think you could just squash this
change where it's needed. That way it's easier to review and
see why this was added.

Thanks,
Ezequiel

