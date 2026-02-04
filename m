Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E332D7EC;
	Wed,  4 Feb 2026 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224698; cv=none; b=MkGQAPxvdnSUCrCrAf8lmj7NnBzJ/26laGZD4E32nmh32jCCOG6dZJxvXDmsB+MNIznrs/fZ7t2WyIGAwcJyzvGZQEpyILf0xYqxyuqmAkkusptIBUKyA269p2WkxahA5q6BEiQ/AA3OlaLqs0c8WGCc/QEms7ysgPNGLpchjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224698; c=relaxed/simple;
	bh=b4FHxE4k6c9u5owRl/0A1kf9dqtDLXPF6jx78vI4wa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3QCy6LC5ZbUye0ytGoV6dXAo7PQTBvMjqP+aCJAorkQKLlwIzTkYCi6OLl5Mu29x/YmPv8mGEqOL/C7Y6VTAwDDXkhEYproBq/ssJNEeKomKsls1Ba2ocMoGfzNXgkP8/yVyM5g7al26ZCEUSPYxYfMEZR0GsL3wKfqAuKeL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VUrNrcSa; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VUrNrcSa"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--ff4.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::ff4])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 22D545B2;
	Wed,  4 Feb 2026 18:04:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770224654;
	bh=b4FHxE4k6c9u5owRl/0A1kf9dqtDLXPF6jx78vI4wa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUrNrcSaUZ8WVpjhC6pBBWWabssL/xgdyAyuC2PwRYRa9xwCRIgpfmOLlBeeHKXx8
	 dGY0zKRaiU6L9CoBTN9hUS6UdrWKNE/DLb1SSeBieHWelw+KaMxJm7bU4eDnvmFVGH
	 cwQ3gwMBPuNCc+cZ8M0OWwSFa0dMp/EnruwBH6KQ=
Date: Wed, 4 Feb 2026 19:04:54 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Isaac Scott <isaac.scott@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dafna@fastmail.com, mchehab@kernel.org,
	heiko@sntech.de, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] media: rkisp1-isp: Add in_bypass flag for YUV
 bypass
Message-ID: <20260204170454.GD170964@killaraus>
References: <20260204112506.3706049-1-isaac.scott@ideasonboard.com>
 <20260204112506.3706049-3-isaac.scott@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260204112506.3706049-3-isaac.scott@ideasonboard.com>

Hi Isaac,

Thank you for the patch.

On Wed, Feb 04, 2026 at 11:25:02AM +0000, Isaac Scott wrote:
> The rkisp1 features a 'bypass' mode for RAW and YUV formats. This
> disables all ISP blocks, and makes the rkisp1 display input data from
> the mipi csi receiver at the output, unmodified.
> 
> To determine whether we can activate bypass, we can detect whether both
> the source and sink formats are YUV. If they are, we can set a new
> in_bypass flag.
> 
> For YUV bypass, we should configure the ISP input to interpret incoming
> H/VSYNC signals as data enable / disable. Add this.
> 
> Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 1 +
>  drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c    | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 5e6a4d5f6fd1..d90233e31ad3 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -532,6 +532,7 @@ struct rkisp1_device {
>  	struct rkisp1_debug debug;
>  	const struct rkisp1_info *info;
>  	int irqs[RKISP1_NUM_IRQS];
> +	bool in_bypass;
>  	bool irqs_enabled;
>  };
>  
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> index 2311672cedb1..f636d738b7e8 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> @@ -212,6 +212,8 @@ static int rkisp1_config_isp(struct rkisp1_isp *isp,
>  	const struct v4l2_mbus_framefmt *sink_frm;
>  	const struct v4l2_rect *sink_crop;
>  
> +	rkisp1->in_bypass = false;
> +
>  	sink_frm = v4l2_subdev_state_get_format(sd_state,
>  						RKISP1_ISP_PAD_SINK_VIDEO);
>  	sink_crop = v4l2_subdev_state_get_crop(sd_state,
> @@ -240,7 +242,10 @@ static int rkisp1_config_isp(struct rkisp1_isp *isp,
>  		}
>  	} else if (sink_fmt->pixel_enc == V4L2_PIXEL_ENC_YUV) {
>  		acq_mult = 2;
> -		if (mbus_type == V4L2_MBUS_CSI2_DPHY) {
> +		if (src_fmt->pixel_enc == V4L2_PIXEL_ENC_YUV) {
> +			isp_ctrl = RKISP1_CIF_ISP_CTRL_ISP_MODE_DATA_MODE;
> +			rkisp1->in_bypass = true;

Based on the review of patches 3/6 and 5/6 I think this flag will
become unused, so you can probably drop this patch too.

> +		} else if (mbus_type == V4L2_MBUS_CSI2_DPHY) {
>  			isp_ctrl = RKISP1_CIF_ISP_CTRL_ISP_MODE_ITU601;
>  		} else {
>  			if (mbus_type == V4L2_MBUS_BT656)

-- 
Regards,

Laurent Pinchart
