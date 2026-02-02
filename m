Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340CE347DD;
	Mon,  2 Feb 2026 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769996672; cv=none; b=Gl7p9xaRUA5bAXPPPffbV7XVSFrIJjGG2anOppDRZa7tMkyyIwVt8/KO2N0Woh3G8tjMEfZz+lx8RlMH5QPWpchlxZVJQ29gmtiKK595eRCmDpNRmgtoBUGgbX06tNPYyNqTwbiADWuNuoKeEvT3YoASew7xobknhzqExcRK/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769996672; c=relaxed/simple;
	bh=fuhwN3cisTYdLDz37vq+hN2egM0+uS30hgOu5Kl3oCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMOPep/woIQe8q/mlLsPGTp1HNWryItIx5kYPJiDxPQhjcQ72c7iDDIZd3JSf0JOWptJ7rMgaqWekIzFhC7mneVuCa54wa1RK7KWkc95BfobRSLghNwCh6dOfPFNtoTxNke/X2umYxgbWu8MHrYi70B6kWwYtBi6iAilgyQ9U6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urHmwzCV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urHmwzCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A55C4CEF7;
	Mon,  2 Feb 2026 01:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769996671;
	bh=fuhwN3cisTYdLDz37vq+hN2egM0+uS30hgOu5Kl3oCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urHmwzCVgkFbOZo7OGKugEkgBr3D5UWx8f76xM7KWkRZEcHUpiimse8UzbFdxw3ZN
	 WUgg8C45ypBOY+aSbkpS8LRCsrCrrZ5JaqcGqUq8UdH/J3C/GScgojXOK+1ijdaKQ3
	 0mu6f4CGBus9RMGcFpEkVm/ecdGIIB4fJ1f4Au2V6boBDQKpW7rzIZtL/Fvijrhwuh
	 qMSkq9VfrV/ITsLI4lfnnQUGxvgWAt9tZDw0Ak/VlwQjbnR5Mv1dQrMqGbd6kOH3Y4
	 ALbwG6QtFARDRQx3zKHC7EV+3xPUjYmq9SEa0ULiaQoX75PwCJhrRLZPHr9lq93tEA
	 MoiyzNCJWKUmg==
Date: Mon, 2 Feb 2026 03:44:27 +0200
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
Message-ID: <aYABe58YpHd5JUjZ@kernel.org>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <20260201182011.GV3374091@killaraus>
 <aX-joEDl_BJai8wY@kernel.org>
 <20260201200649.GW3374091@killaraus>
 <aX-4-gTM9vf03iCp@kernel.org>
 <aX-9iq8r-3SM00qF@kernel.org>
 <20260201210952.GA3374091@killaraus>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201210952.GA3374091@killaraus>

On Sun, Feb 01, 2026 at 11:09:52PM +0200, Laurent Pinchart wrote:
> On Sun, Feb 01, 2026 at 10:54:34PM +0200, Jarkko Sakkinen wrote:
> > On Sun, Feb 01, 2026 at 10:35:12PM +0200, Jarkko Sakkinen wrote:
> > > On Sun, Feb 01, 2026 at 10:06:49PM +0200, Laurent Pinchart wrote:
> > > > On Sun, Feb 01, 2026 at 09:04:00PM +0200, Jarkko Sakkinen wrote:
> > > > > On Sun, Feb 01, 2026 at 08:20:11PM +0200, Laurent Pinchart wrote:
> > > > > > On Sun, Feb 01, 2026 at 03:33:38PM +0200, Jarkko Sakkinen wrote:
> > > > > > > vcam is a DMA-BUF backed virtual camera driver capable of creating video
> > > > > > > capture devices to which data can be streamed through /dev/vcam after
> > > > > > > calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> > > > > > > with VCAM_IOC_DEQUEUE.
> > > > > > > 
> > > > > > > Zero-copy semantics are supported for shared DMA-BUF between capture and
> > > > > > > output.
> > > > > > >
> > > > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > > ---
> > > > > > > Early feedback e.g., is this completely in wrong direction? V4L2 world
> > > > > > > is relatively alien world, and thus I need a sanity check ;-)
> > > > > > 
> > > > > > We already have multiple virtual drivers, including vivid and vimc.
> > > > > > Could you please explain the rationale for yet another one, and why the
> > > > > > new features it provides (if any) can't be added to existing drivers ?
> > > > > 
> > > > > There is a notable user base for v4l2-loopback. It is the defacto choice
> > > > > for streaming phone cams.
> > > > 
> > > > This will then likely face the same hurdles as v4l2-loopback, the main
> > > > one being that camera support should be upstreamed with proper drivers
> > > > instead of a closed-source userspace daemon.
> > > > 
> > > > For phone cameras, the way forward upstream is libcamera. Until kernel
> > > > drivers for ISPs are available, the soft ISP is a stop-gap solution. It
> > > > recently gained GPU acceleration support (with work to improve image
> > > > quality with additional algorithms ongoing).
> > > 
> > > That might have some weight as a pro but the unarguable con is that at
> > > the same time this policy retains a base of tainted kernels in the wild.
> > > 
> > > Not saying that this weight more but it is important to remark this
> > > fact.
> > 
> > It's widely packaged for different distributions and even embedded build
> > systems forming across the board tained ecosystem. And this has been
> > ongoing for years. Suggesting PipeWire as "a fix" for all possible
> > situations is not "a solution".
> 
> PipeWire may not solve all of the world's problems, but it's part of a
> clean solution for this particular issue. The fact that everybody relied
> on an out-of-tree kernel module instead of designing a better stack is
> not a reason to merge v4l2loopback upstream now that we have a better
> option that is actively developed.

Nobody (at least not in this thread) requested to merge v4l2-loopback
upstream. Let's use correct terminology in order not convolute the
discussion further, thank you.

> 
> -- 
> Regards,
> 
> Laurent Pinchart

BR, Jarkko
