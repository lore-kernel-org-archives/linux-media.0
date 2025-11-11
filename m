Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D09331229
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868310; cv=none; b=BsZvJuACXw7EZUjoHmPWw8NksywOTmx2qoOTyhBOVDj8yT9krxeMbtM7qjZuID9vRJjwSON93+svHhh5hJuX3+Nzj37oJF6sJawuHGOVdP8Rh8YV4g2yN1oOLWScMs/ZynSESRzYxjC9XMEzFHeI/tvDH6xXPlLvELdMZUlbQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868310; c=relaxed/simple;
	bh=9+8RKp3wpw269ST0pV/o23oBCV2SjRSEAo7Ju4JeE2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VINIuZl9lrtlvlP8sy6K3RVDArm69hIGq+DmkviMxBbwT1RNHNondAsL6B6EqsINYQXi6BojggCKVU6cunC/Edg2LKkWDxFRx48nyaUaj5rBVdG81WmdfcS6VCDZslv0uw90ulEXn09W9hLvTLJ5ePI+Tq6DRK3GuDltxc2PVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jruR+34z; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jruR+34z"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b427cda88so715164f8f.0
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868307; x=1763473107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnh/EfFcC0OapeosDB3gm6ZI4b7oDHUMEpCiBaNixDQ=;
        b=jruR+34zAhhIRiwsoPh0IoK5V8sjOZ/5nWn1O8D38gdkstcgT2XWsgr3JBSSA+1sbb
         DMCspnhxoKNUoCfYDikjBbfjAk5VfCI34/MfJhRU/6ZUcGqZG+ByD4QvjhAAAHO1WRfX
         NxGZXe+C26/xkAcbJHnM8D4+WoOnrOk3HCQBiMlMvZHANM36A0r2l4kj9lTEPwUdwaj1
         Xs6eT+dGhVfsq/MiD+UKjv8dUYE+o4SB6fA9HGoubUfgWJmn7hF7F4ZY1t42AR9NUSuB
         u5n2GyrnHGXi60Tg4BAqZMcJvYZGnqyMiNqXUBEl0VvLU78Ecd+mShS5NWhHRWxgqRxl
         wUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868307; x=1763473107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qnh/EfFcC0OapeosDB3gm6ZI4b7oDHUMEpCiBaNixDQ=;
        b=j4lx75DPFozeAVZKl+dTdKeghJQ/A+fQsBzpTvg4fVo9DVh3y9mo8CBSX6s1fnBKKQ
         d+m5PPtBrnNgqlnroFfOIqqFvHj3B1w54MFLroeHduR4t6BkeaUlWQyW76RlWbm+CJm7
         g6kHOrElJsJppX4qO+bfiQQLxISOUOX8dsMW52E8n5m/00rCori+gOw5UzjkvB+NqSTH
         Lb6uancxQhmgwqwRIa+t0uSdXHKYGAnu+VC285Kn8uHYKDHwTSH+inVP5OmoLA7w8sXR
         DfNYkTCVs+IzxlnPBJ0RQeoN7AFHRncFNvB0R4iFeI2t0VhBMSOoFcAL8iItNzEUhSOW
         CAAA==
X-Forwarded-Encrypted: i=1; AJvYcCUWa3ifR9iMZkT2Xb84h2/dQpuFrW3ncwRgebOb/oTCmc9gydoHG+gMtqAlUaPS7GmyXERUz6u7RTiwAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4uQ0HDtFzHjt1ZTbjMIueGEdHo321VuwbQJvxJQAe8+EHeZBC
	3n/R5KC7GOuD/KSfP536haL5BVIlNXsmz7MaHyPIid2mv/CmCU1BjjwyD5f6m6oWd44r5Xl7Fy4
	WPTrCg2iuH3x4fE4sdr2KFe433E3X1Uk=
X-Gm-Gg: ASbGncu6otihlQQckqFViXK7bsBnc6f/w50+oMUyGwOT+Wg5f6ct1FtXb6b/G1CrIF2
	kuDIkTuiRJT5wlVKldd1K0WTigK0bbRWgAmjd6hVkLNYm66q740coqQ4U39BUWB7tg41A1BwBg1
	9AhClOSsgiOp45+OoXi37PhkKq9OyXHawVUmy4+A06FYQwkQgajgB9FibX+vMbUDmQjYI7CegJ1
	/mhgqXgZavckJWxRnJYKVdElsjI5q6RoHex8sUHlQ4VjUrValZHh9sqaSWVdQ==
X-Google-Smtp-Source: AGHT+IFao47crFBXAEMryJc61/yylJAwMReb80upl39uZLXSP2IfrU0IRhz0HzfumpWstK5uhCcoN0mp9RwuTfUSerw=
X-Received: by 2002:a05:6000:22c5:b0:42b:3806:2bb4 with SMTP id
 ffacd0b85a97d-42b38062ee3mr8603188f8f.27.1762868306762; Tue, 11 Nov 2025
 05:38:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103145629.21588-1-clamor95@gmail.com> <20251103145629.21588-3-clamor95@gmail.com>
 <aRMw_Qre1FY94soi@kekkonen.localdomain> <CAPVz0n1MokJq6d4s0cS3UdevRt2n-HaicPpwiBu=3HVSKfnzfg@mail.gmail.com>
 <aRM4x7SbdbxMYLCi@kekkonen.localdomain>
In-Reply-To: <aRM4x7SbdbxMYLCi@kekkonen.localdomain>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 11 Nov 2025 15:38:15 +0200
X-Gm-Features: AWmQ_bkmPJ4B9hg_v9slwZgU6JF6B0t9UvmnXNpUX7KozbO5YA-3mLRwPCTqEus
Message-ID: <CAPVz0n0zEmWrocqeFKHVdgegtwLKWZZ2xS5EYnT-rZtoTKxctA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: i2c: add Sony IMX111 CMOS camera sensor driver
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, Dongcheng Yan <dongcheng.yan@intel.com>, 
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>, Tarang Raval <tarang.raval@siliconsignals.io>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 11 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 15:2=
3 Sakari Ailus <sakari.ailus@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Nov 11, 2025 at 02:53:52PM +0200, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 11 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE =
14:50 Sakari Ailus <sakari.ailus@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > I can make the two changes before applying, too, if that's ok.
> >
> > If you don't mind adjusting commit on your own before applying I have
> > no objections. Thank you very much!
>
> The diff is:
>
> diff --git a/drivers/media/i2c/imx111.c b/drivers/media/i2c/imx111.c
> index c269e9fdcb0b..8eb919788ef7 100644
> --- a/drivers/media/i2c/imx111.c
> +++ b/drivers/media/i2c/imx111.c
> @@ -1136,13 +1136,6 @@ static int imx111_set_format(struct v4l2_subdev *s=
d,
>
>         fmt =3D v4l2_subdev_state_get_format(state, format->pad);
>
> -       fmt->code =3D imx111_get_format_code(sensor, mbus_fmt->code, fals=
e);
> -       fmt->width =3D mode->width;
> -       fmt->height =3D mode->height;
> -       fmt->colorspace =3D V4L2_COLORSPACE_RAW;
> -
> -       *mbus_fmt =3D *fmt;
> -
>         if (format->which =3D=3D V4L2_SUBDEV_FORMAT_ACTIVE) {
>                 int ret;
>
> @@ -1183,6 +1176,13 @@ static int imx111_set_format(struct v4l2_subdev *s=
d,
>                         return ret;
>         }
>
> +       fmt->code =3D imx111_get_format_code(sensor, mbus_fmt->code, fals=
e);
> +       fmt->width =3D mode->width;
> +       fmt->height =3D mode->height;
> +       fmt->colorspace =3D V4L2_COLORSPACE_RAW;
> +
> +       *mbus_fmt =3D *fmt;
> +
>         return 0;
>  }
>
> @@ -1542,9 +1542,9 @@ static int imx111_probe(struct i2c_client *client)
>                 goto error_pm;
>         }
>
> -       pm_runtime_idle(dev);
>         pm_runtime_set_autosuspend_delay(dev, 1000);
>         pm_runtime_use_autosuspend(dev);
> +       pm_runtime_idle(dev);
>
>         return 0;
>
> Hopefully that works!
>

Yes, it seems to work as expected on my device. Thank you.

> --
> Regards,
>
> Sakari Ailus
