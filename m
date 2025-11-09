Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1B2E9EB5
	for <linux-media@vger.kernel.org>; Sun,  9 Nov 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692226; cv=none; b=s1NqQleGAZqPAX/BZX/p34NvfOf3ogagwhgCywOy00k6YbkQ1lrReDKxjAaferPItMZfrI0REF/Q5hOiRpH7Qr3S+SaOb6qxtn2H3D+vy6ANRAJt3dJUXBB4pd0dJ+z9xCtn0YEm+VLzHJvl2oUnGqpnNfZ9d3EvjUpPojDJeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692226; c=relaxed/simple;
	bh=BS5KrCiw8PRT9pORU3Re/5WSroIZAKASnJGIlF3es7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZGXzMOykuQ66fmct+nJq+cJWMMJWM3pd7KN8yq86J4jVC91UBn1fTreClPnXgxC1GnHtHIVpoRkiAWrN5c4sF806xIRJXWOq8kcjCGusGzWYWJjBGKrXr8DE6AlaKgFGI+6SO2pzR5oI6rNYdMOHkw/rnxDwX+Yn6H8PvNfWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RGw7p8hN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGw7p8hN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so4277005a12.1
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 04:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762692223; x=1763297023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWErFsO2tEX/BOEFeY/JUuqvBv8pyRA62qDCMk8OHC0=;
        b=RGw7p8hNtL1ayOFEGVZTU4WouxNqK8yu2MEPSf5gx2EU7tVz01TOOgDt0KklgcbsWW
         mt9pfTmAXtzl8xEXjW7hV9P0SUiDz9nUaj4+ywh0YFutzB1TCTANBBXKi3v9kMnoSsba
         ljY56Sm/xgNKoeqOVnm/mqw7zLoJpZhvXIxbbX2Soxl4pQebys9n232zR58dzp+2VxXk
         7u/598z3jDO8PCP9uBd+BZwAQvLO3QmHq3XQ4Jw+8eDynnuO2hWrsEWZV9+grYQUOHka
         4wsCgKbtr1b6Q6+yrj1jxXtKzEA2XM4EXUqK6mkXl+nBdzkeNElVuGBtMb9udl1I2FBK
         n//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692223; x=1763297023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWErFsO2tEX/BOEFeY/JUuqvBv8pyRA62qDCMk8OHC0=;
        b=i9C5jV/bFwd5GZw6N1964GsrcaDHL5les9Tvsn+AC9WjXHq46SuOyUSDHwvRJmtUjP
         HEhuc5JPQqHb3/y7Il0oj41j9vUwm+508rqRpCnSIVGP99AYA4hrhLZPu5TZtnta3O+F
         xrG4OMX7DhRVmCE8gYp67acs3zVNfO2eA9W4nXiSvEQQlRvZNrHjA65K9CwUdKfDP1yF
         SGtgFKRw2SFQVx4F79RHZnGa8E3/lbpgNThkuom/xdn1U5PE5IJh6cqySqny4pFyWa16
         McfKA8uRWXmVvMroG9m6zgCy82vo1tD24A5RlFmsakUY1nQOEbU0+RKNTIDJipGtzQ+l
         rHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXigmy5ffzSqMzI7kOsv3wcrkw/Stv/xQWdMqx21Uj22bqAlLGxAMyINcnC0F0Cv3auUVhvZpB8cHAPzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiLxdhSvJ1SrXmENcgQsq3nc2DDzwlMufn46f7/pJtxEwmLTt+
	EAEbbyoBc2yEBfcwcdFLRd0ap6Rq46ttDsx1wpHHudVLVqjZN3P9lACm+eJbNzhbOH4=
X-Gm-Gg: ASbGncsNS3EtBG/hOd9FTxKwIXtl/nhNg/ottYcY1+9arq7eWaK3D60dfX2t/8R/KT7
	R2VEF+nW9UDbvwNUrDwLdpA4iCMRYjOhooAZ+rDsyXCxTAMjv1GfG+1zGhGYoNe9BCrNjgCQEHM
	Aj3IB0kX4DIGPq+TDbijfrhDpGpkdHel0LYEfqtAavHJ7wP8pNRgsqig8qcbEM10b5SS17/0wuN
	aDKVJPye4jqyc/3Em+DbR+h5k0nZecDm9hzYEvoj7VMER1P1t4gy6HehsSc0ChYs6cBlyepWp57
	enX/SOeAKXbaRDjIIShI6fDKX+2KwMGZicZUlleZ15Aj/0uy4wWP/SZAwFiSEKJD13UF4jOqWWS
	huIleobLEgF8zwaW+yg6ckh8F+mFPplSuwZHUprO/g0XIFXcA2sv+tuTxUcL8gRNlALHOsNRHCA
	vmPz60Umfiv5skSohB8nKCaKtZY0YBsLXfBL7EIQPBhQVTcQpcApcmFRaXhE4nFWMDOPBn4Rhqg
	5XPegdx53w48ac6ZH4PRSzCIC5henh16G0ve5DB3iv1FaAEHMfamO5ZPySIj73Q1RLz1dASnHD6
	zR3WoAja3Bg=
X-Google-Smtp-Source: AGHT+IEmKraCtXyz5pwfItQXmoPTPeRlR1wlc8EhkGzafL7gDnpHwT7RooYHeCo6KYAU03Bhf73/iA==
X-Received: by 2002:a05:6402:3042:20b0:640:c918:e3b with SMTP id 4fb4d7f45d1cf-6415e80b1d2mr3448160a12.26.1762692222982;
        Sun, 09 Nov 2025 04:43:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6? (2001-1c00-3b8a-ea00-4729-b0ef-dcc4-b0b6.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e9d7sm8852874a12.36.2025.11.09.04.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:43:42 -0800 (PST)
Message-ID: <a13b5b89-ee13-4fe6-b57c-5e4ea724522f@linaro.org>
Date: Sun, 9 Nov 2025 13:43:40 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 8/8] media: qcom: camss: Remove D-PHY-only endpoint
 restriction
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
 <20251109-qcom-cphy-v1-8-165f7e79b0e1@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251109-qcom-cphy-v1-8-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/9/25 10:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> C-PHY mode is now supported, so the endpoint bus-type restriction to
> D-PHY can be removed.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 248aa6b21b5ad..1408e8a03f0bd 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4044,15 +4044,6 @@ static int camss_of_parse_endpoint_node(struct device *dev,
>   	if (ret)
>   		return ret;
>   
> -	/*
> -	 * Most SoCs support both D-PHY and C-PHY standards, but currently only
> -	 * D-PHY is supported in the driver.
> -	 */
> -	if (vep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> -		dev_err(dev, "Unsupported bus type %d\n", vep.bus_type);
> -		return -EINVAL;
> -	}

Might be better to just expand the check to include C-phy, since there 
are other bus types that are also unsupported.> -
>   	csd->interface.csiphy_id = vep.base.port;
>   
>   	mipi_csi2 = &vep.bus.mipi_csi2;
> 

