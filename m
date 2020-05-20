Return-Path: <SRS0=Mt3G=7C=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EC0C433DF
	for <linux-media@archiver.kernel.org>; Wed, 20 May 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21EE20884
	for <linux-media@archiver.kernel.org>; Wed, 20 May 2020 22:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgETWXs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 20 May 2020 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgETWXr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 20 May 2020 18:23:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2D9C061A0E
        for <linux-media@vger.kernel.org>; Wed, 20 May 2020 15:23:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id E985E2A1914
Subject: Re: [PATCH v2 3/4] media: staging: rkisp1: rsz: set output format to
 YUV422 if cap format is YUV444
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-media@vger.kernel.org, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com
References: <20200515142952.20163-1-dafna.hirschfeld@collabora.com>
 <20200515142952.20163-4-dafna.hirschfeld@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <8b011c17-0374-c7d7-a030-26ce16828491@collabora.com>
Date:   Wed, 20 May 2020 19:23:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142952.20163-4-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dafna,

On 5/15/20 11:29 AM, Dafna Hirschfeld wrote:
> If the capture format is YUV444M then the memory input format
> should be YUV422, so the resizer should not change the default
> hdiv, vdiv in that case.

I didn't understand why YUV444M is special, do you mind elaborating a bit
more to help me understand please?

Thanks
Helen

> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  drivers/staging/media/rkisp1/rkisp1-resizer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/rkisp1/rkisp1-resizer.c b/drivers/staging/media/rkisp1/rkisp1-resizer.c
> index 04a29af8cc92..5f9740ddd558 100644
> --- a/drivers/staging/media/rkisp1/rkisp1-resizer.c
> +++ b/drivers/staging/media/rkisp1/rkisp1-resizer.c
> @@ -394,10 +394,11 @@ static void rkisp1_rsz_config(struct rkisp1_resizer *rsz,
>  	 * (4:2:2 -> 4:2:0 for example). So the width/height of the CbCr
>  	 * streams should be set according to the pixel format in the capture.
>  	 * The resizer always gets the input as YUV422. If the capture format
> -	 * is RGB then the memory input (the resizer output) should be YUV422
> -	 * so we use the hdiv, vdiv of the YUV422 info in this case.
> +	 * is RGB or YUV444 then the memory input (the resizer output) should
> +	 * be YUV422 so we use the hdiv, vdiv of the YUV422 info in this case.
>  	 */
> -	if (v4l2_is_format_yuv(cap->pix.info)) {
> +	if (v4l2_is_format_yuv(cap->pix.info) &&
> +	    cap->pix.info->format != V4L2_PIX_FMT_YUV444M) {
>  		src_c.width = cap->pix.info->hdiv;
>  		src_c.height = cap->pix.info->vdiv;
>  	} else {
> 
