Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB2C433FE
	for <linux-media@archiver.kernel.org>; Fri, 18 Nov 2022 14:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbiKROl2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 18 Nov 2022 09:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbiKROlG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 18 Nov 2022 09:41:06 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211E4A04F
        for <linux-media@vger.kernel.org>; Fri, 18 Nov 2022 06:39:51 -0800 (PST)
X-KPN-MessageId: de5a29d8-674e-11ed-bd66-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id de5a29d8-674e-11ed-bd66-005056994fde;
        Fri, 18 Nov 2022 15:39:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=KAjWbRWqEitk8RQ8rQGWmCu5fnBnnF3qq3D4wL/pwhg=;
        b=PGuQljui9azlCkqyfPGfVBYQMA7Sfy5qu/k/a94on8TUgdW1i0zq/dfZ4fYLQ/m4QLpIcZ2tIkG+4
         h6Q/vPQI/gvjShZIiCjzXhcIuvE/SJieKtwVZkPRSxteuey4vOFLWc1CW1FguFAt2Xpy9zKuFFNmer
         pODbvVydOI/qoRDsMOdZNwIOCsCbGwotqSwYJxQ/cYPTDMeLDNd888EXz0r/VvYt3A9x/V9iFAXjGR
         FKIh9kN0LoNtSQ73pSvz6gKPVkk/Eng8Csy94Xf+onq6A2jKwh+epmV7tTor2NbemHSWaQDkFeKIQC
         OvhtNna722oWfjPuXkHaZQvynaAjA9Q==
X-KPN-MID: 33|pjf0Jn5zAyCMRtfEBaA4sEua2aYn1IRSQpDdlCjFD2Xi2LRJbY5pB91LA8orcZl
 cUq4QSbC21K8BMR9txUGALQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ySOW7ppoxARsp8AZR2P/+82tTweUC0409/AltcmQM/hk9iRKek0WfTEiiegtRH4
 3jGdHuM6V8DPnnqyebijP9A==
X-Originating-IP: 173.38.220.59
Received: from [10.47.77.219] (unknown [173.38.220.59])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id d9605df8-674e-11ed-8bc9-005056998788;
        Fri, 18 Nov 2022 15:39:48 +0100 (CET)
Message-ID: <8bed61a3-1200-48b3-0934-65285e322184@xs4all.nl>
Date:   Fri, 18 Nov 2022 15:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3] vcodec: mediatek: add check for NULL for
 vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
Content-Language: en-US
To:     Anastasia Belova <abelova@astralinux.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lvc-project@linuxtesting.org
References: <20221111090604.10327-1-abelova@astralinux.ru>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221111090604.10327-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 11/11/22 10:06, Anastasia Belova wrote:
> Any time calling vp9_is_sf_ref_fb we need fb != NULL after checks.

This doesn't match the subject line at all!

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: f77e89854b3e ("[media] vcodec: mediatek: Add Mediatek VP9 Video Decoder Driver")

Drop this, it's not a fix, it just attempts to make things more robust.

> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> index 70b8383f7c8e..776468cd834a 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> @@ -208,6 +208,9 @@ static bool vp9_is_sf_ref_fb(struct vdec_vp9_inst *inst, struct vdec_fb *fb)
>  	int i;
>  	struct vdec_vp9_vsi *vsi = inst->vsi;
>  
> +	if (!fb)
> +		return true;
> +
>  	for (i = 0; i < ARRAY_SIZE(vsi->sf_ref_fb); i++) {
>  		if (fb == &vsi->sf_ref_fb[i].fb)
>  			return true;

This won't work: if fb == NULL, then depending on whether
this function returns true or false, the code in vp9_swap_frm_bufs()
will crash in either vsi->frm_bufs[vsi->new_fb_idx].buf.fb->base_y.va
or in vp9_free_sf_ref_fb().

Unless you can show there really is a path through which fb can be NULL,
I don't think it is worth continuing with this.

Regards,

	Hans
