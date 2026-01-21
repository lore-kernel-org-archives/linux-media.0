Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFE320A20;
	Wed, 21 Jan 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960545; cv=none; b=CRT9xlNBe2+6uBxtgeQuUaP0wehtXFQUuXKwltenNZKFM1npXRkW72aNd5Qr8AVp7EZSl0/6UkaWCjC80xEP49MrMK7Cn3QtKH1XqNPnwM3eYlrolVQ5yQndznjimDm7u3gvAVaBaStxJeoaaYQ9kFV0MaaTucKll9AH9SjKYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960545; c=relaxed/simple;
	bh=PGWeRET9x9NwQjTr/PzV33RX/LFZSGDTwZRC8RPzxY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+K9SAQeX3PndtBU/YY74drQ46UKtHPtepTW3rKETeR4ZUhzruRQVzs185Zs7P8zTrtWOK+nNy9/wrSYvp4UNCwPCHO2dEmodsBUqxMda/wnIV9L9PfKul4mGav5C9ErErcsBRLocWQQmmWpycWxCauSbuIV2KkeK00FLED8DFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EliUVP7Q; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EliUVP7Q"
Received: from pendragon.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id A06F92D7;
	Wed, 21 Jan 2026 02:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768960503;
	bh=PGWeRET9x9NwQjTr/PzV33RX/LFZSGDTwZRC8RPzxY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EliUVP7QuKOFHt1hDvbv68y3XnK9uzkCVa7VjpfqBSqRGRCnrUv3NadKN2YJsSgYw
	 q0PClgEr1lu4d9bdfMIQizKY9eO4M9KC5ncbxiv5aux1JLjybLzuOEOB0WkK76Gavk
	 lN1BG4qYkYMARtB+i91EyxPhKxHfIJ71uYNAmoWw=
Date: Wed, 21 Jan 2026 03:55:33 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger-Novakovic <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v4 0/4] media: platform: nxp: Trivial cleanup pathces
Message-ID: <20260121015533.GD403250@killaraus>
References: <20260116-cam_cleanup-v4-0-29ce01640443@nxp.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260116-cam_cleanup-v4-0-29ce01640443@nxp.com>

Hi Frank,

On Fri, Jan 16, 2026 at 11:29:18AM -0500, Frank Li wrote:
> Some trivial patch to reduce goto at probe functions.

I've applied patches 1/4 to 3/4 to my tree. 4/4 needs a few small fixes.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v4:
> - collect alex's review tag
> - fix grammer in error message
> - Link to v3: https://lore.kernel.org/r/20251215-cam_cleanup-v3-0-a61995068f38@nxp.com
> 
> Changes in v3:
> - rebase to v6.19-rc1
> - avoid use __free() == NULL according to cleanup.h
> - Link to v2: https://lore.kernel.org/r/20251119-cam_cleanup-v2-0-df732cc83ff1@nxp.com
> 
> Changes in v2:
> - add new patch media: nxp: Add dev_err_probe() to all error paths in *async_register() helpers
> - detail change see each patch's change log.
> - Link to v1: https://lore.kernel.org/r/20251117-cam_cleanup-v1-0-6cd42872db79@nxp.com
> 
> ---
> Frank Li (4):
>       media: nxp: use dev_err_probe() to simplify code
>       media: nxp: imx8-isi: use devm_pm_runtime_enable() to simplify code
>       media: nxp: use cleanup  __free(fwnode_handle) simplify code
>       media: nxp: Add dev_err_probe() to all error paths in *async_register() helpers
> 
>  drivers/media/platform/nxp/imx-mipi-csis.c         | 54 +++++++--------
>  drivers/media/platform/nxp/imx7-media-csi.c        | 14 ++--
>  .../media/platform/nxp/imx8-isi/imx8-isi-core.c    | 16 ++---
>  drivers/media/platform/nxp/imx8mq-mipi-csi2.c      | 77 ++++++++++------------
>  4 files changed, 71 insertions(+), 90 deletions(-)
> ---
> base-commit: 49cc7b5d0dee386c44b51a90eb49037b2a1f5b2e
> change-id: 20250807-cam_cleanup-b6d90ba9dac3

-- 
Regards,

Laurent Pinchart
