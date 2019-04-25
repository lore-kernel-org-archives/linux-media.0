Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E04C43219
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7CB2053B
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDYSjq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:39:46 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:57553 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbfDYSjq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 14:39:46 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id JjHYhR1D5b8gSJjHbhoSNJ; Thu, 25 Apr 2019 20:39:44 +0200
Subject: Re: [PATCH 1/5] media: coda: Print a nicer device registered message
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org
Cc:     kernel@collabora.com
References: <20190425183546.16244-1-ezequiel@collabora.com>
 <20190425183546.16244-2-ezequiel@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <c2f859e4-970e-b30e-a367-fea7eab89132@xs4all.nl>
Date:   Thu, 25 Apr 2019 20:39:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190425183546.16244-2-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGfjUj97WkYilHUKwCbOT1ulIcyS+rtVHnORedUnhvneYa/zjm+bJi/chnuf68r8l07H/j4jMSMi3KcH5RSnB3CEd2N42osx5qoO7MpgzCHiNNIIz0zG
 slL4fInx7oFGe2hqpuOi3P9DROeHTkuLbM0R8gMltLfOoEZzfLm6gDStlW6ZbhxZnJ6YAJkO9ybx34Uuw0dV91pAt2FLnOVri+D83kXAes9hJIvN5wnROSTy
 EVCGeVNrdtB1VdYMH7rIFxgG8G1nBOyH6vVGPGYmoMPEbNh5RVWWOxgJYR9FqrOt
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/25/19 8:35 PM, Ezequiel Garcia wrote:
> This is just a cosmetic change to print a more descriptive
> message, to distinguish decoder from encoder:
> 
> So, instead of printing
> 
>   coda 2040000.vpu: codec registered as /dev/video[4-5]
> 
> With this change, the driver now prints
> 
>   coda 2040000.vpu: encoder registered as /dev/video4
>   coda 2040000.vpu: decoder registered as /dev/video5
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/media/platform/coda/coda-common.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index 3ce58dee4422..1f53ca4effd2 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -2480,9 +2480,12 @@ static int coda_hw_init(struct coda_dev *dev)
>  static int coda_register_device(struct coda_dev *dev, int i)
>  {
>  	struct video_device *vfd = &dev->vfd[i];
> +	enum coda_inst_type type;
> +	int ret;
>  
>  	if (i >= dev->devtype->num_vdevs)
>  		return -EINVAL;
> +	type = dev->devtype->vdevs[i]->type;
>  
>  	strscpy(vfd->name, dev->devtype->vdevs[i]->name, sizeof(vfd->name));
>  	vfd->fops	= &coda_fops;
> @@ -2498,7 +2501,12 @@ static int coda_register_device(struct coda_dev *dev, int i)
>  	v4l2_disable_ioctl(vfd, VIDIOC_G_CROP);
>  	v4l2_disable_ioctl(vfd, VIDIOC_S_CROP);
>  
> -	return video_register_device(vfd, VFL_TYPE_GRABBER, 0);
> +	ret = video_register_device(vfd, VFL_TYPE_GRABBER, 0);
> +	if (!ret)
> +		v4l2_info(&dev->v4l2_dev, "%s registered as /dev/video%d\n",
> +			  type == CODA_INST_ENCODER ? "encoder" : "decoder",
> +			  vfd->num);

You can use video_device_node_name() to print the video node name.

Regards,

	Hans

> +	return ret;
>  }
>  
>  static void coda_copy_firmware(struct coda_dev *dev, const u8 * const buf,
> @@ -2612,9 +2620,6 @@ static void coda_fw_callback(const struct firmware *fw, void *context)
>  		}
>  	}
>  
> -	v4l2_info(&dev->v4l2_dev, "codec registered as /dev/video[%d-%d]\n",
> -		  dev->vfd[0].num, dev->vfd[i - 1].num);
> -
>  	pm_runtime_put_sync(&pdev->dev);
>  	return;
>  
> 

