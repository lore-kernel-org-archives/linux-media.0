Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A341DF751;
	Sun,  1 Feb 2026 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769983417; cv=none; b=WLrAL6khVprO3XcqJEdAfj0glW/XEaqL9FxJqjYzgWra3/BWcsogdK2mN3Zukc4O1N0LUWLEcBFnF+CrFfngVdZYpTk0sVrx8TZ+QtfoUHbm8fyGNdi8kkS9kmp31Q7AiXOX1UCQkK2t2x9q5D1doyVgSuiywWQcOuYnuGlL2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769983417; c=relaxed/simple;
	bh=CFW3Z9OHm6NXNayNGLZzIvKZRmsFjKjutr32Z1c7N5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUxiu6UT2kmbDEYemdwRl5e3fbelZ3Zh31qaJTWvXzudvozdVK+02MJv2GVDoqKr6QvaOPiFLO2UvHfeQ0imkt3FRM/iRDDWii+PZu5l10x6pSRrRUuxePM5NH2P9Y02z62dhXuNmGV4a/w58y0j8gf1LfnQwt8uGkd9guy+nK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE8YEoYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE8YEoYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12984C4CEF7;
	Sun,  1 Feb 2026 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769983417;
	bh=CFW3Z9OHm6NXNayNGLZzIvKZRmsFjKjutr32Z1c7N5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VE8YEoYyB0TK2D6YkFEJoD2paKV/pztbpAWTT+XKcOPKvxjk6THRB/RgVYEVPZJ0Y
	 b5pRcadhyqSy8AEGwnC1+hPeyEJHadMtNjHbN5aLZa7zMffInuhG5pk7q5IpT20ecN
	 igfdTILrzisDzsux+qM4JZ9NwkvcvZ8w71HJYwa/tEXV8NOsuvGq9KkuEe9tvce++c
	 Ata0fppDh6tMwFtq/lJDUGNOC1+ietDdWIcoaFiYyvI+jG7bDFlJBLO8E9RItCG97P
	 Qv/m7F2sfRVUllSJg17d40h1SI3qMjvXbfuyBx6hS0EJeddzfmDOew55qRZvOEfdAz
	 NIY6R82Vqd2dQ==
Date: Mon, 2 Feb 2026 00:03:33 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, jani.nikula@linux.intel.com,
	anisse@astier.eu, oleksandr@natalenko.name,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: Virtual camera driver
Message-ID: <aX_NtZJGtMTn-55H@kernel.org>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <20260201182011.GV3374091@killaraus>
 <aX-joEDl_BJai8wY@kernel.org>
 <20260201200649.GW3374091@killaraus>
 <aX-4-gTM9vf03iCp@kernel.org>
 <20260201210144.GZ3374091@killaraus>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201210144.GZ3374091@killaraus>

On Sun, Feb 01, 2026 at 11:01:44PM +0200, Laurent Pinchart wrote:
> On Sun, Feb 01, 2026 at 10:35:06PM +0200, Jarkko Sakkinen wrote:
> > On Sun, Feb 01, 2026 at 10:06:49PM +0200, Laurent Pinchart wrote:
> > > On Sun, Feb 01, 2026 at 09:04:00PM +0200, Jarkko Sakkinen wrote:
> > > > On Sun, Feb 01, 2026 at 08:20:11PM +0200, Laurent Pinchart wrote:
> > > > > On Sun, Feb 01, 2026 at 03:33:38PM +0200, Jarkko Sakkinen wrote:
> > > > > > vcam is a DMA-BUF backed virtual camera driver capable of creating video
> > > > > > capture devices to which data can be streamed through /dev/vcam after
> > > > > > calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> > > > > > with VCAM_IOC_DEQUEUE.
> > > > > > 
> > > > > > Zero-copy semantics are supported for shared DMA-BUF between capture and
> > > > > > output.
> > > > > >
> > > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > ---
> > > > > > Early feedback e.g., is this completely in wrong direction? V4L2 world
> > > > > > is relatively alien world, and thus I need a sanity check ;-)
> > > > > 
> > > > > We already have multiple virtual drivers, including vivid and vimc.
> > > > > Could you please explain the rationale for yet another one, and why the
> > > > > new features it provides (if any) can't be added to existing drivers ?
> > > > 
> > > > There is a notable user base for v4l2-loopback. It is the defacto choice
> > > > for streaming phone cams.
> > > 
> > > This will then likely face the same hurdles as v4l2-loopback, the main
> > > one being that camera support should be upstreamed with proper drivers
> > > instead of a closed-source userspace daemon.
> > > 
> > > For phone cameras, the way forward upstream is libcamera. Until kernel
> > > drivers for ISPs are available, the soft ISP is a stop-gap solution. It
> > > recently gained GPU acceleration support (with work to improve image
> > > quality with additional algorithms ongoing).
> > 
> > That might have some weight as a pro but the unarguable con is that at
> > the same time this policy retains a base of tainted kernels in the wild.
> 
> Do you mean tainted by the out-of-tree v4l2loopback module ? Won't those
> systems be equally tainted by out-of-tree camera drivers then ? With
> libcamera and the soft ISP you can run a 100% mainline stack.

A camera driver could also manage a network stream, not necessarily
some piece of proprietary hardware.

That said I don't have enough knowledge of the industry to say anything
about how properietary risk would change i.e., not really arguing against
that.

Just want to emphasis that while disagreeing in some level I'm not
downplaying totally legit arguments :-)

BR, Jarkko
