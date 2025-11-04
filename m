Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC6334C22
	for <linux-media@vger.kernel.org>; Tue,  4 Nov 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274671; cv=none; b=WtoZJ5MKnj7NI7yM5HqennSQJGj9CI4HwETHBvzNHhZAQmpNiQr/C0HQQUhgkECklmkYuvO3/SK4wsbn+5fTPmcgr5U6k2fX5eiHP0L/xYbImHHpHXAxYn4+OOhjk9Zcd8FbBPLZAMGfGb1hO9Tei1C4rNM0kVbdMSpRfNJBezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274671; c=relaxed/simple;
	bh=iKL6Oeeg1vcVGMXoUhbs/QIz4j1Xx/62odlfUSouZuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebgggI1bst+JjjweI3p3d0p9mVE2kirhbs7gV3acCBA3VJVDqmR+omLRzFV84r7k1N5Zm7CGzRLp8SDvuhWPxLOL3jOAc7rAuJEdCIp9gEWKTpZTgVGrHP+YdJb8OpMFsa11ZnKPlV2nLmuOVuha6+hY+tCyQzgceZqPN156qe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aeV2uXfE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aeV2uXfE"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59431cce798so2035862e87.1
        for <linux-media@vger.kernel.org>; Tue, 04 Nov 2025 08:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762274665; x=1762879465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKL6Oeeg1vcVGMXoUhbs/QIz4j1Xx/62odlfUSouZuU=;
        b=aeV2uXfEwfc5rG6NTnzHWeOYpJl4S2aeKCldzqn3rM0lYkRApZarEazuItDuJZuLUm
         U/92wjEKK2vHaxD30ZPT7gVylJOGtPvx8RUimA+x3wZIGPli9L37SGaN58YwX3JsYJC0
         6N5zFNZuIxn5XLWPvvcCRKo51+HmQfG6nJXeveNY7CiL2ltdcSjOt1aWPzSO5oidl6vA
         xXo02fqvY7kbAPmdt3UWTJaalxCo2HJA9jCNqH8PGUswbu8h1TSfmWofC4ow78RJiRPb
         lOsQ91kVj3gyt8rrbgUW8ZnCHnarepwiA+4q5F3zmxoz+WscnU71zpa9Qepx1sngAtxl
         yptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274665; x=1762879465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKL6Oeeg1vcVGMXoUhbs/QIz4j1Xx/62odlfUSouZuU=;
        b=TPZXhGQX2ZIqVchBRWXGMNXkbx8RSRWBhQyWAqfQmFtnP/RRsuFugUaA/s0hHpf/IK
         ir/9qmYcuWuSMtbGLoVr05OX21SUz3XTAtZ76YyJ+LC46g4wsg0aVXdUrrbZ4uti2blq
         h500eynSrWKtwTEmj0Hi3DQutu+yr5s/q5UtOlyBiJbGu+NDHOwRmS1wByuebQH463vF
         Yvqz8C2Z3sJpwkVLR461mMQNLVzrwBs9mE8tKPruCoAiqXzNxHs8z3dQWih2tSkyPpeZ
         uvnTh4DF6agsKuUT8MX4POMiREZLBQzBkdnL/JWjJ+wzafrfzQ3vgHmRs9HJpNOFhM9n
         KhAw==
X-Forwarded-Encrypted: i=1; AJvYcCUiUOUc6AZe/Hau2hPvCf04QY9X5CuKjFFg3q68ZQSAU1K18sFDexIZ5TRgj4g814IYNe1YKgii+I9TNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvt5X7AMkVx9kYOB/lQjwOuUm5w2BsaH0ZmuA4tmRtSO3Tbfai
	DwZfFgu72N6ywSxNX20s4fzrm0dL8LM/3UkBaVKhMldXXDLp58lulw3sBbOziuCU6CXqlur0Znm
	WnUzVB438E1/7ip+V18MEwnqiSQP0AMYNWALMLyZo9w==
X-Gm-Gg: ASbGnctwmLQleEp282xdfvnvzVSG74hk0fQj7hiGeTl5UwvobRRK+4h2AZsHv+3jB7k
	umI/VxzmRXAgAHUs7lcPoW57+97OEhBc5Xp3dxUhjyrEH4WpDdvqQnZ9NJt21Tpemqm1ITTkOWs
	J4jz2USI7Oz4wybxgp3/tCd3Fmf9MmvH6d4wvMGMd9pDmEAMFJfY4ZUL0D3Ri9WH51HW7Wf2Kik
	hjppJ0NylIgRmOhAG30vyIyR5ZVfYCBjxLF2/BtVBmk3EROAVpjYYwWGa+EFcP8GDQEvus+CeH5
	tDJrS2jcW7OY0MLpUQ==
X-Google-Smtp-Source: AGHT+IFa641/YIc8QEoSM+2u3rdMj8MWSovTl52bmxJ5Ic3O9e6IQnM9GzYEfzl+ACXNT4BjGQcDXpztd26xVGUGShQ=
X-Received: by 2002:a05:6512:12c7:b0:587:7f2d:2580 with SMTP id
 2adb3069b0e04-5941d532321mr5046018e87.32.1762274665492; Tue, 04 Nov 2025
 08:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104102048.79374-1-marco.crivellari@suse.com> <5ce483e5-7384-4d63-8dac-8050c2bd5930@collabora.com>
In-Reply-To: <5ce483e5-7384-4d63-8dac-8050c2bd5930@collabora.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 4 Nov 2025 17:44:14 +0100
X-Gm-Features: AWmQ_bmjsY3yYfB6P9rCzLcYpPklV0nouDUkJG5kFnQHbiBlQza70BlS69U3bhY
Message-ID: <CAAofZF7k7LDxGoXENBtrpP-xokGoCJCqouGX-qumGTPwipAwVw@mail.gmail.com>
Subject: Re: [PATCH] media: synopsys: hdmirx: replace use of system_unbound_wq
 with system_dfl_wq
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	kernel@collabora.com, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 4, 2025 at 1:46=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi,
>[...]
> Took me a minute to find what "dfl" stands for. Would be great if the
> name was self-explanatory as system_default_wq. Even then, not clear to
> me what's the point of this remaining, the system_dfl_wq naming feels
> very obscure compared to the explicit system_unbound_wq.
>
> Could you please explain the logic behind the new naming? Doesn't it
> create more confusion than remove?

Yes, dfl it is just the abbreviation of default.

The reason is to suggest the use of the unbound workqueue
instead of the per-cpu, unless this is really needed, of course.

There are parts of the code who just used system_wq thinking it was the
unbound workqueue (the "general" wq to use), so to make explicit the
"default" is the unbound (system_dfl_wq) I think it is appropriate.

I saw this myself also in this conversion round: there are maintainers
who are asking
to change the wq they were using from system_wq to system_dfl_wq.

Let me share also where the API change (and other stuff) have been discusse=
d:

https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

On Tue, Nov 4, 2025 at 1:46=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> AFAICS, right now system_dfl_wq duplicates system_unbound_wq. Suppose,
> instead, the default wq could alias the system_unbound_wq.

The idea was just give 1 choice, so remove system_unbound_wq (and
system_wq) in future.
Personally I don't have a strong opinion, but I think it's easier to
have just 1 unbound wq, and 1
per-cpu wq.

But if Tejun has other suggestions, based on your observation, I'm fine wit=
h it!

Thanks!

--

Marco Crivellari

L3 Support Engineer, Technology & Product
