Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B97C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 20:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6A5218A5
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 20:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WydxPzZR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LQ5gUOWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfC2UcJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:32:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfC2UcI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 16:32:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CAC71608A5; Fri, 29 Mar 2019 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553891527;
        bh=gB/JRRnyRqNxTxY0oigBmj6msB7I2lyagIGOa0923zI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WydxPzZRwOZEQbM7Sh5amZ1TT9MuPEOj59MzlIxpz+nxwYhHTFKuxoDlM5CL/g6/Y
         9zJqvFiCxghBh7OdOXllDk9FNI02PW93Hl9xJp/YStehnmR13brvxHrjZY9Um6PsIK
         0aCkADDMuASsx9NJx5WOVsQzL/DqKdFkF7pEIrX4=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7141960735;
        Fri, 29 Mar 2019 20:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553891526;
        bh=gB/JRRnyRqNxTxY0oigBmj6msB7I2lyagIGOa0923zI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LQ5gUOWtWRGvBMknkhBs5PM+AiWph7b4eF/5szjfqUn736iQHpWysMGWenfOSqZ6k
         3LQcQq0nArm7TV2zuLdUWPdKu+VdtBpy+WCCtIjtPnXHQp0ITkn1IWGThF/N83iTbC
         9zcWfik0nmjHfiDyehvdpmjGhFi670lZBoOAlADw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7141960735
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] media: staging: use strscpy() instead of strlcpy()
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     devel@driverdev.osuosl.org, Fabio Estevam <festevam@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-rockchip@lists.infradead.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <e5ba9c47436888e9cc4c0cda6ca61ade31e703c0.1553873376.git.mchehab+samsung@kernel.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <401f327c-7a68-2a1f-d359-92b3bfb71579@codeaurora.org>
Date:   Sat, 30 Mar 2019 02:01:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e5ba9c47436888e9cc4c0cda6ca61ade31e703c0.1553873376.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 3/29/2019 8:59 PM, Mauro Carvalho Chehab wrote:
> There are a few left overs at staging with were still using the
> deprecated strlcpy() function.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

s/with/which


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/media/imx/imx-media-dev-common.c      | 4 ++--
>   drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-dev-common.c b/drivers/staging/media/imx/imx-media-dev-common.c
> index 910594125889..6cd93419b81d 100644
> --- a/drivers/staging/media/imx/imx-media-dev-common.c
> +++ b/drivers/staging/media/imx/imx-media-dev-common.c
> @@ -30,7 +30,7 @@ struct imx_media_dev *imx_media_dev_init(struct device *dev)
>   
>   	dev_set_drvdata(dev, imxmd);
>   
> -	strlcpy(imxmd->md.model, "imx-media", sizeof(imxmd->md.model));
> +	strscpy(imxmd->md.model, "imx-media", sizeof(imxmd->md.model));
>   	imxmd->md.ops = &imx_media_md_ops;
>   	imxmd->md.dev = dev;
>   
> @@ -38,7 +38,7 @@ struct imx_media_dev *imx_media_dev_init(struct device *dev)
>   
>   	imxmd->v4l2_dev.mdev = &imxmd->md;
>   	imxmd->v4l2_dev.notify = imx_media_notify;
> -	strlcpy(imxmd->v4l2_dev.name, "imx-media",
> +	strscpy(imxmd->v4l2_dev.name, "imx-media",
>   		sizeof(imxmd->v4l2_dev.name));
>   
>   	media_device_init(&imxmd->md);
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> index 57611464ad07..58721c46fba4 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> @@ -462,7 +462,7 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
>   	}
>   
>   	vpu->mdev.dev = vpu->dev;
> -	strlcpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
> +	strscpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
>   	media_device_init(&vpu->mdev);
>   	vpu->v4l2_dev.mdev = &vpu->mdev;
>   
