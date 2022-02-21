Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0938C433F5
	for <linux-media@archiver.kernel.org>; Mon, 21 Feb 2022 18:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiBUSOh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:14:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiBUSMe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Feb 2022 13:12:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FEB104
        for <linux-media@vger.kernel.org>; Mon, 21 Feb 2022 10:03:17 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D830482;
        Mon, 21 Feb 2022 19:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645466596;
        bh=yCcS4wWSq99lF0daf+3VA5h3LDWo3aOAnkYHST/N7Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVgJttf9fht3mBQ36CjeeB5CCfj9SNDFFRmipkuJahEum1KonaE1QXqK1oolmOrAF
         3A5z6dXH92BGBFAS5pOnjbJ1/Wp+8v0W1E/xrxj+W+KOvDjZpfg0uNDmxdPT+9mlh+
         AP3rrClM+AhMv6QoSCAvpgeGXdHm3n4Wn0+iySk4=
Date:   Mon, 21 Feb 2022 20:03:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     aford173@gmail.com, slongerbeam@gmail.com, p.zabel@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        martin.kepplinger@puri.sm, rmfrfs@gmail.com,
        xavier.roumegue@oss.nxp.com, alexander.stein@ew.tq-group.com,
        dorota.czaplejewicz@puri.sm, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] media: imx: imx8mq-mipi-csi2: Remove YUV422 2X8
Message-ID: <YhPT27uc0eCMnISH@pendragon.ideasonboard.com>
References: <20220221174903.320466-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221174903.320466-1-jacopo@jmondi.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Mon, Feb 21, 2022 at 06:49:03PM +0100, Jacopo Mondi wrote:
> The 2X8 variants of MEDIA_BUS_FMT_YUYV8_2X8 does not apply to serial
> busses.
> 
> Drop it and while at it also add the canonical UYVY wire format for
> packed YUV422 when transmitted on the CSI-2 serial bus.
> 
> Also beautify a little the formats declaration list by putting the
> opening curly brace after the comment.
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> v1->v2:
> - Fix subject (s/mp/mq) as reported by Adam
> - Add UYVY_1X16 as suggested by Laurent
> 
>  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> index 56ef3b3b2906..7d03cb340ed4 100644
> --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> @@ -200,14 +200,16 @@ static const struct csi2_pix_format imx8mq_mipi_csi_formats[] = {
>  	}, {
>  		.code = MEDIA_BUS_FMT_SRGGB14_1X14,
>  		.width = 14,
> -	}, {
> +	},
>  	/* YUV formats */
> -		.code = MEDIA_BUS_FMT_YUYV8_2X8,
> -		.width = 16,
> -	}, {
> +	{
>  		.code = MEDIA_BUS_FMT_YUYV8_1X16,
>  		.width = 16,
>  	}
> +	{
> +		.code = MEDIA_BUS_FMT_UYVY8_1X16,
> +		.width = 16,
> +	}
>  };
> 
>  static const struct csi2_pix_format *find_csi2_format(u32 code)

-- 
Regards,

Laurent Pinchart
