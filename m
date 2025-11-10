Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B792E8B83
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763012; cv=none; b=JUusjuFS8wTCrguwq4lqS1bik2D+0AwIHPEkcjHn8KH/PpHtZC4UG75mWqNhOZN/bx7V6uptU0vqTz/do+Ctd2l4e7FDp5I3oEZwPD26ikHnLgGeEXgu4MBOaCpoSzeS+PRImKsKNL8L7s5tXUu3wV4ubG3rwdmWkR3RoiriGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763012; c=relaxed/simple;
	bh=df094fQFKVW5CYPMljAhSh/S5b+6dOd3Q81MPy5kS9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VLs4GeZPcJqfocHgjnvy0Yt18CiXnxg2/r024LQR3J1gHEUZvfoHdo8GLnY5BdKAQHt2dFr/7ghK3ZQqHthBZ9+ENywgBcpExQPkLVh7Qgn8cp38ApE8nkxpd+ySoR0j2fl/e7TdqvaR5/IodOtoszbNZwzYdKDKMrZspLTXRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINBI-0005qH-VN; Mon, 10 Nov 2025 09:23:20 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINBI-007zQD-23;
	Mon, 10 Nov 2025 09:23:20 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINBI-00000000449-2GKK;
	Mon, 10 Nov 2025 09:23:20 +0100
Message-ID: <213e291cfcce29969fe6addd35c6c633289a5270.camel@pengutronix.de>
Subject: Re: [PATCH 4/6] media: staging: media: imx6-mipi-csi2: use
 devm_mutex_init() to simplify code
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Steve Longerbeam <slongerbeam@gmail.com>, 
 Mauro Carvalho Chehab	 <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team	 <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2025 09:23:20 +0100
In-Reply-To: <20251107-stage-csi2-cleanup-v1-4-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
	 <20251107-stage-csi2-cleanup-v1-4-5d42535243ac@nxp.com>
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

On Fr, 2025-11-07 at 15:44 -0500, Frank Li wrote:
> Use devm_mutex_init() to simplify the code. No functional change.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Although I think this should come before patches 2 and 3.

regards
Philipp
