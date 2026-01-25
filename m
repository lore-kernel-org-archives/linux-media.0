Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839D6F2F2;
	Sun, 25 Jan 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769351250; cv=none; b=rCOsufL0YIvBMu1FCz2rADOFX8vO+z89AIeDyfvDdb3XS3TaN6EZG+wzgZ2rVHRGljPaniTS+d+F0MmgBJyfV9gSeljRS/WRJK+8U4QFIGNpl7WukeZK03O8/vKjeKtx66ma2BoES/oN+EGrEBRAYaSrbu6AyZRS8mvlOpJoSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769351250; c=relaxed/simple;
	bh=0gnDMQZ0Vq1zmYxMoR8WndkzodMPuEg5CTCWExRZ7PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp7Jn6jzgzdHSalP1fZIrfFKARMDj0GOJOMI1QP3MaCvV5IeKfot8HChdtnvfClR/7V/AVZfRbIlPtei+ojOt+ZqEqHM+EhLgzaenNSgdhap37EKmUYa95WSNgm+FAPYCoQtJV/Bxu5Q87ahWuvyg3J/1QiaNq389qgqkkwnRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LYXQV92; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LYXQV92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99038C4CEF1;
	Sun, 25 Jan 2026 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769351250;
	bh=0gnDMQZ0Vq1zmYxMoR8WndkzodMPuEg5CTCWExRZ7PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0LYXQV92xVGtQFfSGTxBld27ksnay9RwMQBk/qVwIKe0QWwXPw5EFub/IE6VHhoBl
	 hxhCLkrdn63yOSIb55P7++oBkIA5SdntseWkI1YT+UhKhAieMhTp2LqCTyhMjpttwf
	 idVn/r7rh0dDw7wH2BJBByNPHtLMS3XkWTKXpbE4=
Date: Sun, 25 Jan 2026 15:27:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: jackson.lee@chipsnmedia.com, mchehab@kernel.org,
	bob.beckett@collabora.com, sebastian.fricke@collabora.com,
	dafna.hirschfeld@collabora.com, nicolas.dufresne@collabora.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: chips-media: wave5: fix a potential memory leak
 in wave5_vdi_init()
Message-ID: <2026012518-carol-hankering-123d@gregkh>
References: <20260125141915.2088123-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125141915.2088123-1-lihaoxiang@isrc.iscas.ac.cn>

On Sun, Jan 25, 2026 at 10:19:15PM +0800, Haoxiang Li wrote:
> Add wave5_vdi_free_dma_memory() in the error path of
> wave5_vdi_init() to prevent a potential memory leak.
> 
> Fixes: 45d1a2b93277 ("media: chips-media: wave5: Add vpuapi layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/media/platform/chips-media/wave5/wave5-vdi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> index bb13267ced38..8f71920a8a35 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> @@ -49,6 +49,7 @@ int wave5_vdi_init(struct device *dev)
>  
>  	if (!PRODUCT_CODE_W_SERIES(vpu_dev->product_code)) {
>  		WARN_ONCE(1, "unsupported product code: 0x%x\n", vpu_dev->product_code);
> +		wave5_vdi_free_dma_memory(vpu_dev, &vpu_dev->common_mem);
>  		return -EOPNOTSUPP;
>  	}
>  
> -- 
> 2.25.1
> 
> 

How was this found and tested?

thanks,

greg k-h
