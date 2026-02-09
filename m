Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91D318B92;
	Mon,  9 Feb 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637214; cv=none; b=jyElyqCFUhD+KrF+14+60T98+Jx79N2JK4ZgF801h4YO1DuRgUyssdYneiNHhIbzxWh5GU+tN7am47b6Do4bGsZscYpjP9FhHG0C8nZ0tMpfrwN242sNKQKuCJyRL5xu5jNzpQK3qz4+bCcD/SbOtt3CMiREUH/ZrMUdi/GW+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637214; c=relaxed/simple;
	bh=Tgl1eaMk6HikkEuvRgkdga3o7FNqzRe0hfA4v+adSQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzC+fNnu4fN2z5t1TD75T0f5uAeBiXKaLELnJ49uYm/B6uAP3a3Qn6WiCB02wpLI+cGC2DjS1lcVeqWe6xQI0yDCa5K95MtAojXBB3sVVcGCm0aOAtqi5NIKrZMVaVka2v5IG5He8bBkEQIJs1u90uPGNlwVSnGrCRZ5oaX1OJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Ijyl0Wl4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ijyl0Wl4"
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 87769454;
	Mon,  9 Feb 2026 12:39:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770637166;
	bh=Tgl1eaMk6HikkEuvRgkdga3o7FNqzRe0hfA4v+adSQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ijyl0Wl4JKfmANyQbwq5VZ2AJG7pHYoZgEN8ine11DlVjBi9w2q2AYIBoqirs32Ft
	 PoNHeJ7MfgytpBLFruqLpWy2R86D+NAIlNWRBgtsNEDwBBH/JEmxqQnTEmrl7ZD4ru
	 K8+hLt8z8iAR3Tm5V5Vo6gxa5yl42OIY9ElETplw=
Message-ID: <472f333a-8605-46cb-b20b-ae8d7b8e62bc@ideasonboard.com>
Date: Mon, 9 Feb 2026 11:40:08 +0000
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: malic55: Fix possible ERR_PTR deference in
 enable_streams
To: Alper Ak <alperyasinak1@gmail.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Nayden Kanchev <nayden.kanchev@arm.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260207091822.601255-1-alperyasinak1@gmail.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260207091822.601255-1-alperyasinak1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Morning Alper, thanks for the patch

On 07/02/2026 09:18, Alper Ak wrote:
> The media_pad_remote_pad_unique() function returns either a valid
> pointer or an ERR_PTR() on failure (-ENOTUNIQ if multiple links are
> enabled, -ENOLINK if no connected pad is found). The return value
> was assigned directly to isp->remote_src and dereferenced in the
> next line without checking for errors, which could lead to an
> ERR_PTR dereference.
> 
> Add proper error checking with IS_ERR() before dereferencing the
> pointer. Also set isp->remote_src to NULL on error to maintain
> consistency with other error paths in the function.
> 
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
> ---
>   drivers/media/platform/arm/mali-c55/mali-c55-isp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> index 497f25fbdd13..c7225e9c8df7 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> @@ -360,6 +360,13 @@ static int mali_c55_isp_enable_streams(struct v4l2_subdev *sd,
>   
>   	sink_pad = &isp->pads[MALI_C55_ISP_PAD_SINK_VIDEO];
>   	isp->remote_src = media_pad_remote_pad_unique(sink_pad);
> +	if (IS_ERR(isp->remote_src))  {
> +		ret = PTR_ERR(isp->remote_src);
> +		dev_err(mali_c55->dev, "Failed to get remote source pad: %d\n", ret);
> +		isp->remote_src = NULL;
> +		return ret;
> +	}
> +


Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

>   	src_sd = media_entity_to_v4l2_subdev(isp->remote_src->entity);
>   
>   	isp->frame_sequence = 0;

