Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88907C10F0E
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 22:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D28D21479
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 22:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNOc3VF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfDRWNM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:13:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39382 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfDRWNM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 18:13:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so4764415wrn.6
        for <linux-media@vger.kernel.org>; Thu, 18 Apr 2019 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Uy/0DDNtgLljKpsFCuW3fUSCZfECyjIJM0kScGu5MqE=;
        b=hNOc3VF36F2HI6vrbsrSQhc7ZO9Fzb+mLWVCuKja20e25kd2E6bTxsblytLbTAid+y
         zrVBb7HcKEdvb+ZpAWDHLdPVAH3geBlRYACiV0gQuYcpHpPyETOelq6Q/8i2ke6icidn
         wnqZgaX4xSKphZNzsmlUxvX7k2/Qdkx/Ial7/6QBo8Kdctuqx0z7IWsU103FtbBFW+Kz
         wUNGt2kVoxE/s4D22QtC4csDxUMLp/jyAMmVX31bmA2NhXoMGS0EAo8ONsQyk1ZTyYc2
         rDDbNmOVMh5dgqxRLet0v020lHFox/9qknVmpwQMbyd7m6QoutSrBA036X7ZqaWsq0Jl
         DAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Uy/0DDNtgLljKpsFCuW3fUSCZfECyjIJM0kScGu5MqE=;
        b=RB/FN4y7tmaBgB9deCi17EfmOgyilXIvSYk8yO1uzT1ZkJWnie9STdEoBlOd3xSXzo
         75FhzAgN9tcmxK4kp8LXN8l+WXKpgx38MznZLQGb0YKMPiForj1FQ7lo66tgCDVMboQu
         SqRssk3yTE+RcjPpzmVENL6hUUPCBihEJYPJNb/7yfGvjXSf6RABIe40Dw4ipmu2BjYt
         bajvV2Ft8oUjwiJDIrAp6TdcxS+7/xMULOH9ci2TmXkNCYkdYDy5uC2R+UQKX6/3JbG8
         TQG3Y9/B+rUvwJ3DySpQpB4LNaRPgYUE8nf0R0QB8WqtpzTnQK5d5qXJCcSK0pihbAkI
         Ypew==
X-Gm-Message-State: APjAAAVAwywHvdJrnAe9Ix/epsZPB0vRjOFM0mbepaq2BHwN7JYmmr2h
        bvR4yKvUihaPYn8vsyUmCzJv/lRn
X-Google-Smtp-Source: APXvYqypmE0qKy1+6usUUuDhejYN4uTcA+kgMBS/NxL9aTXNVbwXMCiPYUiDviFIUiTt7iuHBKOACQ==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr317599wrs.5.1555625589571;
        Thu, 18 Apr 2019 15:13:09 -0700 (PDT)
Received: from [172.30.89.158] (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id i18sm2409894wrm.7.2019.04.18.15.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 15:13:08 -0700 (PDT)
Subject: Re: [PATCH] media: staging/imx: add media device to capture register
To:     Rui Miguel Silva <rui.silva@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devel@driverdev.osuosl.org, linux-media@vger.kernel.org
References: <20190412164400.1270-1-rui.silva@linaro.org>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <ae314f91-9f1d-c372-ea1a-722978f517ba@gmail.com>
Date:   Thu, 18 Apr 2019 15:13:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412164400.1270-1-rui.silva@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Acked-by: Steve Longerbeam <slongerbeam@gmail.com>

On 4/12/19 9:44 AM, Rui Miguel Silva wrote:
> When register the capture media device it is assumed that the device
> data is the media device. In the imx6 case is but in the imx7 is not
> case. The device data is the csi structure.
>
> Add the explicit argument of the media device that we want to
> associate with the capture device.
>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>   drivers/staging/media/imx/imx-ic-prpencvf.c   | 2 +-
>   drivers/staging/media/imx/imx-media-capture.c | 6 +++---
>   drivers/staging/media/imx/imx-media-csi.c     | 2 +-
>   drivers/staging/media/imx/imx-media.h         | 3 ++-
>   drivers/staging/media/imx/imx7-media-csi.c    | 2 +-
>   5 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index 5c8e6ad8c025..3ca1422f6154 100644
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@ -1270,7 +1270,7 @@ static int prp_registered(struct v4l2_subdev *sd)
>   	if (ret)
>   		return ret;
>   
> -	ret = imx_media_capture_device_register(priv->vdev);
> +	ret = imx_media_capture_device_register(priv->md, priv->vdev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
> index 9703c85b19c4..7688238a3396 100644
> --- a/drivers/staging/media/imx/imx-media-capture.c
> +++ b/drivers/staging/media/imx/imx-media-capture.c
> @@ -706,7 +706,8 @@ void imx_media_capture_device_error(struct imx_media_video_dev *vdev)
>   }
>   EXPORT_SYMBOL_GPL(imx_media_capture_device_error);
>   
> -int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
> +int imx_media_capture_device_register(struct imx_media_dev *md,
> +				      struct imx_media_video_dev *vdev)
>   {
>   	struct capture_priv *priv = to_capture_priv(vdev);
>   	struct v4l2_subdev *sd = priv->src_sd;
> @@ -715,8 +716,7 @@ int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
>   	struct v4l2_subdev_format fmt_src;
>   	int ret;
>   
> -	/* get media device */
> -	priv->md = dev_get_drvdata(sd->v4l2_dev->dev);
> +	priv->md = md;
>   
>   	vfd->v4l2_dev = sd->v4l2_dev;
>   
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 3b7517348666..3408ec023d29 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1806,7 +1806,7 @@ static int csi_registered(struct v4l2_subdev *sd)
>   	if (ret)
>   		goto free_fim;
>   
> -	ret = imx_media_capture_device_register(priv->vdev);
> +	ret = imx_media_capture_device_register(priv->md, priv->vdev);
>   	if (ret)
>   		goto free_fim;
>   
> diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
> index ae964c8d5be1..c3a8512bd10f 100644
> --- a/drivers/staging/media/imx/imx-media.h
> +++ b/drivers/staging/media/imx/imx-media.h
> @@ -271,7 +271,8 @@ int imx_media_of_add_csi(struct imx_media_dev *imxmd,
>   struct imx_media_video_dev *
>   imx_media_capture_device_init(struct v4l2_subdev *src_sd, int pad);
>   void imx_media_capture_device_remove(struct imx_media_video_dev *vdev);
> -int imx_media_capture_device_register(struct imx_media_video_dev *vdev);
> +int imx_media_capture_device_register(struct imx_media_dev *md,
> +				       struct imx_media_video_dev *vdev);
>   void imx_media_capture_device_unregister(struct imx_media_video_dev *vdev);
>   struct imx_media_buffer *
>   imx_media_capture_device_next_buf(struct imx_media_video_dev *vdev);
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index 3fba7c27c0ec..a907c5feb3eb 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1124,7 +1124,7 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = imx_media_capture_device_register(csi->vdev);
> +	ret = imx_media_capture_device_register(csi->imxmd, csi->vdev);
>   	if (ret < 0)
>   		return ret;
>   

