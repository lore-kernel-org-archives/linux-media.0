Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B40EC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E6020850
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 13:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfDJNni (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:43:38 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:48876 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730130AbfDJNni (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 09:43:38 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EDVnhl6wiNG8zEDVoh1IGR; Wed, 10 Apr 2019 15:43:37 +0200
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
 <20190408123256.22868-7-p.zabel@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
Date:   Wed, 10 Apr 2019 15:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408123256.22868-7-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMw5Di3IauigyjS2w1cCE7979FOaQaftk5lYeH6O4sFPEWOcoYJyomt4Jgta1x/LzsYjxI8PQDq4r473fPX8sqwjuAUUC/JTK7hmdy8Hw9xYFHDBFLcl
 aBiBCsIFJKlFhfMNxB/pgwoQu6UmjNpEAhHyd2l0+dqegYOH50yNB+f91RQyqw5/fV32GcQBdip9A0GMWHqPqT2bHKb8p531OQhl0CG2DvkFUA7b3S+o8CNo
 muBYomcU4vddj106AK/8evHE5dFhITaPJJuM++NvNPshOGyY8s9HXuBk+LcSIpXPAkV3GobRd26rfk+xr16//6b7JXQgW3zoEIzmDl6Rzouh6Tn9xqtdagg7
 ttWuay8V
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/8/19 2:32 PM, Philipp Zabel wrote:
> Let VIDIOC_ENUM_FRAMEINTERVALS return -EINVAL if userspace queries
> frame intervals for unsupported frame sizes.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/media/platform/coda/coda-common.c | 33 ++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index 943f003c26c4..2966eb1c4d2d 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -1117,7 +1117,8 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
>  				    struct v4l2_frmivalenum *f)
>  {
>  	struct coda_ctx *ctx = fh_to_ctx(fh);
> -	int i;
> +	struct coda_q_data *q_data;
> +	const struct coda_codec *codec;
>  
>  	if (f->index)
>  		return -EINVAL;
> @@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
>  	if (!ctx->vdoa && f->pixel_format == V4L2_PIX_FMT_YUYV)
>  		return -EINVAL;
>  
> -	for (i = 0; i < CODA_MAX_FORMATS; i++) {
> -		if (f->pixel_format == ctx->cvd->src_formats[i] ||
> -		    f->pixel_format == ctx->cvd->dst_formats[i])
> -			break;
> +	if (ctx->inst_type == CODA_INST_ENCODER) {
> +		if (coda_format_normalize_yuv(f->pixel_format) ==
> +		    V4L2_PIX_FMT_YUV420) {
> +			q_data = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> +			codec = coda_find_codec(ctx->dev, f->pixel_format,
> +						q_data->fourcc);
> +		} else {
> +			codec = coda_find_codec(ctx->dev, V4L2_PIX_FMT_YUV420,
> +						f->pixel_format);
> +		}
> +	} else {
> +		if (coda_format_normalize_yuv(f->pixel_format) ==
> +		    V4L2_PIX_FMT_YUV420) {
> +			q_data = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
> +			codec = coda_find_codec(ctx->dev, q_data->fourcc,
> +						f->pixel_format);
> +		} else {
> +			codec = coda_find_codec(ctx->dev, f->pixel_format,
> +						V4L2_PIX_FMT_YUV420);
> +		}
>  	}
> -	if (i == CODA_MAX_FORMATS)
> +	if (!codec)
> +		return -EINVAL;
> +
> +	if (f->width < MIN_W || f->width > codec->max_w ||
> +	    f->height < MIN_H || f->height > codec->max_h)
>  		return -EINVAL;
>  
>  	f->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
> 

Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no sense for a codec.
I'd remove it altogether.

Regards,

	Hans
