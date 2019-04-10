Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F98C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D7620830
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 13:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfDJNsv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:48:51 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:39986 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729829AbfDJNsv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 09:48:51 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EDaqhl96XNG8zEDarh1KBl; Wed, 10 Apr 2019 15:48:49 +0200
Subject: Re: [PATCH 08/10] media: coda: allow encoder to set colorimetry on
 the output queue
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
 <20190408123256.22868-8-p.zabel@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <1c5e978c-eecb-8847-8746-51e83e48ae85@xs4all.nl>
Date:   Wed, 10 Apr 2019 15:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408123256.22868-8-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPSvea72nqw+Pdqhsf2piATqu9G8s+se3AQw2p8bUV7QVLRUq16/IuR+sdCykH092qzFynxLA8T0/zqABK/pu+dtGLb8aqsWo8SW/5P7xYzZN0lcSvcl
 XVrb5rUI5uH6YRygUAb1NrUQdNNV3+TQ2WKWb/5a5O9kJ/UTLlcpIA3+T6Gjtnnxj2qYc1o2xPbFqfVufMPSMwJJZBuSQ0MZWgQmqTzvRqx1/HHW9aYj9veD
 ggwEcRSVTkRaz6hjnYwbymIkhlO7yk9WRd2jk19Lp1C4uNH9GG67iwGWYEkbBMviM1KFquNIUvozBgEpfOawZrL46KxW8LhT/Mr+keylY8uMxbZOd0qVJmBG
 sByjOoON
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/8/19 2:32 PM, Philipp Zabel wrote:
> v4l2-compliance sets colorimetry on the output queue and then verifies
> that querying colorimetry on the capture queue returns the same
> configuration. For this to work, the encoder must allow setting context
> colorimetry parameters on the output queue.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/media/platform/coda/coda-common.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index 2966eb1c4d2d..7b89dbae938d 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -819,6 +819,11 @@ static int coda_s_fmt_vid_out(struct file *file, void *priv,
>  	if (ret)
>  		return ret;
>  
> +	ctx->colorspace = f->fmt.pix.colorspace;
> +	ctx->xfer_func = f->fmt.pix.xfer_func;
> +	ctx->ycbcr_enc = f->fmt.pix.ycbcr_enc;
> +	ctx->quantization = f->fmt.pix.quantization;
> +
>  	if (ctx->inst_type != CODA_INST_DECODER)
>  		return 0;
>  
> @@ -831,11 +836,6 @@ static int coda_s_fmt_vid_out(struct file *file, void *priv,
>  	}
>  	ctx->codec = codec;
>  
> -	ctx->colorspace = f->fmt.pix.colorspace;
> -	ctx->xfer_func = f->fmt.pix.xfer_func;
> -	ctx->ycbcr_enc = f->fmt.pix.ycbcr_enc;
> -	ctx->quantization = f->fmt.pix.quantization;
> -
>  	dst_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
>  	if (!dst_vq)
>  		return -EINVAL;
> 

Isn't the colorimetry information encoded in the stream's metadata? So should
it be set in an encoder register so it ends up in the right place in the bitstream?

And for decoders it should then be read back from a register.

Just curious how this would work for this codec and if it is even possible.

For now this patch is OK, but I think more work is needed.

Regards,

	Hans
