Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749030594F
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774736; cv=none; b=YTYa8Kza7UWQbSYSXW3RzHO74ByJQ4vsIPGoA8TcRw5HATWHWbPIjWGzqcRII8gtNjGD2wVTh45N6hjTYoJRA9QnygYoCgHWIsL0mhOoL+pJTE+SGS1vOZgVHYq0F66tczqHAqPY7UU4JrII1Eiuh4iZdbkd/+K3oMlKdTUlLW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774736; c=relaxed/simple;
	bh=442tawppyk6VW4zUh6UCP/rG01cfIHZsqjC14wtPq6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2GS47/oCaBzENAzoVB4mLeuvm5/v/rW43SIDfwnZQH33hYd8t5+kaixfbDQbruv9H9WlEFWMeeL6QiZ3l9VUA6jJjzxkBZ+ffSmIhWcZCivcnNgwnEI14u9Til3uO0G99LnmrEYFQGONfQGgD2tSpSLQgoHOFndclKHeVwap8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aDasOyGa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDasOyGa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477549b3082so25804845e9.0
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 03:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762774733; x=1763379533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDGyqZKTc6nb0bCAbSIQ1bmZ2i6gcCfwYTLcd5wNs/k=;
        b=aDasOyGavf9cMAYOVFCg8V0Bts9qDcLZ0U4MZWY5IBd1UjKRuD8Bk7J6p3+XsWOZ7J
         An45SH6ebNL+8/Dgnj6jkLoJ5YCEdMudgRmr4una4/tsPeAfOgJ87uDsdiMsSfTLvoJO
         GowvWZl8np0p3ky+/Mn3BbXl4i3W1+wtaoMrZissmKo0t3L3DZKDBqcwDq9J2H/vKdOX
         Z5RBf6E1o8/7TLhawbW2eSvMgzs8v8wTz09bmiem9BAG3elJ4yqHT3ot5GqwBjJ9hp4E
         fHWXJSKRegWjDFMcMasqoGfifk47kx4mdjO0FX2s2iVifHJF+ei2Iiq3JncykkQLVORs
         sJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774733; x=1763379533;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDGyqZKTc6nb0bCAbSIQ1bmZ2i6gcCfwYTLcd5wNs/k=;
        b=i78YSIwZzykZ3dVZujxFHBd/HUkEEMNQg4l50vBBuN/pP9aCZgY+QRzJcNJUVsa3rD
         qRTbatO8+kj29Zt31Wel2mpIczGaJnZywRWJ5Un+MxX6CioyT2wutybkiE4IyYTb8Np9
         1W6+eBujIL4VApvFmndBp60yOWMDlKE+bbV+OCU1RYsk+SCT8SJTzl8OovyA2Yh+mm68
         PZM3RsvdjTdOWI4FfvmobD/1DfNEsFe+tQltvHvbC9YlVVentVn1PSZd8DkI2f/msxfk
         bakVRY2CoDlEdXrQZDxvTyQzPd/o/zJHck3G1cZ7ZA3Lx9X6IfEzD99vNGJWHFpNvAFP
         hikw==
X-Forwarded-Encrypted: i=1; AJvYcCXbfThEzsnK4taecbB2pI0OLVdnEU5NYitP36Y0FPQgmtRlUt4AUni2dbCOi6fHZtacwdgQ5WS3LXSMOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyAFgeXToqA8AWuQDN2ANthHRxlcm3ndpZCFLdDnFoKSCp9qR
	PrqgAAR8AIk5g8fUKJ4BoBp+P0Jy1Rk1TTiEIUu5sZ/IR0XOjQ3CoJEGdwqzcPJzgis=
X-Gm-Gg: ASbGnctiLzS2baEhkttF9X7gu8FZ7vr9leUi3gqlhrgvRA+Ft3Mw21qtAuCKggyYbCq
	JNUdMfEfD4+qOPPeJ66XR/qkCMIHAVcR1Ms41vtS4zTcCI6WhNBiqd+zT+yx1hOJrEsb9QFV/Of
	GGaja9SU1zAeIT/eB0hTldMgC6TNQ9brKojb8EzxSF0VwJZiZE9V243414VnEEdCbCj0hE066Mz
	eJ9eioXeFZvyKJJMJEQhkBV66BUlnJ94tzk/g5LIOLBM/GZCH1aVnYJ6y3YCFLVoGxjdyCPUdWY
	dCOKpl5BvUzorx1tJta4YGMBrUxs2huslhimD+2rH1NZM8brenfdU3MQ6Bp7ZuYb9ceMiXfYVBm
	2Ufz9vOL0wsQ1t49hOv4qhXcZhJtQwUBJbmMew+/ECgPqc0w5/XuLIfDMiv1gZ2E9nJ0zjgDvIL
	GCzPnWiiXhq2pfYVdeXJmtxgPSvbgvFzpRxEcmAE9mQg==
X-Google-Smtp-Source: AGHT+IG+JUAf6UVQVsqEmCn1XhFTq5TWQOptKskoiqVgM/FKW2sNC6jwfwM3QRHOYWASpaXOTouW+A==
X-Received: by 2002:a05:600c:4fcb:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-477732341e9mr73691505e9.13.1762774732654;
        Mon, 10 Nov 2025 03:38:52 -0800 (PST)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ee3sm314783285e9.9.2025.11.10.03.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:38:52 -0800 (PST)
Message-ID: <150cee0d-6c5f-4380-8c3b-ff29c4ca679b@linaro.org>
Date: Mon, 10 Nov 2025 11:38:51 +0000
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/8] media: qcom: camss: Initialize lanes after lane
 configuration is available
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-5-165f7e79b0e1@ixit.cz>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251109-qcom-cphy-v1-5-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/11/2025 09:39, David Heidelberg via B4 Relay wrote:
> From: Petr Hodina <phodina@protonmail.com>
> 
> The lanes must not be initialized before the driver has access to
> the lane configuration, as it depends on whether D-PHY or C-PHY mode
> is in use. Move the lane initialization to a later stage where the
> configuration structures are available.
> 
> Signed-off-by: Petr Hodina <phodina@protonmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 70 ++++++++++++----------
>   1 file changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index 348b8cd18327e..c2adbde6b4e0d 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -1101,6 +1101,42 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
>   	u8 val;
>   	int i;
>   
> +	switch (csiphy->camss->res->version) {
> +	case CAMSS_845:
> +		regs->lane_regs = &lane_regs_sdm845[0];
> +		regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845);
> +		break;
> +	case CAMSS_2290:
> +		regs->lane_regs = &lane_regs_qcm2290[0];
> +		regs->lane_array_size = ARRAY_SIZE(lane_regs_qcm2290);
> +		break;
> +	case CAMSS_7280:
> +	case CAMSS_8250:
> +		regs->lane_regs = &lane_regs_sm8250[0];
> +		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8250);
> +		break;
> +	case CAMSS_8280XP:
> +		regs->lane_regs = &lane_regs_sc8280xp[0];
> +		regs->lane_array_size = ARRAY_SIZE(lane_regs_sc8280xp);
> +		break;
> +	case CAMSS_X1E80100:
> +	case CAMSS_8550:
> +		regs->offset = 0x1000;
> +		break;
> +	case CAMSS_8650:
> +		regs->lane_regs = &lane_regs_sm8650[0];
> +		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8650);
> +		regs->offset = 0x1000;
> +		break;
> +	case CAMSS_8300:
> +	case CAMSS_8775P:
> +		regs->lane_regs = &lane_regs_sa8775p[0];
> +		regs->lane_array_size = ARRAY_SIZE(lane_regs_sa8775p);
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	settle_cnt = csiphy_settle_cnt_calc(link_freq, csiphy->timer_clk_rate);
>   
>   	if (c->cphy) {
> @@ -1160,47 +1196,15 @@ static int csiphy_init(struct csiphy_device *csiphy)
>   		return -ENOMEM;
>   
>   	csiphy->regs = regs;
> -	regs->offset = 0x800;
>   
>   	switch (csiphy->camss->res->version) {
> -	case CAMSS_845:
> -		regs->lane_regs = &lane_regs_sdm845[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845);
> -		break;
> -	case CAMSS_2290:
> -		regs->lane_regs = &lane_regs_qcm2290[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_qcm2290);
> -		break;
> -	case CAMSS_7280:
> -	case CAMSS_8250:
> -		regs->lane_regs = &lane_regs_sm8250[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8250);
> -		break;
> -	case CAMSS_8280XP:
> -		regs->lane_regs = &lane_regs_sc8280xp[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_sc8280xp);
> -		break;
>   	case CAMSS_X1E80100:
> -		regs->lane_regs = &lane_regs_x1e80100[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_x1e80100);
> -		regs->offset = 0x1000;
> -		break;
>   	case CAMSS_8550:
> -		regs->lane_regs = &lane_regs_sm8550[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8550);
> -		regs->offset = 0x1000;
> -		break;
>   	case CAMSS_8650:
> -		regs->lane_regs = &lane_regs_sm8650[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8650);
>   		regs->offset = 0x1000;
>   		break;
> -	case CAMSS_8300:
> -	case CAMSS_8775P:
> -		regs->lane_regs = &lane_regs_sa8775p[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_sa8775p);
> -		break;
>   	default:
> +		regs->offset = 0x800;
>   		break;
>   	}
>   
> 

Agreement in principle.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
