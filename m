Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F882C0F67
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425294; cv=none; b=VtOGez+BiV0m+HubWqQwHNFS6M6NDIduita/FQjSyjRgjaTYDhHF51Rafja1ZizIIrBrqNuTR/54PC7AbxLL6Jk/v/kbVgDcIpa3M2gfb0XgoLgrbTojtySuCKJOWphk571a+Qzw+VQsxl2QSzp3Nkk5ewciJ1unqwCi9TR2itU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425294; c=relaxed/simple;
	bh=E2F1rxwXrrsb8NRrX5W8HOH3YovBH/tPEh/j8MJhtCQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gRjzzyR7N+YjiUCb1lmF+u/mnKTBTFC3MWacfnDRl+LyQ1gw3qfS0sAdb3S4eiz66bhKKI3BaCOvlHw/zsMg1AyUbbSat1LhADomQaimbgiBHJ8IJARf9ieLgg/zRSz7SHhMIZj3oEb+3emCuRCj8bQBpS7B3DWlwMjrYdxauqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvU43Pph; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvU43Pph"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47721743fd0so3501095e9.2
        for <linux-media@vger.kernel.org>; Thu, 06 Nov 2025 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762425291; x=1763030091; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khqybK/xlzWlMQBHPxk0XD3yxDB1oxoxHdP7w8UG3E0=;
        b=mvU43PphvIgMySWyEFNsIBTtsvbDmxhHPeQyC/o47R6ALrECAKACLJb1YTy1p8oSdV
         9q5i/ByHz8lLHY6p6gCOh+Ia4SkEzLblR3G4tTEvx9amfRzcDp1lTDWKwc2Z5tDA29Kr
         LpAo9Otnmlc8JClzu93JffeX2/0SjZi/x2Ay1lDAa0KXrC/BVJDr+CspG5yPNWpFvRQT
         3nHr1D0g3k6VC8bEIyGBpLNgfo2AL0NSMRdcwPZcburI/wanD37mE68pFup30wPw5/j/
         f/1SKB2RpDcg+CZg6LeLLXNFs8QaN4k0IGY8cIm92Md+b1U9l1ek+aIGULPGOG8Pb2dS
         F01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762425291; x=1763030091;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=khqybK/xlzWlMQBHPxk0XD3yxDB1oxoxHdP7w8UG3E0=;
        b=JzbHbH7tl6swikXbkO7Kv+lSPY5RcwK9HQ9Sy6MJYrKSuncEYKFq/BKJRpIQedVNMY
         kD9b+JYuFF1zhnPnCeHTT5yZh3SJjP8WLk+rWD0/kZy2N/t9hys7d5pjjUl2rS54lD2X
         9zqsiHV1zByFR8d+6vefeYZ7o7vskFh87eCDe8telmKLuPH74K0qwII9pIFVjEOEari4
         2EeFsFNIsFVf97+ADqPmDC2dL8BEtivOB8ZDkskRf1eBlghIP6CeiTpj1Ph4embS79MZ
         gZdCbxHZddLlB78iRhZB/F5ivA7zap7U2jv0vk+tw0iAw4/CMIYHXHnRyO4e98pLTLUo
         v3uw==
X-Forwarded-Encrypted: i=1; AJvYcCUTHneGXlIoYhBNdok82/Hm5pNDwrd7Wzs9339YDkRx6YpH1rSM7oY6qlZFzLL826MGjEKAgvreZfFNgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqAmNWHpkCm9Sbb0bIkI6ZC839zGajMNY5dfts8GIX/xYnK4f
	9rz/r9zdlwKnVyIC85rBeVTmaqEvDiokVWBinPvK8XttjdcyhdQJLoMS
X-Gm-Gg: ASbGncsabb3wmWH0NrhSLf/3vCwaZIcO3VvVjOVgUazKl0wpLCmB1YMGAmA289bi52P
	tjDgHUB0f+gZ+uBGrYofv0v4mkkBq/xrLzA9QhF9yU92q2COM6Y5z+gS/5bmpPSvDc+FWaO6hXK
	bvmdsOHEoFMjm2Qc2hr37Ty09OOq3n24dvwWFvTd4cd63Gtscn1tJgH6j3e1RbZ4wigNBlFBPB0
	mR051W1730o1t0fuXTBb7M6hSsNxm2UxLZsC/9VMbBlhUe7CGXq18qzIwdJ8lewtFAsd8+fyWSV
	4KYm31qy+Dn9hht30Bwd8WBTfn0ZLMOVxCttAfXRnppAhZ720qeTIBW5aRPR2mH2YVoeIRHdbYg
	G9jASinHMpIpB9I1vcjJbDPDf2eCep4p27Y6r6w9ovDvwGhPGe4n9qID1X7f4cXQBnDvJD/ymk1
	NE9XqfBlLhs7vL3U1ZhCZAqCP2xXo8ioyTMA==
X-Google-Smtp-Source: AGHT+IHK/oWaeWq7uP78JwTb75evD9pbxUOakU4Fr3bQ3oQuz8S08wrBQPzwEF9doMfvThWNXoaycA==
X-Received: by 2002:a05:600c:6388:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-4775ce1874bmr49277875e9.29.1762425290379;
        Thu, 06 Nov 2025 02:34:50 -0800 (PST)
Received: from localhost (a95-94-245-170.cpe.netcabo.pt. [95.94.245.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm107269485e9.6.2025.11.06.02.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 10:34:48 +0000
Message-Id: <DE1JMG95RZME.2YSV10RI9AME4@gmail.com>
Cc: "Shawn Guo" <shawnguo@kernel.org>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Martin
 Kepplinger" <martink@posteo.de>, "Purism Kernel Team" <kernel@puri.sm>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, <linux-media@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Alice Yuan"
 <alice.yuan@nxp.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Robert Chiras" <robert.chiras@nxp.com>,
 "Zhipeng Wang" <zhipeng.wang_1@nxp.com>, "Hans Verkuil"
 <hans@jjverkuil.nl>, "Sakari Ailus" <sakari.ailus@iki.fi>, "Kieran Bingham"
 <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v4 0/5] media: imx8qxp: add parallel camera support
From: "Rui Miguel Silva" <rmfrfs@gmail.com>
To: "Frank Li" <Frank.li@nxp.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Hans Verkuil" <hverkuil+cisco@kernel.org>
References: <20250729-imx8qxp_pcam-v4-0-4dfca4ed2f87@nxp.com>
 <20250805010822.GC24627@pendragon.ideasonboard.com>
 <aLbcpEZXm5G1Onq7@lizhi-Precision-Tower-5810>
 <20250902123920.GM13448@pendragon.ideasonboard.com>
 <aLhJDXnz9HPGrWcp@lizhi-Precision-Tower-5810>
 <aQuDSROHLGHIhtlh@lizhi-Precision-Tower-5810>
 <20251105171928.GB6046@pendragon.ideasonboard.com>
 <aQul/VGG8e3MJxhx@lizhi-Precision-Tower-5810>
In-Reply-To: <aQul/VGG8e3MJxhx@lizhi-Precision-Tower-5810>

On Wed Nov 5, 2025 at 7:31 PM WET, Frank Li wrote:

> On Wed, Nov 05, 2025 at 07:19:28PM +0200, Laurent Pinchart wrote:
>> Hi Frank,
>>
>> On Wed, Nov 05, 2025 at 12:03:05PM -0500, Frank Li wrote:
>> > On Wed, Sep 03, 2025 at 09:56:29AM -0400, Frank Li wrote:
>> > > On Tue, Sep 02, 2025 at 02:39:20PM +0200, Laurent Pinchart wrote:
>> > > > On Tue, Sep 02, 2025 at 08:01:40AM -0400, Frank Li wrote:
>> > > > > On Tue, Aug 05, 2025 at 04:08:22AM +0300, Laurent Pinchart wrote=
:
>> > > > > > Hi Frank,
>> > > > > >
>> > > > > > Thank you for the patches.
>> > > > > >
>> > > > > > I've quite busy these days, and I don't believe I will have ti=
me to
>> > > > > > review this series before coming back from OSS Europe at the b=
eginning
>> > > > > > of September. Let's see if anyone on CC could volunteer.
>> > > > >
>> > > > > Laurent Pincha
>> > > > > 	I hope you have good time at OSS.
>> > > > >
>> > > > > 	Do you have chance to review this patch?
>> > > >
>> > > > I'm going through my mail backlog, which is really big at the mome=
nt.
>> > >
>> > > Understand.
>> > >
>> > > > I'd like someone else to volunteer to review this series. It won't=
 scale
>> > > > if I have to review all NXP media patches in my spare time :-/
>> > >
>> > > Yes, but none volunteer review this in passed months. Expecially key
>> > > reviewer. I am reviewing i3c patches. but Not familiar v4l system ye=
t. It
>> > > need scalable solution. I can help filter some common and simple pro=
blem
>> > > from beginning.
>> >
>> > Laurent Pinchart:
>> >
>> > 	Do you have chance to check this serise? this one should be related s=
imple.
>> > 	This one sent at 7/29. Still not any volunteer to review it.
>>
>> I'm afraid I won't have time to review this for the time being. My spare
>> time is already exhausted by all the other drivers I maintain upstream.
>>
>> > 	How do we move forward?
>>
>> I think this is a question for the subsystem maintainers. Hans, Mauro ?
>
> Mauro Carvalho Chehab and Hans Verkuil:
>
> 	Laurent provided great help about review and land i.MX related
> patches in past, who are quite famillar with i.MX chips. But he is quite
> busy. So the whole reviews cycles takes quite long time and offten cross
> some merge windows.
>
> 	In pull requests for 6.19:
> https://lore.kernel.org/all/4989c563-47f4-478c-80c4-41f7e98597e4@kernel.o=
rg/
> only 10 patches, and 4 patches is trivial clean up.
>
> 	In reviewing patch queue, there are
> 	1: media: nxp: imx8-isi: Add ISI support for i.MX95
> 	   https://lore.kernel.org/imx/20251105-isi_imx95-v3-0-3987533cca1c@nxp.=
com/T/#t
> 	   This one already review, but I am not sure if it capture 6.19 cycle b=
ecause
> PULL-request already sent.
>
> 	2: Add MIPI CSI-2 support for i.MX8ULP
> 	   https://lore.kernel.org/imx/20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@n=
xp.com/
>
> 	3: media: add imx93 mipi/controller csi support
> 	   https://lore.kernel.org/imx/20250821-95_cam-v3-0-c9286fbb34b9@nxp.com=
/
> 	   This one is quite big, but first 10 patches is simple trivial cleanup=
 patches.
> 	   I post at 8/27, but get first feedback around 10/27, I am not
> 	   sure if missing somethings.
>
> 	4: This series, laurent already said no time review it.
>
> 	5: ap1302 sensor patches
>            https://lore.kernel.org/imx/20250811-ap1302-v4-0-80cc41b91662@=
nxp.com/
>            binding already ACK, most maintainer want to pick binding with
> 	   driver together, but not an feedback since 8/11.
>
> 	I jump into and help do some review.
>
> 	The questions is how to move forward pending patches, like [3], [4],
> [5]. How to keep good community channel to avoid long time pending?

Sorry, but like Laurent I am really without spare cycles to go over the
patch series that have arrived in media (also I do not have any hw anymore)=
.
So, Frank or maybe Laurent knows someone that would like to be add also as
maintainer of this drivers for me would be great, that would also help to
avoid such bottlenecks.

Thanks in advance,
Cheers,
    Rui
>
> Best regards
> Frank Li
