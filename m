Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF82D1F7B
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026082; cv=none; b=rAwAtTYF5LpFHXReyyf/Ysg/MllgBO+omrwEvLCRM3ykjQjNYVLHEr8+CVGWIFblmU+bTFKPIE3gzhvApQtFiHoBk5/YaKxfobymsZhW3CkZWEIAhiONoFZ2YZqpJHdGcIzevTgv+bHObXTwW8UFfCRBGDR6E4pO7Q+u+cCSYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026082; c=relaxed/simple;
	bh=HMyGCJqQYh9ujkqmTBAdu4RGNFwSTELIZpj6aYBe4go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZJitED35OyfCVwUjz+GjvjpIALyOnUsObJgHE55Xt7WP97WTPUAH3srMs5YysJrX7dZYkAEB2rC4SJJGUIKJ1WxhZxX/+Q/tYSKI3aI05a22nngayutO5AzoA8kjY9PXFmktWrf7FVVmLnIPqsm4ocNBO8qzHJ7LfymB/2vGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hU7cUOsA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hU7cUOsA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47774d3536dso4821355e9.0
        for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 01:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763026079; x=1763630879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUQ8rfJZk6stmc9Nrz3QsiJ1sN+nWeofSODQ5AvFLg0=;
        b=hU7cUOsAMH4e6B81GtNyfTRHKV4ib1Hv1JlOZ3xrNriVG+s67XNrQcyRSnZAl0vuX6
         nJt+9+lWMyoHna4b1KEtDnKlhFNfM3NUxfmehzGnO/vAzrE8Sv5Uh4N7cWb3PAlJhKVW
         XGW+G+cVgYexV3gbLvYCQVGfjv745ebCofeKhPvqTKPAEkKoLi7+w9srI2Yu86u6vIlD
         Zp6X1q5dNd9yO7l3Gr4aJO0kB03Wrfx77sq0NIZ64FcJhDJypM9byecx+nIsG+QUQn02
         nL2kxARBNUoZ89Wf0ARRcQSSyxybjSXU5PyAbXksc8zuk4IxFfWDhP7nOWqp8W+fkIvJ
         j/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026079; x=1763630879;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUQ8rfJZk6stmc9Nrz3QsiJ1sN+nWeofSODQ5AvFLg0=;
        b=TnSL9F7zz8K2zSUlAUsg+DwBBAxrFrFrezXxm9ivDmGSZRKCuCftTkaJsGDFMaHXzd
         tyyy9VEMNhVa89yrUcjz5nZDjHl2Ks0s498Xa5hqYjmwx3vcEPnok5cFmBmRTpEJFJoT
         jbbLVvohwoezefx4L/NIlPY+8l4gkLdVwIhmMaDfRUSViyAnvMJotlc/1CPM/mk0+0QE
         jdGYLK8Um9u96WZtSFcmeFiLdprnzwDOLAN11KkQM4KVALSk5PsdQPQqkatSqtH2XRgs
         0tjxoAyAYqUeKbq4sQ4l6IBGuDg9cmsDu7M6ctEs0EuBS4dJG2fFqWLf9vDa9CoABB7+
         NdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBFcl8EMbR3bIkH5G8CwAoDhyN8ZAL9MoNp1OLqsRxsiaXW/BambO6t7Osy/hTLI/Sk/0ADxdKKDuFCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eo7ZpoHMWb/8FAuYtFr+3WNxJWRRz3fdey2ozRtsCnFD1lZZ
	I3K2Qg2LU9Gq44+96+a5Qt51nORVaNKVYr4gb4XchmkgRPWdBvhmut2iFPNVLNO8JJk=
X-Gm-Gg: ASbGncuIF+EUcriNlxc1NShsorGEfVj64+N5AlVpjPQUbo2w19OtuBbQGre36o7PWKa
	qdejssb8QuHrepjpXU1wEMpOC07R8D8LZULUfMPuf18IbhzjVkfpoxqf+4GcueIKbOXg28EEX6/
	wpZYwY7B/Ox+R9ILDkI1Eghf8H/OtxGGAf/InRwhdVIaasnwOOf7kvhMWNvucCk4Xm3FjYBV3kC
	y7UxD88nEiWYNzjl8rhwK4i/jR7zmc9eLB53XYVG79itggxkpdaPu85nIYA1LRNnUmCPc5xdIk7
	ZDI8GbIFMr3ozfPao/kXzEdlKgUJm/uRyxlRbUDYwotIWoaqh8vlqIpkAoBf3qbRPycRpzk9KsP
	rHFCBiD7DeVeaJG+pGSjXS4aByPVxWD3fAxDCojcmavSxemBZ2JiwGao34J2zlXIJ8ciSofiKw7
	6/FD42NUtLYCJxcUEe5+uDbHFPun2qXezO32rtWlwWsbrrDLjXDV/3
X-Google-Smtp-Source: AGHT+IHw7L3XGmJDpxEV8oddbi9Yd4/43abEC2dbuAVSkqiGZ0o9fEeGz0V3OqaYUe1ZOfohrMWy9w==
X-Received: by 2002:a7b:c350:0:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-4778ca11b6cmr8011965e9.7.1763026078746;
        Thu, 13 Nov 2025 01:27:58 -0800 (PST)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c850ca6sm23687815e9.6.2025.11.13.01.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:27:58 -0800 (PST)
Message-ID: <b1dc3644-8df0-4147-94ae-1cfed835b9a0@linaro.org>
Date: Thu, 13 Nov 2025 09:27:57 +0000
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] media: qcom: camss: csiphy: Introduce C-PHY
To: David Heidelberg <david@ixit.cz>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-2-165f7e79b0e1@ixit.cz>
 <26bc458f-1db1-44e3-937a-f3ee7c1027be@linaro.org>
 <cf9fcb8e-b346-4589-910f-09bbcc58f9b7@ixit.cz>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <cf9fcb8e-b346-4589-910f-09bbcc58f9b7@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2025 16:15, David Heidelberg wrote:
>> Should be an integer from
>>
>> include/dt-bindings/phy/phy.h
>>
>> - PHY_TYPE_DPHY
>> - PHY_TYPE_CPHY
>>
>> this should be indicated in the dt and latched here.
> 
> Would it make sense to rather use the int from:
> 
> include/dt-bindings/media/video-interfaces.h
> 
>   - MEDIA_BUS_TYPE_CSI2_CPHY
>   - MEDIA_BUS_TYPE_CSI2_DPHY
>   - ...
> 
> ?
Maybe, but surely you need to get the mode of the PHY from DT ?

I'm fine with the MEDIA_BUS_TYPE but, I do think the logic must be DT 
driven.

---
bod
