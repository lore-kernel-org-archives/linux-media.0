Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA8C63697
	for <linux-media@archiver.kernel.org>; Tue, 17 Nov 2020 19:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9063424656
	for <linux-media@archiver.kernel.org>; Tue, 17 Nov 2020 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgKQTS1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:18:27 -0500
Received: from mailoutvs24.siol.net ([185.57.226.215]:42215 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726906AbgKQTS0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Nov 2020 14:18:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 098A9521E4B;
        Tue, 17 Nov 2020 20:18:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SK40C-NDIV1s; Tue, 17 Nov 2020 20:18:22 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id AD6B4521ED0;
        Tue, 17 Nov 2020 20:18:22 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 0CB7D521ECE;
        Tue, 17 Nov 2020 20:18:22 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v2 2/9] media: cedrus: h264: Support profile and level controls
Date:   Tue, 17 Nov 2020 20:24:18 +0100
Message-ID: <1725677.6jS8d4RcRb@kista>
In-Reply-To: <20201113215121.505173-3-ezequiel@collabora.com>
References: <20201113215121.505173-1-ezequiel@collabora.com> <20201113215121.505173-3-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ezequiel,

sorry for late review.

First of all, this patch doesn't break anything. However, see comment below.

Dne petek, 13. november 2020 ob 22:51:14 CET je Ezequiel Garcia napisal(a):
> Cedrus supports H.264 profiles from Baseline to High,
> up to Level 5.1, except for the Extended profile
> 
> Expose the V4L2_CID_MPEG_VIDEO_H264_PROFILE and
> V4L2_CID_MPEG_VIDEO_H264_LEVEL so that userspace can
> query the driver for the supported profiles and levels.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/
media/sunxi/cedrus/cedrus.c
> index 9a102b7c1bb9..8b0e97752d27 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -103,6 +103,27 @@ static const struct cedrus_control cedrus_controls[] = 
{
>  		.codec		= CEDRUS_CODEC_H264,
>  		.required	= false,
>  	},
> +	{
> +		.cfg = {
> +			.id	= 
V4L2_CID_MPEG_VIDEO_H264_PROFILE,
> +			.min	= 
V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> +			.def	= 
V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
> +			.max	= 
V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> +			.menu_skip_mask =
> +				
BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
> +		},
> +		.codec		= CEDRUS_CODEC_H264,
> +		.required	= false,
> +	},
> +	{
> +		.cfg = {
> +			.id = V4L2_CID_MPEG_VIDEO_H264_LEVEL,
> +			.min = V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
> +			.max = V4L2_MPEG_VIDEO_H264_LEVEL_5_1,

I went through several datasheets and only newer ones (H6, H616) state max. 
supported level, which is 4.2. Please change it in next revision.

After that, you can add
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej

> +		},
> +		.codec		= CEDRUS_CODEC_H264,
> +		.required	= false,
> +	},
>  	{
>  		.cfg = {
>  			.id	= V4L2_CID_MPEG_VIDEO_HEVC_SPS,
> -- 
> 2.27.0
> 
> 


