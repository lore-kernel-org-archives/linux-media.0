Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27F3043D5
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511303; cv=none; b=UO+8qsdLyDoqDrd0Bh60DnbOaekCe//fLVaYfvnZuQuqjP/CYejMvsxJvnSKn5q5BIzx4VyS4RswILfeecH4d0nlNIw55QicwtFUYnhv9Mrh7LXLwgrSiaXJ0zAGG8EdiMO+TiowoVVUV98oBr7OuC3MHoAeLdhoxx8Ivns29Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511303; c=relaxed/simple;
	bh=yKaAk9bGFJxWpNLpvR30z32s14oFUCOtOqIP8NWqOhM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkRtrMiHml58KyPkqRiMte0q8uvH8LOmZWCSESSDCNP3GCbRhBh0Z6WzqTesITEyioXVGz5fsNnsE3MezSPypv9LJ6U4mMxILxXZJoZX5JAp2cjcVFSBgfdW446/gRa86M28uQg1jsMk6ahBMSYa/ZE6YN7wQjLguBQf6fpLaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJha-0005dT-NH; Fri, 07 Nov 2025 11:28:18 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJha-007Vqa-1e;
	Fri, 07 Nov 2025 11:28:18 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJha-000000003hw-1ogW;
	Fri, 07 Nov 2025 11:28:18 +0100
Message-ID: <bc9d736366cd3cf567e89db95710bc8a0052e707.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] media: imx-csi: use media_pad_is_streaming helper
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michael Tretter <m.tretter@pengutronix.de>, Steve Longerbeam	
 <slongerbeam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Mauro Carvalho Chehab
	 <mchehab@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Pengutronix Kernel Team
	 <kernel@pengutronix.de>
Date: Fri, 07 Nov 2025 11:28:18 +0100
In-Reply-To: <20251107-media-imx-cleanup-v1-3-f82a693c28f4@pengutronix.de>
References: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
	 <20251107-media-imx-cleanup-v1-3-f82a693c28f4@pengutronix.de>
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
> The media_pad_is_streaming helper is explicitly for checking, if a pad
> has been started with media_pipeline_start. Use it instead of relying on
> the implicit knowledge, that a pad that has a pipeline is streaming.
>=20
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
