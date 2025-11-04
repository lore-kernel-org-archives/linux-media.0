Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D613B5AE;
	Tue,  4 Nov 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267497; cv=none; b=HhdJ4X9CyqOlUE7qlLhZ3S7owh6vMNcCEfDSb84NQs+2m6da8o+ALbtKxWb7x/l6c/5nfNivWcPkrAqObuAMBRHGt97Jk9lO+4ZBI2GfTJiP+hoNuN1FyOcWDUc+qAY8jh1gVbB6eATIGNOJuzYTcUl8V4m45Hvs1uUgRjkQ/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267497; c=relaxed/simple;
	bh=f3ejIycn0AXi0bJGiQdaeyg6Sqpx9krTgJjt1ejgngc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQooPAFfnIqnYMghxkIHBPP/qA95B7oJY0FLUHXK0yK871gxIgEl6YUR56v1ktQ0UQmGX2zqWTcF3U/TVyFqbS16+OA5VXDtVMhCC3FA+f40M3kKygbeDVoeRjjxTNqcv9Eru6Ldy3QYDAk0xIUtgqlq/XkMFIDjbi4BVY3cXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML8ntpJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML8ntpJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6700FC116B1;
	Tue,  4 Nov 2025 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267497;
	bh=f3ejIycn0AXi0bJGiQdaeyg6Sqpx9krTgJjt1ejgngc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ML8ntpJwL93/nZj6RydMzvMxZYQVpOl093ecp98vQxmG2b22iCv5EsEoLI/M13NU2
	 rjd/UnzDD1IwN56bEhNu1a7VDRdzxzZrXyKqWLDotI0434wOzylBTJRYD3j6CPQ90z
	 ewJWRrCLKascYZ2jsFR6NjAUeKP4PHuCaFNCzdOmz6JJeQVrJ+UXouKcCwkkOQOQDw
	 j2BxkKS7wbaF4BOoaouw90MS6hyCmAEVMB1BmI/Ets/5Ea2ttLyViFflbQoPtfCd46
	 hhJBS+cJDNuD0sd8OnCUichavzge9coCn+vWZLENPvdaN0LBdn5zkNXhuIyMfUbjE0
	 wS7Wxz4EinAFw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vGIHM-000000003dT-0Dlb;
	Tue, 04 Nov 2025 15:45:00 +0100
Date: Tue, 4 Nov 2025 15:45:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: imx8-isi: Drop unused module alias
Message-ID: <aQoRbFfo8jTdJZiT@hovoldconsulting.com>
References: <20251102234438.8022-1-laurent.pinchart@ideasonboard.com>
 <aQnRsVPq1ndQrLr_@hovoldconsulting.com>
 <20251104143636.GD27255@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104143636.GD27255@pendragon.ideasonboard.com>

On Tue, Nov 04, 2025 at 04:36:36PM +0200, Laurent Pinchart wrote:

> How about the following commit message ?
> 
> 
> media: imx8-isi: Drop unneeded module alias
> 
> The imx8-isi driver has a module alias named "ISI". This is not
> required, as there is no reason to load this module through an alias:
> the device is probed through OF, and the module has never been named
> "ISI". Drop the alias.

Looks good. Feel free to add my:

Reviewed-by: Johan Hovold <johan@kernel.org>
