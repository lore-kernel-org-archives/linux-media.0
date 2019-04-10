Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D991C282CE
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 13:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2653320854
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 13:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbfDJN7w (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:59:52 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:43292 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbfDJN7w (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 09:59:52 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EDlVhlDhrNG8zEDlWh1OLH; Wed, 10 Apr 2019 15:59:50 +0200
Subject: Re: [PATCH v2 3/3] rcar-csi2: Move setting of Field Detection Control
 Register
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
References: <20190308235702.27057-1-niklas.soderlund+renesas@ragnatech.se>
 <20190308235702.27057-4-niklas.soderlund+renesas@ragnatech.se>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <93d816cd-5562-8eb9-8596-63097d329917@xs4all.nl>
Date:   Wed, 10 Apr 2019 15:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308235702.27057-4-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNBe7YrM6+6a85F12duq3TJjY3tNLlyCM+VdTpSdPidYwnfM/wXq5IpcX2Z3rmOM+z30+m8965+bzYrQAfuPz4Maop7JB3D8M4QOJ0C88pBExn05kEry
 bHhEFnRfqbJuxuqJ4VaQkI9cRgL1dxT2M1/IDTExAFQP2faWYX7yVf5ubnrH0L/CsAYdEKLLmITnWmF0I6TS1gdP3J6Au4GMnBVhR8aKBo/gfPvHviYSvo7A
 ewxSjchcl8HEh7Rc0XXMaim9GI64eM13l3poPXgR1PwDE3ZKaoHlPcy79ZYfMnjsxwKwGvXgwM8UapuIR39lVviyqu11S/kHfwmdf6FD2khhFVoh5W/JsxNZ
 dBYkVGdkhEIzhkwtQYaJidhFMBFpRAY1/ZahCQyRnSiERuNHEmU4esl8bMGhGC3zRWjC6XE7JtzdKvUWvuqIfjaKT/gkmbdgoM3aTV4aTwRFBuqWr5jaKxLN
 ltLQ+0RHUqnZvSmyfv/BOfWUqJjKN2Sn5efUapNfyG3FnMqB+SSiyKHtt4k=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 3/9/19 12:57 AM, Niklas Söderlund wrote:
> Latest datasheet (rev 1.50) clarifies that the FLD register should be
> set after LINKCNT.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index 07d5c8c66b7cd382..077e0d344b395b54 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -529,7 +529,6 @@ static int rcsi2_start_receiver(struct rcar_csi2 *priv)
>  	rcsi2_write(priv, PHTC_REG, 0);
>  
>  	/* Configure */
> -	rcsi2_write(priv, FLD_REG, fld);
>  	rcsi2_write(priv, VCDT_REG, vcdt);
>  	if (vcdt2)
>  		rcsi2_write(priv, VCDT2_REG, vcdt2);
> @@ -560,6 +559,7 @@ static int rcsi2_start_receiver(struct rcar_csi2 *priv)
>  	rcsi2_write(priv, PHYCNT_REG, phycnt);
>  	rcsi2_write(priv, LINKCNT_REG, LINKCNT_MONITOR_EN |
>  		    LINKCNT_REG_MONI_PACT_EN | LINKCNT_ICLK_NONSTOP);
> +	rcsi2_write(priv, FLD_REG, fld);
>  	rcsi2_write(priv, PHYCNT_REG, phycnt | PHYCNT_SHUTDOWNZ);
>  	rcsi2_write(priv, PHYCNT_REG, phycnt | PHYCNT_SHUTDOWNZ | PHYCNT_RSTZ);
>  
> 

This patch doesn't apply because the fld variable no longer exists.

I think the fix is easy, but I prefer it if you rebase and repost this patch.
I've merged the others, so it's just this patch that's the problem.

Regards,

	Hans
