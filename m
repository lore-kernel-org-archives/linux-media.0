Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022BC10F14
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 06:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861582184B
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 06:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gh3rbinM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbfDRGdw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:33:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57930 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRGdv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 02:33:51 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A649C306;
        Thu, 18 Apr 2019 08:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555569229;
        bh=MwWj6ItxMyDbbhld7dbGxHSj6jxY/8txXD/7IKHPHYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gh3rbinMjqb6ePZkoIs1Y8QMMXG055A2Flzx8BMXDqfFFg4dHsQ2C5I9O7mjb9U6v
         LUkoHkYOeyXe92MjH/XUT7fu41Zqbglx+4BBGATzjs/abgWOS5VS5/uFZdKD36TsIb
         H/9s44StpAxoZip+smDNM7x1hMPqH3TU0fu2WNcw=
Date:   Thu, 18 Apr 2019 09:33:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 3/5] media: vsp1: Document partition algorithm in code
 header
Message-ID: <20190418063341.GG4806@pendragon.ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
 <20190411161256.19607-4-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411161256.19607-4-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thu, Apr 11, 2019 at 05:12:54PM +0100, Kieran Bingham wrote:
> The image partition algorithm operates on the image dimensions as input
> into the WPF entity. Document this in the code block header.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
> index 563f9a02c373..d1ecc3d91290 100644
> --- a/drivers/media/platform/vsp1/vsp1_video.c
> +++ b/drivers/media/platform/vsp1/vsp1_video.c
> @@ -173,6 +173,14 @@ static int __vsp1_video_try_format(struct vsp1_video *video,
>  
>  /* -----------------------------------------------------------------------------
>   * VSP1 Partition Algorithm support
> + *
> + * VSP hardware can have restrictions on image width dependent on the hardware

Did you mean s/dependent/depending/ ?

> + * configuration of the pipeline. Adapting for these restrictions is implemented
> + * via the partition algorithm.
> + *
> + * The partition windows and sizes are based on the output size of the WPF
> + * before rotation, which is represented by the input parameters to the WPF
> + * entity in our pipeline.
>   */
>  
>  /**
> -- 
> 2.19.1
> 

-- 
Regards,

Laurent Pinchart
