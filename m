Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0E30AAB6
	for <linux-media@vger.kernel.org>; Tue,  4 Nov 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267004; cv=none; b=DRwTlA1v4efOzFmQX9Yhx3/OMUg12+2Y1HP+KKsqLlU5REitJzYGpGb1sVI/F8njHr83lS7nLB7i5Jpr2/YBrqwGx1r7juq7cy7czgWqymz1nKlrOIb/ZfTSbznFQiGYdtJ1NsKWZYF/FkjXqgPKjvNmJQgXKTfzEegJaMrkloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267004; c=relaxed/simple;
	bh=YbNQZmQDRHZuJEslGSplhQKbIwrxt/EXEnw5WMnSajg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTBH30joorUqzoQ9E1SsAb4P4YYtmGwKP6CT87kGEMcpEu665lBCzZGaBsDKzW8jG0pFt/ZnsF7muY9gvigrIwE0SrDTCvkUs5Z7xcdyyzZvl/E1EDEqk3LueVft1a1qLpOalWNaaFeg9ex6IIH+uvX/h/+ITwpp3He/E36P8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bc4uA7j1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bc4uA7j1"
Received: from pendragon.ideasonboard.com (82-203-160-149.bb.dnainternet.fi [82.203.160.149])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CBD982B3;
	Tue,  4 Nov 2025 15:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762266886;
	bh=YbNQZmQDRHZuJEslGSplhQKbIwrxt/EXEnw5WMnSajg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bc4uA7j1fURx+NgskT53wh2ZAmze2XORP0DL6w/60BjHQTInlUYGg+aBc/Juord0Y
	 Am4zn3UAhJ1g/+uVpaWceLyhuEVDMrnUmnrqKjIFHBbZI+9V0bYfDVrv5vTAQjYFRC
	 wDY2AstzUCvKWZAjsxgHeHJDFezq5rd6QkSm1guA=
Date: Tue, 4 Nov 2025 16:36:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-media@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: imx8-isi: Drop unused module alias
Message-ID: <20251104143636.GD27255@pendragon.ideasonboard.com>
References: <20251102234438.8022-1-laurent.pinchart@ideasonboard.com>
 <aQnRsVPq1ndQrLr_@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQnRsVPq1ndQrLr_@hovoldconsulting.com>

On Tue, Nov 04, 2025 at 11:13:05AM +0100, Johan Hovold wrote:
> On Mon, Nov 03, 2025 at 01:44:38AM +0200, Laurent Pinchart wrote:
> > The driver has never supported anything but OF probing so drop the
> > unused platform module alias.
> 
> The commit message needs some more work since this isn't a platform
> module alias (i.e. has a "platform:" prefix),

Oops indeed.

> and judging from a quick
> look it seems like the driver did support platform probing before commit
> 605b57c4e888 ("media: nxp: imx8-isi: Drop partial support for i.MX8QM
> and i.MX8QXP"), at least in theory.

That has never been used upstream. It was code from the BSP that should
never have been imported in the first place, I missed removing it when I
rewrote the driver for upstreaming.

> It's probably fine to remove the "ISI" alias, but it should not affect
> module autoloading.

How about the following commit message ?


media: imx8-isi: Drop unneeded module alias

The imx8-isi driver has a module alias named "ISI". This is not
required, as there is no reason to load this module through an alias:
the device is probed through OF, and the module has never been named
"ISI". Drop the alias.

> > Suggested-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Johan, I've got the idea from similar patches you submitted for other
> > NXP media drivers, hence the Suggested-by tag. Please let me know if I
> > can keep it.
> 
> Sure, please do.
> 
> > -MODULE_ALIAS("ISI");

-- 
Regards,

Laurent Pinchart
