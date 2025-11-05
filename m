Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09B314A93
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362812; cv=none; b=h/kD0fUJYFGdt5R6EODV4DnPhVWQ8rOJaSHPm8a96TVlQDDj9FA0gH5D0NEm9+jJDy2gb81faSJQLTWq3Je8l/b80wVxnHX2Q6N3n3eqCGj5MPoV+zbFspt2a3HucJLErHNsFRTgJQ81N50D6526UVTkF093zigtLwAdaDCScFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362812; c=relaxed/simple;
	bh=fJ1j5M4Uzh7dF9QWtRSTcy7soZzpyFOdthif8hR356s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNV9/e9SNgKAj316iRqDsA/xonk3u4jfN7TyQl1di6lSwjaFkVLqePUq4TkpNGxgIFp+FIr/yVzGIxJazGempQDBj6h9s5iEDf+yU1RZ7isUXcX1B7VkwPz+DzkP5Pb2bayZqZfd21Eg42yY6eU000URFNaYBorwTh7rUmj6Zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKjBZKV8; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKjBZKV8"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-940dbb1e343so43845039f.0
        for <linux-media@vger.kernel.org>; Wed, 05 Nov 2025 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762362809; x=1762967609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Krh+lHfAiaYuFIm9yjGcUPl8AxxSVocyBSJOh5XMOss=;
        b=SKjBZKV8jJCix6HNRd0gx2gA3yhE39IyELIHgTZW9LO/4mQFAvpge6IdMoXTygKsrS
         X0TkenbBo60SlHst5d6GCl+C9rxASyeT53H1Qn4xlJUIIGqswXN09DXcFZv+R/LJ5gNH
         E9GPwXB5PfEAUCr4aMPDeeCGnKFwEGQUli/Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362809; x=1762967609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Krh+lHfAiaYuFIm9yjGcUPl8AxxSVocyBSJOh5XMOss=;
        b=ijljq+m5cAfLTrfhCYyhamKgWN6FXCsPKFzuyBcgQmZBPqKg6nk7JmcQXn14B63BfU
         haVmVN7ervKhkqX+AkQitf+OGUDr8WVe2TLYFRI3WAeCV7SPX7dUxtTfNu1ghemeRmHG
         J7IHiQJ+DOF00b+mwf4ml4nAcdFeEWiaVSP++HRKqL9C/2aNNyU8Wkw5M4mzQ6x4Q5LI
         ERIVK21N87pOiXwTu/9fHc/32Qz5p+llGbMeBrrbgABCOKr7FoBANr3Rn3KgWziAJzCP
         ijGOhzhQSXjMVBosU/5anHwwhFZPdO9jLC3fACDM3N/GqAxPffBRr839sTQC94cfMsGF
         5c7g==
X-Gm-Message-State: AOJu0YyP1UBkuSyows243cHW1HnGsq7zHLA7Yu/vSRJjeqA0Nj0pGwku
	HkKEhR2lImsTZgbZo0GC+Jx7qzZejUFCKO2MKlNK/YLEGEhSxO1eMXNHJxmYoCKMFSXvzGwQUic
	Uv9N/
X-Gm-Gg: ASbGncuYOpugDG/1Kcd+nj26Ao4fMADNKecbsHADmYzNb3KPpHWkdwHip48J462Ly+k
	HPYtMUrHHN1AvQHOALb6wt0L9ybztPVD3JEHKOGU4j6Yt/8vUNMsx8uF7YK+Ox7wUemSMmaKhCs
	l2cQPAa32ABpMJD3BhtaJ2SseOjch9jnAIAXoP4o8ar+W2mnqsjLOe93hjoPZvoKZnX0+0yKYof
	U0YY8J6IXRgOXJ7mwijtoX/Sfrhldoa/LnqVbbwIPa8gRjEcUeU9Zrtf8iOCkjqIZ6sT+S8GKWl
	89bsRUXLFlrApCBYMWceFg1V8ThHyvYF5Zcn37PKJEs3ca8kMWOC8XGNgqHLGarr/AC5R7LM5k2
	KB52mRB7yrLYDBnKdrmxPrq8Pbt5ldfUmhL1STGpzAKWYFxCIIypXPFEh/GOGxAs+gd1FEPP8Nq
	AQi+3DTnCAcVqu
X-Google-Smtp-Source: AGHT+IEnWfjpMUpFTXcYKkaNwF3Yr8kygQ3Z8/qPeVCdcw+B5jrsWpOIkGJ2g0TLDrdKnsnMYU/Nxw==
X-Received: by 2002:a05:6e02:3cc9:b0:430:da51:95f3 with SMTP id e9e14a558f8ab-4334ee1fca4mr3032785ab.3.1762362809273;
        Wed, 05 Nov 2025 09:13:29 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b73e5f4021sm464454173.53.2025.11.05.09.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 09:13:28 -0800 (PST)
Message-ID: <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
Date: Wed, 5 Nov 2025 10:13:27 -0700
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vimc: add RGB/YUV input entity implementation
To: Pavan Bobba <opensource206@gmail.com>, kieran.bingham@ideasonboard.com,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251101052651.6197-1-opensource206@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251101052651.6197-1-opensource206@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 23:26, Pavan Bobba wrote:
> Introduce a new vimc-input entity to simulate a color frame source in the
> Virtual Media Controller (VIMC) pipeline. This entity outputs RGB888 frames
> and allows testing of pipelines that start from a pre-processed RGB/YUV
> source instead of a raw Bayer sensor.
> 
> The patch adds vimc-input.c with basic pad operations for format
> enumeration, get/set, and stream enable/disable handlers. The entity is
> registered in the VIMC core configuration, replacing the previous temporary
> use of vimc-sensor. Frame generation is not yet implemented and remains a
> TODO for future work.
> 
> This change enables link validation and format negotiation for the
> RGB/YUV input path, paving the way for software frame injection and
> test-pattern generation.
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>

I see 4 patches - are they dependent then gerenrate a sries
with cover letter explaining the changes you are making.

thanks,
-- Shuah
