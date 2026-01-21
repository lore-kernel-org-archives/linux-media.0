Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B2246797
	for <linux-media@vger.kernel.org>; Wed, 21 Jan 2026 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965268; cv=none; b=gudinw2D5Q+lwfz6otfJSWuJEqWyarcLG4Z/x8YXHvNTIHG59AlSue4SWOzOw2nJuZ7EfPghQwnjPgW/tXeCra6ajz1kqc0TXbM9ZbU0wD5QdDHnPEOlh6+Y/B/ZqGzXWw+KUsVWdORRwWoebwVmhI1WJkH/yMjYMWJyiBx61gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965268; c=relaxed/simple;
	bh=ZkRErDQKkDzm4pY6pXa53KV1oHliSJ6eJ85GcBi6B1M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EuQ5cBZ4Ot1zG4jA5RNb3eoL4RCxHm16MgtaZrIizkOLYkpFNKhKo+72rS7pb72M9Yvf3FcSy69lPvLbi4mZx+2G/TXA5PXpNnAIs1RW8fMgOaKXqzh2MEhjaOj4dMQVf3/2FNIo7wFvPRrx1GNM3/WVI/kFVacwW96GwieY0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nt/yE4Ik; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nt/yE4Ik"
Received: from pendragon.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CEF96593;
	Wed, 21 Jan 2026 04:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768965233;
	bh=ZkRErDQKkDzm4pY6pXa53KV1oHliSJ6eJ85GcBi6B1M=;
	h=Date:From:To:Cc:Subject:From;
	b=nt/yE4Ik/G+27XYjXD+uCm2Mgu/Nb+gvmM9zlsCTPG9h5kR0QXycB7RwFN+HermaU
	 pu3M1k0+643chTaleVmXGN8fKZohBTZZEGwKS0NBBtawcWMaN2dh6VL4hlpmPnrS5L
	 nH5vRouZ1U34Cbe9oaywNT1rY3na9Opg+VkEA1/E=
Date: Wed, 21 Jan 2026 05:14:23 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hans Verkuil <hans@jjverkuil.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rui Wang <rui.wang@ideasonboard.com>, linux-media@vger.kernel.org
Subject: [GIT PULL FOR v6.20] NXP media drivers changes
Message-ID: <20260121031423.GB409142@killaraus>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Hans, Mauro,

The following changes since commit dde659d37036c6edf5eeef81274b43fe12dfad53:

  media: iris: Introduce vpu ops for vpu4 with necessary hooks (2026-01-20 16:22:24 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/linux-media/users/pinchartl.git tags/next-media-nxp-20260120

for you to fetch changes up to a26a438dc814fdffb6f53add5296dde3f4d3b3a6:

  media: staging: media: imx6-mipi-csi2: use devm_platform_ioremap_resource() simplify code (2026-01-21 04:16:50 +0200)

----------------------------------------------------------------
Improvements to NXP media drivers:

- Fix filter configuration in rkisp1
- Discard pm_runtime_put() return value
- Simplify code in various drivers

----------------------------------------------------------------
Frank Li (6):
      media: nxp: use dev_err_probe() to simplify code
      media: nxp: imx8-isi: use devm_pm_runtime_enable() to simplify code
      media: nxp: use cleanup __free(fwnode_handle) simplify code
      media: staging: media: imx6-mipi-csi2: replace spaces with tabs for alignment
      media: staging: media: imx6-mipi-csi2: use devm_mutex_init() to simplify code
      media: staging: media: imx6-mipi-csi2: use devm_platform_ioremap_resource() simplify code

Laurent Pinchart (1):
      media: imx8-isi: Drop unneeded module alias

Rafael J. Wysocki (1):
      media: rkisp1: Discard pm_runtime_put() return value

Rui Wang (1):
      media: rkisp1: Fix filter mode register configuration

 drivers/media/platform/nxp/imx-mipi-csis.c         |  31 ++----
 drivers/media/platform/nxp/imx7-media-csi.c        |  14 +--
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c    |  17 ++--
 drivers/media/platform/nxp/imx8mq-mipi-csi2.c      |  58 +++++------
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |   5 +-
 .../media/platform/rockchip/rkisp1/rkisp1-params.c |   6 --
 drivers/staging/media/imx/imx6-mipi-csi2.c         | 106 ++++++++++-----------
 7 files changed, 94 insertions(+), 143 deletions(-)


-- 
Regards,

Laurent Pinchart
