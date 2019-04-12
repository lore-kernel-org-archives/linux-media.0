Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064BDC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 09:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF396205F4
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 09:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDLJbq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:31:46 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:45983 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfDLJbp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 05:31:45 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EsX7hzeJVNG8zEsX8hC4G2; Fri, 12 Apr 2019 11:31:43 +0200
Subject: Re: [PATCH v3 1/2] media: exynos4-is: Properly report _MPLANE caps
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     kernel@collabora.com, Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
References: <20190412092027.20410-1-boris.brezillon@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <62460a3c-b627-7c7f-5c0d-8f2d242ce83e@xs4all.nl>
Date:   Fri, 12 Apr 2019 11:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412092027.20410-1-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNeLQJ4eki4FSXUIAbxbYUloI2iP8EeaONH3R8fbKYjdsObdfgH5SPyYrqDaxLsswiuqQ7M3dq8nWucdMjZM86ypeTQoxss9cQlWgt/yupI0fCQQjg9F
 w9jPfpY/UUDBgDFXohHwIZ+xKWr1I7CrvUYPJ30MwQtlIAJev3+QWPl3FxjQwyw9DQjVwCZZ0TCFlaMjY3HZVkAFTIJuB9lNhUcQVuF1Aqs35+3+8YY3WZJr
 a+Mfy2cvc6fClniRxjtr11HG3QLoGbq3xPH4UjFaQROFsxIkPOTic6QrdXTya1KoewsXKgtGNLGymL77HHyZET5cVCtuGpPFHYu8B3/MqOe5HHJurlSC98y6
 2mHzVdnTjnl/SbxIaKhztHoWUH/CjXTKM+C275pyozPw4VnvTLTptKLmfNcACzf0S907EGLhNKEIQCErXhN6pfkvAKFN6eWukox1jT7YUds55eLRIKD/SuC5
 722FTQ8E5BVXBBPB2jZ6q84fUCu1s/iDfDok8p3eHZlQ2l7zjuqxqhKvoXk+GydQgWFile0UCDV96cWvCxMIW6KR7ezUS2G7pPo5484RrUUcw97RCv7Y0wIn
 deg=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/12/19 11:20 AM, Boris Brezillon wrote:
> The fimc-isp-video.c and fimc-lite.c were missing the
> V4L2_CAP_VIDEO_CAPTURE_MPLANE flag when reporting device caps.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Changes in v3:
> - New patch
> ---
>  drivers/media/platform/exynos4-is/fimc-isp-video.c | 4 +++-
>  drivers/media/platform/exynos4-is/fimc-lite.c      | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/media/platform/exynos4-is/fimc-isp-video.c
> index bb35a2017f21..8cd7b1c6565c 100644
> --- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
> +++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
> @@ -349,7 +349,9 @@ static int isp_video_querycap(struct file *file, void *priv,
>  {
>  	struct fimc_isp *isp = video_drvdata(file);
>  
> -	__fimc_vidioc_querycap(&isp->pdev->dev, cap, V4L2_CAP_STREAMING);
> +	__fimc_vidioc_querycap(&isp->pdev->dev, cap,
> +			       V4L2_CAP_STREAMING |
> +			       V4L2_CAP_VIDEO_CAPTURE_MPLANE);
>  	return 0;
>  }
>  
> diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/exynos4-is/fimc-lite.c
> index 96f0a8a0dcae..13dfa5e39139 100644
> --- a/drivers/media/platform/exynos4-is/fimc-lite.c
> +++ b/drivers/media/platform/exynos4-is/fimc-lite.c
> @@ -659,7 +659,7 @@ static int fimc_lite_querycap(struct file *file, void *priv,
>  	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
>  					dev_name(&fimc->pdev->dev));
>  
> -	cap->device_caps = V4L2_CAP_STREAMING;
> +	cap->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING;
>  	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;

That's not what should happen. The driver should set device_caps in the struct
video_device, and then it can drop setting cap->device_caps and cap->capabilities
from the querycap implementation (it will be set by the v4l2 core based on the
vdev->device_caps value).

It definitely is a (surprising!) bug that V4L2_CAP_VIDEO_CAPTURE_MPLANE wasn't
set here, but the real thing that you should check MPLANE capable drivers for is
that they set vdev->device_caps.

Regards,

	Hans

>  	return 0;
>  }
> 

