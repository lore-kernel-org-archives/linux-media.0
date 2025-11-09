Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006992E9EB5
	for <linux-media@vger.kernel.org>; Sun,  9 Nov 2025 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691758; cv=none; b=e1Z4nvIaJZvpyYk5wwWh14qgyO6Zo4R/Yysu0EF6XjjSry8cIzkX5jnF5Rux3Ifx/2jXtgN8+RvmFi/QMVAc0RoUH6DQjcsC0HRcJ7blWzt01biG0ya35w7TS7g8M7dvJWOIa7ylGcsworQDLdSSdM5cMOdjlJPuG9y8KTfATr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691758; c=relaxed/simple;
	bh=aipiftIL6cxlw0GmgAzYCOHVmHzME3ZaXt6XC5G+Nz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx67Nr2l4lJ/1aI4GVoUCT7Y8UDizM6MCCrSzX/wL2QaQyUp3rwen+Ms9Zj8JEBaZOH820fz7qZdhvnfangat/kVByCMhIMDErLGbk+fFUb87bqOq6pWuSMXOkAhaJAJQwXNQ0PBYffGxuJOhgX3iBybOSQVbEOLV6tWL3MtKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AKmndVwy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKmndVwy"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b72dc0c15abso238432266b.1
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 04:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762691755; x=1763296555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0Qyhz1x92lWHWIws7RgtXksw84DNzrjoWDqoYr7AO8=;
        b=AKmndVwyCCdfIuvbYslfOaz43nYUeQLkQFvyscJDKS6u4GGhwp+q2LAcOmfnREbnly
         F6PjfVWxM9VI1joImX+CfXhVyK/iVZ5whptNyuYGEukSwzyrMWRfZ8TZVoqaIEWbHtkG
         WLnhTGiLsTosV3+miPaqJVfO6Wsu2ciiobAEHUMXWdAPWjO8H5VhLLxPaXjBbmxi5huF
         LxVwNdo8s2Dl39vsokC1Ja3X0Izjy9ZSnDbXyLFhKNWRcNwR0cPzIji0MJY2TEMl6HAP
         H6+pDPYUz7IeCeJKEjRILOY7yv3F26Wc9FuKX7skhFgMUQTWkZrle4kUHrPR7UEFWuiB
         JJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762691755; x=1763296555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0Qyhz1x92lWHWIws7RgtXksw84DNzrjoWDqoYr7AO8=;
        b=oeEgtE5ZuW8QSXz66Psm6N4/TU3voZabmpJzPh7VWMbgTuh6kPVEAqFg9ftb0Bo1Va
         FizsBWhhkabR43rAp+xdtlyHQUg0rZKOV38zwkaORBBOFz1LJqSYwwtGyFWs3Hkm+rcK
         uJZR8ntuv+QlZrZSi7pi/kO9qJ1JigBhBskMCn7vWbZ8XdQ8EQz+ym5BfkvHUl2vRqiR
         qqqAaM1DU3ij+uMsyhJwNMASpvWNsO+SvE9FCsEddrcFfT55zrtgZ0jLnoNN5Fm7nnCR
         FQ0xLqzK3/x4OlZXvdZeFgqhTcsYxfsuQmuXC8Yp05L1WPeSfPsln5bjqi6y6bF4r0wC
         Apbw==
X-Forwarded-Encrypted: i=1; AJvYcCXXj02C9evQuPW7Jada9qKAn48/gT64Q6UBXv2l5xhertfsKbM2Y4Lj/XeyCK2ggOpJoGT12HTosKqHfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZnHHxpk/GG7TBP1mgKllyanW4AQreqdKPwwQ094dm2jpOqiS
	cw/aS58MIXmxeovu7HSMV1mXqubk0YwlDJN/OT9XhAuI37326BviZasKCHLu66DxPzE=
X-Gm-Gg: ASbGnctSxcvx2mH25/cn+WfPMVwbLcHH6Pgzf1xf9mTzQgB5Sc1JYSSMvGfQvgKpx7O
	SvyDUZIb7RZ2998UNjwPrUMAeCErDz2w8rOUe2RL4AKZaYuZknNVGRf3mF4iyn0mW6hZWTUYirO
	ooMj+CjoGGQHYf9dRDXydArLdl1wuQNzlESY6IuIvxQ9Ay0rH8x4nk1zTSXIPZYOnt9kVV2zKku
	ioKWv00CPc4aBCiDlC0ZoJ8XyQZMtDZdgNoH6bn8M0HvVjDHqS0n2RaN69OSxOu882YNT3FB3UM
	0DjqG/LEwn0GAmh9ZCF58FtbbjRkbZs2bc1wh9rBUqk7GzQZ5+gMsGC/Iyl6YyuLrkzEE6ZnlcQ
	ENEzduVv4lFKq7+TkODolywJ3zXxpxZdrk+PTkT+d+us1i+RUVZ4HKKPapOeOucTFfLpTerNvNU
	dtMGi5fjTy92ejz8VYV8HOoMyGq6lWeCvDgv0zM9BayBVdCjkt42K7qf+snbbXyya968ztgUIAV
	O+a1XxbVjPOT/zKMRWkjHa6Vs1eR1q7OE9i0OxQfo73SsB4ueiBUaj/7gJb/7bwQHY5X8Fj+gIG
X-Google-Smtp-Source: AGHT+IHyykZNktMvLQKNtgxSniaCk3u7efAcZ163+WwM1eqdehxI0ewxnn6NYoG1aJsp8Lj9a6zjlA==
X-Received: by 2002:a17:907:2d8d:b0:b72:a899:169f with SMTP id a640c23a62f3a-b72e028a446mr537437266b.4.1762691755219;
        Sun, 09 Nov 2025 04:35:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6? (2001-1c00-3b8a-ea00-4729-b0ef-dcc4-b0b6.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97ea95sm811509566b.44.2025.11.09.04.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:35:54 -0800 (PST)
Message-ID: <f3a5c965-6bf7-4e0a-bccf-f0342928150f@linaro.org>
Date: Sun, 9 Nov 2025 13:35:53 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] media: qcom: camss: csiphy: Introduce C-PHY
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-2-165f7e79b0e1@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251109-qcom-cphy-v1-2-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 11/9/25 10:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Read C-PHY from the device-tree bus-type and save it into the csiphy
> structure for later use.
> 
> For C-PHY, skip clock line configuration, as there is none.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csiphy.h | 2 ++
>   drivers/media/platform/qcom/camss/camss.c        | 8 ++++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
> index 895f80003c441..8f7d0e4c73075 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.h
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
> @@ -28,11 +28,13 @@ struct csiphy_lane {
>   
>   /**
>    * struct csiphy_lanes_cfg - CSIPHY lanes configuration
> + * @cphy:     true if C-PHY is used, false if D-PHY is used
>    * @num_data: number of data lanes
>    * @data:     data lanes configuration
>    * @clk:      clock lane configuration (only for D-PHY)
>    */
>   struct csiphy_lanes_cfg {
> +	bool cphy;

Bit of a nit, but it would read better to use an enum here I think, then 
one doesn't have to infer that "!lncfg->cphy" means dphy mode.

Kind regards,
Casey (she/they)

>   	int num_data;
>   	struct csiphy_lane *data;
>   	struct csiphy_lane clk;
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index fcc2b2c3cba07..549780f3f948b 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4055,9 +4055,13 @@ static int camss_of_parse_endpoint_node(struct device *dev,
>   	csd->interface.csiphy_id = vep.base.port;
>   
>   	mipi_csi2 = &vep.bus.mipi_csi2;
> -	lncfg->clk.pos = mipi_csi2->clock_lane;
> -	lncfg->clk.pol = mipi_csi2->lane_polarities[0];
>   	lncfg->num_data = mipi_csi2->num_data_lanes;
> +	lncfg->cphy = vep.bus_type == V4L2_MBUS_CSI2_CPHY;
> +
> +	if (!lncfg->cphy) {
> +		lncfg->clk.pos = mipi_csi2->clock_lane;
> +		lncfg->clk.pol = mipi_csi2->lane_polarities[0];
> +	}
>   
>   	lncfg->data = devm_kcalloc(dev,
>   				   lncfg->num_data, sizeof(*lncfg->data),
> 

