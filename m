Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9136C5A0
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883574; cv=none; b=Pq6VZV7HhTdXgWo6hpAF6d53cpMXFszsdWPrkKcPJFQZmkzjOpYQ3LtIudSi5SLYX9n2YBzFxr8An/9Yi9ZbWl9yhaX2DqSyt9xzoWkIDFCdSRN5X/VgxrsqMVIKvgHoHA6VRVU/73WYyZY4jvcp0UyOTo+NKZTZhz3LO0sAenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883574; c=relaxed/simple;
	bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf8QKMbSL2gOAohj/Y9OfvzwK5CRJUvXY/WpLLN5zN+lq6FS9ax+pSzEqT0QSe/pMUSmuRGon4jLgfHGVowLzbWI8P2Tgpp4hhupCB3b7r2wCoI2Pes61QsI0WW9exH3kZoeZ1TqRD4d3XMatraJlPthzVKeQzEQeG3aIMPIPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j0uuJRWx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j0uuJRWx"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso8312966b.0
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762883571; x=1763488371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
        b=j0uuJRWx4TCgzGcs0iQ/SY+Rz3bHmVL8AO9iaZEmEfl2Hvk3Rq1JTDY0Avo9eNwBF9
         g4jcgzz2Zn+9VuQKLxQChIuYSGAHg2DDU10EHVRSc9HmVefDP7xf1duGH/mXH/ktm/B6
         5XK+iNWb7ZvuvPqVV1hlGaSXhp5zZjJyCm6uhxM9HLcul0bmu+qr7hUpjpt8bI3Nkx6h
         PU/5p3MDB2/pt2aS6Ud1UqOm3jJKyIPNDVeSWfH4j/id7I85JcnMm5qASHLEUkY3bhn6
         /xfn1gOFI/5IhBVMBp2HuV5VZkX/9Y4U6qcJACFw8kOrcLTqKTvhn68SVt7tB9yd4EGn
         XIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883571; x=1763488371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
        b=knjhN7plnR2xu4LmI1Y/owXPcImNFRLwEKtDtt+OyDaom/RL37k3Qj2Rt+XhyFsjoh
         lJi5lqevayBMpj81qw+PgfmkxvzykKmirJXG54B9xXYAlQpx/2GiFwHimh4AweymvhFR
         QfqG1WzGiGKTMuIt8zpq0ZU9Y+x/fuzoZw7DP3vZubFJjxH/o9zILN4wdtCVlIeOAasW
         BmKHKFVL9LzrrfvHpX4zqBgIJ8TIcQDOxlRn0b6+L5afNb+zY3E84/MpF2KPf2RopcHh
         fDsAeyinDR2S4qLK3vbaQYW84UgAFFIGo8wKwUd7ttsvR80UCZ1NNY6Kj2XoRElg+3Dz
         78Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWqBlXNg4GVagGPZ4+jW0p9O46172KcdbVSooi1rXjiddLuKnHRTO4qVZOFHq5op+jlWv0L140keyxjKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySWO6J1Sg/rxPwd+j/lXLQyrDpxctluDikzV1CRHhcQ6z3NOEb
	F8tmOfZKfrBfm5bSZn5EoFaCUzN52IpxIkfLWgaQ72M0eMj793YwkqnlUpoHtqJHzPE=
X-Gm-Gg: ASbGnctTmxNBuT2xF3up3YgfVYcNEebFp23PV0or1WNXPGmWkBfL54xOrX7csSFuEQD
	Blx57xbwfYEsQ8xGEbKK7BrQdcPn9J5+4gP182l70OrgZB6vXeODAwXspSZGfUV7PlCkOY5/3ux
	xXM8CR0AxHxTUc/m8fjMqMgtsoFphYwOsXs0A6arA9CD5eemTaG3On7c2/04W5ztuQ+wqA5itQs
	945YETn6/6iOD3j6ww35l0Ixjb4LVU8uLknDAV3XbPvt15ls7XOz38F7wjxtTA7V0J6t2k0FjKR
	gBbeXYycVipooO8fR6/9X+m6zUNfXOFdaGeybHvdvR+ZfvR1D20pk/wJxvuCi2A6RBh2OUw6lZt
	T8WXAHl/281kWh9AIFcxIp14eTp/JNoEwbQr5H02dR+R8aBXCz6D2BUqV8UlmAH0VhZc8sUVvBj
	0P2Ybbq0fvMKAhPlkmditvcsHvoxw6g5cbq3HFgkcmLcI3uU8z0KSazJpZinJiLkeN
X-Google-Smtp-Source: AGHT+IGZ24gPwNf9yPCfR7VYmGLvGJvKsnhVnsEWjyP34dYxdAWzeTApGxpBX2H8vl8E9dV82whA7w==
X-Received: by 2002:a17:907:7fab:b0:b72:d56f:3468 with SMTP id a640c23a62f3a-b7331aac316mr1013366b.50.1762883570945;
        Tue, 11 Nov 2025 09:52:50 -0800 (PST)
Received: from localhost (p200300f65f2353049e8cfcf6469e7c35.dip0.t-ipconnect.de. [2003:f6:5f23:5304:9e8c:fcf6:469e:7c35])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b732c87ccfcsm76547366b.9.2025.11.11.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:52:50 -0800 (PST)
Date: Tue, 11 Nov 2025 18:52:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Malcolm Priestley <tvboxspy@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <dvdu27leqnwvxgz6rcgsdbovw2576dtcbmxuaznevjvijdxp6s@t64lg6bckgkd>
References: <20251010030348.it.784-kees@kernel.org>
 <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
 <aRMhLEs9NpGexL7B@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwbp63t7mxf4mfm7"
Content-Disposition: inline
In-Reply-To: <aRMhLEs9NpGexL7B@black.igk.intel.com>


--mwbp63t7mxf4mfm7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
MIME-Version: 1.0

Helo Andy,

On Tue, Nov 11, 2025 at 12:42:36PM +0100, Andy Shevchenko wrote:
> Folks, are you aware that this change blown up the sparse?
> Now there is a "bad constant expression" to each MODULE_*() macro line.
>=20
> Nice that Uwe is in the Cc list, so IIRC he is Debian maintainer for spar=
se
> and perhaps has an influence to it to some extent.

To be honest, in the nearer past I'm very passive on the sparse
maintainer side and even stopped using it as it fails on guard locking.

My impression is also that upstream isn't very active any more, but that
might have been temporal and wrong as I stopped looking.

If there is an outcome and a patch to cherry-pick into the Debian
packaging, give me a ping.

Uwe

--mwbp63t7mxf4mfm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkTd+4ACgkQj4D7WH0S
/k6QXQf/WqP001zUT4Bxw/oC7trx3KqIhrnryL+Ih+OAu0LFHWKobNA3K556JcXQ
YEoGffzJU/J7ODVixICet7Uv94oeQ/1Oqr/OSPXlUst2vEIgQrkAO5guB/DCoS6C
c+aODonO57Ovlc834ylWPacex8K1XrSEC3bO3guctIxR+FLcfYyc6w8CI7pMRZ/0
Kqaype/E9cFIvlGjyxnIZ28NKGuACVyiO6a4jrfnLtCiFsirGWww65tqhUg9hJx8
sZ2RViIzMnMbl+Vqgoxm3JhpqsfgiA9k6069Ey0zw6JgBVH67N8IQs4v/AKqeBeB
05CxLfZZIK/RlfUZfQ1d/EY78KJxOg==
=qd7W
-----END PGP SIGNATURE-----

--mwbp63t7mxf4mfm7--
