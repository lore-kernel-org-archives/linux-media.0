Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28ED3358B7
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537889; cv=none; b=LJkdD6AIiYBmmGvqro231RxbMMcH+QbomAc7iPhbeOZrzNPeTx4LA0B3BB6ZnCBDaq8fMicXGq5UT27+IfcA2W+IpKFZ2G+iktp71SqEVQ7iFd8l94GQLNLONaaKRZRRrVbCPuT7A2/GPFAooEpQztgcUfz6yBOUS9D5ZpE1/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537889; c=relaxed/simple;
	bh=zH5Y5kzfZDqM6XSPZXHd+xDsjJay/Ois7rZjMY6UsPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0kuX8miSZwQBPvjnt6PZIMgd6Gh1da+G+7p0hVXBWnHE14+dqRj9k7ytHETf4AIgShVSni+XdFbSF6qdnYbenuPJwyWMzYW2LqbQP24MuvfHjlP+Toi1f3TJYgBnU75oci6cNWJxUUywWIuf7FSAew5aT5CBuGLIAMHUOYKE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELrQNNZt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELrQNNZt"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477563e28a3so7384785e9.1
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762537886; x=1763142686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tucutz7IrOhRztkZU3smHLVMxqcaOobL5jt095lc2k=;
        b=ELrQNNZtZ8xpyrUTaNVMrMLq6edSahgtODjiKm1IKWRWjWseiPqOOQhk1anKez3R3S
         8T+u+cMNZ7ztTu0DnveXsu7TuI93hL0HOIUEG4uMv+Fbfa2ls1yVSCKK8p/fCbDSC+cm
         UVNvMrpIn4Y1pzdQWBN7WcbtmJopnlnzNsOmV3c6WrcGlVVwdiZbVTO2BvBdtWuLYhqV
         qk741iJpVI6iTsleB0+cO0DAi80Wsdt43uMhT8Mxjxo2/h0Z8tFvMESZLdyCV8AhyaM/
         5QXnZR1Q0oUIjeN+7442j8mCLFcl4Z0SFtewxSlgIKOh0eyzSxJQTcORp34lE4LhEveK
         QALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762537886; x=1763142686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Tucutz7IrOhRztkZU3smHLVMxqcaOobL5jt095lc2k=;
        b=RqAX0x4nODhoiJXvl4EUN54nS6GhIx/nO82xIBGdYl6zC9YKvKNslMOmFsv3PSRPsM
         4aojHL9xPiI9BIsLlsgcsp+1g5aJlOqf7vIx2I+efuknoFXSE3BYGJnVi786fVhNMQgf
         YqhAY/S1SwuTk0sMIyFmMIzo4WQe5XbkTgEwDPy0RsyY5Q3MqEikkaLeNpQD1iRwUwk5
         Jiv9kUb9E/JBB5wcxhTn13O0vqpEzGUL/Vwx+glKns38g4ZDKrA25JIDnt2ulFyqiyYv
         D1xkyQoLk4cWrAwTae+GyS5i/4yXRfXjMWnoCTO9HGFo+3DfzGitj60YQm/bQLog6jKe
         2s3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsFi51GQ9PjkXj03iYMXx78aJ/R/8m1ohn1LyYYL3KtrHIpuhVhmCCTcgQaqj9euYrVlWRXgNYLEyRmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg44/j+GF3gKlQ34yVU/53I3dG+nXrD4HyQTruAxdOmTAGfLQH
	6laK/joCKYqygJ8Ib3gGWYrVVzrzyPn2fuDUJQn8CxwlnfmL7w2xw5xm
X-Gm-Gg: ASbGncujsmSrLnOVGfbswHXcDe+qGadMauKr0gA37g2unszkg+ilojFTrmOtQrmGXs7
	FDvbXL48PxIVkfvAkJmayXcS68xCOVBCWAKK6mK1H/NwUmT2W2CM5ElDPilYoby1KTYe+QftmEi
	3GEKGaTRyFs9Z8S7ItCYQh7ZRYoHOn0xbZVFHSI8WIG+eRGMPa7kR02U6tDKA8EeAEFqLb4bhg0
	BE3HwXAHxRkEgQw89abwc0e2GyEPBsQHx3Fpx0y8pI1jBwST7MC2Cg5X6dVZo0UusGKzm0WRGGS
	BGqmfEeGlIq14k+ENKxErmQdztp8tIKdMAgG1o1bu+YxLhPGv2mBA8J1kZj7ZaA1aABMiP1IXxz
	hCRb4uVg85AWFFsHY6ma+4D1chTc2YYPHHU33wRjqCSJ4lz696R+Z5bbSwpB148daUc/cVWOhyE
	/rtCu+5ZeA24Xop5XhGUzb8mY6f0tzootbahuuG5VUAfH6weL/52rD
X-Google-Smtp-Source: AGHT+IEoWHsw26cGBlNpbuXd/J8PJbsclbLScfONHz/78/yXn3dKVEpgZr30FQ4+9RfcD30Gp2hhjg==
X-Received: by 2002:a05:600c:c0c9:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-4776e57b741mr22139575e9.16.1762537885623;
        Fri, 07 Nov 2025 09:51:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f89fsm49280675e9.3.2025.11.07.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 09:51:25 -0800 (PST)
Date: Fri, 7 Nov 2025 17:51:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Junrui Luo <moonafterrain@outlook.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, tiwai@suse.com,
 perex@perex.cz, linux-sound@vger.kernel.org, mchehab@kernel.org,
 awalls@md.metrocast.net, linux-media@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <20251107175123.70ded89e@pumpkin>
In-Reply-To: <aQ3riwUO_3v3UOvj@pathway.suse.cz>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
	<SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
	<20251107091246.4e5900f4@pumpkin>
	<aQ29Zzajef81E2DZ@smile.fi.intel.com>
	<aQ3riwUO_3v3UOvj@pathway.suse.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 13:52:27 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:
> > On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:  
> > > On Thu, 6 Nov 2025 21:38:33 -0800
> > > Andrew Morton <akpm@linux-foundation.org> wrote:  
> > > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:  
> > 
> > ...
> >   
> > > That is true for all the snprintf() functions.
> > >   
> > > > I wonder if we should instead implement a kasprintf() version of this
> > > > which reallocs each time and then switch all the callers over to that.  
> > > 
> > > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > > doing all the work of snprintf twice.
> > > 
> > > I'd be tempted to avoid the strlen() by passing in the offset.
> > > So (say):
> > > #define scnprintf_at(buf, len, off, ...) \
> > > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)  
> 
> It does not handle correctly the situation when len < off.
> Othersise, it looks good.

That shouldn't happen unless the calling code is really buggy.
There is also a WARN_ON_ONCE() at the top of snprintf().

	David

> 
> > > Then you can chain calls, eg:
> > > 	off = scnprintf(buf, sizeof buf, ....);
> > > 	off += scnprintf_at(buf, sizeof buf, off, ....);  
> > 
> > I like this suggestion. Also note, that the original implementation works directly
> > on static buffers.  
> 
> I would prefer this as well. IMHO, it encourages people to write a better code.
> 
> Best Regards,
> Petr

