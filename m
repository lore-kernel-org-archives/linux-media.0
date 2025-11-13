Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871823E23C
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042186; cv=none; b=aTbEJEius4TjXQUULy8zgkULGkshE55JQKDIO9w+Iysx/mkCpNytq431JSBPOzJLjwhyX0sFM3xypi+u1fkZ+LHY9GKXtaEViPvXxaNPD8Hglvmk8Yv/h8lWnny3tIEbtkUjXTYUp/HwlPlVgMd3EtLq60/b3YpG8fJtYeFOVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042186; c=relaxed/simple;
	bh=3dBlMJS05WiRtSY0yabWtz7N5sDIXptfdaP92jdowtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwVqhI46L771DtnISWEuzVOOC1KsVL8cR9bnI1sBRZAXPS75UiiNaSoetWlFTU54jYRZ5V/sco0XSbStb6uFE+yiAIIfjAQEkoV4hGYROCohcW/57Q5hMYFaxofcD95N0GWRh7x5bxocZF21IETWa3p6txuifK92r7donVexI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R7//II1/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R7//II1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763042182;
	bh=3dBlMJS05WiRtSY0yabWtz7N5sDIXptfdaP92jdowtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R7//II1/UjvNC5QmXJvgHYQRpwRHfxInUxsnoMOPwUws99r0xeQC8IUYBb16lq+5E
	 gzjRV2YemUpv+ATliDS77cZnpBSVBRtHWv+rGwPKv9BPcxNe6ZvBBXX9F33dOo68Rh
	 kGxsHYbEOj9Mivd5CF2IR6xCjggDtJMq1NYC+vEdfZD3RNyyvdn0ZMHFCygaYnN1g9
	 LSgij30/pjcXc9Ts+7H6vRmRF3iSuuhmmtQyM+uU1AT4fv13zGlRR08ZBlB71G8ECb
	 GT4ykf/7gtcyWf6SJrkmrWLRRxY1BimEGt3zFF8KBXyjDZ30Kd4T+Z6gSgLzCfXt2q
	 Y+V8MEf+Wm4Fw==
Received: from [10.40.0.100] (185-67-175-126.lampert.tv [185.67.175.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4DB2F17E1340;
	Thu, 13 Nov 2025 14:56:22 +0100 (CET)
Message-ID: <54404cd0-2aae-489a-bb7d-771058b35aa5@collabora.com>
Date: Thu, 13 Nov 2025 14:56:19 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] media: v4l2-fwnode: Allow passing NULL fwnode to
 endpoint parsers
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <20251112100333.97288-1-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20251112100333.97288-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sakari,

Thanks for the patch!

On 11/12/25 11:03, Sakari Ailus wrote:
> v4l2_fwnode_endpoint_parse() and v4l2_fwnode_endpoint_alloc_parse() take
> a fwnode as the first argument and leave it up to the caller to check a
> valid fwnode has been obtained through various means. Instead, add a check
> here so the callers won't need to do that anymore.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Michael Riesch <michael.riesch@collabora.com>

LGTM, just one question...

> ---
>  drivers/media/v4l2-core/v4l2-fwnode.c | 3 +++
>  include/media/v4l2-fwnode.h           | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
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
> index f7c57c776589..299b60ce960b 100644
> --- a/include/media/v4l2-fwnode.h
> +++ b/include/media/v4l2-fwnode.h
> @@ -182,7 +182,7 @@ enum v4l2_fwnode_bus_type {
>  
>  /**
>   * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
> - * @fwnode: pointer to the endpoint's fwnode handle
> + * @fwnode: pointer to the endpoint's fwnode handle (may be NULL)

... isn't that addition a bit misleading? It says it may be NULL, but it
returns an error in this case?

Checking for pointer == NULL in public functions is excellent practice,
but I wouldn't say this needs to be emphasized in the argument
documentation. But that's just my €0.02, I am fine either way.

Best regards,
Michael

>   * @vep: pointer to the V4L2 fwnode data structure
>   *
>   * This function parses the V4L2 fwnode endpoint specific parameters from the
> @@ -236,7 +236,7 @@ void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep);
>  
>  /**
>   * v4l2_fwnode_endpoint_alloc_parse() - parse all fwnode node properties
> - * @fwnode: pointer to the endpoint's fwnode handle
> + * @fwnode: pointer to the endpoint's fwnode handle (may be NULL)

PS.: Same here of course

>   * @vep: pointer to the V4L2 fwnode data structure
>   *
>   * This function parses the V4L2 fwnode endpoint specific parameters from the

