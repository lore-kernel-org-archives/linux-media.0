Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F5208AD
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762320325; cv=none; b=jEZ1I3Y5Z4HIMNYixOZnMyufYxMvZ22fCoLwoY/T+IUylO2Rw7jIkkVI+8CrLqnJDQT8t4+6x32yGi1wLcB6DSTJ2A8M/fE8/DEheiRO3cNe6MyycPgHFH2pzJSIh+eWGKbBHbj2tUFxjYVzw7ROvkVGjr31BIe4kQVSe37uRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762320325; c=relaxed/simple;
	bh=nRMwFMEWMHAhXv22jHJnc40mE6Yhluo1ZmkZgMNgnNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NDnJ4bDXHW27myjbqOmvNT77QWZaMqdsF01649thHXxzF/SIWUA6emJ7EB/flx7VtZ2YZlJ9jH2BTjKsS2RM8neyPu4a8eShtfbKFACD3oRbWVAM+YswNOGywYfuEj6mUm1Vh9UBy/Pat8CawF9fN5B47zl65TxkMWz85LkHokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 9C594C3EEAC9;
	Wed,  5 Nov 2025 06:25:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 9C594C3EEAC9
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: linux-media <linux-media@vger.kernel.org>
Subject: Re: i.MX8MP Hantro G2 HEVC decoding problems
In-Reply-To: <1cb18a0bbf503db78caff09042283df560dc7b07.camel@ndufresne.ca>
	(Nicolas Dufresne's message of "Tue, 04 Nov 2025 11:22:26 -0500")
References: <m31pmfp6j3.fsf@t19.piap.pl>
	<382e94e1b932938fffd92ead86cf057b4623417c.camel@ndufresne.ca>
	<m3seeunrlg.fsf@t19.piap.pl>
	<1cb18a0bbf503db78caff09042283df560dc7b07.camel@ndufresne.ca>
Sender: khalasa@piap.pl
Date: Wed, 05 Nov 2025 06:25:11 +0100
Message-ID: <m3pl9xrqyw.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

Nicolas Dufresne <nicolas@ndufresne.ca> writes:

>> From time to time I'm getting:
>> hantro_g2_irq: 0x80100 masked 0x0
>> hantro-vpu 38310000.video-codec: not all macroblocks were decoded.

> As for the remaining error, it matches my observation. Though, I strongly
> believe its yet another hidden problem in the driver. More research neede=
d, that
> hard part is being able to isolate the bitstream that triggers it. I have=
 very
> little information about this specific error, most of the time, there is =
no
> evident visual artifacts (so its not really broken for the users).

I see. I don't know if the above IRQ status comes with artifacts or not.
What I have is a printk() in the logs from time to time. I'll let you
know if I have a stream reliably triggering it.

Thanks again,
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
