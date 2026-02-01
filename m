Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262262874FB;
	Sun,  1 Feb 2026 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769980197; cv=none; b=FQrIIjm7kj4mlhRJn6dR3omNYNagH8+Zu8bsxccsxDWjkbjxUpDY3kSFfdON+FC7H2e4tk5pMSRKU5VBjf06ZYOH+HKXbjz8DP2fMjx+jUiQmlAtwyNtCnzBVq0F33iIO+iTah/Yu6iG6D3cEuHyeDAJtR7Dr+sgxTrgNu/GRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769980197; c=relaxed/simple;
	bh=5JxSG8sg1h2R0JspFk5NUk7uMNs0rLWSG3D2IEJ0J0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsXh5ga5QtkaDztNB3r2nfM58cV7ca38Q9MWZZ8xIz9N/wbj5FsdfysbWAJSdcwz840tOYPvtMJ/cs+d3sjWcj/b2UCMS0flxERLUuHaEoJNIZSQ5T05z601uhyo/8sDn3HZa0DgISPRAhpnr78zNBwsGkJIaxbHNVXo/DvoaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rh4MJzKS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rh4MJzKS"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id C75764D3;
	Sun,  1 Feb 2026 22:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769980154;
	bh=5JxSG8sg1h2R0JspFk5NUk7uMNs0rLWSG3D2IEJ0J0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rh4MJzKSH6V3lgs2djkBcRVQv8owZ6o8Bdbj2SkcWzvwCp5/do2R5TdnM8qzUu621
	 hktu2YIZyN6xIG09Kwhvd8oDAvrVLQS2IG9qXSD9sIs4+YsR4BaGFfULTtowaP/ret
	 i0Ct39IykupjWT1QZzdVBuSbI2ycKWwR1bUXR+6g=
Date: Sun, 1 Feb 2026 23:09:52 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-media@vger.kernel.org, jani.nikula@linux.intel.com,
	anisse@astier.eu, oleksandr@natalenko.name,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: Virtual camera driver
Message-ID: <20260201210952.GA3374091@killaraus>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <20260201182011.GV3374091@killaraus>
 <aX-joEDl_BJai8wY@kernel.org>
 <20260201200649.GW3374091@killaraus>
 <aX-4-gTM9vf03iCp@kernel.org>
 <aX-9iq8r-3SM00qF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aX-9iq8r-3SM00qF@kernel.org>

On Sun, Feb 01, 2026 at 10:54:34PM +0200, Jarkko Sakkinen wrote:
> On Sun, Feb 01, 2026 at 10:35:12PM +0200, Jarkko Sakkinen wrote:
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
> > 
> > Not saying that this weight more but it is important to remark this
> > fact.
> 
> It's widely packaged for different distributions and even embedded build
> systems forming across the board tained ecosystem. And this has been
> ongoing for years. Suggesting PipeWire as "a fix" for all possible
> situations is not "a solution".

PipeWire may not solve all of the world's problems, but it's part of a
clean solution for this particular issue. The fact that everybody relied
on an out-of-tree kernel module instead of designing a better stack is
not a reason to merge v4l2loopback upstream now that we have a better
option that is actively developed.

-- 
Regards,

Laurent Pinchart
