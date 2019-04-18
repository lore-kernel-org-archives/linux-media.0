Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E748BC10F14
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 06:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0035214DA
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 06:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DnQfu8wF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfDRGiF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:38:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57956 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRGiE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 02:38:04 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 28360306;
        Thu, 18 Apr 2019 08:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555569483;
        bh=/iIzZDcrE+ifQT/TUzHSWauCSTUOJOdBPozchHtMWLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnQfu8wFfFrEsc3CxfRChplTdxUW5KsduA0iwRBmQZWq++c0auKW7d12NrOyqTKhZ
         s/yV+X66rDqN+f7yvKu538rlakciCq+0mwdfstLW2CixEGQLqsqOXIvbvbetyKJNtZ
         WxzjprxzoahKq4HfHMKSNPl+ouiJCpqoXBx5nx3Q=
Date:   Thu, 18 Apr 2019 09:37:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 4/5] media: vsp1: Split out pre-filter multiplier
Message-ID: <20190418063754.GH4806@pendragon.ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
 <20190411161256.19607-5-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411161256.19607-5-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thu, Apr 11, 2019 at 05:12:55PM +0100, Kieran Bingham wrote:
> The 'mp' value is used through many calculations in determining the scaling
> factors of the UDS. Factor this out so that it can be reused in further
> calculations, and also ensure that if the BLADV control is ever changed only a
> single function needs to be modified.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_uds.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
> index 27012af973b2..c71c24363d54 100644
> --- a/drivers/media/platform/vsp1/vsp1_uds.c
> +++ b/drivers/media/platform/vsp1/vsp1_uds.c
> @@ -46,6 +46,18 @@ void vsp1_uds_set_alpha(struct vsp1_entity *entity, struct vsp1_dl_body *dlb,
>  		       alpha << VI6_UDS_ALPVAL_VAL0_SHIFT);
>  }
>  
> +/*
> + * Determine the pre-filter multiplication value.

This would benefit from a more detailed description, and in particular a
definition of what "pre-filter" means.

> + *
> + * This calculation assumes that the BLADV control is unset.

s/control/bit/ ?
s/unset/not set/ ?

> + */
> +static unsigned int uds_multiplier(int ratio)

Should the function be renamed to uds_pre_multiplier() ? And isn't it a
divisor ? :-)

> +{
> +	unsigned int mp = ratio / 4096;
> +
> +	return mp < 4 ? 1 : (mp < 8 ? 2 : 4);
> +}
> +
>  /*
>   * uds_output_size - Return the output size for an input size and scaling ratio
>   * @input: input size in pixels
> @@ -55,10 +67,7 @@ static unsigned int uds_output_size(unsigned int input, unsigned int ratio)
>  {
>  	if (ratio > 4096) {
>  		/* Down-scaling */
> -		unsigned int mp;
> -
> -		mp = ratio / 4096;
> -		mp = mp < 4 ? 1 : (mp < 8 ? 2 : 4);
> +		unsigned int mp = uds_multiplier(ratio);
>  
>  		return (input - 1) / mp * mp * 4096 / ratio + 1;
>  	} else {
> @@ -88,10 +97,7 @@ static unsigned int uds_passband_width(unsigned int ratio)
>  {
>  	if (ratio >= 4096) {
>  		/* Down-scaling */
> -		unsigned int mp;
> -
> -		mp = ratio / 4096;
> -		mp = mp < 4 ? 1 : (mp < 8 ? 2 : 4);
> +		unsigned int mp = uds_multiplier(ratio);
>  
>  		return 64 * 4096 * mp / ratio;
>  	} else {

-- 
Regards,

Laurent Pinchart
