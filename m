Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE62E827
	for <linux-media@vger.kernel.org>; Fri,  3 May 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751358; cv=none; b=A3zaG40siWeZ1DrIsNkoV7CTp4hkTc0TIZjOkEA/muCMMAnGbmJ2cr4mvlGJHq3QFbqzw6cTJgFuugEzQctRSDj90Gj2nVC7frPSai84WGFPt4WloDhR/meiQsmec25EngXpnZO5oV7jsWmN2vMFuXiiUEIgU9fxSY7tTNk0yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751358; c=relaxed/simple;
	bh=ZrJX8JioSGMr0hzqImXGDk8tXNZG7wj/s09xQKuSZTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEj3Iih1aAi07X8wk4Ayf9Ls0TVTwE4DsUEWQPUDRPds1aQWKuI7Gur2gLLAL9dgmlf3k6RZHZwqbKX5hydzTKqetcX4h8ZEGk9wBV2Jw37FUDaaU9qFYebt74rU2QJk7lY8y9ZGkNAoUUqFQOPFloXgytStu6yCC7Myx2QWLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a65aVUoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a65aVUoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F048C4AF19;
	Fri,  3 May 2024 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714751358;
	bh=ZrJX8JioSGMr0hzqImXGDk8tXNZG7wj/s09xQKuSZTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a65aVUoeJGMXALekeS/AWEW+eNFUOA1PzI2gTKcCB8f7HknQJFewhQLr3KjzN0GVG
	 1EWQ/+DM/8X/rZNi/obuHipwHeV7zg62yx9waDEmytLLIA8Ia0Ef2AvAwgZjRjCSKo
	 7eNGxClkWLIOWXkBL+QkmPzKpdjn71WlXvzbA+qe7KuT4cAGuNPFRWW5HbN075dCH6
	 xKsCXUFJSyy1nHUpRBiwRJ9zWZBafkL+nkMir/3GhS1ImLhASAoVdROz4QWZWNcepD
	 553rTx4msLZRZsJtNOevxvTSWgzUSFoXxXpb7awDxL1Ydow8udypsxgKkoPnEAmNlA
	 +QhcEkY3tmjJg==
Date: Fri, 3 May 2024 16:49:13 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Yarny <Yarny@public-files.de>
Cc: linux-media@vger.kernel.org
Subject: Re: dtv-scan-tables: Gaisberg update and tarballs
Message-ID: <20240503164850.72e8ce61@sal.lan>
In-Reply-To: <75149976-693b-444e-b4cc-dd2dd86ea1d7@public-files.de>
References: <75149976-693b-444e-b4cc-dd2dd86ea1d7@public-files.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sun, 24 Mar 2024 11:07:00 +0000
Yarny <Yarny@public-files.de> escreveu:

> Hi linux-media,
> 
> please find attached a patch for dtv-scan-tables that
> adds a missing dvb-t2 transmitting station from Austria.

Applied, thanks!

> 
> Also:
> I'm maintaining the dtv-scan-tables package of NixOS.
> Are the tarballs in
> https://linuxtv.org/downloads/dtv-scan-tables/
> still updated?

It should be. There's a script which updates it once per day.
Unfortunately, the script had some issue (a library was
missing at the part which updates the kaffeine tables).

I fixed. We need to verify if it will work properly next time
we merge new stuff there.

Regards,
Mauro

> Or should we abandon that source and
> fetch directly from the git repo instead?
> 
> Thanks and best regards -- Yarny
