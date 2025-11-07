Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B431DA0E1
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547421; cv=none; b=gChzooZFmxTOljva7ykQw2LEFI2FPT0uC9H2T9GPXb1XGgvy0uIMFuilvc6g0OpxYU7jSYhpjSxY/O3kYlYdYHuZLyu0ppbF1sott8bISVkmvPTuEoDswSyGdpnk4/lW95Myc0OsIPaVgzJ1zL16lh5AvC+aJ80i7nLpSWBYY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547421; c=relaxed/simple;
	bh=1RMj1PijAoUCInZJAwYJc++Vsy8WPvb340ysZA76GSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BjckA4YsSSr4wLNOPnR3eTPblNl3RcMj+NRbw3gZOm+Iiu/MUwontosHgg2l6tMSYjeAJVqiI5cYMkDzyUBFqSd217oHFsytA8edMzZsrrC6AG2pue3DsLXDfkMG26jzWhaR8zA2ZY8+I9m4etJV4s0ywRBJ2EIHh3Dc3KG3vC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=zpHyISJk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="zpHyISJk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b144ec3aa8so118953385a.2
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762547418; x=1763152218; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bDUTuqIm1mC7bv4+LL+huhJyC8iiKtLcTtZF/qxPnqw=;
        b=zpHyISJkWYqIPb2HQjh00MLU3iEkBzAM/DnYuRpz1HVuKy5UjDapep+O9Y+bXTb5oK
         1C+HyzXubTYufwQBwjmdANkWaZYUe4uX1j9R39XIq5ZwfbnTFykU7Au7fPqRc5DvEQbb
         6H5ffDRtsWDZ8H6lWyz/Z3bGfbZB1OqKgmyaBXmtkT2fy2OtakBaN41kk8a4YzXDmE0A
         dFeUwtxGgDp0+xsQJGbbbIyRiHgdBcB+po59hA2jOlGE+NjjrSbOZGpBiM8Hi/0mxsqy
         7DieIZ2Bm1lmdEvSVxRAa8+mkqJfeFLRGA0NrRnoQpCyYYTS2kN0OU7/oIoUyhMONyQ/
         /aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762547418; x=1763152218;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bDUTuqIm1mC7bv4+LL+huhJyC8iiKtLcTtZF/qxPnqw=;
        b=qdlDICiyUY5/YJ4l4FYosrIUiBYvdb+kqmnv7BcGjC93VRGCDr70MIblIGzog7jdY/
         QP6fRYSsGvTZUFiob/btILcUeyJWwttNOIBBw//nAIhNmnAz5Ahp3wNy4gEW3zKqeB+Q
         FThAxf2njYSSBaXO+nBlxMjB/bXD3t/huM51+zrzAyfoPf/ob306PnTIvtFcAFf6t1Y4
         UbfSxs/VTawdLdbgnENKjeGbApX/6HD1LKnD9Rs4KBGLCkw2KmxJO2BVAbJiXgHEcFBj
         f+YFkN3OJIAUO75Fs+8CFgo4ZXxtHciBu1Gb7/VRfaf3le/yn4OVEHPYxwQfKNbEFSB9
         U6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUig2F/10zwqiBBKy7/Phsfk6n0iSkaHXFq7gLh84OuB9iDXBC/wKGLKLG9m6EjVPbT+x3/2t0YAz/e3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJA/uffyVukSDA9uVShS7pO+MYdSY6m6WfuZXxNoJNuTfNsSg
	1i4pHpQoiRG5wgTLqUWkt8cvbWZdU0qfQn6vo44XGoLkeBh404OJ3doS3Wy4AaB4gKQ=
X-Gm-Gg: ASbGncsySHX4LScSJHFp6OUaOsy9a4eTSYP37CcRcm66Dtq6YQlGBJUJQWiO24Z1g4D
	30Y8wGSQxnYUZt8toJriKtBpgvcPu+aSl7o77DzFOn4Q9+QAOjeweW98K45ZUNOn3EFpizOk4do
	76WNGtgBhAeQu1ESBMYCXcnlIEuZEMNmbNOBwhIrf6spCBtr5hTmWAKaI67wSV0j9PyfyVto+pu
	j9lWBhsUwSz44SplAbcfmgMcjDqJytZixrlawI2Vd6aEIy1GykO0XWc/cUJeqpcuzMToiIDgBlg
	NSZbVDvr8eCZcZ7HbuR4J2VrqjcvDtaeFqvoYoxBGCyS4N4K0V5TJtHsGBR8klPXn/nRQmK9HDk
	KEqPYWsmeXz54qvGS6eAaY9cDm2uGd63HEYSZ/V3Y79FFheFVdIHC7k/EKRyXTsCRt07QS62txg
	j863M8ZE0kYPL88MDk
X-Google-Smtp-Source: AGHT+IE9+bUnPNb+D1GoECSagGgXpcy/iSFjYsJia7JIfqLUwPkrl0EwAL48d7DeRv+bzbrI2oATHQ==
X-Received: by 2002:a05:6214:dc4:b0:880:5001:17d1 with SMTP id 6a1803df08f44-8823871e956mr4781436d6.37.1762547418122;
        Fri, 07 Nov 2025 12:30:18 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ef24::c41? ([2606:6d00:11:ef24::c41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda578532csm1296591cf.19.2025.11.07.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:30:16 -0800 (PST)
Message-ID: <65c923cda564f308eae5f24191afc1c15c500ea9.camel@ndufresne.ca>
Subject: Re: [PATCH v4 1/4] media: allegro-dvt: Move the current driver to a
 subdirectory
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: yassine.ouaissa@allegrodvt.com, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Michael Tretter <m.tretter@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Michal Simek	
 <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Date: Fri, 07 Nov 2025 15:30:15 -0500
In-Reply-To: <20250716-allegro_dvt_al300_dec_driver-v4-1-f87c01c9f7b5@allegrodvt.com>
References: 
	<20250716-allegro_dvt_al300_dec_driver-v4-0-f87c01c9f7b5@allegrodvt.com>
	 <20250716-allegro_dvt_al300_dec_driver-v4-1-f87c01c9f7b5@allegrodvt.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ticGmTQqqGJykJCTcdtU"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ticGmTQqqGJykJCTcdtU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 16 juillet 2025 =C3=A0 14:55 +0000, Yassine Ouaissa via B4 Rela=
y a =C3=A9crit=C2=A0:
> From: Yassine Ouaissa <yassine.ouaissa@allegrodvt.com>
>=20
> In preparation for the upcoming driver update, we need to relocate the
> current driver.
> This will help ensure a clean transition and avoid any potential
> conflicts with the new driver.
> This patch is crucial for keeping our directory organized and
> facilitating a smooth integration of the new driver.
>=20
> Signed-off-by: Yassine Ouaissa <yassine.ouaissa@allegrodvt.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/media/platform/allegro-dvt/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +--------------=
-
> =C2=A0drivers/media/platform/allegro-dvt/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +----
> =C2=A0drivers/media/platform/allegro-dvt/zynqmp/Kconfig=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 +++++++++++++++++
> =C2=A0drivers/media/platform/allegro-dvt/zynqmp/Makefile=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A0.../platform/allegro-dvt/{ =3D> zynqmp}/allegro-core.c=C2=A0=C2=A0=
=C2=A0 |=C2=A0 0
> =C2=A0.../platform/allegro-dvt/{ =3D> zynqmp}/allegro-mail.c=C2=A0=C2=A0=
=C2=A0 |=C2=A0 0
> =C2=A0.../platform/allegro-dvt/{ =3D> zynqmp}/allegro-mail.h=C2=A0=C2=A0=
=C2=A0 |=C2=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-h264.c=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-h264.h=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-hevc.c=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-hevc.h=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-rbsp.c=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-rbsp.h=C2=A0 |=C2=
=A0 0
> =C2=A014 files changed, 26 insertions(+), 20 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60bba48f5479a025f9da3eaf9dbacb67a194df07..2cea337bd426f203a8dd8f5f2=
689f8091137175e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -817,7 +817,7 @@ R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> =C2=A0L:	linux-media@vger.kernel.org
> =C2=A0S:	Maintained
> =C2=A0F:	Documentation/devicetree/bindings/media/allegro,al5e.yaml
> -F:	drivers/media/platform/allegro-dvt/
> +F:	drivers/media/platform/allegro-dvt/zynqmp

If you can get Micheal approval, you can then carry over this for the follo=
wup versions:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

cheers,
Nicolas

> =C2=A0
> =C2=A0ALLIED VISION ALVIUM CAMERA DRIVER
> =C2=A0M:	Tommaso Merciai <tomm.merciai@gmail.com>
> diff --git a/drivers/media/platform/allegro-dvt/Kconfig b/drivers/media/p=
latform/allegro-dvt/Kconfig
> index 2182e1277568a407f51a23ea437811c50b1183c8..e9008614c27b9490d1cd29fab=
887977a1918ede4 100644
> --- a/drivers/media/platform/allegro-dvt/Kconfig
> +++ b/drivers/media/platform/allegro-dvt/Kconfig
> @@ -2,18 +2,4 @@
> =C2=A0
> =C2=A0comment "Allegro DVT media platform drivers"
> =C2=A0
> -config VIDEO_ALLEGRO_DVT
> -	tristate "Allegro DVT Video IP Core"
> -	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV
> -	depends on ARCH_ZYNQMP || COMPILE_TEST
> -	select V4L2_MEM2MEM_DEV
> -	select VIDEOBUF2_DMA_CONTIG
> -	select REGMAP_MMIO
> -	help
> -	=C2=A0 Support for the encoder video IP core by Allegro DVT. This core =
is
> -	=C2=A0 found for example on the Xilinx ZynqMP SoC in the EV family and =
is
> -	=C2=A0 called VCU in the reference manual.
> -
> -	=C2=A0 To compile this driver as a module, choose M here: the module
> -	=C2=A0 will be called allegro.
> +source "drivers/media/platform/allegro-dvt/zynqmp/Kconfig"
> diff --git a/drivers/media/platform/allegro-dvt/Makefile b/drivers/media/=
platform/allegro-dvt/Makefile
> index 66108a3037747020d549bc0a427881e0667a3f0a..d2aa6875edcf7760901996aac=
4d5ac98282cce20 100644
> --- a/drivers/media/platform/allegro-dvt/Makefile
> +++ b/drivers/media/platform/allegro-dvt/Makefile
> @@ -1,6 +1,3 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> =C2=A0
> -allegro-objs :=3D allegro-core.o allegro-mail.o
> -allegro-objs +=3D nal-rbsp.o nal-h264.o nal-hevc.o
> -
> -obj-$(CONFIG_VIDEO_ALLEGRO_DVT) +=3D allegro.o
> +obj-y +=3D zynqmp/
> diff --git a/drivers/media/platform/allegro-dvt/zynqmp/Kconfig b/drivers/=
media/platform/allegro-dvt/zynqmp/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..0a0a697c420da47f87f05153a=
2dbfbe5d3ccf988
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/zynqmp/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config VIDEO_ALLEGRO_DVT
> +	tristate "Allegro DVT Video IP Core for ZynqMP"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select VIDEOBUF2_DMA_CONTIG
> +	select REGMAP_MMIO
> +	help
> +	=C2=A0 Support for the encoder video IP core by Allegro DVT. This core =
is
> +	=C2=A0 found for example on the Xilinx ZynqMP SoC in the EV family and =
is
> +	=C2=A0 called VCU in the reference manual.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module
> +	=C2=A0 will be called allegro.
> diff --git a/drivers/media/platform/allegro-dvt/zynqmp/Makefile b/drivers=
/media/platform/allegro-dvt/zynqmp/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..66108a3037747020d549bc0a4=
27881e0667a3f0a
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/zynqmp/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +allegro-objs :=3D allegro-core.o allegro-mail.o
> +allegro-objs +=3D nal-rbsp.o nal-h264.o nal-hevc.o
> +
> +obj-$(CONFIG_VIDEO_ALLEGRO_DVT) +=3D allegro.o
> diff --git a/drivers/media/platform/allegro-dvt/allegro-core.c b/drivers/=
media/platform/allegro-dvt/zynqmp/allegro-core.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/allegro-core.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/allegro-core.c
> diff --git a/drivers/media/platform/allegro-dvt/allegro-mail.c b/drivers/=
media/platform/allegro-dvt/zynqmp/allegro-mail.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/allegro-mail.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/allegro-mail.c
> diff --git a/drivers/media/platform/allegro-dvt/allegro-mail.h b/drivers/=
media/platform/allegro-dvt/zynqmp/allegro-mail.h
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/allegro-mail.h
> rename to drivers/media/platform/allegro-dvt/zynqmp/allegro-mail.h
> diff --git a/drivers/media/platform/allegro-dvt/nal-h264.c b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-h264.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-h264.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-h264.c
> diff --git a/drivers/media/platform/allegro-dvt/nal-h264.h b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-h264.h
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-h264.h
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-h264.h
> diff --git a/drivers/media/platform/allegro-dvt/nal-hevc.c b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-hevc.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-hevc.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-hevc.c
> diff --git a/drivers/media/platform/allegro-dvt/nal-hevc.h b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-hevc.h
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-hevc.h
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-hevc.h
> diff --git a/drivers/media/platform/allegro-dvt/nal-rbsp.c b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-rbsp.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-rbsp.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-rbsp.c
> diff --git a/drivers/media/platform/allegro-dvt/nal-rbsp.h b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-rbsp.h
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-rbsp.h
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-rbsp.h

--=-ticGmTQqqGJykJCTcdtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQ5W1wAKCRDZQZRRKWBy
9LquAP4vrhxbrcsa2NVRSdgDGr1S60g6GOJFRtdYIYHSkGdo0AEAm0E/gtv2/K/S
yEhiuHijQF7Oy/mcG+Fguwx5A8DoVAg=
=tUk5
-----END PGP SIGNATURE-----

--=-ticGmTQqqGJykJCTcdtU--
