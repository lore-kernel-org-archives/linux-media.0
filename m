Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBBD23F40C;
	Mon, 10 Nov 2025 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807554; cv=none; b=Sc5j+tR9dQFPjK9W07k5RLDANncDQZ2djaxOxMikCUboBTP0F/q4YAT0GhkFpx5Zf5qKG935wQjvmdOa8gGZ2vDmy1kFFqTI5EDZ4s0vb80najtEuU7gcHReGyHW+RLssue9n58r624SUfBgOCIithe+IWz6sIB20UjwZ7gH6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807554; c=relaxed/simple;
	bh=0SD9Ewvk+/wZhTK1E9Nrbs9eHYimjnLTzygkomhvpS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGtqnzllJnTV0HYbrEbrV0MDSMWblsHibwGSzT+tuMwT02Hu3OqoxMtqPAgSeE8Adk0Rw5Ckug8PWNbLNbpTEQ7lJlB6RG/Z8FpKRZ1xzJwUbIA9xoA2oBOq9pwOFbLupXX47WS+D51dk3URsG5mLPVSykacEk5jpY9CXpzRONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Pxm3YZ/G; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Pxm3YZ/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1762807545; bh=0SD9Ewvk+/wZhTK1E9Nrbs9eHYimjnLTzygkomhvpS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pxm3YZ/GPdOMSnqh+znGRdNZSvJgB8KHEtFBAT+xWZh6jZ+G9qYw5olHTYCl55OvN
	 ljpAS5iluemR9/UdxFKVXuOGI96xvLz5TnlpTw1OJN51aZWfMibPiFX3m6WsKDQmJb
	 xki5mKrl9EAXUC1wN68+WM6Onvq83nV8F51lV5Ogd6C5PsksOXlDWBNNMGc2+K0m8A
	 tlj1D6K6YC0Jk1DXMqzlh5rokpnPv7iVxuwaR6pLiPiwjdZEFRMMxCTpRiVWsvyQZ5
	 GR7iyvQAYgsIkgGU+WaBG4pQenptaMiwT0o7TJIVvVbEBl3L7PKCLsMxy1aE7JWJip
	 e6yYGHLtCw2eg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 691901000D4; Mon, 10 Nov 2025 20:45:45 +0000 (GMT)
Date: Mon, 10 Nov 2025 20:45:45 +0000
From: Sean Young <sean@mess.org>
To: Johan Hovold <johan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ir-hix5hd2: drop unused module alias
Message-ID: <aRJO-egLSI8doikz@gofer.mess.org>
References: <20251017060626.8693-1-johan@kernel.org>
 <aRGsnubMhZYJI0M_@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGsnubMhZYJI0M_@hovoldconsulting.com>

Hi Johan,

On Mon, Nov 10, 2025 at 10:13:02AM +0100, Johan Hovold wrote:
> On Fri, Oct 17, 2025 at 08:06:26AM +0200, Johan Hovold wrote:
> > The driver has never supported anything but OF probing so drop the
> > unused platform module alias.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> 
> Can this one be picked up for 6.19?

Of course; I've sent a pull request for this, you should be on the CC.

Thanks,

Sean
