Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CD0C10F14
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 06:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ABF2184B
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 06:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cMJbvrBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbfDRGcq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:32:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57912 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733151AbfDRGcq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 02:32:46 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0CF6F306;
        Thu, 18 Apr 2019 08:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555569165;
        bh=cKAbQJY5NniLcF6UYV0LrkIbhzq7TZvdLdC5hcKlMC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMJbvrBubHeiSIpIw8LpGWuKEz6mFqehqLN3bjUaGkuPh3vGnCe6fkVfy08Rr3tAb
         588hU179ZJi1Gsu/M0ZRR9EMIevI86P8C5wMbfd5Rea22gqddg6wMf+ZpT5WFpuMJh
         q5E8OOc0Bz4RrlJsQpa34HKoWqZLbY96PoZGmnyQ=
Date:   Thu, 18 Apr 2019 09:32:36 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 2/5] media: vsp1: Initialise partition windows
Message-ID: <20190418063236.GF4806@pendragon.ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
 <20190411161256.19607-3-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411161256.19607-3-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thu, Apr 11, 2019 at 05:12:53PM +0100, Kieran Bingham wrote:
> Ensure that the partition window is correctly initialised before being
> utilised.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
> index ee2fb8261a6a..563f9a02c373 100644
> --- a/drivers/media/platform/vsp1/vsp1_video.c
> +++ b/drivers/media/platform/vsp1/vsp1_video.c
> @@ -189,7 +189,7 @@ static void vsp1_video_calculate_partition(struct vsp1_pipeline *pipe,
>  					   unsigned int index)
>  {
>  	const struct v4l2_mbus_framefmt *format;
> -	struct vsp1_partition_window window;
> +	struct vsp1_partition_window window = { 0, };

This isn't needed as-is. If this change is required by a patch further
in this series, you can squash it there.

>  	unsigned int modulus;
>  
>  	/*

-- 
Regards,

Laurent Pinchart
