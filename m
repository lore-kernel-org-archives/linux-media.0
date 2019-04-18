Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC94EC10F0E
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 21:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC9D20693
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 21:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fIN6d4an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfDRV5S (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:57:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46392 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDRV5S (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 17:57:18 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8336333;
        Thu, 18 Apr 2019 23:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555624636;
        bh=AjgTo/mSviGKN44MoTp0x9yHMwazZgvTbIhfdrZFBBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIN6d4anMGGiMTVCa5L28ScoqnvkEEaAk1f8w70788JALX9aRPGeuVkVX/h/pZpRl
         mB7jYTR+OabqLsEASke191xEDsYfRIADDV1rDa+JNt4sD74p7c07zv+8slxN4uWtja
         5I/LNTRBiGDoByMHOKPRnw7qYrLcubsdWEp/NN60=
Date:   Fri, 19 Apr 2019 00:57:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: staging/imx: add media device to capture register
Message-ID: <20190418215707.GF4794@pendragon.ideasonboard.com>
References: <20190412164400.1270-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412164400.1270-1-rui.silva@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Rui,

Thank you for the patch.

On Fri, Apr 12, 2019 at 05:44:00PM +0100, Rui Miguel Silva wrote:
> When register the capture media device it is assumed that the device
> data is the media device. In the imx6 case is but in the imx7 is not
> case. The device data is the csi structure.
> 
> Add the explicit argument of the media device that we want to
> associate with the capture device.

I've tested this, and the driver no longer deadlocks. I can't capture
images though, but that may well be due to my platform, the sensor
driver hasn't been validated yet.

Thank you for your help, I will report any progress. In any case there's
certainly room for improvement in the i.MX6/7 camera driver if we want
to get it out of staging, the way the multiple components are backed by
separate drivers that access each other's device data is a big hack at
best. If time permits, after getting capture working, I'll see if I can
start cleaning it up.

> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  drivers/staging/media/imx/imx-ic-prpencvf.c   | 2 +-
>  drivers/staging/media/imx/imx-media-capture.c | 6 +++---
>  drivers/staging/media/imx/imx-media-csi.c     | 2 +-
>  drivers/staging/media/imx/imx-media.h         | 3 ++-
>  drivers/staging/media/imx/imx7-media-csi.c    | 2 +-
>  5 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index 5c8e6ad8c025..3ca1422f6154 100644
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@ -1270,7 +1270,7 @@ static int prp_registered(struct v4l2_subdev *sd)
>  	if (ret)
>  		return ret;
>  
> -	ret = imx_media_capture_device_register(priv->vdev);
> +	ret = imx_media_capture_device_register(priv->md, priv->vdev);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
> index 9703c85b19c4..7688238a3396 100644
> --- a/drivers/staging/media/imx/imx-media-capture.c
> +++ b/drivers/staging/media/imx/imx-media-capture.c
> @@ -706,7 +706,8 @@ void imx_media_capture_device_error(struct imx_media_video_dev *vdev)
>  }
>  EXPORT_SYMBOL_GPL(imx_media_capture_device_error);
>  
> -int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
> +int imx_media_capture_device_register(struct imx_media_dev *md,
> +				      struct imx_media_video_dev *vdev)
>  {
>  	struct capture_priv *priv = to_capture_priv(vdev);
>  	struct v4l2_subdev *sd = priv->src_sd;
> @@ -715,8 +716,7 @@ int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
>  	struct v4l2_subdev_format fmt_src;
>  	int ret;
>  
> -	/* get media device */
> -	priv->md = dev_get_drvdata(sd->v4l2_dev->dev);
> +	priv->md = md;
>  
>  	vfd->v4l2_dev = sd->v4l2_dev;
>  
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 3b7517348666..3408ec023d29 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1806,7 +1806,7 @@ static int csi_registered(struct v4l2_subdev *sd)
>  	if (ret)
>  		goto free_fim;
>  
> -	ret = imx_media_capture_device_register(priv->vdev);
> +	ret = imx_media_capture_device_register(priv->md, priv->vdev);
>  	if (ret)
>  		goto free_fim;
>  
> diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
> index ae964c8d5be1..c3a8512bd10f 100644
> --- a/drivers/staging/media/imx/imx-media.h
> +++ b/drivers/staging/media/imx/imx-media.h
> @@ -271,7 +271,8 @@ int imx_media_of_add_csi(struct imx_media_dev *imxmd,
>  struct imx_media_video_dev *
>  imx_media_capture_device_init(struct v4l2_subdev *src_sd, int pad);
>  void imx_media_capture_device_remove(struct imx_media_video_dev *vdev);
> -int imx_media_capture_device_register(struct imx_media_video_dev *vdev);
> +int imx_media_capture_device_register(struct imx_media_dev *md,
> +				       struct imx_media_video_dev *vdev);
>  void imx_media_capture_device_unregister(struct imx_media_video_dev *vdev);
>  struct imx_media_buffer *
>  imx_media_capture_device_next_buf(struct imx_media_video_dev *vdev);
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index 3fba7c27c0ec..a907c5feb3eb 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1124,7 +1124,7 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = imx_media_capture_device_register(csi->vdev);
> +	ret = imx_media_capture_device_register(csi->imxmd, csi->vdev);
>  	if (ret < 0)
>  		return ret;
>  

-- 
Regards,

Laurent Pinchart
