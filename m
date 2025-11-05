Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F6316919
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350689; cv=none; b=mElJ5C1mEQtUXfjVEMRQMKizfCGOp0V6sjLYZoMgtbz8dK+HKCJru1BYHLEO+oErHBV9zTpfLv1A5BZKvdS2INvZR7zLdWj7zdTKzoUHBdxDZCh2dshL//XxR1EhIR75gjzXVjxtJ9c0w/FWIe52dDAi21xAlpD60HsfLFhks78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350689; c=relaxed/simple;
	bh=zP41Rmpn5mMZPXrAIAfE+G59N4Vqeo9bSbuVW5Vwl9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZQUc+o2Nhc+CHJDPgSXebghkn7nvR8VrqUc9K3GEHdtmyoTT3C/w3PTQk3MV1/gqNbMPJNSrUHyCa+U3H1qosSrtF6rSvUcWjr6wHbt4txKp7nh+Ndd/Sxoq1ZSDxJ2yA1aKEDb7cmrwrTf9Ynesu31S8P449mcvVQ4CAfju7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=XJqh+z8A; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="XJqh+z8A"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88e51cf965dso982088485a.2
        for <linux-media@vger.kernel.org>; Wed, 05 Nov 2025 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762350687; x=1762955487; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zP41Rmpn5mMZPXrAIAfE+G59N4Vqeo9bSbuVW5Vwl9E=;
        b=XJqh+z8AprQdeWWVaS5BDhVHZbvRwsTpw2yaxVcGPy6Lszbpc/xb9PpgQcV6iRzHmh
         fC8gQDMzQ4cEyFcyhWYriJVTBDdTPRbvgKVQNFDzKQohrK2TBn1VBBTN803zsn89uYuk
         FEJq7AEiiNoyyMLmTpVUonDMasiPOSsAvhSLc1obGNu90ZmZIizzy7pto1qPB3hW5ASv
         9DLMewKqSwaXHbdVzAY5FyMiECtdNuY0O9b5WqkrSmG3LPa9oo+MayM5XsBKi1q/EgWk
         0CVSlnEDGJIl5l9FOnQG3CYHsz5pm5t3GiQTZqlFcEJKUUri+hb6FwETuhL8/1JuGLT3
         pXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350687; x=1762955487;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP41Rmpn5mMZPXrAIAfE+G59N4Vqeo9bSbuVW5Vwl9E=;
        b=b0H/4LSV0Jq+wgCo8w8aQGC8lQjJm7SBbJv/XYmpnKCGfZk27PrlOjt8F0B1B88skW
         +7Fy4nL/asBQfgwoHpB6j4WC/v9Gd5ccUMlVWE9Gh93ORRMzCCsrYIL0hovied8Y5OsB
         ZkC7Oy7Oo0GPYtr7tF4NbNSvNggu0XQTz6Jw7DARqHcqjCdGlNKL+0nHvcz/OkLvViP9
         UbFZZbkwLCWhZ0GnMuS0tl8kdv5yFh79Cc+sXn8uUvIICrSLfg4x6LJxmPvu1IHS1EvF
         jRMc0Qyv9J+H/28D8a078VTfZLYs+Qd4E09TjOMI2C8wl6JSmLc3axBpKzlhC6bf0Cj+
         HMoQ==
X-Gm-Message-State: AOJu0YyAAOhOaVU8LS2f7fyw9k8QrLUaSwhtGNrQxCNxT8ArlD+4Cd7E
	vK+QKgnHrsIq/ldpRvn7IKuLbd8RZsl3F4iAxt0Ei35jRslGDxYa6jtLVJDoSIcuddiNmSwGC/h
	MDtrl
X-Gm-Gg: ASbGnctw9Z9q7JX+qFPabOcGJdPJj1a4zKuf46081f/96ygsoGDka9l/C1vAlwWczwg
	TfyRsTmHYRSGT/NcHH+gx8VyQWW9r6f5NP0/l4VA4QfIYwOXwOMXk0hspZdHjjYGa5wJ/7Bzjvi
	s7hla8BOHlWDa2mX5wzSrM/HCFh0my9f5+V2DrDzZdNx93/LQpHCm7uOtAaBagHfCSLgDzU2GyD
	1mXjIj0ndIFOudBA+AeOWx8M0I+IfIYkVxmkmwTm14Sob+9fQh8hdfZXJbP0hGnrok7RnrH6T1J
	KhrEIcjhOfvOTC+0vVXXtyTCNY1pLExoxfXhwYw2x+pHWREYi1+nhIl6k8PgvWY3sZxVudfl1HA
	i6bxrk00j4AkHIN1BC6Bo9nIztwrpflm+kxHniwt1D0PgpcnXqgbxQ0UbDfzEvFZaj25T7xPdFS
	HiqoO6lQ==
X-Google-Smtp-Source: AGHT+IHjDb17WJE5ovnji+ZuOA/1CxRvnHlgllSFFQ/L3BHsKI5wbhqVXzK9pnt8K5pFCIhkgw4W3A==
X-Received: by 2002:a05:620a:4045:b0:8b0:f8c4:a5fe with SMTP id af79cd13be357-8b220c001f8mr430100785a.89.1762350686452;
        Wed, 05 Nov 2025 05:51:26 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ef24::c41? ([2606:6d00:11:ef24::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f5413f43sm432543785a.8.2025.11.05.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:51:25 -0800 (PST)
Message-ID: <6d046cef20dcef4eb14aba6fa89e30d303f6a1b5.camel@ndufresne.ca>
Subject: Re: [PATCH 0/3] Add Amlogic stateless H.264 video decoder for S4
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Zhentao Guo <zhentao.guo@amlogic.com>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley	 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet	 <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Date: Wed, 05 Nov 2025 08:51:23 -0500
In-Reply-To: <174ef722-99f0-440d-8eee-5dca086e13f0@amlogic.com>
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
	 <b976b442-7d07-4fef-b851-ccd14661a233@linaro.org>
	 <540d98ea-114c-43bc-94c0-e944b5613d74@amlogic.com>
	 <b6e6881197dc4c83e43ef5eb1f20c2bf1887d395.camel@ndufresne.ca>
	 <174ef722-99f0-440d-8eee-5dca086e13f0@amlogic.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-2cG765y6sSQkAAGLj2Ko"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-2cG765y6sSQkAAGLj2Ko
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 05 novembre 2025 =C3=A0 17:26 +0800, Zhentao Guo a =C3=A9crit=
=C2=A0:
>=20
> =E5=9C=A8 2025/11/5 0:13, Nicolas Dufresne =E5=86=99=E9=81=93:
> > [You don't often get email from nicolas@ndufresne.ca. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> >=20
> > [ EXTERNAL EMAIL ]
>=20
> Yes, we plan to support the interlaced and mbaff streams in the=20
> following stages. The decoder hardware can support interlaced/mbaff.

Perfect, let's focus on the core for now then, I have additional feedback f=
or
you on top of Neil's review, hopefully I can get these ready this week.

regards,
Nicolas

--=-2cG765y6sSQkAAGLj2Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQtWXAAKCRDZQZRRKWBy
9C7bAP9Qs1rNKbRgDkazxpbW2p5TVrPLZK8wjWZLZUY+/CCltwD+LgR3cm+8x2UQ
D82jlWcSVIKc5R+xySP7dgFgB+WISQU=
=2auc
-----END PGP SIGNATURE-----

--=-2cG765y6sSQkAAGLj2Ko--
