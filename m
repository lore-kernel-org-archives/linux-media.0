Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16F305960
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511283; cv=none; b=JQI9ifbiCwCqodNdmccb8VjOGf6NalypK9WSevWFjmKpOcdQ4s2maUuTdfUD7yl8eeerXG+RmzUrTSPDtbCuHLK6+tdtlakz49+U6tRBSN4e4wReSA/o3xRY2MgDB2Q+k1Namk1eHCJ0I6uEQs8fYHeuRersKVBx6eEjxnr/b0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511283; c=relaxed/simple;
	bh=d3nAVq26ABkLe7YbYTpBzgZzTSoZK7RuOBFNBuFqk7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCjWRLwWLG36DB1aKfXb8+obPmLgB4pkJUGa1NGrqXFAS9F4BMdnKIEULLO7gIbSnsGbQlwEaV4+gItKg1ZjubtyfvX9hYBneHK4if3dav4X1Gs/d8RFcQobs1jAtVzRTpZ7qxjPsonpvYhU+s0B+UvwZRZxYjQcqQbmVNJaxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJhF-0005T7-TE; Fri, 07 Nov 2025 11:27:57 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJhF-007VqL-0L;
	Fri, 07 Nov 2025 11:27:57 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJhF-000000003eq-02yK;
	Fri, 07 Nov 2025 11:27:57 +0100
Message-ID: <3f97f737c00ce9d82a6b54955241458d0f77c4ec.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] media: imx-csi: move media_pipeline to video device
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michael Tretter <m.tretter@pengutronix.de>, Steve Longerbeam	
 <slongerbeam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Mauro Carvalho Chehab
	 <mchehab@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Pengutronix Kernel Team
	 <kernel@pengutronix.de>
Date: Fri, 07 Nov 2025 11:27:56 +0100
In-Reply-To: <20251107-media-imx-cleanup-v1-1-f82a693c28f4@pengutronix.de>
References: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
	 <20251107-media-imx-cleanup-v1-1-f82a693c28f4@pengutronix.de>
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
> The imx-media driver has a single imx_media_device. Attaching the
> media_pipeline to the imx_media_device prevents the execution of
> multiple media pipelines on the device. This should be possible as long
> as the media_pipelines don't use the same pads or pads that be
> configured while the other media pipeline is streaming.
>=20
> Move the media_pipeline to the imx_media_video_dev to be able to
> construct media pipelines per imx capture device.
>=20
> If different media pipelines in the media device conflict, the
> validation will fail. Thus, the pipeline will fail to start and signal
> an error to user space.
>=20
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
