Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89974BA3F
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 05:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405397; cv=none; b=pr24BJuzCDrfPqD1/WoD+KuLEEGUFIJTX61waFAbNAYAE5Z9akEgXYB26xD88cLcSk5UHKfKfgLvw8B8ml1a1NECqYVCAa9DFs6J3y+OjgdljuNmwxrmLJ+bPF57PEfrEwPztNojoHdZsj5CdjgM/IB/Ikpy2oHaqdeSBo+KM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405397; c=relaxed/simple;
	bh=EvcrG3dDGncaL739yj1nMubM8EpRLHOh2MgJIi094OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNFJ6+S8rljtqc+1Wxz7RdZ1Xvr/W92mTv68q4N/Pl+AAjRw3FZ3xc13Gx7PzCdX/lAa5uhRhMWkvhUYM2MrZEZnoY8/J+yqm8aBtIfFzxARCt6rtQFdgShlIojFGbZ2b4qm0usym5RD405UljVaci8oqS+tFYqLlOrRwE2kwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGWl50ho; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGWl50ho"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2957850c63bso6750025ad.0
        for <linux-media@vger.kernel.org>; Wed, 05 Nov 2025 21:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762405396; x=1763010196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvcrG3dDGncaL739yj1nMubM8EpRLHOh2MgJIi094OU=;
        b=PGWl50hoLXqBoiz5k1atMyyqYuxDFlIS1xqH1F1J7gY02ih/OBBCBbhcvlYqi+HefP
         oWpLWMyyrWX9p6Y2ySWM9aXcrQbffegzleeczde/KQaGTy7EhDfzjHxAABTXb9ZdXd/q
         v0h7p7A91LykxCMuOHRDuiomxd6mzJGtdFQZIXy5PYgY/3jAZSh0xWd/x546CZWzLHHa
         KAsg/rqDirONtZeGvmkU0KO7z4Zn9AW5vVprMtaXR4FPbbMrZpYEAOnKvlWIJkhAXalF
         u9aNTH5LOGd6YkpgQbEW/cpFz9hGMbYKJL+8DHQFYl5ikYGjOWIKVWGMD7W/7o95CVkm
         XfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762405396; x=1763010196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvcrG3dDGncaL739yj1nMubM8EpRLHOh2MgJIi094OU=;
        b=KS0B8hsEy+Weom+Zss1W0ju6euxWCtjDf+DbuBUlEKMTmMIBsWl/BevbiK0y52IE/M
         t842PAJoNAq8D1DTh2Qa6ThN6n8E8XHwf+P8uABxCBHDOB8d8vWOrZTgsoyumT9bZ2Yo
         e9+QECfO1QqfnRYnvjDYwzCtIFejn+PhLLBtln3tNuBaERNW8zwUy98yypZY/1tD/2uV
         rF3OECg3Q9ipPWsMw6c7ZC91z3mOZyUePxflX5n1r3hCAgnh+BnCckNXvvPzrsx8ubU6
         bXsPEyKvoChnJ+hA3vQlBj+acfGGfUM4Nk4lq3Y6q/7a4tD5LFilwBKU0cgaefIJkaRm
         4dpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8AYfRCVbV++eAqUy9HW1jSX8YGYKqIGuDQDvbSYoIsCuOMtA7DK8mo3u0W6J+tgezMfeDfrpHkJnpjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoB2dnzt2AbNKq+9CK9SJh0nG+XIR3ZyKdDFYPzO8VtPVdoDvz
	AJWcJ14RXximayLbt+XlWgWDbZ4RgEfvob9z4/WSWhZECwhVUhWcliTc8uvAHXsfOA1Qc19HhOS
	We5v7G3SZ8N7ZpLM9w3WFAitFbtSz3VMozg==
X-Gm-Gg: ASbGncuCF147ramjHG70oiBeuKxIoKQb5He4TdWr4BkCDHu7uNtVrd6KeEXG3dIWdX3
	xjwEcZtV4f57vbGnMpgG4Cle4cWAlOIHHUj7xk8CEdWQJbScZmE+hA/3pCbiMueYKA1cUtOhfoA
	FQ75a5Jkxp5tptroR+jcXKk/8Rl0kHGvB3drK3JZW9or9zoZjeOncCCpvBEPwzNqnfs1TUMmKBo
	N+nK8HroNV8O+ymWgmvl6drS3b6+3b2UUcVPQCmeTY56Bsv2csePnhckNvtDCwthelXPuLvJ6qy
	IZmCBUBnKov3fUcf7xs=
X-Google-Smtp-Source: AGHT+IHrzZ1/4Im3y8/huzYUwmXZhSlgvoJLEyQxj5Zo/aAIeNAwDkLVT9KBvnRTTtAYY599LBT0I1aztN6PiD0fTwc=
X-Received: by 2002:a17:902:f601:b0:290:ad7a:bb50 with SMTP id
 d9443c01a7336-29651a60c70mr19004155ad.27.1762405395674; Wed, 05 Nov 2025
 21:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101052651.6197-1-opensource206@gmail.com> <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
In-Reply-To: <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
From: opensource india <opensource206@gmail.com>
Date: Thu, 6 Nov 2025 10:33:04 +0530
X-Gm-Features: AWmQ_bmtfdYLunGxnebB2YzfbIByDDfiElXZmfRrWBesyRCRzuiHt6fwI6_gKWU
Message-ID: <CAKPKb8-nFzqgh+k3aBxUvZ8g28usiAt5BEdFDQysVnCk3S+sEg@mail.gmail.com>
Subject: Re: [PATCH] media: vimc: add RGB/YUV input entity implementation
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kieran.bingham@ideasonboard.com, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Wed, Nov 5, 2025 at 10:43=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/31/25 23:26, Pavan Bobba wrote:
> > Introduce a new vimc-input entity to simulate a color frame source in t=
he
> > Virtual Media Controller (VIMC) pipeline. This entity outputs RGB888 fr=
ames
> > and allows testing of pipelines that start from a pre-processed RGB/YUV
> > source instead of a raw Bayer sensor.
> >
> > The patch adds vimc-input.c with basic pad operations for format
> > enumeration, get/set, and stream enable/disable handlers. The entity is
> > registered in the VIMC core configuration, replacing the previous tempo=
rary
> > use of vimc-sensor. Frame generation is not yet implemented and remains=
 a
> > TODO for future work.
> >
> > This change enables link validation and format negotiation for the
> > RGB/YUV input path, paving the way for software frame injection and
> > test-pattern generation.
> >
> > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
>
> I see 4 patches - are they dependent then gerenrate a sries
> with cover letter explaining the changes you are making.
>
> thanks,
> -- Shuah

even though all 4 patches are part of vimc driver,
these are independent patches
