Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC5288C2C;
	Mon,  2 Feb 2026 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023947; cv=none; b=XreTixXp4FbCSSvHDmHjBigN1Uq2THNJnOOrMnJQ4D3vzo/mysW6CnFK/nTHYzeAGf4bgHxbpJgiSkFXfZOE4Ouwv/j74V/IxhFbT/7kk9h+U0hTM7udCGoTy4v44WWapFHHpeIwV04MHb1OH2yB9oJ41ZriHfl1iTt0rdQAeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023947; c=relaxed/simple;
	bh=V0WbQpFix6zCTYwDV07C7w3HOSiWB/FGNOUmcH8b5FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIxNuMFdsAELAPYYxYJKut1ikJSk7M5F0FJBxKnh/Ac04hkHV/2XoGT9XS4XVdgfghEY3jplRyP5y6IGhlpgTN33WTSbAKu5pPHHxlfvi2Kl2Jf7K2xf/JcNZgGQVdEagKQPGUSUJdSdpC3rSEhNsOm4nNrFCuClTNF4VG7c72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDb9590Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDb9590Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909B9C116C6;
	Mon,  2 Feb 2026 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770023946;
	bh=V0WbQpFix6zCTYwDV07C7w3HOSiWB/FGNOUmcH8b5FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDb9590YPYc6rZMQSomSYvADo2E4v6xx2zi2Le0KTYChFRTkUo7L9SnLCiUWhIWGm
	 vnw7591TEEk0YW0QYxsBuoYHhhUbZI2j52dWdSSrqAskVM8MWPcLcylc20OxYQBbw2
	 TUU8qFLwujHhROquEnkE4X1BIKOI3hs22sKxXK4Ipb1fORWbjlqUcf1qpi6dSkf94v
	 Z+i7UbnG9JBYY89Sj5yGKFyoP2ARGMPZ9m7NyFxeFFx7wi4uubw9O5tSBAwpwHgB6I
	 TEAkPcrehsuAf2DmsKT5EAo6LHCr9fVVliuWwOIcdneS/O40heByW140YCKwPXvvsJ
	 v1BZaOGBqRRUg==
Date: Mon, 2 Feb 2026 11:19:03 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org, jani.nikula@linux.intel.com,
	anisse@astier.eu, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: Virtual camera driver
Message-ID: <aYBsBw2j6pkwAssn@kernel.org>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <5073898.31r3eYUQgx@natalenko.name>
 <20260202001704.2419778a@foz.lan>
 <13939245.uLZWGnKmhe@natalenko.name>
 <20260202020214.2243acec@foz.lan>
 <aYBo69zrMnRdWs32@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYBo69zrMnRdWs32@kernel.org>

On Mon, Feb 02, 2026 at 11:05:52AM +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 02, 2026 at 02:02:14AM +0100, Mauro Carvalho Chehab wrote:
> > On Mon, 02 Feb 2026 00:25:37 +0100
> > Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> > 
> > > Date: Mon, 02 Feb 2026 00:25:37 +0100
> > > From: Oleksandr Natalenko <oleksandr@natalenko.name>
> > > To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jarkko Sakkinen <jarkko@kernel.org>, linux-media@vger.kernel.org, jani.nikula@linux.intel.com, anisse@astier.eu, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Ricardo Ribalda <ribalda@chromium.org>, open list <linux-kernel@vger.kernel.org>
> > > Message-ID: <13939245.uLZWGnKmhe@natalenko.name>
> > > 
> > > On pondělí 2. února 2026 0:17:20, středoevropský standardní čas Mauro Carvalho Chehab wrote:
> > > > No. At the machine with the camera, obs can read from a V4L2 input,
> > > > generate a mpeg TS stream, and listen to a UDP port (for instance). 
> > > > 
> > > > At the remote machine, you can just pass the URL to ffmpeg.  
> > > 
> > > I can't, I have to feed the stream into Firefox somehow for it to see the stream as a virtual webcam.
> > 
> > Motioneye could be used on such scenario. It has a proper web
> > interface, allows multiple users to watch, has login control accepts
> > multiple cameras.
> 
> When proposed workarounds move in the area of motion detection systems
> it feels like there was a competion who invents the most impractical
> solution for a practical real-world problem out in the wild.

A trivial Google search shows that the scope of the issue, which is
also (on emphasis) a security issue, and net effect that is caused
of not addressing it properly.

> 
> > 
> > Thanks,
> > Mauro


BR, Jarkko
