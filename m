Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739C313538
	for <linux-media@vger.kernel.org>; Tue,  4 Nov 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272786; cv=none; b=Pv8u4wgrZAf67zFz2+4GVzQLze8weu8I/qui69H0YArMG9jsynsRa8NQeEn5fp04la1hQYKLeupufY2fN1a9cVwo4rS1hZgyNsWliyjYF6fgfD7tXT+Zo9yvtwXLwl9p831J1h2m+lfFqQEpG60kZlyOztUwqCNo1Mkgtu6S0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272786; c=relaxed/simple;
	bh=EhPNKWXcOC4wz99nX7zOq9HMTheZCFEjaub0QmjufR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZAYHaeh9JtpEWP76wbT1nlq9MyJjaV5E6c8lalu+uU07n+w3H0ndESY9eTPXfFQ8coGsdZcC8Xxvlu2gCXx/Qz3wZ8ovCkW36u+nXhzcsdh/7fB6X5+6Owdaim80yBG8gzDYI4epGJCuFeHlqzYYYB602BhrL4VenOEfFsAgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=BeAqfUtd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="BeAqfUtd"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2148ca40eso45943985a.1
        for <linux-media@vger.kernel.org>; Tue, 04 Nov 2025 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762272783; x=1762877583; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EhPNKWXcOC4wz99nX7zOq9HMTheZCFEjaub0QmjufR4=;
        b=BeAqfUtdB1UulzkJ+Y1YQzsc3D0PmjgBNpuEk49hvPM7yYWrM0orjBN70f/as5eqaC
         Ao0NdOy5mYyYHg3vzY/QXXSoiSha7Fn8w6YQIZRQ2dXEoLNpod0CJv9/X0a2pgbX32WY
         /7CW1AakNTM5hNa4BehpGmsaTJW4R+nZBx2tyvV+I/QXt8DMJcdpiwmWDCLemacnO9Md
         F0j+0KPjqXCEbPA5F5CyoQaWzQHUozcaNXXj/LP0v8NlUPMedPtgNbJ5fS6biwQziO+7
         zlulWyy2/Qg9B2L7IfGUee0LjfDVRlGgxRgae/TloJUTa1AlFU6lAkoqhJ2TLtTfgEAX
         cWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272783; x=1762877583;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhPNKWXcOC4wz99nX7zOq9HMTheZCFEjaub0QmjufR4=;
        b=NJ0mGlbmqEMHcK4Yw9groczpZtZlsxoP5t28QjcesP+XcVGbSdwL32qpFb5bXfk3X1
         P7uuYYyORGg2iqGG/4f+KG3iWCaDp0+yXbCfVG0XE6HQbtaMYXdJZ/mF8bEXN7G05L6Q
         8PxxpQJsI46WInNvCfQo3f0K5tL9Up2WGkgl6/WkVzpLwAEflgijjyYmZ7SIq684PaHB
         3QJAwUcKBGiAlzaVqsvhuiS+WsfgBZJXCthrb8RGRB2btVLXJcbhnFKmjUNr2YFEmLfZ
         bh1I/u3MnlnzMDoV5JL80bBbL8HOd0yGOO7qYkyWBU7RTIBg1N7yOqmO5ddva6qQfzJr
         zyWg==
X-Gm-Message-State: AOJu0YxJ9CtmmX12r8eQb8BdiUPSBEYtKvvRmQDMFOWGD6MLic14MABx
	Q0RGgEGxji6FJzCzoClGzWIU78l6f3PxazxSMZ5ULYocrZHlYQrs06CpZ8qPs4sVGzo=
X-Gm-Gg: ASbGnctARluP7X4snUPikjMJszQJcIZ+Jy8wOTKK7iXXS6HOYmRl+hYaAcDRU0yQ936
	qnsKSgJ6Rv68LqRUSDIbgYkzXbj2aqwmNVBuXZeOKgpZOZ6Ja0tQ3wyjDISzvHw2h88mdXVNo1A
	myARz/ZCsVdmMR9Ot1INJmo9e36TbBjjpUS/GbRNc7OmREc/lt4iEUPHvWdilXTd+MMNTXVrxts
	+kFQHu/x5ati75yUJxmkVsRt/B5hoGwTmGHnDkNjf+dpaBbi1IVc7NYxDoPPaMj3yOZ9W+M6ANv
	KKB37EWp3GdifZ80Zt5PitdHm2c3lRUeA/8gnt3X5SNShJNhRDatA0xBSZ8JCRqryzwlZv45sgS
	/yXQRkZYFUc4V2u3g4XVxThgIcoZIckiGJxd10YgD+KuT0YoSpDzxUF9JhbEd+cK7A2xHs88Bcx
	/zktFbJNnJdVW0CEVe
X-Google-Smtp-Source: AGHT+IHJNxRdepwmA70rIxH7CleHW+ih2OcQNUmhfvzupPYK5yYekte9k/E/acCX6TG/uH9ZccgQuw==
X-Received: by 2002:a05:620a:d8b:b0:8a1:eac9:a84d with SMTP id af79cd13be357-8b220b7f57dmr20914885a.44.1762272782998;
        Tue, 04 Nov 2025 08:13:02 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:ebd3::5ac? ([2606:6d00:17:ebd3::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f51ecd3fsm216022085a.11.2025.11.04.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:13:02 -0800 (PST)
Message-ID: <b6e6881197dc4c83e43ef5eb1f20c2bf1887d395.camel@ndufresne.ca>
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
Date: Tue, 04 Nov 2025 11:13:01 -0500
In-Reply-To: <540d98ea-114c-43bc-94c0-e944b5613d74@amlogic.com>
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
	 <b976b442-7d07-4fef-b851-ccd14661a233@linaro.org>
	 <540d98ea-114c-43bc-94c0-e944b5613d74@amlogic.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-kJqvtTvIehm+17QzwcKF"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-kJqvtTvIehm+17QzwcKF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 28 octobre 2025 =C3=A0 19:47 +0800, Zhentao Guo a =C3=A9crit=C2=A0=
:
> Ran 54/135 tests successfully
>=20
> - 52 test vectors failed due to interlaced or mbaff clips: The Amlogic=
=20
> stateless
> =C2=A0=C2=A0 decoder driver only support bitstreams with frame_mbs_only_f=
lags =3D=3D 1.
> =C2=A0=C2=A0 Test Vectors:

Is there plan to support it ? Most of the legacy content, and why users wan=
ts
H.264 around is to handle interlaced content. Its also not really optional =
in
the ITU conformance spec.

regards,
Nicolas

--=-kJqvtTvIehm+17QzwcKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQomDQAKCRDZQZRRKWBy
9G86AP9s4PfT2ZOEc7H8CSULI0fPz0RdFYmemyQn3wCh76IcygD6A5aq+z1GM0Eb
LOyvHiMpTuu/yzDSHPEMnVL2wN653Qc=
=yfQW
-----END PGP SIGNATURE-----

--=-kJqvtTvIehm+17QzwcKF--
