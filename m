Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B832860F
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540625; cv=none; b=Qp2RlTQINl3AKoURkrwJmWBF4PWwV0c8Zdi5/jYxjVVoqWiV3vV6RCSQ9iG3DG4OHa9VUU3ItbFhTJpoxayEJzt10HPv7BbPKXSQzahzfRd2h+3wgJb2zVbClDfLHc4BYo+77L/gaDh3QIssfLMzylwldq7q0Wx7kypERp//90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540625; c=relaxed/simple;
	bh=rLiP3gEtn72ck68kGmlb3ojW5hIqH/o/7GXrlLRkSi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2kaK/2tNRZ3kYRs+IlN9T7CFBMaDJ/5HENqjN4JmGWBWTG/406xDnawG/1V1fvl0uaj9NF8W4q3x7HC8iJ5q0fG2XuMBaPdMf08KIINQmSuQFzDEvtVpl+UcWbR6KIWT9JF1UPDXpSeaTTJwzuFuLkc41BoJhZhmHA/W956ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pP6ZGZP1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pP6ZGZP1"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1C544111F;
	Fri,  7 Nov 2025 19:26:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762540013;
	bh=rLiP3gEtn72ck68kGmlb3ojW5hIqH/o/7GXrlLRkSi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pP6ZGZP1+Zp4ZOyeB6rmVyJJI8TLMd4d1MeRqy/wEipiTE9NWTChZyyWQSdc8LE5N
	 5vDCwPYlN1U/ye2L4OJYQbnlSwlvVESmxZ0yKEcvARwQByxzC1vOdAy3z5XgaBcKHA
	 plwFCBXirR1DSAjzhetkcQRa5MA9McgOI9wnLFHI=
Date: Fri, 7 Nov 2025 20:28:43 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 0/6] media: imx-mipi-csis: Add streams support
Message-ID: <20251107182843.GB5558@pendragon.ideasonboard.com>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <60dac85af5ed941c40cfb55dff0ccf7864f0e681.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60dac85af5ed941c40cfb55dff0ccf7864f0e681.camel@posteo.de>

Hi Martin,

On Fri, Nov 07, 2025 at 09:31:39AM +0000, Martin Kepplinger wrote:
> Am Freitag, dem 07.11.2025 um 03:58 +0200 schrieb Laurent Pinchart:
> > Hello,
> > 
> > The reference manual for the NXP i.MX7D in which the CSIS is integrated
> > lists four outputs named "channels" in various diagrams and tables, but 
> > only documents registers for channel 0. Reference manuals for i.MX8 SoCs
> > that integrate the CSIS gradually removed mentions of channels 1 to 3 as
> > newer revisions of the documents got released, which was interpreted as
> > an indication that the CSIS has only a single output.
> > 
> > That interpretation turned out not to be correct. In the i.MX8MP, the
> > CSIS features multiple output channels. Channel 0 is connected to the
> > ISI, and channels 0, 1 and 2 are connected to the ISP. Multi-channel
> > support towards the ISP is meant to support HDR, where camera sensors
> > transmit multiple exposures or gains over different virtual channels.
> > The glue logic between the CSIS and ISP hardcodes this use case and
> > combines the channels in a way suitable for the ISP's single input
> > port.
> 
> Hi Laurent,
> 
> This is going to be a dumb question, I know this, but I'm equally
> confused as interested:
> 
> What you implement here is *not* muxing CSIS to (one of the 2) ISI-
> pipes, right? This specifically is something I still need to do on
> mainline (nxp-tree has a way to "mux" this, with rather cryptic
> devicetree properties) where a board physically has the camera
> connected to the *second* CSI interface but I need data to run through
> the *first* ISI pipe. By default the second ISI pipe is used for the
> second CSI interface but only the first ISI pipe can do 4k. Is this
> "muxing" implemented in mainline right now? (ISI driver most
> probably?).

You can configure routing of inputs to channels within the ISI crossbar
subdev using the set routing ioctl. This should work in mainline today.

> Also, your patch is not about the connection CSIS->ISP, right? Because
> that is something I tested using libcamera a while ago and have a dtso
> lying around for.

Connecting the CSIS to the ISP also works today with a change in DT,
that's correct. I would like to make this more dynamic by declaring both
connections in DT and dynamically configuring the routing from
userspace, but that's an entirely different issue (and will require lots
of work).

> Can you put this new functionality into perspective for lazy people
> like me? :) For the ISI-case this doesn't seem to have any implication
> right?

What this series is about is how to demultiplex CSI-2 virtual channels
(not to be confused with the CSIS output channels, despite being both
called channels they are entirely different things) inside the CSIS and
route them to different CSIS outputs. This is not a feature useful for
the ISI as only CSIS output channel 0 is connected to the ISI.

> anyways, fascinating :)
> 
> > With a time machine, we would probably redesign the CSIS DT bindings to
> > model each output channel with a port, and the V4L2 subdev would use
> > multiple source pads. Without a time machine, we need to preserve
> > backward compatibility with userspace. Not only would the addition of
> > new ports and pads make this tricky, they would also require modelling
> > the glue logic between the CSIS and ISP with a subdev. This would
> > conflict with the need to preserve backward compatibility.
> > 
> > Fortunately for us, the CSIS is an old IP. The NXP i.MX9 series uses a
> > different CSI-2 receiver, and the probability of needing to support an
> > SoC that connects different output channels to different devices is
> > extremely low. We can therefore implement a solution tailored to the
> > needs of the i.MX8MP, and model the output channels as separate streams
> > instead of separate pads. Should the need arise in the future to support
> > connecting output channels to different devices in a new SoC, we will
> > still be able to model this with extra ports in the device tree without
> > breaking backward compatibility. The driver could then create extra
> > subdev pads accordingly.
> > 
> > The series starts with 5 preparatory patches to ease review. Patch 1/6
> > adds missing register definitions. Patch 2/6 then switches from
> > .s_stream() to .enable_streams() and .disable_streams(), a pre-requisite
> > for multi-stream support. Patch 3/6 follows by implementing the
> > .s_routing() operation, supporting a single route exactly as done
> > implicitly so far. Patches 4/6 and 5/6 refactor the code to group
> > parameters in structures and clean up how they are written to registers.
> > Finally, patch 6/6 adds multi-channel support.
> > 
> > The series has been tested on an i.MX8MP with libcamera, both without
> > changes to verify that backward compatibility is preserved, and with HDR
> > support (work still in progress) to verify that VC filtering works as
> > expected.
> > 
> > Laurent Pinchart (6):
> >   media: imx-mipi-csis: Add VC-related register fields
> >   media: imx-mipi-csis: Switch to .enable_streams()
> >   media: imx-mipi-csis: Implement the .set_routing() operation
> >   media: imx-mipi-csis: Group runtime parameters in structure
> >   media: imx-mipi-csis: Set all per-channel registers in one function
> >   media: imx-mipi-csis: Add multi-channel support
> > 
> >  drivers/media/platform/nxp/imx-mipi-csis.c | 551 ++++++++++++++++---
> > --
> >  1 file changed, 429 insertions(+), 122 deletions(-)
> > 
> > 
> > base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa

-- 
Regards,

Laurent Pinchart
