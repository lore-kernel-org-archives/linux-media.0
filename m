Return-Path: <SRS0=PhFA=7E=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098E6C433DF
	for <linux-media@archiver.kernel.org>; Fri, 22 May 2020 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9F32087E
	for <linux-media@archiver.kernel.org>; Fri, 22 May 2020 14:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgEVOPa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 22 May 2020 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVOPa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 22 May 2020 10:15:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BA0C061A0E
        for <linux-media@vger.kernel.org>; Fri, 22 May 2020 07:15:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 933612A38B7
Subject: Re: [PATCH] media: vimc: Apply right blue and red channels to BGR
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>, linux-media@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20200522071145.GA17375@kaaira-HP-Pavilion-Notebook>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <d0668aa2-a091-6c33-bdc2-d0bddbb3e50e@collabora.com>
Date:   Fri, 22 May 2020 11:15:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522071145.GA17375@kaaira-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Kaaira,

Thanks for the patch.

On 5/22/20 4:11 AM, Kaaira Gupta wrote:
> rgb[] is already calculated in the right order, there is no need to swap
> the blue and red channels in it for BGR images. Hence give right rgb
> channels to the src_frame.

It would be nice if you explain the issue you are facing, and what this fixes.

> 
> Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> ---
>  drivers/media/test-drivers/vimc/vimc-debayer.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vimc/vimc-debayer.c b/drivers/media/test-drivers/vimc/vimc-debayer.c
> index c3f6fef34f68..d41d9f6180df 100644
> --- a/drivers/media/test-drivers/vimc/vimc-debayer.c
> +++ b/drivers/media/test-drivers/vimc/vimc-debayer.c
> @@ -318,21 +318,11 @@ static void vimc_deb_process_rgb_frame(struct vimc_deb_device *vdeb,
>  				       unsigned int col,
>  				       unsigned int rgb[3])
>  {
> -	const struct vimc_pix_map *vpix;
>  	unsigned int i, index;
>  
> -	vpix = vimc_pix_map_by_code(vdeb->src_code);
>  	index = VIMC_FRAME_INDEX(lin, col, vdeb->sink_fmt.width, 3);
> -	for (i = 0; i < 3; i++) {
> -		switch (vpix->pixelformat) {
> -		case V4L2_PIX_FMT_RGB24:
> -			vdeb->src_frame[index + i] = rgb[i];
> -			break;
> -		case V4L2_PIX_FMT_BGR24:
> -			vdeb->src_frame[index + i] = rgb[2 - i];
> -			break;
> -		}
> -	}

This code looks correct to me.

The rgb[] arrays is an intermediary representation of the pixel, in the order of Red Green Blue.

If you look at vimc_deb_calc_rgb_sink(), you will see that rgb[] is indexed by this enum:

enum vimc_deb_rgb_colors {
	VIMC_DEB_RED = 0,
	VIMC_DEB_GREEN = 1,
	VIMC_DEB_BLUE = 2,
};

So rgb[0] is the red component, rgb[1] green and rgb[2] blue.

The, in this part of the code that you removed, we use rgb[] array to calculate the final frame.

So, if there is an error, then I don't think it is here.
Maybe the rgb[] array is wrong, and the error would be somewhere in vimc_deb_calc_rgb_sink().

Regards,
Helen


> +	for (i = 0; i < 3; i++)
> +		vdeb->src_frame[index + i] = rgb[i];
>  }
>  
>  static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
> 
