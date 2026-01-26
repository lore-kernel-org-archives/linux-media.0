Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AC2C0F7A;
	Mon, 26 Jan 2026 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458348; cv=none; b=P32ljwYhh56rbS9N7s6YAKVfzXA4iuldyXpycVQzunXt4/MgpPYBZ7f+Qg+GGH0OgB/SjMRsKcPjAjBGCAJoSuBSC4DdZvfAbNAdKIIm2Zp//lGWC8GZbu8OP/ta3Fu0nkaiuD3+EAZETNoWPgxcn6kRc7C5p8CWtm+Eln7EyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458348; c=relaxed/simple;
	bh=0MZV5SHpXgj6efswXu26trmZTETx0ryITD+Xi5KLVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1TU2vFdGOlDpJnDhfUJkthui/AUD/feeLAmxeH4UumshLLaAtrFURJpCuyuNoE3arpQrew+2q+RQlARFLJyne4nqIJdZApfh7nGZLmyOphwRQTBnTufTP+WKsQKzzvDoFR7pCfy8V1Zxn/y5tQmnxV0i4nT2ZpNnOFRK7LLiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYQatx95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYQatx95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02776C116C6;
	Mon, 26 Jan 2026 20:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769458348;
	bh=0MZV5SHpXgj6efswXu26trmZTETx0ryITD+Xi5KLVRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYQatx95c50mfrwwpQ3Cc58z6xeEu6S0TK0ysj81kiNsRRbPatYhtQ7BqyvrE5rxI
	 hm1agJNNj3E9xD4T8jGw4oxWUyar+tcmg8PtJt6sH0MFps4K/BTL7yad5/+lmzbkul
	 dR5l2IO1420bv3ca6zug4CZhcVR91UmgID6cEDPcph97ohdB3WZlSFMqXUhh3W35bF
	 xqtJ2w0VmQNRiyEyN498TcgihbjVybLfQTVk7/757sDfZjPfmOr7q57wm/LEOK/ROt
	 UsGAEdxMt6heelw7nBUmlvNdXhuzk6WIBxz1w9kIstfRW2RqqJEeENZNcuRbEov6yl
	 CquEebUcTzLLg==
Date: Mon, 26 Jan 2026 20:12:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: media: mt9m114: document MI1040
 sensor
Message-ID: <20260126-scholar-trolling-187f708aa0b8@spud>
References: <20260126083430.8247-1-clamor95@gmail.com>
 <20260126083430.8247-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mo8s9FnlqzFwYsoS"
Content-Disposition: inline
In-Reply-To: <20260126083430.8247-2-clamor95@gmail.com>


--mo8s9FnlqzFwYsoS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--mo8s9FnlqzFwYsoS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXfKpwAKCRB4tDGHoIJi
0mP3AP9dngbCGsrtFo1mk2d2A5CHMLyEHaWMxcrVrei+O46KOgEA+M8sS03N8Hz7
dka8PGOvWAJs7WiojuDl6eGAxxZHew0=
=Y/sv
-----END PGP SIGNATURE-----

--mo8s9FnlqzFwYsoS--
