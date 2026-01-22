Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39C2E764C;
	Thu, 22 Jan 2026 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047090; cv=none; b=nUqb1vT3gjIG2+A9FCXjs1Ts5/WAQYChhm9UPdXAgntYMvMqB3BmiutlkC968vlOL7xSA86+a9jz/r1g+VzQZO9i2ZxlkKaFmYOvFMhQbjL9QZA/n4BruIXfWQjdCjhwfZR7sEYyMmx2mAvMdrYzNe3C9Y1tCY8QR7ndxOLo6w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047090; c=relaxed/simple;
	bh=2hEzQvkfXRd2dgXFNapWgfSJabTaxDQt/CraxNkPkOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVjPeKuM28uEn0gCFeC2Qh8jVgDVOJhyKrEcybImdjU465wM23lDvMx/CmkdczI8XXYSjmrj95AJ1YRieenUHWqogDJGqyOY80ohY71MiNCPGK1bvUn23ws8a4HrjbKSWr6cmAbcUxze776cGSEG8nGvYz+0OhGXr5bf4g79CNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RyWG3jDl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RyWG3jDl"
Received: from pendragon.ideasonboard.com (2001-14ba-703d-e500--ff4.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::ff4])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 3C8D02DD;
	Thu, 22 Jan 2026 02:57:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769047053;
	bh=2hEzQvkfXRd2dgXFNapWgfSJabTaxDQt/CraxNkPkOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyWG3jDldkR+PSwxPHUbdiQzJ/kONadW5StHwNtFbFEAaChlo2/1WZdHbBwUQi46G
	 BvRwdAa8FGcYBAvFv8UxykYWAMhk4BK1ngxcXHZcBl2wBqj249jNWYA6PclYG51zyx
	 bU5szkmECO5m10uriYcy1t6/Pbn2vc3m11CLSHr4=
Date: Thu, 22 Jan 2026 03:58:04 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: yogev.modlin@realsenseai.com
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] media: uvcvideo: change comment to 'Intel
 RealSense'
Message-ID: <20260122015804.GD183118@killaraus>
References: <20251026-fix-uvc-v4-0-610eb1329600@realsenseai.com>
 <20251026-fix-uvc-v4-1-610eb1329600@realsenseai.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251026-fix-uvc-v4-1-610eb1329600@realsenseai.com>

Hi Yogev,

On Sun, Oct 26, 2025 at 06:43:02PM +0200, ymodlin via B4 Relay wrote:
> From: ymodlin <yogev.modlin@realsenseai.com>
> 
> RealSense branding is now independent of Intel. Update all driver
> comments referencing "Intel" to "Intel RealSense" to reflect
> current ownership. No code logic changes.
> 
> Signed-off-by: ymodlin <yogev.modlin@realsenseai.com>

I just noticed that the SoB line (as well as the From line) uses
"ymodlin" as a name, while the kernel policy is to use the author's real
name. I assume this was caused by an oversight in the configuration of
git or b4. Can I replace "ymodlin" with "Yogev Modlin" in patches 1/2
and 2/2 ?

> ---
>  drivers/media/usb/uvc/uvc_driver.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index fb6afb8e84f0..dbdacc64ea6b 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3142,7 +3142,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
> -	/* Intel D410/ASR depth camera */
> +	/* Intel Realsense D410/ASR depth camera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,
> @@ -3151,7 +3151,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -	/* Intel D415/ASRC depth camera */
> +	/* Intel Realsense D415/ASRC depth camera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,
> @@ -3160,7 +3160,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -	/* Intel D430/AWG depth camera */
> +	/* Intel Realsense D430/AWG depth camera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,
> @@ -3169,7 +3169,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -	/* Intel RealSense D4M */
> +	/* Intel Realsense RealSense D4M */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,
> @@ -3178,7 +3178,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -	/* Intel D435/AWGC depth camera */
> +	/* Intel Realsense D435/AWGC depth camera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,
> @@ -3187,7 +3187,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -	/* Intel D435i depth camera */
> +	/* Intel Realsense D435i depth camera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,
> @@ -3196,7 +3196,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -	/* Intel D405 Depth Camera */
> +	/* Intel Realsense D405 Depth Camera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,
> @@ -3205,7 +3205,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -	/* Intel D455 Depth Camera */
> +	/* Intel Realsense D455 Depth Camera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,
> @@ -3214,7 +3214,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -	/* Intel D421 Depth Module */
> +	/* Intel Realsense D421 Depth Module */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>  	  .idVendor		= 0x8086,

-- 
Regards,

Laurent Pinchart
