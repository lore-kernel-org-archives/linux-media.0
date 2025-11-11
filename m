Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB02F1FCA
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851947; cv=none; b=sczw/F+F6UdUQ8H2t3NhXO3M3fYUYgHjoReycoYqo0da2Z2bWxhdYz8vtHzmt0mbUZ0NdQOVsrv8cv1HkCW4gCPPCaJzVghJSZipAsVKsPcNluukomCfbAm2ZrciMFHffG0Rk/dXpKT09m+R2lFmV7xayyt0Ufm9CIBUW2SItZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851947; c=relaxed/simple;
	bh=QF6aQ3IdMCUuQqVHJbHPgyORjRtZpqrwMPpiV3AGqVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuPfSjNdjPgNgC5WRGKYP7oM7hwqsjEKsoGPBTsrLma+6y6IQybPpzRj7sTzj/GUxKFFSRLe6lFzLiAuznC1f9weyZDSxU8yVVyw4AfDaLpAbGvO9YhNbOfSFj8zblXyeCF/77bWsSJFRGGrATHNILkgNJQnDRUgLEs6eRBaCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=kdyibVZh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="kdyibVZh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3360948b3a.3
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 01:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762851945; x=1763456745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDlWYzAyw7NsYv6KeXf0OHPO2SF0Gn6MTuOEGND/dGM=;
        b=kdyibVZhwF4wLeu8/y5ChKkcL3iY9wKS25jGeyI/f907qLw8AEExBaixA3Y77Cz0y0
         NVlPUji4zZfRIFR6wi/E9WjnS3C8rPzdDOwf9qwujrE53NoncTs0p41MbDoEJcDmFou+
         ID3d68cqprfjRKExElsb0eDfNVKcUyCIEIxpLH9sqLQ2pvQoG4lSswHT/zoJOr3AUJua
         evIgcu1lOcmg3LfA5rL/FfVb4v0bQXyL1y9irxT7re1TVssiXql6bn8Z7zaKGz2ZSFs3
         cwsIwNHUodxfadgTzy/9HPhMy4l2g59abTLFZfutbfRa3ENuXd5M3Fgl4olJoAVEkU9Q
         d55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762851945; x=1763456745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDlWYzAyw7NsYv6KeXf0OHPO2SF0Gn6MTuOEGND/dGM=;
        b=NAr1T5lntQi4dxoSXict9rXUynqxEES1GbhObl2yqL/i8X6LpzDeaYHZKmST36kVFK
         PQOcOz22W/FMy7gaxIc1DE1+dkSjw8cLKYaHY+UTn+y5xt1ZSdhH+MO0CTEsUGabcSm5
         V1zPmWdUfuG3hplaQspG/78k8x4R7HesoGPYdvNEkytmPtnB9sZ3Q9gRJek7UF5J8MBK
         Lq8fqLhBobgAnqLEK17nUiBzmwr84PsnG+pxLl0iLRhhhcox5a+8TdNKmD/a5yQ5m07I
         JmFg/DrMkiIYT9pmdW5x5h7eixPbpYo2UYr/30qawl36j/pemFXr+vVjErN87UgS44Do
         oh7g==
X-Forwarded-Encrypted: i=1; AJvYcCXTI4y594eZmHTYGWNsZ2BkzwrjfZUYsIuDDs+v2RXLHHQj3Czv7sseCXhof1P3WxkIYfS3W7cVO6U5fA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvFKsoQMIm/DRqHfOJ3d4fjIGTLzPhpd204wvpCiPbgv82gaE
	ywbZaT0ydfxJX0PMPr2POThF8o85zyV7wUMSsanehf5RE38+zsEWIFXqMcsHDJmhex9H
X-Gm-Gg: ASbGnctGigHdtq4sLXVsHr3Kac0V3AInqipDJ13M0Ni1nBPMSgO+7PMX+ckd70kXgJN
	RyoGHgz0DmdN1C3PhB64xjM7rBmYXX5fkOCe0ljferyPaSlrLl80q5pza+QQG9ETcnurXzH911n
	0zuMHEHehKHhV7ExaaGIY4d0WC3bqKCwon5Mqv+Zh36a9Ec3CATvBSrvErbxr5ofVVWI2jyt/Ar
	lpl2h+agzJcF7DmqGePBR7R5K0jX3XSrWnyeYYQ+CG1hrMbNGHVMXMBE44/OX5iOZ0lm9avSYTx
	P+pYhk3k0EFUL3KMBEHdznOOs9utrAt1nQPWYPT3ynsDTHy/xt4Kq5vMSOIC3X9bOVFpt/zPKjL
	SZaTCikN4UCC/ksZx5z76yX34SFYhizLDJOOCMHBpn64pYzENOeF5KoDP+cj2U8RSGN2dG8LUtf
	OUNmorUPxjqc2wyw==
X-Google-Smtp-Source: AGHT+IGEbfJbmbA8+8wSi/s5UWHmDTg58KEwntFAKebBbBnt7cMwBebamugI89g9CGFu62qAJEzcaw==
X-Received: by 2002:a05:6a20:9145:b0:34f:ec32:6a4b with SMTP id adf61e73a8af0-353a31550d4mr15999459637.32.1762851944823;
        Tue, 11 Nov 2025 01:05:44 -0800 (PST)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm14608708a12.36.2025.11.11.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:05:44 -0800 (PST)
Date: Tue, 11 Nov 2025 01:05:40 -0800
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
Message-ID: <aRL8ZPwXSeKD4Qmn@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box>
 <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>

On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
> Thank you, Sultan, for your time, big effort, and constant support.
> Apologies for my delayed reply for being occupied a little with other
> matters.
> 
> On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
> > Hi Bin,
> > 
> > On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
> > > Hi Bin,
> > > 
> > > To expedite review, I've attached a patch containing a bunch of fixes I've made
> > > on top of v5. Most of my changes should be self-explanatory; feel free to ask
> > > further about specific changes if you have any questions.
> > > 
> > > I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
> > > I should send what I've got so far.
> > > 
> > > FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
> > > protecting the list_del() anymore. I also checked the compiler output when using
> > > guard() versus scoped_guard() in that function and there is no difference:
> > > 
> > >    sha1sum:
> > >    5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
> > >    5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
> > > 
> > > So guard() should be used there again, which I've done in my patch.
> > > 
> > > I also have a few questions:
> > > 
> > > 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
> > >     faster to use that than using disable_irq_nosync() to disable the IRQ from
> > >     the CPU's side.
> > > 
> > > 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
> > >     beforehand to mask all pending interrupts from the ISP so that there isn't a
> > >     bunch of stale interrupts firing as soon the IRQ is re-enabled?
> > > 
> > > 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
> > >     when the ISP posts a new response _after_ the kthread determines there are no
> > >     more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
> > > 
> > > 4. Why are some lines much longer than before? It seems inconsistent that now
> > >     there is a mix of several lines wrapped to 80 cols and many lines going
> > >     beyond 80 cols. And there are multiple places where code is wrapped before
> > >     reaching 80 cols even with lots of room left, specifically for cases where it
> > >     wouldn't hurt readability to put more characters onto each line.
> > 
> > I've attached a new, complete patch of changes to apply on top of v5. You may
> > ignore the incomplete patch from my previous email and use the new one instead.
> > 
> > I made many changes and also answered questions 1-3 myself.
> > 
> > Please apply this on top of v5 and let me know if you have any questions.
> > 
> 
> Sure, will review, apply and test your patch accordingly. Your contribution
> is greatly appreciated, will let you know if there is any question or
> problem.
> 
> > BTW, I noticed a strange regression in v5 even without any of my changes: every
> > time you use cheese after using it one time, the video will freeze after 30-60
> > seconds with this message printed to dmesg:
> >    [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
> > 
> > And the video never unfreezes. I haven't found the cause for the regression yet;
> > can you try to reproduce it?
> > 
> 
> Really weird, we don't see this issue either in dev or QA test. Is it 100%
> reproducible and any other fail or err in the log?

Yes, it's 100% reproducible. There's no other message in dmesg, only that one.

Sometimes there is a stop stream error when I close cheese after it froze:

  [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
  [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
  [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)

When I revert to v4 I cannot reproduce it at all. It seems to be something in
v4 -> v5 that is not fixed by any of my changes.

I will try to identify the cause this week.

Sultan
