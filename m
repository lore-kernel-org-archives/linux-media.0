Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A74C10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 23:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B565220811
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 23:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfDXXEO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:04:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58848 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfDXXEO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 19:04:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 5A9F7280B9F
Subject: Re: [PATCH v3 14/14] media: vimc: Create multiplanar parameter and
 ioctls
To:     Helen Koike <helen.koike@collabora.com>,
        linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, kernel@collabora.com,
        lucmaga@gmail.com, lkcamp@lists.libreplanetbr.org
References: <20190424135642.31973-1-andrealmeid@collabora.com>
 <20190424135642.31973-15-andrealmeid@collabora.com>
 <74e2ae03-5346-f167-b475-590730ca9eda@collabora.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <bff28ba1-3f05-b832-ab56-7c4b399f9748@collabora.com>
Date:   Wed, 24 Apr 2019 20:03:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <74e2ae03-5346-f167-b475-590730ca9eda@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Helen,

Thanks for your review!

On 4/24/19 6:32 PM, Helen Koike wrote:
> Hi André,
>
> Thanks for the patch, please see my comments below.
>
> On 4/24/19 10:56 AM, André Almeida wrote:
>> Create multiplanar kernel module parameter to define if the driver is
>> running in single planar or in multiplanar mode. Define the device
>> capabilities and format ioctls according to the multiplanar kernel
>> parameter. A device can't support both CAP_VIDEO_CAPTURE and
>> CAP_VIDEO_CAPTURE_MPLANAR at the same time. Add functions to handle
>> multiplanar format ioctls, calling the generic format ioctls functions
>> when possible.>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>> Change in v3:
>> - Squash commit with "Add handler for multiplanar fmt ioctls" 
> Was there any reason to squash those? Could you please unsquash it?
> so we can have one commit with the handlers and the last one adding the
> kernel parameter?

It was because if I add those functions to the code, it would give the
warning of function defined but not used. I only use the multiplanar
format ioctls when the multiplanar variable exists.

>> - Remove functions that only did the `IS_MULTIPLANAR(vcap)` check
>> - Assign ioctls according to device capabilities
>>
>> Changes in v2:
>> - Squash commits to create multiplanar module parameter and to define
>> the device capabilities
>> - Move the creation of the multiplanar parameter to the end of
>> history, so it's only added when all required changes are applied
>>
>>  drivers/media/platform/vimc/vimc-capture.c | 78 +++++++++++++++++++---
>>  1 file changed, 70 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
>> index 2592ea982ff8..27caf14ddf43 100644
>> --- a/drivers/media/platform/vimc/vimc-capture.c
>> +++ b/drivers/media/platform/vimc/vimc-capture.c
>> @@ -28,6 +28,10 @@
>>  
>>  #define VIMC_CAP_DRV_NAME "vimc-capture"
>>  
>> +static unsigned int multiplanar;
>> +module_param(multiplanar, uint, 0000);
>> +MODULE_PARM_DESC(multiplanar, "0 (default) creates a single planar device, 1 creates a multiplanar device.");
>> +
>>  /* Checks if the device supports multiplanar capture */
>>  #define IS_MULTIPLANAR(vcap) \
>>  	(vcap->vdev.device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE)
>> @@ -144,6 +148,10 @@ static void vimc_cap_get_format(struct vimc_ent_device *ved,
>>  	*fmt = vcap->format.fmt.pix;
>>  }
>>  
>> +/*
>> + * Functions to handle both single- and multi-planar VIDIOC FMT
>> + */
>> +
> This comment could be added in commit 5 (where the  single format
> comment was added)
>
>>  static int vimc_cap_g_fmt_vid_cap(struct file *file, void *priv,
>>  				  struct v4l2_format *f)
>>  {
>> @@ -247,6 +255,41 @@ static int vimc_cap_s_fmt_vid_cap_sp(struct file *file, void *priv,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * VIDIOC handlers for multi-planar formats
>> + */
>> +static int vimc_cap_s_fmt_vid_cap_mp(struct file *file, void *priv,
>> +				     struct v4l2_format *f)
>> +{
>> +	struct vimc_cap_device *vcap = video_drvdata(file);
>> +
>> +	/* Do not change the format while stream is on */
>> +	if (vb2_is_busy(&vcap->queue))
>> +		return -EBUSY;
>> +
>> +	vimc_cap_try_fmt_vid_cap_mp(file, priv, f);
> I know the original code wasn't checking for errors in this func, you
> could add a check here it would be great.
What kind of error checking? Checking if the try format was successful?
>
>> +
>> +	dev_dbg(vcap->dev, "%s: format update: "
>> +		"old:%dx%d (0x%x, %d, %d, %d, %d) "
>> +		"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vcap->vdev.name,
>> +		/* old */
>> +		vcap->format.fmt.pix_mp.width, vcap->format.fmt.pix_mp.height,
>> +		vcap->format.fmt.pix_mp.pixelformat,
>> +		vcap->format.fmt.pix_mp.colorspace,
>> +		vcap->format.fmt.pix_mp.quantization,
>> +		vcap->format.fmt.pix_mp.xfer_func,
>> +		vcap->format.fmt.pix_mp.ycbcr_enc,
>> +		/* new */
>> +		f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>> +		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.colorspace,
>> +		f->fmt.pix_mp.quantization, f->fmt.pix_mp.xfer_func,
>> +		f->fmt.pix_mp.ycbcr_enc);
>> +
>> +	vcap->format = *f;
>> +
>> +	return 0;
>> +}
>> +
>>  static bool vimc_cap_is_pixfmt_supported(u32 pixelformat)
>>  {
>>  	unsigned int i;
>> @@ -257,6 +300,7 @@ static bool vimc_cap_is_pixfmt_supported(u32 pixelformat)
>>  	return false;
>>  }
>>  
>> +
>>  static int vimc_cap_enum_framesizes(struct file *file, void *fh,
>>  				    struct v4l2_frmsizeenum *fsize)
>>  {
>> @@ -287,13 +331,9 @@ static const struct v4l2_file_operations vimc_cap_fops = {
>>  	.mmap           = vb2_fop_mmap,
>>  };
>>  
>> -static const struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
>> +static struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
>>  	.vidioc_querycap = vimc_cap_querycap,
>>  
>> -	.vidioc_g_fmt_vid_cap = vimc_cap_g_fmt_vid_cap,
>> -	.vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap_sp,
>> -	.vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap_sp,
>> -	.vidioc_enum_fmt_vid_cap = vimc_cap_enum_fmt_vid_cap,
>>  	.vidioc_enum_framesizes = vimc_cap_enum_framesizes,
>>  
>>  	.vidioc_reqbufs = vb2_ioctl_reqbufs,
>> @@ -529,6 +569,7 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
>>  {
>>  	struct v4l2_device *v4l2_dev = master_data;
>>  	struct vimc_platform_data *pdata = comp->platform_data;
>> +	struct v4l2_ioctl_ops *ioctl_ops = &vimc_cap_ioctl_ops;
>>  	struct vimc_cap_device *vcap;
>>  	struct video_device *vdev;
>>  	struct vb2_queue *q;
>> @@ -560,7 +601,9 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
>>  
>>  	/* Initialize the vb2 queue */
>>  	q = &vcap->queue;
>> -	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> +	q->type = multiplanar ?
>> +		V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
>> +		V4L2_BUF_TYPE_VIDEO_CAPTURE;
>>  	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_USERPTR;
>>  	q->drv_priv = vcap;
>>  	q->buf_struct_size = sizeof(struct vimc_cap_buffer);
>> @@ -588,13 +631,32 @@ static int vimc_cap_comp_bind(struct device *comp, struct device *master,
>>  	dev_set_drvdata(comp, &vcap->ved);
>>  	vcap->dev = comp;
>>  
>> +
>>  	/* Initialize the video_device struct */
>>  	vdev = &vcap->vdev;
>> -	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
>> +	vdev->device_caps = (multiplanar ?
>> +			V4L2_CAP_VIDEO_CAPTURE_MPLANE :
>> +			V4L2_CAP_VIDEO_CAPTURE) | V4L2_CAP_STREAMING;
>>  	vdev->entity.ops = &vimc_cap_mops;
>>  	vdev->release = vimc_cap_release;
>>  	vdev->fops = &vimc_cap_fops;
>> -	vdev->ioctl_ops = &vimc_cap_ioctl_ops;
>> +
>> +	if (multiplanar) {
> Please, use the IS_MULTIPLANAR macro here.

The IS_MULTIPLANAR macro depends on the vcap->vdev.device_caps being
assigned but vcap->vdev is only assigned on line 663, and to do this
assignment, the vdev->ioctl_ops must be defined.

André

> Helen
>
>> +		ioctl_ops->vidioc_g_fmt_vid_cap_mplane = vimc_cap_g_fmt_vid_cap;
>> +		ioctl_ops->vidioc_s_fmt_vid_cap_mplane =
>> +						vimc_cap_s_fmt_vid_cap_mp;
>> +		ioctl_ops->vidioc_try_fmt_vid_cap_mplane =
>> +						vimc_cap_try_fmt_vid_cap_mp;
>> +		ioctl_ops->vidioc_enum_fmt_vid_cap_mplane =
>> +						vimc_cap_enum_fmt_vid_cap;
>> +	} else {
>> +		ioctl_ops->vidioc_g_fmt_vid_cap = vimc_cap_g_fmt_vid_cap;
>> +		ioctl_ops->vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap_sp;
>> +		ioctl_ops->vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap_sp;
>> +		ioctl_ops->vidioc_enum_fmt_vid_cap = vimc_cap_enum_fmt_vid_cap;
>> +	}
>> +
>> +	vdev->ioctl_ops = ioctl_ops;
>>  	vdev->lock = &vcap->lock;
>>  	vdev->queue = q;
>>  	vdev->v4l2_dev = v4l2_dev;
>>

