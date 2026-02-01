Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2B1A5B84;
	Sun,  1 Feb 2026 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769977326; cv=none; b=TAptXpO0ltQfefKp+Sewj42bfbJszPUZsWmojc0Fu78CPjaqczQJj8pH0NalhpB6zhlqxcPKDnKFOvGGYdhmhpil+DJdWL3IxHueMU4ZnVTxZZNAcjsKdvZQB1qCvCSXqty7hTbgGgf0xIRHvTD+1SrXpDYoK2k6t4i/eJ3khME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769977326; c=relaxed/simple;
	bh=3oUqY3vk4sM9ac/Hg//IOCWXx3lzt4hQaahSBJN9wh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIL7upI0+tt8DjlAXPWUJ4G4vPdD2qCYefLW2T99Vz6TyNr1ZQyQKe14j6bNkQaZYVanfSv6t21S/TKcLVCufcuV8BwGWrVC5/IXn5xU0vMHLmocYOgutLnjkFqX35FrpEi2Yq3L7xeCgFw4W1Dm8ByDu8rjbdXnyGCwIrSi018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NHDLiP0/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NHDLiP0/"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 2B2B51BA;
	Sun,  1 Feb 2026 21:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769977282;
	bh=3oUqY3vk4sM9ac/Hg//IOCWXx3lzt4hQaahSBJN9wh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHDLiP0/Q6LC0HFMsyD7sM5Uc45DGK36CUrGy22RSL8Y24ky8z7LOktvciStiZgmb
	 dnw2rDmc9s0yJSKYeJ5OYfw0O2+WBEoNXda8TRPMU2M6A1+DUaKVXsDwFs8bkzbeGl
	 +Z78XTNqsUb9db7MtfzAyPNFrmNg5csE6IDNcvg4=
Date: Sun, 1 Feb 2026 22:22:00 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-media@vger.kernel.org,
	jani.nikula@linux.intel.com, anisse@astier.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: Virtual camera driver
Message-ID: <20260201202200.GX3374091@killaraus>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <aX-joEDl_BJai8wY@kernel.org>
 <20260201200649.GW3374091@killaraus>
 <12828248.O9o76ZdvQC@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12828248.O9o76ZdvQC@natalenko.name>

On Sun, Feb 01, 2026 at 09:14:54PM +0100, Oleksandr Natalenko wrote:
> On neděle 1. února 2026 21:06:49, středoevropský standardní čas Laurent Pinchart wrote:
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
> My use-case for v4l2loopback is to stream a webcam from one machine to
> another (with the help of ffmpeg). Is this covered by something other
> than v4l2loopback now?

On the transmitting side I assume you don't use v4l2loopback. On the
receiving side, the recommened option is PipeWire.

-- 
Regards,

Laurent Pinchart
