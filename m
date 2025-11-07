Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AB283C8E
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511807; cv=none; b=rpLPGIcCWWWpL0K5zBNqyW6c3AkgOh5sOnj1/LuKoHHYmPBsNC5aWdVRH/n96dUgWoDh/PttiOsH3TbQ9jWSvWpqw6jRTT3amWwqSwMIGcu0DVPzCByCXUBAM8l21ouVxxvFbAmt2RWFvOYWknHDrllVIgSrz15eZm7ZoTOhc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511807; c=relaxed/simple;
	bh=292WAxpEB52jiI3fHCRPNW1lPGzvVg2oecSIVi2nkiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRFh1cnUjQHLeuXdTrPDqXYFjpZvmIPWoMogDFSlXHKlpMTP+Xp/z+HxKYQWG7HR9Ua9oVaXoRka6TOi99R8E0c+wKilqLXt+4dtilr09vH2eaiMLMGI7byVwHXoHC4RpvXMY3OvsBrcoBllGzXJ2mPktXC+pUxD+nZ7PaWUAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJpc-0008OG-Nu; Fri, 07 Nov 2025 11:36:36 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJpc-007VwC-1L;
	Fri, 07 Nov 2025 11:36:36 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJpc-0000000041J-1PL2;
	Fri, 07 Nov 2025 11:36:36 +0100
Message-ID: <85335f1cd661741594316c68457a9b943d0d50d1.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] media: staging: imx: request mbus_config in
 csi_start
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michael Tretter <m.tretter@pengutronix.de>, Steve Longerbeam
	 <slongerbeam@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Pengutronix Kernel Team
	 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Hans Verkuil
	 <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Michael
 Tretter	 <michael.tretter@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Nov 2025 11:36:36 +0100
In-Reply-To: <20251107-media-imx-fixes-v2-1-07d949964194@pengutronix.de>
References: <20251107-media-imx-fixes-v2-0-07d949964194@pengutronix.de>
	 <20251107-media-imx-fixes-v2-1-07d949964194@pengutronix.de>
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

On Fr, 2025-11-07 at 11:34 +0100, Michael Tretter wrote:
> Request the upstream mbus_config in csi_start, which starts the stream,
> instead of caching it in link_validate.
>=20
> This allows to get rid of the mbus_cfg field in the struct csi_priv and
> avoids state in the driver.
>=20
> Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
