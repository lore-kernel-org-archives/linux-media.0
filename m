Return-Path: <SRS0=wpjx=S6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B9C43219
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FAA20679
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 18:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Y7nMsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfD1Sxj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:53:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37027 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1Sxi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 28 Apr 2019 14:53:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so4098632pgc.4
        for <linux-media@vger.kernel.org>; Sun, 28 Apr 2019 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SlWVRomA6xIR/PzGao/Vc2oQImPpSzfK9D5R2MMSd2o=;
        b=R6Y7nMsDH7e4914TKgH88GlFp+9l0yAT9aa6ce/MnwuRG4QQeD9uaaBOQdK4OC5noH
         77XgWEtkGGXRlKrWeScIB38pnBRfRg6nfMeeobyFr8RIBPVm+JuInguSoRuY8rs9OL1G
         GtcQtg7WaRT4Ce3q3EKfrV7CD5721xtdS/3lH4HGR6S97DU4rKRabpBYdsFcAXl18b1f
         dcrNmZ16ZT6drp6jYp8WpN49Ag8Mc1ueiJJmINx9yG/TCkij2WFDzHkd6v0U5NGipp7u
         NHCvaDXtmMtevNKjfipTEG0Id1JTYpMQbV9Xmt8o61cb2sJ4PuPQxFVK+viQhqJ4nhOP
         trng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SlWVRomA6xIR/PzGao/Vc2oQImPpSzfK9D5R2MMSd2o=;
        b=OosSgMTzW7W7QP52LnfFPwz+G8Qmj3rOBN8YByzSFoWlEgT8ZQTuHc7WdK3/WdilBa
         VOmSuC0hKEv0m6OyZVck3NaCO41tTgLKwkYI7Y/Os6pzqGkAuaMQO3qJknvxkEbht92P
         iLfJuKA4CFni9l8cKw0h5AyR4/BwgDKsxmjYR+4EgwxwhHsBk1bG8lk7Dv4g8kHT+H75
         BeZg8vvW3Sfo2t2pcbt//qSQgmPI5q4XAfDL6r7BBL7V8CYgUxlwEBaA9kABnfLYzFlo
         OWY8WQlfRjPB1IJ84l5UMdhpdnDdLMjNzErTQcZ7W/MqjbI5uYWRi+S4oRaKXl0ki+P2
         oVcQ==
X-Gm-Message-State: APjAAAUMQGtoON0G5r5R+xKvteO7DtTUnrOQvY174r0f3N6Yy0tIiGnB
        z5+eHWO2BsDiBAGeAEtm3Ksc2Aeu
X-Google-Smtp-Source: APXvYqwhgN+vbjuLCwYfITQw4hTuDgZiNhSJjcInfdsOpbibm9oLm3GT2BNkPGrLixG/kB3WuR6H3g==
X-Received: by 2002:a62:2848:: with SMTP id o69mr12608107pfo.95.1556477617248;
        Sun, 28 Apr 2019 11:53:37 -0700 (PDT)
Received: from [192.168.1.59] (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.gmail.com with ESMTPSA id s85sm55541041pfa.23.2019.04.28.11.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 11:53:36 -0700 (PDT)
Subject: Re: [PATCH] media: staging/imx: add media device to capture register
To:     Rui Miguel Silva <rui.silva@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devel@driverdev.osuosl.org, linux-media@vger.kernel.org
References: <20190412164400.1270-1-rui.silva@linaro.org>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <a375ed17-72e3-21d7-59c1-60b1fbe4b166@gmail.com>
Date:   Sun, 28 Apr 2019 11:53:31 -0700
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

Hi Rui,

On second thought, there is no reason to pass the media device to 
imx_media_capture_device_register(), because it is already available via 
v4l2_dev->mdev. I will be posting a patch in v2 of the "Switch to sync 
registration for IPU subdevs" series that fixes this.

Steve


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

