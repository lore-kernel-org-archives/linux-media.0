Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E4C4361B
	for <linux-media@archiver.kernel.org>; Wed,  9 Dec 2020 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F1723BC7
	for <linux-media@archiver.kernel.org>; Wed,  9 Dec 2020 16:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgLIQxt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:53:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57848 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgLIQxt (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 9 Dec 2020 11:53:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 55CB91F45369
Subject: Re: [PATCH] media: rkisp1: rsz: crash fix when setting src format
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
References: <20201209161510.31399-1-dafna.hirschfeld@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <1154106a-6c66-5560-189d-d67251026745@collabora.com>
Date:   Wed, 9 Dec 2020 13:53:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209161510.31399-1-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 12/9/20 1:15 PM, Dafna Hirschfeld wrote:
> When setting the source media bus code in the resizer,
> we first check that the current media bus code in the
> source is yuv encoded format. This is done by
> retrieving the data from the formats list of the isp
> entity. This cause a crash when the media bus code on the
> source is YUYV8_1_5X8 which is not supported by the isp
> entity. Instead we should test the sink format of the resizer
> which is guaranteed to be supported by the isp entity.
> 
> Fixes: 251b6eebb6c49 ("media: staging: rkisp1: rsz: Add support to more YUV encoded mbus codes on src pad")
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> index 813670ed9577..79deed8adcea 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> @@ -520,14 +520,15 @@ static void rkisp1_rsz_set_src_fmt(struct rkisp1_resizer *rsz,
>  				   struct v4l2_mbus_framefmt *format,
>  				   unsigned int which)
>  {
> -	const struct rkisp1_isp_mbus_info *mbus_info;
> -	struct v4l2_mbus_framefmt *src_fmt;
> +	const struct rkisp1_isp_mbus_info *sink_mbus_info;
> +	struct v4l2_mbus_framefmt *src_fmt, *sink_fmt;
>  
> +	sink_fmt = rkisp1_rsz_get_pad_fmt(rsz, cfg, RKISP1_RSZ_PAD_SINK, which);
>  	src_fmt = rkisp1_rsz_get_pad_fmt(rsz, cfg, RKISP1_RSZ_PAD_SRC, which);
> -	mbus_info = rkisp1_isp_mbus_info_get(src_fmt->code);
> +	sink_mbus_info = rkisp1_isp_mbus_info_get(sink_fmt->code);
>  
>  	/* for YUV formats, userspace can change the mbus code on the src pad if it is supported */
> -	if (mbus_info->pixel_enc == V4L2_PIXEL_ENC_YUV &&
> +	if (sink_mbus_info->pixel_enc == V4L2_PIXEL_ENC_YUV &&
>  	    rkisp1_rsz_get_yuv_mbus_info(format->code))
>  		src_fmt->code = format->code;
>  
> 
