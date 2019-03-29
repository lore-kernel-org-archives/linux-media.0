Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A9C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2713218A5
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfC2Pai (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:30:38 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:44890 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728720AbfC2Pai (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 11:30:38 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9tShhPO9WUjKf9tSkhwX5a; Fri, 29 Mar 2019 16:30:36 +0100
Subject: Re: [PATCH] media: staging: use strscpy() instead of strlcpy()
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <e5ba9c47436888e9cc4c0cda6ca61ade31e703c0.1553873376.git.mchehab+samsung@kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <b76b3f81-e9c9-cc13-0b34-ce149fa7b213@xs4all.nl>
Date:   Fri, 29 Mar 2019 16:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e5ba9c47436888e9cc4c0cda6ca61ade31e703c0.1553873376.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCHD5kDU733jbbGxr62BHxgWP7ULfVwsGqoH5gXAc8Mf0A16+sb+mnaibKoe7hY2+fradmFx3nK2NQUq7Oj/zTgv8XFnaOawY6cR3rbynxLi/48SUu98
 fVrSlP6FAhaQIkEM9ha9X5VfGGad6n90QekkkmR41+iu1ShdIhdnYFJ6ApH/v3u5efj3noS1x8LnPp6iNTjuf0/Xw+vaqxG658MykAEpIe8zOnoyC7j9mAyY
 oQdgxVKbmc0GbPYHq8CfZee2aWwybFbSru2p1Q9Mpw31Pgi/Uq/dCr8wGR+x6J213cfbK8czVgsSjJhvqjRWo/GAC4RUtinm6euXDwcXUFuDgGNxi5vi9IVp
 TUtHtYc/fOuhkZ1wMqwBzUD59e2bXLRas6l4XtQi8xZmliZIZlMyhlEqzWbJdtG306olU4KG9uzovoGgJWN3Ioi6rucZmjkwrgxCnlUoDG81IOnFafY0Qga2
 vJWNQSkTMkmASKDgDqvEsCBNbR0Tqb8uuVO86R5E+YKlnGkUuobmZUYGYJnNfRquyad/SNqOC34cuPuvP2hsnrFVm+UuAHLX0fi6Pj8/wp92Swn9GecXeJZy
 GT7vU6z2scNQlBHLZJTaTapLGmxxptFaUI5UreaDXR0lfhViJZXu2KqJpEQqulHLyQ6lGKC142aJgt0uB5AMh7lDrxMQ5SW57vyMOByA6JuCuuPbd/qTIed7
 y2PgpoppTkGNjEAFBUKklc5Mzbf6yd0trTPV1zGHTesVh+fJtq2tFQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 3/29/19 4:29 PM, Mauro Carvalho Chehab wrote:
> There are a few left overs at staging with were still using the
> deprecated strlcpy() function.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  drivers/staging/media/imx/imx-media-dev-common.c      | 4 ++--
>  drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-dev-common.c b/drivers/staging/media/imx/imx-media-dev-common.c
> index 910594125889..6cd93419b81d 100644
> --- a/drivers/staging/media/imx/imx-media-dev-common.c
> +++ b/drivers/staging/media/imx/imx-media-dev-common.c
> @@ -30,7 +30,7 @@ struct imx_media_dev *imx_media_dev_init(struct device *dev)
>  
>  	dev_set_drvdata(dev, imxmd);
>  
> -	strlcpy(imxmd->md.model, "imx-media", sizeof(imxmd->md.model));
> +	strscpy(imxmd->md.model, "imx-media", sizeof(imxmd->md.model));
>  	imxmd->md.ops = &imx_media_md_ops;
>  	imxmd->md.dev = dev;
>  
> @@ -38,7 +38,7 @@ struct imx_media_dev *imx_media_dev_init(struct device *dev)
>  
>  	imxmd->v4l2_dev.mdev = &imxmd->md;
>  	imxmd->v4l2_dev.notify = imx_media_notify;
> -	strlcpy(imxmd->v4l2_dev.name, "imx-media",
> +	strscpy(imxmd->v4l2_dev.name, "imx-media",
>  		sizeof(imxmd->v4l2_dev.name));
>  
>  	media_device_init(&imxmd->md);
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> index 57611464ad07..58721c46fba4 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> @@ -462,7 +462,7 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
>  	}
>  
>  	vpu->mdev.dev = vpu->dev;
> -	strlcpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
> +	strscpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
>  	media_device_init(&vpu->mdev);
>  	vpu->v4l2_dev.mdev = &vpu->mdev;
>  
> 

