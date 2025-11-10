Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BB3126D3
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784042; cv=none; b=R1xbOEEgwnY32ylPN5hj4N9bIytHSVAgPD/Ac9F20iuqVWkJiTe11+D4Q5PrHl7xmnRDXAb3/ktD9N6LwHaJQXSSd5m/NLLkzTMVdY6ZsE2wz9H0vtiP7GumoL534h1RCDxLkWfs3itb5ibGOQ1OTGi2/TKC760XdJD7mwlIufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784042; c=relaxed/simple;
	bh=nhj3Igbx12WySTAs3L6CZE8fbVP3gkRxrlKpU0V1S2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVSQK9owGhDX42PpMr9b54qFYH6fUliH/0VQB9LWUpdSGB2togbabMyQvtz9j7/1geqVQpUzzghoxurhO4eui2Qx4dyCQYohejQkjbPBZMz3FK1D2aNiMwDVtwTWL4sCOiilzcJyfrajHUaUKTthRW2LqPMtvfg0/c8x3isbGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QshNdn8y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QshNdn8y"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso2478985a12.3
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 06:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762784039; x=1763388839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYf9FpLZWUf42lAhUlxsk+V48xYQlFSQ2G8JV6jPPvE=;
        b=QshNdn8yQ7FchSFTx7qcHFGVopt7Fd31yJBamIE8scdUsKrK/Dl1wesxzuiw1aqwxw
         fA/KZZckMgyCowdFY8JB/HTMTraHBXYKDxp3G0h4p8MwKLJKR5gD8iuVHN0pF642sdZe
         35kwMDAl2kDoP9y0NDtIAln4A7XoOOIzGpAGgABYPj58EL6qhnVIyeyRjKWvq3jb/i/0
         v1SPcux9ZbAl7ofXlfFewNgib5lDR7/+CHOxRVJMToN5jiokP/6QbncOOyYPgBILY3s7
         8yMZZnIFGt0Fyiz4VYERDzIaYTR6O1a0NTGIn7nus2e95TP3UtcrIGYg0nAjFpqxtAxQ
         eBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784039; x=1763388839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYf9FpLZWUf42lAhUlxsk+V48xYQlFSQ2G8JV6jPPvE=;
        b=Y7uxuRQ0LEc0ByRFvyV67CCNJE2BIbpWdIUqCW74WcO9ysGB84HwTEF85rfdvngF6G
         G2PsGbhotWiQ1ucdiNSbaksCDPPxGlEtzVCCp6C0yWNUe2qcCympTgCzpXBFGrHzHSfE
         KHWDij9pQQLm1sNH4veej2CcDe0U/2rMgUW0f2d4xj/ATs9YiBnuyVziFCD/KF+C7N12
         JQY6M90H/dXvpMxQSY3k07uPr1uAK6IkgqrI07CrZNKff3kS4lOwwEb8ZoKUuIEgtANo
         kUkFFcwP408VkuLjUGQel6XDLRrb32yVJz1P1yTYJEj2+61lgzSPBSGLP3A/zNKCp4Fi
         Op/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaaubZVRcikBbZb4iEoWNjg7GnaAudBwPoZvmo/3obRk6hrMLN2/YtABNDqqwu4azMpeLrtr25VJURxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiL+UA23LNcw+KE3Yg4wqecJ5cyaU24RhRu0wcpO+69N2Mhttx
	JsbKB1VDVp36EW2H/zFBvaO8dOsq9eW+x9pOMdGm1F9EHWnoclMhoUeoUKUP9JNQVqM=
X-Gm-Gg: ASbGncvjdE0UFm9Z1n4y87gLusx3oq0LwknCG7H2w8xpf9JrVgQUjiORAixxpbQKwfH
	vn442mHQNky5BUeUCSGB4ewVSShxAuITTW6UvgVGALU8AIGH+hvlTrOYC98cWlzYlURnPkKO8Jb
	O8TBLuf6/aMH/s9dMWXGSc0K59xT7PQAK3nkb1Sy48wR1mwkB5iTTCs4aEIuayfOqYY9XKRzUEz
	wR1YLkmXaJqgtWcP/yamE7hF2qzL5MKDKfWrZ9LbaiCNJxGZVtxUdnFYANM2x3wy3QtvFviz+Vw
	mkU1S9/TAYLwJzoMmBVu3yUafG+qsi3JSSi3btOSJdzCgtJlmXngbASqtUA9S6sewQtbtxeINyV
	GZBHzdtAZo9rr6iyKEndGwc5mFr3dYVeD4FxbtdNbDb41ltYs0EG4Y+uSpDSZ5mS3AepqKK7v9m
	Qweec=
X-Google-Smtp-Source: AGHT+IFWGbbWVSdwsSwRLLUACXXxYZpMnpmrI0HtAU0yQT12wD1kfbTgpMWg/xPH1FaG58xVuN8lew==
X-Received: by 2002:a17:907:a0c8:b0:b3f:9b9c:d49e with SMTP id a640c23a62f3a-b72e053f2b5mr824285466b.57.1762784039128;
        Mon, 10 Nov 2025 06:13:59 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm1105466366b.22.2025.11.10.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:13:58 -0800 (PST)
Date: Mon, 10 Nov 2025 15:13:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Junrui Luo <moonafterrain@outlook.com>,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, tiwai@suse.com,
	perex@perex.cz, linux-sound@vger.kernel.org, mchehab@kernel.org,
	awalls@md.metrocast.net, linux-media@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <aRHzJIFkgfHIilTl@pathway.suse.cz>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
 <20251107091246.4e5900f4@pumpkin>
 <aQ29Zzajef81E2DZ@smile.fi.intel.com>
 <aQ3riwUO_3v3UOvj@pathway.suse.cz>
 <20251107175123.70ded89e@pumpkin>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107175123.70ded89e@pumpkin>

On Fri 2025-11-07 17:51:23, David Laight wrote:
> On Fri, 7 Nov 2025 13:52:27 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:
> > > On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:  
> > > > On Thu, 6 Nov 2025 21:38:33 -0800
> > > > Andrew Morton <akpm@linux-foundation.org> wrote:  
> > > > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:  
> > > 
> > > ...
> > >   
> > > > That is true for all the snprintf() functions.
> > > >   
> > > > > I wonder if we should instead implement a kasprintf() version of this
> > > > > which reallocs each time and then switch all the callers over to that.  
> > > > 
> > > > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > > > doing all the work of snprintf twice.
> > > > 
> > > > I'd be tempted to avoid the strlen() by passing in the offset.
> > > > So (say):
> > > > #define scnprintf_at(buf, len, off, ...) \
> > > > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)  
> > 
> > It does not handle correctly the situation when len < off.
> > Othersise, it looks good.
> 
> That shouldn't happen unless the calling code is really buggy.
> There is also a WARN_ON_ONCE() at the top of snprintf().

Fair enough.

BTW: I have found there exists a userspace library which implements
this idea, the funtion is called vsnoprintf(), see
https://arpa2.gitlab.io/arpa2common/group__snoprintf.html

I know that it is cryptic. But I like the name. The letters "no"
match the ordering of the parameters "size, offset".

In our case, it would be scnoprintf() ...

Best Regards,
Petr
