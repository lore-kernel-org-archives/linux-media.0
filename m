Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415C2BEC42
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520889; cv=none; b=IY2/CuHzMTINQxDpKwsYbEpGrbEeMZ0vX9lmo9dnRg9EjoRFoXEPVmTX5TZAtaWZ88M/utcjNUxNCFl2ALI70SF/yp1K+mS3GpDw8FJCxc0FOyDIDWrdlUhJPE5kILKHhdkbDM46JBHJBGGZzrGyvKcmBWvLisX+ZcS/WrbkBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520889; c=relaxed/simple;
	bh=ab4JdEU2wkT0Hj03mRg7cQTBpYv7n0lBGv/VFV9YQ5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEc8YZySZZrWF6lt4oQBcyyfHKrhHR1Jx+/O3uWEDDvTCPlt77JEnu6cnAB0byqNO2EP6uKpKbleFX6B2b6vc3QLoWTG1v3aVFxWDsw9bNA32pHtI+9UCOBz/5AshSBkJj9x1q1iXWXYjKiA5QhNEHIfXFUu9QKlJZrVTh2lraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOpuKlo/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOpuKlo/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64124874e6dso119085a12.3
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 05:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762520886; x=1763125686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUZwTrdAx5DA1QRiAEjUm/Dj+qOzLieiy+DwjMngH4U=;
        b=uOpuKlo/yAGDmdsbjTqnvwt3QU4cMvcG4XlcvqqXxtARKW7qwsd2/zi1asHoiYU8F+
         6G+siioOvn/hjQQdupT8jVm1sjg3XcX8BOrHNb4Gk+3e+MtPJW94ZH/C1GAyg1wGfK2t
         +/6hynOlY/xrok0ja2uu3XwDMK4W+N0ci/3MnO5L8tKnKmDeWf/WCKv7++IoWRyogKlt
         Exj4YfwItzfphRVv3xX++966ezFo9mhQQe+hTveeuf84xAPhuTM73nx/47giLioosA0T
         Z1RZ/o1njm+M/bnXjHlKJtK7EKTP+DfSaO5mANy35iUhU2FDxSuPQCZ6WBeAFrCWLeZt
         /RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520886; x=1763125686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUZwTrdAx5DA1QRiAEjUm/Dj+qOzLieiy+DwjMngH4U=;
        b=vZrRpY+16zUJO91jH/N1fgaFOJMHNq++5fqWWrbiMXw+LV0kOl4AhKMaVnDWU1fm/e
         sSOopKoCCI2QlEeG9Xkm7Tgz+DWABLHBbQW9fJll8tJw5xqS1lGpDPQ7j6xHH2LATaH+
         Gw08TPFDMdQS5WtxGjpMaEH8mWBeMBbF3ANY1DjFGzqDVnwwf4wGNgSGnpq5nXoQFFxN
         +tlEzq4Zm85CFR6U0zEeXq6PPN4wbzbK4UdlBHNjJATofTUaNAJFCMEq6XZqXr54yO6i
         HhChqIZNLtFeITjdgwoCZevRm1EUGBKnw41B0cBSMD03mTxOAPcKbAXwxe9QkROKEGpx
         9UDg==
X-Forwarded-Encrypted: i=1; AJvYcCX1l+U6FAZ+ToTBWcMMOn+utV6Y8U58z7QtroSIOm4UZAnKJYCqkUlT5Zv1J3MTcw1hFqjVvaEGNZKBtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsOCeZMMA3lhcHlvvy5MFde36/GSmnNzadFw4WDYYwPLLRt/hB
	kU94BZ0xDjj6gwGOxUtohUL6hWExio6mwYzgrbxO9TI9V0yzDG8kChuM+Upzzd6xapc=
X-Gm-Gg: ASbGncuAUir1x3x9p8qmMR0qJarpBXzlmYEG5554YijTvvJ8LIN9WIIRjkAT20/65Ic
	4OTzoE/+PVfPudyxXAWYrSHGUdEjQoPg3+UK+4Zi+wGsiog1GBAcoIDddHBj1vANk6YIzv+Y8an
	lfhVNFYP6Rg80xFLtHGor4myVoCWyHRK61UqJvsSkB9+Euw3ySyGMFjlv0jPavo+FU1l4zEqK6R
	o1kjHglZSOnP2Ez57QVynUSLapBtOI6AlO6zSQVP+h+SZkbP5xbFFQWIIiZVOIUNystjy5tkriC
	6LYki/FXHlgmoc1OwPX5EC9Tcl3gCJ6S6gI6ZIU7HblW8+woagcXvLXCm1ilnhykqpiX7PayULu
	ZKSYRUyekTl5PWN5K5755clcRvHTFVGydZhWmY11cAMR0AkhGovqa7DXHK45T7CfUsl5k9s3wp2
	8cCtS4qr4l2lijnXoCdeDRDU+dq8D57A==
X-Google-Smtp-Source: AGHT+IH9tINldpmuxzATwX+vJGBph2fWU/B2JPxAB+dd5zTEjXHIhI/JdfJAw6vwGdZgenYc3xl5rA==
X-Received: by 2002:a05:6402:268b:b0:639:fbd0:4e44 with SMTP id 4fb4d7f45d1cf-6413f063d32mr1657770a12.2.1762520885794;
        Fri, 07 Nov 2025 05:08:05 -0800 (PST)
Received: from [172.20.148.107] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e457sm235515266b.43.2025.11.07.05.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 05:08:05 -0800 (PST)
Message-ID: <57585b7f-0c4c-4b28-892f-4aefec388136@linaro.org>
Date: Fri, 7 Nov 2025 15:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] media: i2c: add Samsung S5KJN1 image sensor device
 driver
Content-Language: ru-RU
To: Luca Weiss <luca.weiss@fairphone.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251023025356.2421327-1-vladimir.zapolskiy@linaro.org>
 <20251023025356.2421327-3-vladimir.zapolskiy@linaro.org>
 <DDZU8E8EBAMW.3J9K3YJ94V2B4@fairphone.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <DDZU8E8EBAMW.3J9K3YJ94V2B4@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luca.

On 11/4/25 12:28, Luca Weiss wrote:
> Hi Vladimir,
> 
> On Thu Oct 23, 2025 at 4:53 AM CEST, Vladimir Zapolskiy wrote:
>> Samsung S5KJN1 is a 50MP image sensor, it produces Bayer GRBG (2x2)
>> frames in RAW10 output format, the maximum supported output resolution
>> is 8160x6144 at 10 frames per second rate.
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>> ---
>>   MAINTAINERS                |    8 +
>>   drivers/media/i2c/Kconfig  |   10 +
>>   drivers/media/i2c/Makefile |    1 +
>>   drivers/media/i2c/s5kjn1.c | 1407 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 1426 insertions(+)
>>   create mode 100644 drivers/media/i2c/s5kjn1.c
>>
>> diff --git a/drivers/media/i2c/s5kjn1.c b/drivers/media/i2c/s5kjn1.c
>> new file mode 100644
>> index 000000000000..9e2ac3d695ae
>> --- /dev/null
>> +++ b/drivers/media/i2c/s5kjn1.c
> 
> <snip>
> 
>> +static const char * const s5kjn1_supply_names[] = {
>> +	"afvdd",	/* Autofocus power */
>> +	"avdd",		/* Analog power */
>> +	"dovdd",	/* Digital I/O power */
>> +	"dvdd",		/* Digital core power */
> 
> My comments from the dt-bindings patch apply here as well of course.
> 
> Also my datasheet mentions that VDDD should be powered up before VDDA,
> and there should be a minimum time of 1 us between them.
> 

Good, thank you.

> And power down first VDDA then VDDD, again with 1 us minimum time
> between the two.
> 

Ack.

> Can't say much more about the rest of the driver, great to see this
> being worked on!
> 

What might be the most important, my plan is to keep the AF supply
on the list of the regulators. The testing has been done on SM8650
reference boards, you'll find the dts changes.

-- 
Best wishes,
Vladimir
