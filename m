Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9072E8B8A;
	Mon, 10 Nov 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765983; cv=none; b=oE0azX/vy7p/vfD38vHTHuYOGpFXNs4Xivmy6w8bWM6O/zfNHvnzhQpibrpD/kulBS7RzrY+6azoIUjqatf/xWfXAZcltAe7vXo/Q99s7p9EM/JeiaRk/PkaQwMElL449Co+YwB4Ucs2Xp0qIQ14lEe12rZadLP6iVAlU5OIA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765983; c=relaxed/simple;
	bh=CBbrF25WexVPVqWbQZIvNNnC1kHvcOHXVQ9kczKy/dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvDYOM36U/EUdr22DzB2tcDcDQb2r/qgnVtBFq6D/NiFMWjhfED1pSYrm5bPNM4oG2zqzlgcPm6TQGQbKVsTRods2oCl0L0iHhVvF04jEdwLwhXMUNvd9Yr1BgRMX3I7ZoRL7jB2GsfETpCq3BdNScS6hriw88R7G/ZLpVWI2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkhPS3Np; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkhPS3Np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1C5C4CEF5;
	Mon, 10 Nov 2025 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762765982;
	bh=CBbrF25WexVPVqWbQZIvNNnC1kHvcOHXVQ9kczKy/dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkhPS3NpmX9MdWJ+lidwRaKKh/g7/M+TDpMCtS9s3kzrpIQ9ElC0Is+Q+woPCkkzO
	 NvODfxSYHfGbElGmlI+6Ta+OeEJHIjXL10Ip5pcjfraQcKD7hiI/R1B6MYl+1Iwun5
	 7Ucum9GLBDvq2GfrWSIjEZIZtLyk28JaGmZqRNvKdHhoMr1zyozmIJR6YzpR3LNvLY
	 JJ/93J6Kpr3J89UV1MDwkft+/ZYqu/IdaHY53DHuyAOwKDDa6Y6+aohmOvsCSbKDNn
	 qY7wJJjUtdz6Z6eB+kwKUZmjxVa4d56dsM74LQkAvbjpnBHzPu53ZdZD6r1ttJTqQO
	 m7wibWHzSuH+w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vINxO-000000008Ek-2nBZ;
	Mon, 10 Nov 2025 10:13:02 +0100
Date: Mon, 10 Nov 2025 10:13:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ir-hix5hd2: drop unused module alias
Message-ID: <aRGsnubMhZYJI0M_@hovoldconsulting.com>
References: <20251017060626.8693-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017060626.8693-1-johan@kernel.org>

On Fri, Oct 17, 2025 at 08:06:26AM +0200, Johan Hovold wrote:
> The driver has never supported anything but OF probing so drop the
> unused platform module alias.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up for 6.19?

Johan
