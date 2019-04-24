Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F44BC282CE
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 21:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DDF218B0
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 21:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfDXVcr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:32:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58552 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731194AbfDXVco (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 17:32:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 80F1D2639A7
Subject: Re: [PATCH v3 14/14] media: vimc: Create multiplanar parameter and
 ioctls
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, kernel@collabora.com,
        lucmaga@gmail.com, lkcamp@lists.libreplanetbr.org
References: <20190424135642.31973-1-andrealmeid@collabora.com>
 <20190424135642.31973-15-andrealmeid@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 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
Message-ID: <74e2ae03-5346-f167-b475-590730ca9eda@collabora.com>
Date:   Wed, 24 Apr 2019 18:32:32 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424135642.31973-15-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi André,

Thanks for the patch, please see my comments below.

On 4/24/19 10:56 AM, André Almeida wrote:
> Create multiplanar kernel module parameter to define if the driver is
> running in single planar or in multiplanar mode. Define the device
> capabilities and format ioctls according to the multiplanar kernel
> parameter. A device can't support both CAP_VIDEO_CAPTURE and
> CAP_VIDEO_CAPTURE_MPLANAR at the same time. Add functions to handle
> multiplanar format ioctls, calling the generic format ioctls functions
> when possible.>
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
> Change in v3:
> - Squash commit with "Add handler for multiplanar fmt ioctls" 

Was there any reason to squash those? Could you please unsquash it?
so we can have one commit with the handlers and the last one adding the
kernel parameter?

> - Remove functions that only did the `IS_MULTIPLANAR(vcap)` check
> - Assign ioctls according to device capabilities
> 
> Changes in v2:
> - Squash commits to create multiplanar module parameter and to define
> the device capabilities
> - Move the creation of the multiplanar parameter to the end of
> history, so it's only added when all required changes are applied
> 
>  drivers/media/platform/vimc/vimc-capture.c | 78 +++++++++++++++++++---
>  1 file changed, 70 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
> index 2592ea982ff8..27caf14ddf43 100644
> --- a/drivers/media/platform/vimc/vimc-capture.c
> +++ b/drivers/media/platform/vimc/vimc-capture.c
> @@ -28,6 +28,10 @@
>  
>  #define VIMC_CAP_DRV_NAME "vimc-capture"
>  
> +static unsigned int multiplanar;
> +module_param(multiplanar, uint, 0000);
> +MODULE_PARM_DESC(multiplanar, "0 (default) creates a single planar device, 1 creates a multiplanar device.");
> +
>  /* Checks if the device supports multiplanar capture */
>  #define IS_MULTIPLANAR(vcap) \
>  	(vcap->vdev.device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE)
> @@ -144,6 +148,10 @@ static void vimc_cap_get_format(struct vimc_ent_device *ved,
>  	*fmt = vcap->format.fmt.pix;
>  }
>  
> +/*
> + * Functions to handle both single- and multi-planar VIDIOC FMT
> + */
> +

This comment could be added in commit 5 (where the  single format
comment was added)

>  static int vimc_cap_g_fmt_vid_cap(struct file *file, void *priv,
>  				  struct v4l2_format *f)
>  {
> @@ -247,6 +255,41 @@ static int vimc_cap_s_fmt_vid_cap_sp(struct file *file, void *priv,
>  	return 0;
>  }
>  
> +/*
> + * VIDIOC handlers for multi-planar formats
> + */
> +static int vimc_cap_s_fmt_vid_cap_mp(struct file *file, void *priv,
> +				     struct v4l2_format *f)
> +{
> +	struct vimc_cap_device *vcap = video_drvdata(file);
> +
> +	/* Do not change the format while stream is on */
> +	if (vb2_is_busy(&vcap->queue))
> +		return -EBUSY;
> +
> +	vimc_cap_try_fmt_vid_cap_mp(file, priv, f);

I know the original code wasn't checking for errors in this func, you
could add a check here it would be great.

> +
> +	dev_dbg(vcap->dev, "%s: format update: "
> +		"old:%dx%d (0x%x, %d, %d, %d, %d) "
> +		"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vcap->vdev.name,
> +		/* old */
> +		vcap->format.fmt.pix_mp.width, vcap->format.fmt.pix_mp.height,
> +		vcap->format.fmt.pix_mp.pixelformat,
> +		vcap->format.fmt.pix_mp.colorspace,
> +		vcap->format.fmt.pix_mp.quantization,
> +		vcap->format.fmt.pix_mp.xfer_func,
> +		vcap->format.fmt.pix_mp.ycbcr_enc,
> +		/* new */
> +		f->fmt.pix_mp.width, f->fmt.pix_mp.height,
> +		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.colorspace,
> +		f->fmt.pix_mp.quantization, f->fmt.pix_mp.xfer_func,
> +		f->fmt.pix_mp.ycbcr_enc);
> +
> +	vcap->format = *f;
> +
> +	return 0;
> +}
> +
>  static bool vimc_cap_is_pixfmt_supported(u32 pixelformat)
>  {
>  	unsigned int i;
> @@ -257,6 +300,7 @@ static bool vimc_cap_is_pixfmt_supported(u32 pixelformat)
>  	return false;
>  }
>  
> +
>  static int vimc_cap_enum_framesizes(struct file *file, void *fh,
>  				    struct v4l2_frmsizeenum *fsize)
>  {
> @@ -287,13 +331,9 @@ static const struct v4l2_file_operations vimc_cap_fops = {
>  	.mmap           = vb2_fop_mmap,
>  };
>  
> -static const struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
> +static struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
>  	.vidioc_querycap = vimc_cap_querycap,
>  
> -	.vidioc_g_fmt_vid_cap = vimc_cap_g_fmt_vid_cap,
> -	.vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap_sp,
> -	.vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap_sp,
> -	.vidioc_enum_fmt_vid_cap = vimc_cap_enum_fmt_vid_cap,
>  	.vidioc_enum_framesizes = vimc_cap_enum_framesizes,
>  
>  	.vidioc_reqbufs = vb2_ioctl_reqbufs,
> @@ -529,6 +569,7 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
>  {
>  	struct v4l2_device *v4l2_dev = master_data;
>  	struct vimc_platform_data *pdata = comp->platform_data;
> +	struct v4l2_ioctl_ops *ioctl_ops = &vimc_cap_ioctl_ops;
>  	struct vimc_cap_device *vcap;
>  	struct video_device *vdev;
>  	struct vb2_queue *q;
> @@ -560,7 +601,9 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
>  
>  	/* Initialize the vb2 queue */
>  	q = &vcap->queue;
> -	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	q->type = multiplanar ?
> +		V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
> +		V4L2_BUF_TYPE_VIDEO_CAPTURE;
>  	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_USERPTR;
>  	q->drv_priv = vcap;
>  	q->buf_struct_size = sizeof(struct vimc_cap_buffer);
> @@ -588,13 +631,32 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
>  	dev_set_drvdata(comp, &vcap->ved);
>  	vcap->dev = comp;
>  
> +
>  	/* Initialize the video_device struct */
>  	vdev = &vcap->vdev;
> -	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	vdev->device_caps = (multiplanar ?
> +			V4L2_CAP_VIDEO_CAPTURE_MPLANE :
> +			V4L2_CAP_VIDEO_CAPTURE) | V4L2_CAP_STREAMING;
>  	vdev->entity.ops = &vimc_cap_mops;
>  	vdev->release = vimc_cap_release;
>  	vdev->fops = &vimc_cap_fops;
> -	vdev->ioctl_ops = &vimc_cap_ioctl_ops;
> +
> +	if (multiplanar) {

Please, use the IS_MULTIPLANAR macro here.

Helen

> +		ioctl_ops->vidioc_g_fmt_vid_cap_mplane = vimc_cap_g_fmt_vid_cap;
> +		ioctl_ops->vidioc_s_fmt_vid_cap_mplane =
> +						vimc_cap_s_fmt_vid_cap_mp;
> +		ioctl_ops->vidioc_try_fmt_vid_cap_mplane =
> +						vimc_cap_try_fmt_vid_cap_mp;
> +		ioctl_ops->vidioc_enum_fmt_vid_cap_mplane =
> +						vimc_cap_enum_fmt_vid_cap;
> +	} else {
> +		ioctl_ops->vidioc_g_fmt_vid_cap = vimc_cap_g_fmt_vid_cap;
> +		ioctl_ops->vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap_sp;
> +		ioctl_ops->vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap_sp;
> +		ioctl_ops->vidioc_enum_fmt_vid_cap = vimc_cap_enum_fmt_vid_cap;
> +	}
> +
> +	vdev->ioctl_ops = ioctl_ops;
>  	vdev->lock = &vcap->lock;
>  	vdev->queue = q;
>  	vdev->v4l2_dev = v4l2_dev;
> 
