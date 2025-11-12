Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AF2FE045
	for <linux-media@vger.kernel.org>; Wed, 12 Nov 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940389; cv=none; b=uxiAoo1cpR7+JrFtx0UjodGUm2ILzoqtigh04f0YPm3KiLdhyCzfmHbOnJ1fZWmInnyl4N5RnZfXcmjaDNCT4JQ75MbzcvY/UIVLUT35a5D4hEIUJ6ckEk+aVpZ3ayMIiSeUg18o4dORe4Sm2M5mVzoyEQ1SHrl6l+ZPavfVjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940389; c=relaxed/simple;
	bh=XP3zVEDuJXzXClQ0do6m+eEmqEvNrjIuZbPC/rg0ds0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoHYMHbYHOfamBp8/6CpG948xM7ln3kLu4NwU+Q/HNdUEPB5g19Ja3SGBH2DrtIBTsaXqk8kQm2r2e2/8KK4zyotIs0UBy6s2/LqYZWzyiJcXT+FjJ76sbeniuMZN/oW9lshGXa+AiBuJl/AfIRZ1EbW42IsbkO+LNlNSOZfSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZRG+Ddoq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZRG+Ddoq"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so776791a12.3
        for <linux-media@vger.kernel.org>; Wed, 12 Nov 2025 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762940386; x=1763545186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMF8ALsV864vheQzgDcfGk5BNkQop27BuXXH8eM/nR4=;
        b=ZRG+Ddoqz/frIVZQVpDLof3VggCyZD5cXhoM1Vb1XxUWtYIbdg42+Da++jCiMxgloP
         Gu2I2ESmXOm3UNoDfgR97cTtr85HeWH9h17q/qesQQ7LVh03wKO+w+iVcG6SUNE/YS5Q
         hfe6qtgUG8Y77lzd9Hp87oAwjpKGYr/cFMNl8QQx63Foopc8MRd9+n+WcEIk96pCAZRk
         u2DVGN92fKXC9o6pAQaFq5pyhI+D3K3nkfum4ZPnjoO50UTcYYU83anTMcRZbDNyv1xv
         BvVrzbXVrYjv2+m3uTKnj06wdJnVFzYBLOvbWubSRval9zucwWvvki/r3m8AYyBGf5jr
         qRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940386; x=1763545186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMF8ALsV864vheQzgDcfGk5BNkQop27BuXXH8eM/nR4=;
        b=CYckz6EveDAFGZxzDx13uSXeth+RnygweUCdKMas7QMBORo48BelEzeKTuRNqdw9WP
         o7JpPfu/Nl6vhdze365gfk6wtrBlXGZ+Qc42Hsnyg3jBGFvZkXePvOQr6up3PsaBNke7
         0jOOw3p6GuYWhuIVTr3rLscieTmEKoKZ3fFXTjfhXzHw9oKsdaVohmUROB/5yPhoO7hg
         zNaYKKzKG4wRXSxAd/deW0qZtdYINLnSIGdrMmqB/yq0oOjUbZQcTrwoxxUV691sOypy
         kvSpjLQt5oWeD49OSdGGK9jsBrskHrXWuJVvxHyHYyYyRSh6cakB56X/WjpvkFJ7zpRg
         EBvw==
X-Forwarded-Encrypted: i=1; AJvYcCXtSfwYirtIZyU158LkfblkP7cC+DrvXhspC19z19b+whk8OACmRSkpZxXsskxPKYNyTFIbXn6ox1QG2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YytDM+dNp0GvWK9kg1SFsKrFQQZL6UCHc9xn5yMNnPvCqZsoIM2
	ul/t4+U2hDueuBBsWpId601ZGw92liMizRi1ZDHI2rj0qbWcIp4Ho0t+Dtk2radMD+I=
X-Gm-Gg: ASbGncsPPVm4cCibjRRaQ73AKQit1c6UbrPk+2cEp4ZYKOO2pD+RGxR7AbvnwKRzPP1
	loAihiIz9HTsShB1rJdDE7opOd6mfp6K0o6ZPlDvXfVXErY+ZQl1Bf8Ke5z2mGEPPKCtfeh1TIO
	cb7V1Vm5p2oLr9ZlQuVJbPr1KrCd/eijurwx8dOC2kWrgi/vxuaQu3wowY+8VDJI29tW4+oTTST
	FzvQHpsD1FNjR5jwFn1TDDq1vfy+aZx8EYb0hbhMJkmMRCV1RpfUjbsDSbm1JEmyfLK02jwvzBz
	fZ0d/jKFLYZLtRasoUcdl3Hk3QfWA3EykqDmj2Ra8p6s0GiUwZ4860xTegO8CxWTMZtwOjBbkqB
	LqvfJ+qI2iXC80K66i0W4hR5tDz52jc9ccnUOly7bs8JUCxHR+VzBbvcrYMtH6rMnRYD0Qzff06
	wUXJ8=
X-Google-Smtp-Source: AGHT+IHqkOBG3QT37sypafGY0arEyaeulcMIFbw4A7vB4hFyHSAIml6v9aGckPIeEnDDTFYftumN3A==
X-Received: by 2002:a05:6402:2706:b0:640:b978:efdb with SMTP id 4fb4d7f45d1cf-6431a55e1e8mr1943716a12.25.1762940386139;
        Wed, 12 Nov 2025 01:39:46 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64166d06531sm9914810a12.27.2025.11.12.01.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 01:39:45 -0800 (PST)
Date: Wed, 12 Nov 2025 10:39:43 +0100
From: Petr Mladek <pmladek@suse.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"awalls@md.metrocast.net" <awalls@md.metrocast.net>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <aRRV3yo9KHZV7sBM@pathway.suse.cz>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
 <20251107091246.4e5900f4@pumpkin>
 <aQ29Zzajef81E2DZ@smile.fi.intel.com>
 <aQ3riwUO_3v3UOvj@pathway.suse.cz>
 <20251107175123.70ded89e@pumpkin>
 <aRHzJIFkgfHIilTl@pathway.suse.cz>
 <SYBPR01MB788101676D637353D4E27F64AFCFA@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB788101676D637353D4E27F64AFCFA@SYBPR01MB7881.ausprd01.prod.outlook.com>

On Tue 2025-11-11 13:31:00, Junrui Luo wrote:
> On Mon, Nov 10, 2025 at 03:13:56PM +0100, Petr Mladek wrote:
> > On Fri 2025-11-07 17:51:23, David Laight wrote:
> > > On Fri, 7 Nov 2025 13:52:27 +0100
> > > Petr Mladek <pmladek@suse.com> wrote:
> > > 
> > > > On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:
> > > > > On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:  
> > > > > > On Thu, 6 Nov 2025 21:38:33 -0800
> > > > > > Andrew Morton <akpm@linux-foundation.org> wrote:  
> > > > > > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:  
> > > > > 
> > > > > ...
> > > > >   
> > > > > > That is true for all the snprintf() functions.
> > > > > >   
> > > > > > > I wonder if we should instead implement a kasprintf() version of this
> > > > > > > which reallocs each time and then switch all the callers over to that.  
> > > > > > 
> > > > > > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > > > > > doing all the work of snprintf twice.
> > > > > > 
> > > > > > I'd be tempted to avoid the strlen() by passing in the offset.
> > > > > > So (say):
> > > > > > #define scnprintf_at(buf, len, off, ...) \
> > > > > > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)  
> > > > 
> > > > It does not handle correctly the situation when len < off.
> > > > Othersise, it looks good.
> > > 
> > > That shouldn't happen unless the calling code is really buggy.
> > > There is also a WARN_ON_ONCE() at the top of snprintf().
> > 
> > Fair enough.
> > 
> > BTW: I have found there exists a userspace library which implements
> > this idea, the funtion is called vsnoprintf(), see
> > https://arpa2.gitlab.io/arpa2common/group__snoprintf.html
> > 
> > I know that it is cryptic. But I like the name. The letters "no"
> > match the ordering of the parameters "size, offset".
> > 
> > In our case, it would be scnoprintf() ...
> > 
> 
> Thanks for the feedback. Based on the discussion above, I plan to prepare a v2 patch.
> int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
> {
> 	va_list args;
> 	size_t len;
> 
> 	len = strnlen(buf, size);
> 	if (len == size)
> 		return len;
> 	va_start(args, fmt);
> 	len += vscnprintf(buf + len, size - len, fmt, args);
> 	va_end(args);
> 	return len;
> }
> EXPORT_SYMBOL(scnprintf_append);

I am fine with this. Just please add a comment that that it can be
inefficient when using massively because it does strlen().
I see similar comment in "CAVEATS" section in man 3 strcat.

> I agree that using a macro like David suggested, with an explicit offset, is a reasonable and efficient approach.
> The `scnprintf_append()` function, however, does not require such a variable; though if used improperly, it could introduce an extra `strlen()` overhead.
> 
> However, if the consensus is to prefer the macro approach, I can rework the series to use `scnoprintf()`, as suggested by Petr instead.
> 
> That said, I believe `scnprintf_append()` also has its merits:
> it simplifies one-off string constructions and provides built-in bound checking for safety.
> Some existing code that appends strings in the kernel lacks proper bound checks, and this function could serve as a graceful replacement.
> The benefits were also demonstrated in other patches.

I think that both functions might have their users. You might consider
adding the other variant when doing the conversions.

Best Regards,
Petr
