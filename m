Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0D2C2ABF;
	Sun,  1 Feb 2026 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769978112; cv=none; b=kONZtMnpZL+2w0hM0hps3qXbkWa+7W6/GjTFwwtggZzg2ZA78IvfOB1/X3wVg5VmFPvXUYG/Enh/z5ZPSTGUYZWru0AhfTxt4h+TQ44JC+ywaFaQ4gkwAIKOJabk7uESwNjKLEwmsRc/T7CkZpKvl/UF8pdig/M0Scp14dOC5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769978112; c=relaxed/simple;
	bh=9AZrhuP8bJLjru6u0kp/mk9SAFQNQD2+eLv5yuCJgaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ6tKBaGsBnD6P6NH9XesTLDPqDZxhPgVd83UtIkx6JoXfcPfIo2jn7b+jcgTZj8AJKv5Glq7RCcC/L3lZN6rcP9/BG+J0iwaF9Ndq8V5NBne8HixYI6bp19O/ptM4Oez42AC4TfflkZ7gK34TbrPct51x1XNByvk4c3h7p+Mto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZijpDo7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZijpDo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE560C4CEF7;
	Sun,  1 Feb 2026 20:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769978111;
	bh=9AZrhuP8bJLjru6u0kp/mk9SAFQNQD2+eLv5yuCJgaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZijpDo7Mtt/eY5gpTObZFgO9Gge1VW53ncaleQp/tra7TkvgpidQzz+mDnjNZNOF
	 lAgr2+GLep96rAwPleBHW9FzrLU98erxIY70EXbgB4fywpTStvyG0BqnzWnB75edFG
	 lz4MqWcDsti8Rmm4ceiKxPhYA9BLHnucXCnz54Yvdd1kfRNAmApJQliVg1ndhop4Vn
	 rQ/iB1YI7U3GBQ2PbQtIorevHHbY/Sd5UOjLwdhyKvrdjADlXdVmLEK5A1npfBHaix
	 ajynoRV5c1ei5k+g02oOF1YxcNPDxveZopArXd290yh1X5j4tGoGTEzUKDzkvYgBKr
	 pJ3eRdEDJvf0g==
Date: Sun, 1 Feb 2026 22:35:06 +0200
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
Message-ID: <aX-4-gTM9vf03iCp@kernel.org>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <20260201182011.GV3374091@killaraus>
 <aX-joEDl_BJai8wY@kernel.org>
 <20260201200649.GW3374091@killaraus>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201200649.GW3374091@killaraus>

On Sun, Feb 01, 2026 at 10:06:49PM +0200, Laurent Pinchart wrote:
> On Sun, Feb 01, 2026 at 09:04:00PM +0200, Jarkko Sakkinen wrote:
> > On Sun, Feb 01, 2026 at 08:20:11PM +0200, Laurent Pinchart wrote:
> > > On Sun, Feb 01, 2026 at 03:33:38PM +0200, Jarkko Sakkinen wrote:
> > > > vcam is a DMA-BUF backed virtual camera driver capable of creating video
> > > > capture devices to which data can be streamed through /dev/vcam after
> > > > calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> > > > with VCAM_IOC_DEQUEUE.
> > > > 
> > > > Zero-copy semantics are supported for shared DMA-BUF between capture and
> > > > output.
> > > >
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > > Early feedback e.g., is this completely in wrong direction? V4L2 world
> > > > is relatively alien world, and thus I need a sanity check ;-)
> > > 
> > > We already have multiple virtual drivers, including vivid and vimc.
> > > Could you please explain the rationale for yet another one, and why the
> > > new features it provides (if any) can't be added to existing drivers ?
> > 
> > There is a notable user base for v4l2-loopback. It is the defacto choice
> > for streaming phone cams.
> 
> This will then likely face the same hurdles as v4l2-loopback, the main
> one being that camera support should be upstreamed with proper drivers
> instead of a closed-source userspace daemon.
> 
> For phone cameras, the way forward upstream is libcamera. Until kernel
> drivers for ISPs are available, the soft ISP is a stop-gap solution. It
> recently gained GPU acceleration support (with work to improve image
> quality with additional algorithms ongoing).

That might have some weight as a pro but the unarguable con is that at
the same time this policy retains a base of tainted kernels in the wild.

Not saying that this weight more but it is important to remark this
fact.

> 
> > The motivation here is to provide a service optimized for that use and
> > purpose. It's virtual but non-generic i.e. not aimed for testing/emulation.
> > 
> > > >  .../driver-api/media/drivers/index.rst        |    1 +
> > > >  .../driver-api/media/drivers/vcam.rst         |   16 +
> > > >  MAINTAINERS                                   |    8 +
> > > >  drivers/media/Kconfig                         |   13 +
> > > >  drivers/media/Makefile                        |    1 +
> > > >  drivers/media/vcam.c                          | 1700 +++++++++++++++++
> > > >  include/uapi/linux/vcam.h                     |  124 ++
> > > >  7 files changed, 1863 insertions(+)
> > > >  create mode 100644 Documentation/driver-api/media/drivers/vcam.rst
> > > >  create mode 100644 drivers/media/vcam.c
> > > >  create mode 100644 include/uapi/linux/vcam.h
> 
> [snip]
> 
> -- 
> Regards,
> 
> Laurent Pinchart

BR, Jarkko
