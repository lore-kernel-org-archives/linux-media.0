Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63882DAFBE
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533054; cv=none; b=IHNk/YyAKDJ0WBxpwhDvivrMVHpuY8xoYyxwAs3jZrjN/KsVbYP92Skz+HDVx95G2SiT+bxnJgLOJmbT7CB/OfXdfQ+7nD/66c8aUgCsZlMMPHUVsy+x6jVPaYgoTNUjCXfD5W0IAVgfVJHmN7f3XP9y3SrfzzW+SDM9+59NkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533054; c=relaxed/simple;
	bh=al2zZOjy1s9k9uG0J5tQ/tOLemu8rJl5iPBRWP7bhxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goMUfOuHCnabECzV3lLqZUIcIeDrxc7ToS7njVi59kiPwUf70cSUWiat5bS4gIMOuZODDOUJYdQzLsrv2CWAKmBTx/oYNfkZAY/ttgEyA3wo2P4ZVoT72TIE3OX6KKKg3pKJQ4g3suwpobtLouTU6XhxBn7NyrW0nYqOuUmwFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=JE7DNmKr; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="JE7DNmKr"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b22b1d3e7fso94654585a.3
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 08:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762533052; x=1763137852; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AVrp19hgKD6fn901dtJIwIEFWrRkipQPPUAVv1GRELc=;
        b=JE7DNmKrFErNzCVWUhhWI3DZH1h5UNvmLUnC5bNLRWGEA8kosZ0iSaSMXZMXS8dEMO
         IdxSphU5SF8mOIXU5BlQ02nS5ymF0ip9Ig5mqOF+GjFeZ6ki1UF5srqfB7b08wbSPWSV
         gYME1++VsvXktWRaOo9IUne7f/AN1+2rIjATUMQue1s3unW7uO3IdLKwI+A9uUD7ZRnh
         X60rNYMG6HMuYysv3sH5sF1fHc6V3f6rJlq9uNYfm/1VlEt5gcm6C4eeKLVvMxqHINT8
         /mcJqtfoknAgQg4xtEcluTuzk4ueLpEz0T9VuJl8sA05uQl2Ce8KOGUVSvWYcEmeCbNp
         m3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762533052; x=1763137852;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AVrp19hgKD6fn901dtJIwIEFWrRkipQPPUAVv1GRELc=;
        b=lOQaug6F7u1k1Bb9h87MpUBJdYoEtF43i+MyhAEHaqYURMxU9+i2yCwPiOEgVsZiVH
         TQbCfyn1VbYRiQxpBSqAqfPj8Z0hxLaJOAR75w3LwQ6D4T8uwKR+tQVz8p68LYjJCLT9
         aWxeFhOuNKKWgdADDePLbzyYOxpQUGbrQOmWJr7nRHvidqf1QGAgEZClEKXuf+A3Zkru
         jEuxQ3efMpBQ0U8L3fLaj+jFNFDWgEwHMH6mVk+iiZE06V0IMktspSqu01zdMSiZnL/H
         BYrsN/S+oUGYgXWmJsoVyczv3hKl79q/mbgzqWsCYEs/HEOvraum7/1nFoGtt1ZeOW0n
         AO/w==
X-Forwarded-Encrypted: i=1; AJvYcCXtyi/amyToTkBX5FRw4FbZahC8dko0HR39fw+gTabedqlAat1WFkoRuM5BbiPsK4sGWxIuBy6w9ZFk7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd25hptyjL8QxKcBloUTPF3WK2McHdAfugbx8dLRAW0WD6knR+
	o2zBGSxs1fGsramhqd8AjDuVhc395JNRG+91DmIT4wWBWtZtLLo+RGxLRCdktVTZAi0=
X-Gm-Gg: ASbGncuy3nalJ1xsfqsh+S73zOJj+7OYq0+vduLim8etowM2PFuGJTNyWm+lpAm1RF+
	VSvnjVcuDMfKQrOfL1qmUVrkw9BRVlITpqkPrGWN01NvJEwsI9UC04uiJiGrdoVpE/UtKi0RH5x
	E2rprU1OlUg2jppoIUd6eBZFor3sF1SBJYqMOZwGQuZPEWe2O2WWDNW0Ppt4a4hnxK9kIm6vmxL
	KiEBd+jQ+S9Dj8QaiNzcDnSwKn+7TP2ZSb88BCdOlBWLtkXO/KNKuiyQJ2YYXVJVg7aKerumirJ
	rUJXheItC5V9Q9EoF8OyBQehtqT5T4DO8iuwC7xEyfngiyxuarEAU+NyW8vQFJOADXnU94ZZBRu
	PrBus8z8zU325fa5zKYMJwzRCIEOxIRRDgJrRNrfUAwrlLXGfQdQeFYQY7pQJA+6thELq+MWk7Y
	bGnhaTEg==
X-Google-Smtp-Source: AGHT+IFz/UlnV0OMfhq87mlorD8XvK8vi/cdNG2hzp5O044mKb/ma/Fx+Ie3hyppzhpm+e9TfHmw3g==
X-Received: by 2002:a05:620a:1a23:b0:89e:72fa:ba8b with SMTP id af79cd13be357-8b24529f1f3mr550636985a.34.1762533051280;
        Fri, 07 Nov 2025 08:30:51 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ef24::c41? ([2606:6d00:11:ef24::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23580b649sm435035985a.48.2025.11.07.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:30:50 -0800 (PST)
Message-ID: <e99ff4f12d52eee03075f911e6b904290b47a961.camel@ndufresne.ca>
Subject: Re: [PATCH v4 2/5] media: ioctl: Add pixel formats NV12MT_COL128
 and NV12MT_10_COL128
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, John Cox
 <john.cox@raspberrypi.com>,  Dom Cobley <dom@raspberrypi.com>, review list
 <kernel-list@raspberrypi.com>, Ezequiel Garcia	
 <ezequiel@vanguardiasur.com.ar>
Cc: John Cox <jc@kynesim.co.uk>, Stefan Wahren <wahrenst@gmx.net>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Nov 2025 11:30:48 -0500
In-Reply-To: <20250701-media-rpi-hevc-dec-v4-2-057cfa541177@raspberrypi.com>
References: <20250701-media-rpi-hevc-dec-v4-0-057cfa541177@raspberrypi.com>
	 <20250701-media-rpi-hevc-dec-v4-2-057cfa541177@raspberrypi.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Q5o4lQgKYevCwoTHFi6w"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Q5o4lQgKYevCwoTHFi6w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

sorry for the long delay.

Le mardi 01 juillet 2025 =C3=A0 17:01 +0100, Dave Stevenson a =C3=A9crit=C2=
=A0:
> Add V4L2_PIXFMT_NV12MT_COL128 and V4L2_PIXFMT_NV12MT_10_COL128
> to describe the Raspberry Pi HEVC decoder NV12 multiplanar formats.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
> =C2=A0drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
> =C2=A0include/uapi/linux/videodev2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 4 ++++
> =C2=A02 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 650dc1956f73..3bdcbb12bb30 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1381,7 +1381,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
> =C2=A0	case V4L2_PIX_FMT_NV16M:	descr =3D "Y/UV 4:2:2 (N-C)"; break;
> =C2=A0	case V4L2_PIX_FMT_NV61M:	descr =3D "Y/VU 4:2:2 (N-C)"; break;
> =C2=A0	case V4L2_PIX_FMT_NV12MT:	descr =3D "Y/UV 4:2:0 (64x32 MB, N-C)"; =
break;
> +	case V4L2_PIX_FMT_NV12MT_COL128: descr =3D "Y/CbCr 4:2:0 (128b cols)"; =
break;
> =C2=A0	case V4L2_PIX_FMT_NV12MT_16X16:	descr =3D "Y/UV 4:2:0 (16x16 MB, N=
-C)"; break;
> +	case V4L2_PIX_FMT_NV12MT_10_COL128: descr =3D "10-bit Y/CbCr 4:2:0 (128=
b cols)"; break;
> =C2=A0	case V4L2_PIX_FMT_P012M:	descr =3D "12-bit Y/UV 4:2:0 (N-C)"; brea=
k;
> =C2=A0	case V4L2_PIX_FMT_YUV420M:	descr =3D "Planar YUV 4:2:0 (N-C)"; bre=
ak;
> =C2=A0	case V4L2_PIX_FMT_YVU420M:	descr =3D "Planar YVU 4:2:0 (N-C)"; bre=
ak;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 9e3b366d5fc7..f0934d647d75 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -697,6 +697,10 @@ struct v4l2_pix_format {
> =C2=A0#define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1', '2') /=
* 12=C2=A0 Y/CbCr 4:2:0 16x16 tiles */
> =C2=A0#define V4L2_PIX_FMT_NV12M_8L128=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4l2=
_fourcc('N', 'A', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
> =C2=A0#define V4L2_PIX_FMT_NV12M_10BE_8L128 v4l2_fourcc_be('N', 'T', '1',=
 '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> +#define V4L2_PIX_FMT_NV12MT_COL128 v4l2_fourcc('N', 'c', '1', '2') /* 12=
=C2=A0 Y/CbCr 4:2:0 128 pixel wide column */
> +#define V4L2_PIX_FMT_NV12MT_10_COL128 v4l2_fourcc('N', 'c', '3', '0')
> +			/* Y/CbCr 4:2:0 10bpc, 3x10 packed as 4 bytes in a 128 bytes / 96 pix=
el wide column */
> +

Nothing to report here, it looks good. I can't remember, was there a reason=
 not
to add this format to ./drivers/media/v4l2-core/v4l2-common.c ?

Nicolas

> =C2=A0
> =C2=A0/* Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.ht=
m=C2=A0*/
> =C2=A0#define V4L2_PIX_FMT_SBGGR8=C2=A0 v4l2_fourcc('B', 'A', '8', '1') /=
*=C2=A0 8=C2=A0 BGBG.. GRGR.. */

--=-Q5o4lQgKYevCwoTHFi6w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQ4euAAKCRDZQZRRKWBy
9LGvAQCRyeU868ClTZ8TOWAm+66FB54e7PZmn1fgF9EQ0WmVqgD+OzrEF4eJkgtd
36v1rz7DSr3XtmcoiIfkHMDBuatl4wA=
=KmUC
-----END PGP SIGNATURE-----

--=-Q5o4lQgKYevCwoTHFi6w--
