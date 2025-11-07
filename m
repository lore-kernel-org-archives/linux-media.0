Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE033054F2
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511297; cv=none; b=X+JQoEfuEx8QfWuMKClcgKDopl5UctpXflh2Tsw8+HUX1r5O7X95IIESC0+RCQEz9axxz6aQ9y+20F8DgJmbMzZl+0TlKNry1LRV1sk/X+tNJkE61Fc59Z0NUamlE3WXF+R/RYPRIxiM194xHvsv6XuB42VKZ7O3qlTKWyWlMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511297; c=relaxed/simple;
	bh=r5pS+4bEmRoRUM2DRztyodk0Lbb3HGgXQieKfomHaaU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GhSLAPSdkJrWEnK7zgyvGaVe4RRu7rm6apOW4Ir9ux5Tfh6c0iaO3tEcc2RMHsPWMBH/cGrEEdJNRFrN3Im1Bgd5aIGFer9d0150CPLxPKeb2LmqD300w/9XnwogLwphV+FlFCcsL1VWFW3A4dU2WhL6Fwv4WupumgW4Q52zGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJhR-0005Xe-2b; Fri, 07 Nov 2025 11:28:09 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJhQ-007VqR-2U;
	Fri, 07 Nov 2025 11:28:08 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJhQ-000000003gY-2vNj;
	Fri, 07 Nov 2025 11:28:08 +0100
Message-ID: <065cc19c76bcd19a3919e77df4ead48952181a33.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] media: imx-csi: explicitly start media pipeline on
 pad 0
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michael Tretter <m.tretter@pengutronix.de>, Steve Longerbeam	
 <slongerbeam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Mauro Carvalho Chehab
	 <mchehab@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Pengutronix Kernel Team
	 <kernel@pengutronix.de>
Date: Fri, 07 Nov 2025 11:28:08 +0100
In-Reply-To: <20251107-media-imx-cleanup-v1-2-f82a693c28f4@pengutronix.de>
References: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
	 <20251107-media-imx-cleanup-v1-2-f82a693c28f4@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org

On Fr, 2025-11-07 at 11:16 +0100, Michael Tretter wrote:
> entity->pads is an array that contains all the pads of an entity.
>=20
> Calling __media_pipeline_start() or __media_pipeline_stop() on the pads,
> implicitly starts the pipeline with the first pad in this array as
> origin.
>=20
> Explicitly use the first pad to start the pipeline to make this more
> obvious to the reader.
>=20
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
