Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106329A9CD
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550050; cv=none; b=EFLat6qhfqEEXV5Bo6ROs7SjQPYM8+Py+7N4FhZD7zcJzPklktHxFvmDaWzcnCb2BVSCINL5aJMEfYja4xVXvTXG1h8Zftcd4O12Co+NeomzlGH54nIW7kkYWqGy6tEnjnRvqSSRQHHivQSQQJcOpYHnsh/LZ0U6AOBBAbgXLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550050; c=relaxed/simple;
	bh=UV51qyXzYtxwGuB0zES4FqkBW93FAxvKUjuQF+mTpr0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gGgxNm7UVt7VdEPU34K6mJ8qz8QLBWQxhmoio25jiBLRz30AFEG6WiUErLckkzzXGffojiy7Ts87OYN9SV3lF3u1RdNegLYn9z9AarqNCsDVHcRH0MOx9W+QO4vd7EWixkN9oUxt5Bp2102ypngPHZHZGNS9SnxlIhdy3y8yCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gfRyHloZ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gfRyHloZ"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-44fff490b19so264995b6e.1
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 13:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762550048; x=1763154848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vo2b5stOOMkheFTgFZGlOEGzsHrk4gEITKRM/xPVOlg=;
        b=gfRyHloZ8hHEZSlMb20dAUZruZQMPz3LxKyzsL2eEEpk4ZUChE2sBNNmMVyZ+K61ll
         h+9drTxHRX1LZoamY204Uae1mtOj8FQ4NfmHqcxxyhlAGgjZRa/bpkSO6ADVhlsmzsjJ
         HB0TZETIZ+IeToO6xrB8EkR9OJCZTXHefip1KB2bdzDq5rJNctmpifpbSQK3m5S41Ev+
         JDLRxHSDCSFlJQ9D8FozcvyFaG4I8X+p14VC+LEIfmokliiDRGUofTLTAAuDPEyw/jGj
         wjZpTP585I/gKPSgnjG8oJu2A/SovYmyl1im3cALpJcPM8SUSRfp9nIfYITaD8mA5PMk
         zxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762550048; x=1763154848;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo2b5stOOMkheFTgFZGlOEGzsHrk4gEITKRM/xPVOlg=;
        b=It/IMF61bBi09tn2AjRTryYjmgKM7cHeXr3/uvpxDmyBk5xA3j3ZYi2mw2185CXqu/
         yvm/jZiOZwaS1knDwjvbbBeyx3eJOQDpRklry+M38oQlArZZZlW+EF1/aheEdtw7pzqv
         ANlZJHdvXnP0G+7x1XpbOWDmSnReXoZ+o8a+U1bPdxtJ2X/+47rFLg5EAStI66zTrkwt
         ZL64l+n10PVw2cSGSMhXgyzjsO6ezFLWYyTxE9isdnbxiAHfW/ViNAvtHLmVKLsGEnor
         LWmU09OvEfoqpALaEGwe8L/XsKzi/4RRE96TCjQSucbUZmc416pL0Cnn2Y4g1tpM9TTY
         e46w==
X-Forwarded-Encrypted: i=1; AJvYcCUsSietNCh4ONAq7VxwCueOgUGSLavEKNOPgQmQX4QXRv0+JAkQIggE62W+yl4vNUZTYBxOqIAFEgrAJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLuOEhIdoUWjlQ3xoJ0Sc1DipQZauydm/BxEC7EDATcfZuflzJ
	O0SEoPSmaxYMuZtH2MaZt9+hG55c6PDkFz62OpYgwKPlvzg6abOFgfj9zyXgSp+90mY=
X-Gm-Gg: ASbGncsKXikG/EOC9skJzP8i6+oMdPWUvVsJHIyLaeAo5OGfC5dHMw4fqe7RoCqvdkc
	+uGgaPfsQ9bP6dkZ/ntIInEqvSgaxC9YmoRpAP8iXjfeniRuosi8NlngiYDKvw5Ecijrxoa95Qg
	p2xxQZohHBwZ5RP0ytdrO/eiitefMmAezqlZWhDGRmwsLBjMGfU+k4btxHsTtQOe2ihsVPY86SW
	pncCXisGa7SyHqXI8sBUH4RFVrt8CPxb5ABhmrEl1KXoJgsEO3Tu7H64YASX2wNRHav34L8y2hm
	66y+fmlihc3+DCaYLZ/6Ql/u1mfg+IQEtMl7feSXlpR1j0HvgT8SglYZVcs/z4An282HFnSRB1e
	w1lG5pB3DAQOv04AXtYMqstEkmqc7ZP9C6mYHWBbcLvkt4gsgfUYvjTSSaIIX8YdDlb892IBD9W
	LuaKhyO3v5T4cKXIvd3hgB1KI4KsYpkU4gdDyDLcqkxuM3nX0M5W0JH6S+P/1M3XhcSo/Y7ZY=
X-Google-Smtp-Source: AGHT+IH58JNXTTmu6lPkALuS59F00c00c+agrganN7d8UEB0Nzs1Gj/HxCtytEXComYXlhKlM//Npw==
X-Received: by 2002:a05:6808:80c6:b0:44d:aa05:ce74 with SMTP id 5614622812f47-4502a1be72amr387091b6e.19.1762550047721;
        Fri, 07 Nov 2025 13:14:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7bb8:950b:327d:4ba4? ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450027f640esm2781467b6e.23.2025.11.07.13.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 13:14:06 -0800 (PST)
Message-ID: <45bf8a0c-0491-4356-ad54-79c25079ad19@baylibre.com>
Date: Fri, 7 Nov 2025 15:14:04 -0600
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2/6=5D_units=3A_Add_32-_and_64-bit_sign?=
 =?UTF-8?Q?ed_values_of_=CF=80?=
From: David Lechner <dlechner@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
 <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
 <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
Content-Language: en-US
In-Reply-To: <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/25 3:09 PM, David Lechner wrote:
> On 11/7/25 2:03 PM, Andy Shevchenko wrote:
>> There are a few drivers that want to have these values, and
>> one more known to come soon. Let's define the values for them.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  include/linux/units.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/units.h b/include/linux/units.h
>> index f626e212d4ca..5b3293bce04c 100644
>> --- a/include/linux/units.h
>> +++ b/include/linux/units.h
>> @@ -21,6 +21,12 @@
>>  #define PICO	1000000000000ULL
>>  #define FEMTO	1000000000000000ULL
>>  
>> +/* Value of π * 10⁸ (fits s32 or signed int) */
>> +#define PI	314159265
> 
> It isn't clear to me at all in the other patches that e.g.
> DIV_ROUND_UP(PI, 1000) would be π ✕ 10⁴ (rounded to nearest

Typo. Should be DIV_ROUND_UP(PI, 10000) or  DIV_ROUND_UP(PI, 10 * KILO).

> integer, of course).
> 
> Calling these PI_E8 and PI_E18 or PI_x10_8 and PI_x10_18
> would help to clear that up.
> 
>> +
>> +/* Value of π * 10¹⁸ (fits s64 or signed long long) */
>> +#define PI_LL	3141592653589793238LL
>> +
>>  /* Hz based multipliers */
>>  #define NANOHZ_PER_HZ		1000000000UL
>>  #define MICROHZ_PER_HZ		1000000UL
> 

