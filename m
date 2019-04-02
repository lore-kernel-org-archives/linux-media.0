Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CCBC4360F
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 11:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E98C208E4
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 11:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a08oQr50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfDBLdw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:33:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60078 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDBLdv (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Apr 2019 07:33:51 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89A432F9;
        Tue,  2 Apr 2019 13:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554204829;
        bh=WFjwqemxH0pwRmzBB3cMxtC24up2w5vHK0J/fwHG5HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a08oQr50uzUic0sgdOO1GazP3VfMSXemsYGlzfF1em9Gw7C9x6vV0Y/kf8sdIQ/Or
         eTkgMsLb3Xcye2i8rfuxCVE5aiw1PHnhPXU+KUi/MESmby9EgTHsCDcXcbt+aN7EbZ
         Xn1w8NMuAljAfmsa4bqt1ysC3coxoVJqWpR4p594=
Date:   Tue, 2 Apr 2019 14:33:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jungo Lin <jungo.lin@mediatek.com>
Cc:     tfiga@chromium.org, hans.verkuil@cisco.com,
        laurent.pinchart+renesas@ideasonboard.com, matthias.bgg@gmail.com,
        mchehab@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Sean.Cheng@mediatek.com, sj.huang@mediatek.com,
        christie.yu@mediatek.com, holmes.chiou@mediatek.com,
        frederic.chen@mediatek.com, Jerry-ch.Chen@mediatek.com,
        frankie.chiu@mediatek.com, seraph.huang@mediatek.com,
        ryan.yu@mediatek.com, Rynn.Wu@mediatek.com, yuzhao@chromium.org,
        zwisler@chromium.org, srv_heupstream@mediatek.com,
        Jungo Lin <jungo.lin@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v1] media: media_device_enum_links32: fix missing
 reserved field copy
Message-ID: <20190402113339.GT4805@pendragon.ideasonboard.com>
References: <jungo.lin@mediatek.com>
 <1554199444-16827-1-git-send-email-jungo.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554199444-16827-1-git-send-email-jungo.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jungo,

Thank you for the patch.

On Tue, Apr 02, 2019 at 06:04:04PM +0800, Jungo Lin wrote:
> From: Jungo Lin <jungo.lin@mediatek.corp-partner.google.com>
> 
> In v4l2-compliance utility, test MEDIA_IOC_ENUM_ENTITIES
> will check whether reserved field of media_links_enum filled
> with zero. Reserved field is filled with zero in media_device_enum_links.
> 
> However, for 32 bit program, the reserved field is missing
> copy from kernel space to user space in media_device_enum_links32
> function.
> 
> This patch copies reserved field of media_links_enum from kernel space
> to user space.
> 
> Signed-off-by: Jungo Lin <jungo.lin@mediatek.com>
> ---
>  drivers/media/media-device.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/media-device.c b/drivers/media/media-device.c
> index b8ec886..f420829 100644
> --- a/drivers/media/media-device.c
> +++ b/drivers/media/media-device.c
> @@ -502,6 +502,7 @@ static long media_device_enum_links32(struct media_device *mdev,
>  {
>  	struct media_links_enum links;
>  	compat_uptr_t pads_ptr, links_ptr;
> +	int ret;
>  
>  	memset(&links, 0, sizeof(links));
>  
> @@ -513,7 +514,15 @@ static long media_device_enum_links32(struct media_device *mdev,
>  	links.pads = compat_ptr(pads_ptr);
>  	links.links = compat_ptr(links_ptr);
>  
> -	return media_device_enum_links(mdev, &links);
> +	ret = media_device_enum_links(mdev, &links);
> +	if (ret)
> +		return ret;
> +
> +	if (copy_to_user(ulinks->reserved, &links.reserved,
> +			 sizeof(links.reserved)))
> +		return -EFAULT;

I think it would be better to zero the reserved field here instead of
copying it, as we know it has to be zero.

> +
> +	return 0;
>  }
>  
>  #define MEDIA_IOC_ENUM_LINKS32		_IOWR('|', 0x02, struct media_links_enum32)

-- 
Regards,

Laurent Pinchart
