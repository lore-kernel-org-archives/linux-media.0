Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865833993
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474318; cv=none; b=HekOf13vxxVs7P3tRs55RcWzAF/SUq9hOtzxgV53tcq3Co0LPoAow2JX3FJm2LOBKNW5RVmt5pz7nlqhzQTDkJde7dh9xdFB0Ly7ESYAgid+UAL7H0GG6hQNgzdOaIAqPNnVyy0S9YiVGbwq6QyieRc3B1cg+gpZcBLnauaJVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474318; c=relaxed/simple;
	bh=Gz94VwghZAcWH0Y4Qii83vg3Xhzkg1tWELnBwvoWwmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIY7yYTuCHJggKDmQZZ6sasCCyVUGtYudpvL/HxVc1bwoNKDyLVbNrQdWdx1ZsCqTDy9NYHwwUnYmqKlMPwN3YCKugkZYABRsA9/zDAoPqVCjohGK0SiX6qd+NgvUw7oWPdPXQkq9fIcmhqa//EwMUB9xfcrlZkWT53CYqoItlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyhD011n; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyhD011n"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4331e9cb748so732255ab.1
        for <linux-media@vger.kernel.org>; Thu, 06 Nov 2025 16:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762474315; x=1763079115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GwBxceYDDYB1hhqN34v7e/nCrVCNwzzouj9wlQU3do=;
        b=dyhD011ndN2+t0uiZtW4n88oc2ixKfg7swcEQ+a8qfXvIDDbeyoD0XlKQZkrcyCVkM
         6/0RAKI0InVydH51Kq/9RK25+8oRxKg4+s8tt6QYHrHiN415Z8HBvT9NIc7j2BhA+Xzw
         n0fLDMhLj3IukolCmnPDZ7UfpTELHPE3EIO/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762474315; x=1763079115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GwBxceYDDYB1hhqN34v7e/nCrVCNwzzouj9wlQU3do=;
        b=dP5efpTkg4NXIu0CHcCJPHpUd1P5gRi6VJdI3nw7w8WXcrVqrpJGOsDT51qLhR3gli
         irt/8JLUV/O9qZztSm65RM1+shjBUgw1WlqEEYH9O/cppsX98un8Sm9MEkfE1UsSbgq/
         pXatbs0DiVz3D/MD4Xu+R/6MFc6DLM/biYsvSBfWKi2CR90tIW/BQdR3lNAYlrN10MTm
         kYgOrMOeqmM2RCf2PoSN5yzZVAbJWNbtxqZPucCh3Vovagk5h/QXHo+2leiGg6EiHDx6
         AWBT08p3l7+pdqp7DG9LwSWPHcaTm0rvKJprcBXr0zTxT9G/0i9wFA9tYIK+vD3A+nFv
         jJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0JoMm1LvHUovzzGuud/NJ0GpAItJfOUStI+R5yjE8IZ/eLv5CD6TLCAheMcJbnrz1JEv/yn6UcM+EHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWRsRhUpqlAhy9kbPHAbBqeEiSu3UhwnZ90okbNm9N5yU4Rcq
	O3jtIfxUTb2M8hixsWd8h/m7eIRTKFBdSMYkiR2+B4YxTJmkISoM3gLjAwwW+SARsIs=
X-Gm-Gg: ASbGncvSDT+nGv9i3cVKTAJfmSb3kCGSaQpWCoZNh/HkNO12KC1wB8Tk+utArFpa2Sh
	TwHupq8hsX3uIg0+qK1KoZ+wPhVSzYqvfeNOTGJ+/vcL2ih48c4YknCEUrrcqMQkOJOpQSYV3uV
	ianBAGPdoppSWjRsOi/xmuemP5GzD9eKTXwz3/qYSNNbNmIOEJNeU6WY8/TUSKYzcPBHIQNN+vJ
	crqZdzqK5Nod9KN69NgL8Gf8g43QzvVdWSa6Va8tfpviER+PRyaE/ls0OlcQZ50+5IPjognL+7/
	iXqsihCZeY21ItPfvq7iQKh/MCmFzI+hgwd9kHab4GMBGD27yTe08EmgSAdGopkUODMWXIwh2YR
	5Nm8Fl4SWh3daBWSfBSOV1mG63X6D+4MAhEu8Mycn+q9n+9lNaNUJboPxpETpugX0dBWrIeMW2J
	7G8DetnoYZFZGvP5iNZBOwL44=
X-Google-Smtp-Source: AGHT+IFXbwBzw/G+QcPg/t1QNjcHfjVbP/MOFLMN2clgnclgPEyW0ZVqwz7uIpdbibH+YlR1+l7hPA==
X-Received: by 2002:a92:d786:0:b0:432:fc40:f323 with SMTP id e9e14a558f8ab-4334ee812eemr67104275ab.10.1762474315341;
        Thu, 06 Nov 2025 16:11:55 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b746923cbasm1421935173.33.2025.11.06.16.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 16:11:54 -0800 (PST)
Message-ID: <c64985f5-f1e5-4880-876d-0a3c9d83629c@linuxfoundation.org>
Date: Thu, 6 Nov 2025 17:11:53 -0700
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vimc: add RGB/YUV input entity implementation
To: opensource india <opensource206@gmail.com>
Cc: kieran.bingham@ideasonboard.com, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251101052651.6197-1-opensource206@gmail.com>
 <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
 <CAKPKb8-nFzqgh+k3aBxUvZ8g28usiAt5BEdFDQysVnCk3S+sEg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAKPKb8-nFzqgh+k3aBxUvZ8g28usiAt5BEdFDQysVnCk3S+sEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/25 22:03, opensource india wrote:
> Hi Shuah,
> 
> On Wed, Nov 5, 2025 at 10:43 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 10/31/25 23:26, Pavan Bobba wrote:
>>> Introduce a new vimc-input entity to simulate a color frame source in the
>>> Virtual Media Controller (VIMC) pipeline. This entity outputs RGB888 frames
>>> and allows testing of pipelines that start from a pre-processed RGB/YUV
>>> source instead of a raw Bayer sensor.
>>>
>>> The patch adds vimc-input.c with basic pad operations for format
>>> enumeration, get/set, and stream enable/disable handlers. The entity is
>>> registered in the VIMC core configuration, replacing the previous temporary
>>> use of vimc-sensor. Frame generation is not yet implemented and remains a
>>> TODO for future work.
>>>
>>> This change enables link validation and format negotiation for the
>>> RGB/YUV input path, paving the way for software frame injection and
>>> test-pattern generation.
>>>
>>> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
>>
>> I see 4 patches - are they dependent then gerenrate a sries
>> with cover letter explaining the changes you are making.
>>
>> thanks,
>> -- Shuah
> 
> even though all 4 patches are part of vimc driver,
> these are independent patches

Independent in the sense that they can be applied and tested
independently?

thanks,
-- Shuah

