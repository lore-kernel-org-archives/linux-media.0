Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4672CC43218
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A000F2077C
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDYSzM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:55:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35536 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYSzM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 14:55:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5BF1226117E
Message-ID: <cc6c0b45e42d4d5ec2ebb8c656b9434dd6a7b484.camel@collabora.com>
Subject: Re: [PATCH 13/13] media: coda: fix unset field and fail on invalid
 field in buf_prepare
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Thu, 25 Apr 2019 15:55:05 -0300
In-Reply-To: <20190412155135.13907-13-p.zabel@pengutronix.de>
References: <20190412155135.13907-1-p.zabel@pengutronix.de>
         <20190412155135.13907-13-p.zabel@pengutronix.de>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 2019-04-12 at 17:51 +0200, Philipp Zabel wrote:
> v4l2-compliance likes to queue a buffer with field set to V4L2_FIELD_ANY
> and expects it to be returned corrected to a valid field.
> 
> Follow vicodec in handling this in the buf_prepare callback.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/media/platform/coda/coda-common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index 1cd0fb5b1c5b..1d8e0a045df1 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -1515,10 +1515,20 @@ static int coda_queue_setup(struct vb2_queue *vq,
>  
>  static int coda_buf_prepare(struct vb2_buffer *vb)
>  {
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>  	struct coda_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
>  	struct coda_q_data *q_data;
>  
>  	q_data = get_q_data(ctx, vb->vb2_queue->type);
> +	if (V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type)) {
> +		if (vbuf->field == V4L2_FIELD_ANY)
> +			vbuf->field = V4L2_FIELD_NONE;
> +		if (vbuf->field != V4L2_FIELD_NONE) {
> +			v4l2_warn(&ctx->dev->v4l2_dev,
> +				  "%s field isn't supported\n", __func__);
> +			return -EINVAL;
> +		}
> +	}
>  
>  	if (vb2_plane_size(vb, 0) < q_data->sizeimage) {
>  		v4l2_warn(&ctx->dev->v4l2_dev,

I believe instead of this, you can just populate your buf_out_validate
like this:

static int coda_buf_out_validate(struct vb2_buffer *vb)
{
        struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);

        vbuf->field = V4L2_FIELD_NONE;
        return 0;
}

Thanks,
Eze

