Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F928314B;
	Sun,  1 Feb 2026 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769979709; cv=none; b=DHPC54/iupXTb2aXAAOz6cyWEDAsWHcj5TXOyFKatBTaAIzLm2V5ej4vXRXgQY00hj2DFvVEjpK+Cpg5XYEP/PZ3Qm1iHMh/35N9UOIIaEfuGLLLPHsJ1XFD71wITk33yYrBjW4prqCpXdTwnBNbdcIPIF6zRTWpMLudM+wPZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769979709; c=relaxed/simple;
	bh=vjhiCNXVEl4JwTm9FOMfP9G8iIONK7YsIk6rcyN+OQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LasZECmhaVx6ikm4zpUfpbNCljgB4LABYRhWoBTyqnDI7Dn6ARSZ152hs7oL60M77iCmK1xQqK8BmoWtIQDIrT2DFXLBReANrbvIyoLayc10Inb+mceR+rSfFFUn2GaazseVkqu8Hqv1Pt6xEJhzoWj/yT71rSEmZLZIRnA5rwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HhFat/aj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HhFat/aj"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id AE9244E1;
	Sun,  1 Feb 2026 22:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769979665;
	bh=vjhiCNXVEl4JwTm9FOMfP9G8iIONK7YsIk6rcyN+OQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhFat/ajvZxz+CrymkcVyhI0lTtklLAo5Zbge4n4Tquh5Pycb+vSglK0rPJLTtSou
	 kvm+Rpzp954bGsYGYcVmywLr4+FXbPTgle82J9J9te4MKKOgZvPzqWupYCOHOV+ZPG
	 UIfVj0XBe7sueWDejBiToEWgsTmbPzCvPTXtxV/o=
Date: Sun, 1 Feb 2026 23:01:44 +0200
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
Message-ID: <20260201210144.GZ3374091@killaraus>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <20260201182011.GV3374091@killaraus>
 <aX-joEDl_BJai8wY@kernel.org>
 <20260201200649.GW3374091@killaraus>
 <aX-4-gTM9vf03iCp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aX-4-gTM9vf03iCp@kernel.org>

On Sun, Feb 01, 2026 at 10:35:06PM +0200, Jarkko Sakkinen wrote:
> On Sun, Feb 01, 2026 at 10:06:49PM +0200, Laurent Pinchart wrote:
> > On Sun, Feb 01, 2026 at 09:04:00PM +0200, Jarkko Sakkinen wrote:
> > > On Sun, Feb 01, 2026 at 08:20:11PM +0200, Laurent Pinchart wrote:
> > > > On Sun, Feb 01, 2026 at 03:33:38PM +0200, Jarkko Sakkinen wrote:
> > > > > vcam is a DMA-BUF backed virtual camera driver capable of creating video
> > > > > capture devices to which data can be streamed through /dev/vcam after
> > > > > calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> > > > > with VCAM_IOC_DEQUEUE.
> > > > > 
> > > > > Zero-copy semantics are supported for shared DMA-BUF between capture and
> > > > > output.
> > > > >
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > ---
> > > > > Early feedback e.g., is this completely in wrong direction? V4L2 world
> > > > > is relatively alien world, and thus I need a sanity check ;-)
> > > > 
> > > > We already have multiple virtual drivers, including vivid and vimc.
> > > > Could you please explain the rationale for yet another one, and why the
> > > > new features it provides (if any) can't be added to existing drivers ?
> > > 
> > > There is a notable user base for v4l2-loopback. It is the defacto choice
> > > for streaming phone cams.
> > 
> > This will then likely face the same hurdles as v4l2-loopback, the main
> > one being that camera support should be upstreamed with proper drivers
> > instead of a closed-source userspace daemon.
> > 
> > For phone cameras, the way forward upstream is libcamera. Until kernel
> > drivers for ISPs are available, the soft ISP is a stop-gap solution. It
> > recently gained GPU acceleration support (with work to improve image
> > quality with additional algorithms ongoing).
> 
> That might have some weight as a pro but the unarguable con is that at
> the same time this policy retains a base of tainted kernels in the wild.

Do you mean tainted by the out-of-tree v4l2loopback module ? Won't those
systems be equally tainted by out-of-tree camera drivers then ? With
libcamera and the soft ISP you can run a 100% mainline stack.

> Not saying that this weight more but it is important to remark this
> fact.
> 
> > > The motivation here is to provide a service optimized for that use and
> > > purpose. It's virtual but non-generic i.e. not aimed for testing/emulation.
> > > 
> > > > >  .../driver-api/media/drivers/index.rst        |    1 +
> > > > >  .../driver-api/media/drivers/vcam.rst         |   16 +
> > > > >  MAINTAINERS                                   |    8 +
> > > > >  drivers/media/Kconfig                         |   13 +
> > > > >  drivers/media/Makefile                        |    1 +
> > > > >  drivers/media/vcam.c                          | 1700 +++++++++++++++++
> > > > >  include/uapi/linux/vcam.h                     |  124 ++
> > > > >  7 files changed, 1863 insertions(+)
> > > > >  create mode 100644 Documentation/driver-api/media/drivers/vcam.rst
> > > > >  create mode 100644 drivers/media/vcam.c
> > > > >  create mode 100644 include/uapi/linux/vcam.h
> > 
> > [snip]

-- 
Regards,

Laurent Pinchart
