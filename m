Return-Path: <SRS0=15ZL=7Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8668BC433E0
	for <linux-media@archiver.kernel.org>; Thu, 11 Jun 2020 03:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584F5206FA
	for <linux-media@archiver.kernel.org>; Thu, 11 Jun 2020 03:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ymj2Auy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFKDO1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Jun 2020 23:14:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45510 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFKDO1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Jun 2020 23:14:27 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5D4F26A;
        Thu, 11 Jun 2020 05:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591845266;
        bh=A/er+LYKcf/rkDc+MwkqmFtbRb/EqAqRGvUhPyido44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ymj2Auy5ZP/oxjzJ4FcUidKLcCKRn/UH6FjT9G/xl/v0/JhgkQYxy6eunAeYZIp26
         bVJYL32AByEVrGACt3m/6NnbkWJI2UC9zm9JGBMa0F0OpC2maXIimIZLpjVcB+mxGx
         UTM2m0b9ij3GErkTZliOWdImu62pyIU0NHXr2Ek0=
Date:   Thu, 11 Jun 2020 06:14:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 4/5] mc-device.c: Report graph complete to user-space
Message-ID: <20200611031404.GG13598@pendragon.ideasonboard.com>
References: <20200610230541.1603067-1-niklas.soderlund+renesas@ragnatech.se>
 <20200610230541.1603067-5-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610230541.1603067-5-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Niklas,

Thank you for the patch.

On Thu, Jun 11, 2020 at 01:05:40AM +0200, Niklas Söderlund wrote:
> If the graph in the media device is complete report it to userspace by
> setting the MEDIA_TOPOLOGY_FLAG_COMPLETE flag.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/mc/mc-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
> index c2ef5bb512a5fba0..d63792cc014279fc 100644
> --- a/drivers/media/mc/mc-device.c
> +++ b/drivers/media/mc/mc-device.c
> @@ -242,7 +242,7 @@ static long media_device_get_topology(struct media_device *mdev, void *arg)
>  	int ret = 0;
>  
>  	topo->topology_version = mdev->topology_version;
> -	topo->flags = 0;
> +	topo->flags = mdev->complete ? MEDIA_TOPOLOGY_FLAG_COMPLETE : 0;
>  
>  	/* Get entities and number of entities */
>  	i = 0;

-- 
Regards,

Laurent Pinchart
