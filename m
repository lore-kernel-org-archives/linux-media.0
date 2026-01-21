Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90621305E32;
	Wed, 21 Jan 2026 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959834; cv=none; b=Wn+5n0mycAv1vwr4GeVHg8Hf13Lhi0BZDOjIleAu+ae7A98Gg5jjYYEeddaE7NIencbS1R5yt+JQiXJbEiaY56wLsiYYH7IWf1jwNwNcqinbtLVwZjwh1xtCO3FSGGaDmm7WenbEvS6o+FHb3RnD0XDboe3YR+JAU9ZTOypp4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959834; c=relaxed/simple;
	bh=4tldAe57KIhnwtzr8Bq/hvpgF6dJBV0FlSqy2EGPIco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9yi3zW5QyNeA7WMHfvrKEGxJgmoe7YWmJWk8HAbZSYKZ1uen1q4icLI6jgPtAtLRmpQpQtNvEL3VmZNikDMa5Sxpk2ZW6OeG7XbsS44j42SC1tvEHiSXXNHO9IYIiS093bFJ6zPXvNyV6jGjUmqJcTrQ91RMHyH15Mm+NSbjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Ru1Q91pt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ru1Q91pt"
Received: from pendragon.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 31B182D7;
	Wed, 21 Jan 2026 02:43:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768959794;
	bh=4tldAe57KIhnwtzr8Bq/hvpgF6dJBV0FlSqy2EGPIco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ru1Q91ptMf7hveD3WxgR/C5BZjDqyKE8SqVBUqZNE6ltTIsv87fdJLJ8PKVk/CHmS
	 +Nj+Q2LFzqSr9spnLmtTocPaIFlH7eFD7E/2FIVmJApNl2pml3c9gQt2rUBB97YgKe
	 ENTG8QunDOkoc0J+bKMzdJ8NonSF8Im1NPo1nOkw=
Date: Wed, 21 Jan 2026 03:43:44 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger-Novakovic <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] media: nxp: imx8-isi: use
 devm_pm_runtime_enable() to simplify code
Message-ID: <20260121014344.GA403250@killaraus>
References: <20260116-cam_cleanup-v4-0-29ce01640443@nxp.com>
 <20260116-cam_cleanup-v4-2-29ce01640443@nxp.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260116-cam_cleanup-v4-2-29ce01640443@nxp.com>

Hi Frank,

Thank you for the patch.

On Fri, Jan 16, 2026 at 11:29:20AM -0500, Frank Li wrote:
> Use devm_pm_runtime_enable() to simplify code. Change to use
> dev_err_probe() because previous goto change to return.
> 
> No functional change.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> change in v2
> - remove error code print at dev_err_probe.
> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> index c3d411ddf492eb27b372763ce5d344a90c6ec524..486092511d1f9381c250ddcf844fc74c61a789b7 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> @@ -499,13 +499,14 @@ static int mxc_isi_probe(struct platform_device *pdev)
>  	dma_size = isi->pdata->has_36bit_dma ? 36 : 32;
>  	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_size));
>  
> -	pm_runtime_enable(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
>  
>  	ret = mxc_isi_crossbar_init(isi);
> -	if (ret) {
> -		dev_err(dev, "Failed to initialize crossbar: %d\n", ret);
> -		goto err_pm;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to initialize crossbar\n");
>  
>  	for (i = 0; i < isi->pdata->num_channels; ++i) {
>  		ret = mxc_isi_pipe_init(isi, i);
> @@ -528,8 +529,7 @@ static int mxc_isi_probe(struct platform_device *pdev)
>  
>  err_xbar:
>  	mxc_isi_crossbar_cleanup(&isi->crossbar);
> -err_pm:
> -	pm_runtime_disable(isi->dev);
> +
>  	return ret;
>  }
>  
> @@ -548,8 +548,6 @@ static void mxc_isi_remove(struct platform_device *pdev)
>  
>  	mxc_isi_crossbar_cleanup(&isi->crossbar);
>  	mxc_isi_v4l2_cleanup(isi);
> -
> -	pm_runtime_disable(isi->dev);
>  }
>  
>  static const struct of_device_id mxc_isi_of_match[] = {

-- 
Regards,

Laurent Pinchart
