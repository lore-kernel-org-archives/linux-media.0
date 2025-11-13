Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B982EB5B4
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046771; cv=none; b=cHSHr/3RwirEJPw0n74qy3wJ3wfesqaKfrG5yu1DxuKChzmzyOxUdD94fhFZy67V+w4TBeegHLAwOqCo2fkr6g8OubTP3PCKsfAMz+3RV4T80NH/5RwuFR3Gm/aDNS6/YJooD74cHqyCmZzCOX86KKcaDyvQk0Mq35fJKgkCHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046771; c=relaxed/simple;
	bh=5Sf4zyHB9WGqifEJ1fMpmBIqmZUt1PUaELM/Oh/eL2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJmEb34MGcotPtp3VWR/A8PlmVZ6qI3zZIxiXSEM9Bj2fTdLeLfQHHNewwXkX4pCbH+5X4e68qyP5g8TxaqWw0c0VbetWulECnr487LPW96tI/neyzDkOYOOTQpHK1W2eoX350tK+ByiXFUcz5TlgPd3+LfGa1jsJbH15q+V6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=htstDCKC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="htstDCKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763046765;
	bh=5Sf4zyHB9WGqifEJ1fMpmBIqmZUt1PUaELM/Oh/eL2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=htstDCKCnQdE3oPoTH6FcUeEAt4XLnvuWA+mpmA1E5YtjG5f6yideNKYg59FnP/ZX
	 3O70YMY/C0mKUg2xpPy3q8CDhVZFENHewUvEJOzcgirx4ZAIq/YmPQ/cFgdtFEF1Uy
	 UUHOVVkfCp1yWLjy2ArMHTfDmrt0kZwcV7lmmRM/9pX+fueuttsrerqt9sq4IsKEZI
	 taMd+LqzKSejsiWA9hzdwOYV3Wes8eAW6RqoLCB/LDwFkoY6aFRAJZ78J3rZR7QIHz
	 vkO+i99qeSN/r53XP6pD3btDxnQ7atYMEN77Me6inX9IDfZ0LJJpewCiQLEMzYNxau
	 MEoDcGKyPhLkg==
Received: from [10.40.0.100] (185-67-175-126.lampert.tv [185.67.175.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9688517E10DC;
	Thu, 13 Nov 2025 16:12:45 +0100 (CET)
Message-ID: <b13fe66a-674e-4db3-9467-ac7619c17f77@collabora.com>
Date: Thu, 13 Nov 2025 16:12:45 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] media: v4l2-fwnode: Allow passing NULL fwnode to
 endpoint parsers
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <20251113150926.655972-1-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20251113150926.655972-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sakari,

Thanks for the patch and for addressing my comment!

On 11/13/25 16:09, Sakari Ailus wrote:
> v4l2_fwnode_endpoint_parse() and v4l2_fwnode_endpoint_alloc_parse() take
> a fwnode as the first argument and leave it up to the caller to check a
> valid fwnode has been obtained through various means. Instead, add a check
> here so the callers won't need to do that anymore.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Michael Riesch <michael.riesch@collabora.com>

Best regards,
Michael

> ---
> since v1:
> 
> - Explicitly mention @fwnode == NULL case for -EINVAL
> 
>  drivers/media/v4l2-core/v4l2-fwnode.c | 3 +++
>  include/media/v4l2-fwnode.h           | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index cb153ce42c45..22ec702a4567 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -465,6 +465,9 @@ static int __v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwnode,
>  	enum v4l2_mbus_type mbus_type;
>  	int rval;
>  
> +	if (!fwnode)
> +		return -EINVAL;
> +
>  	pr_debug("===== begin parsing endpoint %pfw\n", fwnode);
>  
>  	fwnode_property_read_u32(fwnode, "bus-type", &bus_type);
> diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
> index f7c57c776589..cd82e70ccbaa 100644
> --- a/include/media/v4l2-fwnode.h
> +++ b/include/media/v4l2-fwnode.h
> @@ -182,7 +182,7 @@ enum v4l2_fwnode_bus_type {
>  
>  /**
>   * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
> - * @fwnode: pointer to the endpoint's fwnode handle
> + * @fwnode: pointer to the endpoint's fwnode handle (may be NULL)
>   * @vep: pointer to the V4L2 fwnode data structure
>   *
>   * This function parses the V4L2 fwnode endpoint specific parameters from the
> @@ -218,7 +218,7 @@ enum v4l2_fwnode_bus_type {
>   *
>   * Return: %0 on success or a negative error code on failure:
>   *	   %-ENOMEM on memory allocation failure
> - *	   %-EINVAL on parsing failure
> + *	   %-EINVAL on parsing failure, including @fwnode == NULL
>   *	   %-ENXIO on mismatching bus types
>   */
>  int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwnode,
> @@ -236,7 +236,7 @@ void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep);
>  
>  /**
>   * v4l2_fwnode_endpoint_alloc_parse() - parse all fwnode node properties
> - * @fwnode: pointer to the endpoint's fwnode handle
> + * @fwnode: pointer to the endpoint's fwnode handle (may be NULL)
>   * @vep: pointer to the V4L2 fwnode data structure
>   *
>   * This function parses the V4L2 fwnode endpoint specific parameters from the
> @@ -276,7 +276,7 @@ void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep);
>   *
>   * Return: %0 on success or a negative error code on failure:
>   *	   %-ENOMEM on memory allocation failure
> - *	   %-EINVAL on parsing failure
> + *	   %-EINVAL on parsing failure, including @fwnode == NULL
>   *	   %-ENXIO on mismatching bus types
>   */
>  int v4l2_fwnode_endpoint_alloc_parse(struct fwnode_handle *fwnode,

