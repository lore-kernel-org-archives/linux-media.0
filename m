Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B104332EA3
	for <linux-media@vger.kernel.org>; Tue,  4 Nov 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273350; cv=none; b=cV+eTEyuVK8FOPPsqo5ME3LFb1iy0Qit1hmxcrwCW3zRaEhfrk7rK4TT1FpbRpUJspdwg2qr49PeMfpMuJ51T/VN/wXl39lZZESfnTJNUGbxtHD+Z0bah3niOcV0pNOQRbvHXWzGR1fUyqutEqDm9DAhIQ8d68VbFAB7auM/SCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273350; c=relaxed/simple;
	bh=hdCT5TXMVwZ43iLPpU8lJqSTQs6Rvih8gdvxvVscQFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSN4wBFcA/E9l2yFdQwxvJI3wIhA5L6gEcrBTBkXs5/M024QexHNfKu4v2qeGosL+l+KP3DKq5id/1wzcVDt9qOLuE5R3tZQ03ivR7DjR3u/eyrE5Ytlq/xM9hkeqs4empULNBcBrVu+n1ylVazb80phoWJIrTwENkf1GtNjZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=c9KaCtvm; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="c9KaCtvm"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-795be3a3644so36614596d6.0
        for <linux-media@vger.kernel.org>; Tue, 04 Nov 2025 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762273348; x=1762878148; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hdCT5TXMVwZ43iLPpU8lJqSTQs6Rvih8gdvxvVscQFA=;
        b=c9KaCtvmA8iJ1kw9RrljOmi/BITtd8GvF1MbHxJxttfKz1k4iapUA/ML+pKyqoWyf4
         p2fQp1OItm82ymZz/sSFhvO5WEFftofwdYOtFY9f8IhdV6ng+wwzPNEexx2KWvCF1zL+
         t0H+/GVz9in8Sg9OclY/vi6+n0RnbPLdQj6Qpn4eXUh9bvtY47+fC8xEDmBnzmMVmU3y
         WkVZKzw9LFsQ3WGrcO2gaLddHVyYy2LrsD98mMt2BEBtUYE4JvkGg7b5EZ87svtjAXW7
         9TBQ/rYriynJFTMSSfOIK0N7U87q1A/DI8qZ8YbpML2kSv+oT5W6W62ZDHgIZOG+okj2
         hD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273348; x=1762878148;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdCT5TXMVwZ43iLPpU8lJqSTQs6Rvih8gdvxvVscQFA=;
        b=aMWlvE6nkR1VYsttyYwW9ki/jdmdzgn78HSlzIzaVf+CFQRlCVthGnecYAiMCPMu14
         eNNlnEwfGgN4rqAzaZMe1H1CMOP0DFid4FpjdBDE/6NNrtWQiH3vQOtbscg+QAZ97ir9
         rKstbeFhpNlF+cQYtT6AESn1tUEWOrHC6rwm/2leRGYjHWMqOa+4kREdKVQd38WipQaq
         bYn9IrqShUYTfR/y86yJnTdS1wv96ujpPfjKr3aSt9qyKarGjEQ5q3A72xsPZHLAqrWI
         cUzY1KOalGWSRpMZPuVInIPsjdjkE/YUnDdKuvnNWjlXMzKRgGVBXGIaXCV3BbyMcMYh
         WQYA==
X-Gm-Message-State: AOJu0Yy04lFgbML0iznT92dDBZdH7UHvY6ni9GUWk1NfD9cWduughogU
	+DhfsUZE7yrrI3sF3T3nFfTFAnpJT21FfOSB3nffoTnm2iQSHq7In2RV1D4Y7dvfdWnN3gG5KO7
	Ramhy
X-Gm-Gg: ASbGncsLdD+1EH7fFrsse/0VQcllhDvUnSy51lloIII72RV392cdHzILRtxRwfM12hb
	e41WqRhibO4TNCdIer5x82vACRIyvH2ezH9aH7RgQCGMpLmnbzc5NnHWZdJhlGrSrdXaCjDA8Vg
	gKcfrcu7mOfqNzkaHa1wbvyjGi/qzIT5O3UIyLe1OfuL+zWy3gtX8NgBryrkz5YsNRvDGVypmpD
	0kWtnJC95IAphzOzifTffxpQWWo4235TmKG23apri/qBRyWMv2Cd08XZyc14Uwezfk/c2ZbDtoL
	VS4e2J2sh/SWpy9Qn4M2tyEbmcIgPucDMUMGww2RtoZj1kPAeWAMzxUripildSnwJI74NuNnPov
	PhTOy6BIGdDIeTJ36D7ZQfpZj6P/k6ucA/CGSbL8u/08d3T9cD1ei+euh1wyzrrw3UIpsq2KQl2
	qXBSo1Tg==
X-Google-Smtp-Source: AGHT+IGB1DARU+d+HVVT2IF+mZGJFO3yC7h+M8Yx4vf5VJANWGaEs2TUU/dzb+PGPA4vuknu6uI7tA==
X-Received: by 2002:ad4:4ea3:0:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-880711850d5mr2889446d6.43.1762273347663;
        Tue, 04 Nov 2025 08:22:27 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:ebd3::5ac? ([2606:6d00:17:ebd3::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060e90058sm22714486d6.46.2025.11.04.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:22:26 -0800 (PST)
Message-ID: <1cb18a0bbf503db78caff09042283df560dc7b07.camel@ndufresne.ca>
Subject: Re: i.MX8MP Hantro G2 HEVC decoding problems
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: linux-media <linux-media@vger.kernel.org>
Date: Tue, 04 Nov 2025 11:22:26 -0500
In-Reply-To: <m3seeunrlg.fsf@t19.piap.pl>
References: <m31pmfp6j3.fsf@t19.piap.pl>
		<382e94e1b932938fffd92ead86cf057b4623417c.camel@ndufresne.ca>
	 <m3seeunrlg.fsf@t19.piap.pl>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Rq3bZvANQpAejUmCgceM"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Rq3bZvANQpAejUmCgceM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Le mardi 04 novembre 2025 =C3=A0 09:12 +0100, Krzysztof Ha=C5=82asa a =C3=
=A9crit=C2=A0:
> Hi Nicolas,
>=20
> > In queue for the next kernel release, we have a rewrite of the IRQ hand=
ler:
> >=20
> > https://gitlab.freedesktop.org/linux-media/media-committers/-/commit/19=
c286b755072a22a063052f530a6b1fac8a1f63
> >=20
> > The important take away for this chip is that it does not always stop o=
n
> > errors.
> > It can also raise a dry IRQ (I don't have explanation, only happen on I=
MX8
> > boards). The new handler properly check if the hardware is still runnin=
g,
> > which
> > avoid programming over a live IP. The G2 has fancy internal clock gatin=
g, so
> > doing so can lead to CPU hang if the register you set is hooked to a ga=
ted
> > portion of the IP. At least this is my mental model of it.
>=20
> Right. This patch seems to fix the crashes. The (possibly badly
> transformed by GStreamer?) HEVC stream isn't displayed correctly yet,
> though a direct HEVC 1080p RTP from camera is now ok (certain rate of
> packet loss is possible here). Then:
>=20
> > And there is an important bug fix for missing references, without that,=
 you
> > get
> > thousands of error IRQs while the IP is fetch from address 0x0 and its
> > surrounding. This large burst of IRQ, combine with multiple memory rela=
ted
> > erratas of IMX8 boards cause random other things to fall appart.
> >=20
> > https://gitlab.freedesktop.org/linux-media/media-committers/-/commit/47=
825b1646a6a9eca0f90baa3d4f98947c2add96
>=20
> After applying the above, the stream from GStreamer is fixed, too. It
> seems it all works fine now.
>=20
> From time to time I'm getting:
> hantro_g2_irq: 0x80100 masked 0x0
> hantro-vpu 38310000.video-codec: not all macroblocks were decoded.
>=20
> But I guess it's due to my network setup.
>=20
>=20
> Thank you very much for your help. You have saved me a lot of work -
> a work with an uncertain outcome.

Glad my recent fixes helped. These fixes took me several weeks to find and =
fix,
now be ware that the IRQ coding pattern needs to be extended to all other h=
antro
cores type, its in my todo, but not has urgent as it does not break as badl=
y.

As for the remaining error, it matches my observation. Though, I strongly
believe its yet another hidden problem in the driver. More research needed,=
 that
hard part is being able to isolate the bitstream that triggers it. I have v=
ery
little information about this specific error, most of the time, there is no
evident visual artifacts (so its not really broken for the users).

On another IMX8, the MQ, we often see the display controller fails at the s=
ame
time we get this error. Though, the MP have a bit less problems, I believe =
the
memory QoS is working and the that interconnect does a smoother job at load
balancing the bandwidth.

Nicolas

--=-Rq3bZvANQpAejUmCgceM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQooQgAKCRDZQZRRKWBy
9MhnAP9AvvnmOGZU0XWU3NDRP+uEN04awDa31A1sSw2ZE6toAwD/ZchOaRso3TCF
tN7iDNcdfM6BJTmA5324FoOHPCxahAY=
=m0qD
-----END PGP SIGNATURE-----

--=-Rq3bZvANQpAejUmCgceM--
