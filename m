Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228423EA88
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774807; cv=none; b=KanEeRIKSSSqB0h6Vz3+j0GSU2GAWJ9iGeq9Qk8CWZo0HyHW6ImQ9xegmwyO/KShlWrhVnTWbRQO3F3l/TBWFj+mRm09zgte+xjM1hOn5LVnRDATOdSbQdVHXPIZUGPr8j8B/v1O4SWPAIHTUo6JT0OQ8WI6jnLwEynXEyrCbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774807; c=relaxed/simple;
	bh=54NkSaWzKBnhmYKVhYAafCeDsl+Vi7l2IbYdsfjy6rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHS6GQMrG0khV6gEMYz5iZVkkrdChlMAL4RxG0n0RPk2FYBO4ihOaXpd90IR5ChjVGtUbWlz6glb8zDlfyP2Rv0q5HoJ3c4YnGKJaCgEdr6jMhxftHwU42R/W0kNSNvjTI2hb02KdYWg2uKJgzHh8OkgGemFrWiK6Yf74E2ioTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6AIftcw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6AIftcw"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1198968f8f.0
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 03:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762774804; x=1763379604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8LJLkQlhnVDYB5WFdSOlgPUhT3qQ6T/PIi1MnL8a34=;
        b=v6AIftcwQ1ywkxLSX+uPqASz8T39pooRv69YFV1yTl5CvajDJ0hgWiE/hXWtrPTy22
         dwgpp3dRIxV/g4dJALmCl8V+AK92J+Vx0o9IMbrqwfnHycHPFFi3/SmwA2twiZX0pKSH
         mZKQjuMWQSn/KBCGFiKjr6gZhIiTuWmEWd0hl/MLyUdELWmNU+txhYzbFu7ju7PDJp6Q
         tmrrSxvC7/3Jc0Zr3NVCg0dXMouJj5e8lV+nGoaG4Rw4+w/4BloJB+VeqtXPWbkXHMdu
         V1T5h2I4cAXtV49mz0NZ7EHZK2ndRDwxK+kln0/sn9YKmOfN9Ra2feWsDg6l/ruxEuhw
         ANQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774804; x=1763379604;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8LJLkQlhnVDYB5WFdSOlgPUhT3qQ6T/PIi1MnL8a34=;
        b=ozw8v42IB+1cZ1KPuG6F05+tT274PP3PVv6GqqFUo7s84wJpancldHDJC/edttBce3
         3/nsqtOcuAvaro7P5M3WPGJAeN7bgWSOutKSrDMWp+doUA4Svf9sBU+VIryx5ty3abpH
         VxKjmeUawyk8Vad8eMo64/pxSKkUiSurAXV+jiwe4ZBthdc7Efk6Y8ZNoqjJYm8SW1ei
         IU+SVqll8i1dB9lcsGA0br1PJBig+1XJ9NeLUZ5wnQcxnSQM3Yx2bEjvEp8pdXOl+V9m
         u7Ik1goNH/9e3hdeOVJJ7wJsQbXcrnCObbx3urrXMtewOUPRy08OMmP73jHQr5wcmgYM
         30bA==
X-Forwarded-Encrypted: i=1; AJvYcCVzgJ+hJlHVSFHIwWEZ0CcgEDG0zU8pKZhdWNXhXI8JMmYcAlityUHbzd8yV1HOCOTIysJOsQnpEa3kCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKTIwuAT8uNSvfPn2auRMTAexcIYjsi7IYiV2yaaX0o6UpWbZ
	VaZYQpqIyiyksfa2m9LdBxJbSeEcXMIZ/STB2MrHqEEX+4scBMAtZrm4OOWabjYME+g=
X-Gm-Gg: ASbGncu9nhePL0goWA3QfICk6+5jJgiAFR2pcDSadKnt6cy+1xzdMXWlVnp5X3P0cla
	TUnL8mfcYgKKQ2vTCi5q1EISMohyiDQy7rOUGPbz0d9Y/NyM/b/jQ6wDLdBX68YRyvi7DFBHTIo
	mvjN4a+5WccbAEMwgXTbaItfRhg1FsrctjPvvylVnG9uvhkqjXenMmAuaRItv8L7YA9BkcLymhc
	AaHRxIIfGhmVBIA3O6i+GpbY4SWH/peYDXvgyM7izZqfO3cH2JFUxJB9F7mEa0cH7/C1Fs04BGz
	EyguVTg9/xMAXgLjGZOd667l8CySPuYoojbHZ9extnIFiUO9WDYQsPNWKMx5YhHqo7DzJ6VBG2q
	9LQ5axHJtfsOpKXC6F8XImzsM84fKi0QMU5E058ju/yrrf+/Ky3Rrhm3HT6lzRUqtGB3m0zRsua
	K39bK5H08REgfi5/Bjdd02WFUVjtD9Pri40UpG0dPD0/xIXtRylFT3tj3+fYrwx+k=
X-Google-Smtp-Source: AGHT+IHc0y0L/IlFkDJCuI/XoUBdec6Dc+v/BCPlZFQShA4ijfqtxDc6+cizrEb5ne5sPA0PgA8OEQ==
X-Received: by 2002:a05:6000:657:b0:42b:3907:a38b with SMTP id ffacd0b85a97d-42b3907a591mr3013836f8f.44.1762774803631;
        Mon, 10 Nov 2025 03:40:03 -0800 (PST)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d544sm22562080f8f.46.2025.11.10.03.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:40:03 -0800 (PST)
Message-ID: <f48bf868-29df-43bb-b1f5-d27f8ffb9d8e@linaro.org>
Date: Mon, 10 Nov 2025 11:40:02 +0000
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/8] media: qcom: camss: csiphy-3ph: Use sdm845 C-PHY
 configuration sequence
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
 <20251109-qcom-cphy-v1-6-165f7e79b0e1@ixit.cz>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251109-qcom-cphy-v1-6-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/11/2025 09:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Enable the 3-phase (3PH) lane configuration introduced earlier when
> C-PHY mode is requested on the SDM845 platform. This ensures the proper
> initialization sequence is used for C-PHY operation.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index c2adbde6b4e0d..03f5c4676e89a 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -1103,8 +1103,14 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
>   
>   	switch (csiphy->camss->res->version) {
>   	case CAMSS_845:
> -		regs->lane_regs = &lane_regs_sdm845[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845);
> +		if (c->cphy) {
> +			regs->lane_regs = &lane_regs_sdm845_3ph[0];
> +			regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845_3ph);
> +
> +		} else {
> +			regs->lane_regs = &lane_regs_sdm845[0];
> +			regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845);
> +		}
>   		break;
>   	case CAMSS_2290:
>   		regs->lane_regs = &lane_regs_qcm2290[0];
> 

Assuming the bool becomes an int derived from the define instead...

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
