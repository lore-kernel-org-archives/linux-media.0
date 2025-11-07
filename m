Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A2218596
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507909; cv=none; b=ZFkjZB7OzUvDrstL7wt2B8ppx77DRWYRxTE/MDW7zxCTIDPsDVtxWGwID8XUymg8m1bzPbHyDMiRynqfgPbzIgCi6PfykUw+aQLUJaGj9AvMiRb1E3zNHRW82V85kcktLAGZoUzDNB+/lmfK3LSbNFGL0kq2raepu31vwGkT2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507909; c=relaxed/simple;
	bh=cq2v5sb0cXY8GZI0jcJDW3FaxEStFtvApCLAlKv/1/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgyAiKeaoWH2FhwBjfloUQGqlF3DA0K2NLNCh3B2MzlEGawIrxVnBjrgST7pBDYazO6UFaUBXgnmpZE89lDCo2w529D8JnrG7Y6HASXkVoZKU+HG867aD/QKg8GNu6XpuTpnvwp11in+0oK9os5r8WvhyqFBCYjQBAyMIZQS5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=oGj30N54; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="oGj30N54"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id BE2E1240029
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 10:31:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1762507899; bh=Xkg3j82jHgx45swNrHI04pUtVRZQ6Cd3uf1V88lBztM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=oGj30N54+zHZ3t9nPEWckxXm6EBZt1X2CG9WxJpC3pG+uGtlYBEVP1w5XZjw2V5M1
	 ZNCrb2jwKGlDqhlLFFZEHHLj5gLBYhaXPOAbRUgVJdpptgUdjlmbdfkjFKIm/cZZ8B
	 NZMl5xsbhvxy3tQ1kCd2jgcLM4eORuh3VSsZNG9pooWxoKRXcR43l5mGX8bBkdWocs
	 1hPTa9Z1or6ap6mz7TZYyylXfWe9zh2CSmSuHjS6beyWhZvDiB2OVU4bp7k5otEtM3
	 5UGrocwzj6W5bzOnkUgTL3AHyMVuq7UYNozWRnhAFYwOOvxbNbsX3SMxOfqo1r3PRo
	 O8QVw51Bqbc1w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4d2v2d3zbXz9rxF;
	Fri,  7 Nov 2025 10:31:37 +0100 (CET)
Message-ID: <60dac85af5ed941c40cfb55dff0ccf7864f0e681.camel@posteo.de>
Subject: Re: [PATCH v1 0/6] media: imx-mipi-csis: Add streams support
From: Martin Kepplinger <martink@posteo.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	linux-media@vger.kernel.org
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Purism Kernel Team
 <kernel@puri.sm>,  Pengutronix Kernel Team	 <kernel@pengutronix.de>,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,  Stefan Klug
 <stefan.klug@ideasonboard.com>, Sakari Ailus <sakari.ailus@iki.fi>
Date: Fri, 07 Nov 2025 09:31:39 +0000
In-Reply-To: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Freitag, dem 07.11.2025 um 03:58 +0200 schrieb Laurent Pinchart:
> Hello,
>=20
> The reference manual for the NXP i.MX7D in which the CSIS is
> integrated
> lists four outputs named "channels" in various diagrams and tables,
> but=20
> only documents registers for channel 0. Reference manuals for i.MX8
> SoCs
> that integrate the CSIS gradually removed mentions of channels 1 to 3
> as
> newer revisions of the documents got released, which was interpreted
> as
> an indication that the CSIS has only a single output.
>=20
> That interpretation turned out not to be correct. In the i.MX8MP, the
> CSIS features multiple output channels. Channel 0 is connected to the
> ISI, and channels 0, 1 and 2 are connected to the ISP. Multi-channel
> support towards the ISP is meant to support HDR, where camera sensors
> transmit multiple exposures or gains over different virtual channels.
> The glue logic between the CSIS and ISP hardcodes this use case and
> combines the channels in a way suitable for the ISP's single input
> port.

Hi Laurent,

This is going to be a dumb question, I know this, but I'm equally
confused as interested:

What you implement here is *not* muxing CSIS to (one of the 2) ISI-
pipes, right? This specifically is something I still need to do on
mainline (nxp-tree has a way to "mux" this, with rather cryptic
devicetree properties) where a board physically has the camera
connected to the *second* CSI interface but I need data to run through
the *first* ISI pipe. By default the second ISI pipe is used for the
second CSI interface but only the first ISI pipe can do 4k. Is this
"muxing" implemented in mainline right now? (ISI driver most
probably?).

Also, your patch is not about the connection CSIS->ISP, right? Because
that is something I tested using libcamera a while ago and have a dtso
lying around for.

Can you put this new functionality into perspective for lazy people
like me? :) For the ISI-case this doesn't seem to have any implication
right?

anyways, fascinating :)

                          martin


>=20
> With a time machine, we would probably redesign the CSIS DT bindings
> to
> model each output channel with a port, and the V4L2 subdev would use
> multiple source pads. Without a time machine, we need to preserve
> backward compatibility with userspace. Not only would the addition of
> new ports and pads make this tricky, they would also require
> modelling
> the glue logic between the CSIS and ISP with a subdev. This would
> conflict with the need to preserve backward compatibility.
>=20
> Fortunately for us, the CSIS is an old IP. The NXP i.MX9 series uses
> a
> different CSI-2 receiver, and the probability of needing to support
> an
> SoC that connects different output channels to different devices is
> extremely low. We can therefore implement a solution tailored to the
> needs of the i.MX8MP, and model the output channels as separate
> streams
> instead of separate pads. Should the need arise in the future to
> support
> connecting output channels to different devices in a new SoC, we will
> still be able to model this with extra ports in the device tree
> without
> breaking backward compatibility. The driver could then create extra
> subdev pads accordingly.
>=20
> The series starts with 5 preparatory patches to ease review. Patch
> 1/6
> adds missing register definitions. Patch 2/6 then switches from
> .s_stream() to .enable_streams() and .disable_streams(), a pre-
> requisite
> for multi-stream support. Patch 3/6 follows by implementing the
> .s_routing() operation, supporting a single route exactly as done
> implicitly so far. Patches 4/6 and 5/6 refactor the code to group
> parameters in structures and clean up how they are written to
> registers.
> Finally, patch 6/6 adds multi-channel support.
>=20
> The series has been tested on an i.MX8MP with libcamera, both without
> changes to verify that backward compatibility is preserved, and with
> HDR
> support (work still in progress) to verify that VC filtering works as
> expected.
>=20
> Laurent Pinchart (6):
> =C2=A0 media: imx-mipi-csis: Add VC-related register fields
> =C2=A0 media: imx-mipi-csis: Switch to .enable_streams()
> =C2=A0 media: imx-mipi-csis: Implement the .set_routing() operation
> =C2=A0 media: imx-mipi-csis: Group runtime parameters in structure
> =C2=A0 media: imx-mipi-csis: Set all per-channel registers in one functio=
n
> =C2=A0 media: imx-mipi-csis: Add multi-channel support
>=20
> =C2=A0drivers/media/platform/nxp/imx-mipi-csis.c | 551 ++++++++++++++++--=
-
> --
> =C2=A01 file changed, 429 insertions(+), 122 deletions(-)
>=20
>=20
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
