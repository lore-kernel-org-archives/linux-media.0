Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C53246ED
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865647; cv=none; b=Aw2hkiuDKstSAzjcpHxmsMpg5fNGzS+Cnzp6y9ga2sS1It598EkKFuDk6GA69tZcXduV/+tGhv5neWCSTtRuabI9XaiRenZ4S/b4ubfg7oL2kgBU3aLfZF4wvpGNJs03GR78Z0iVCAkpduYoTChpnjbHxGYsZAG/B+AIPZ3laEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865647; c=relaxed/simple;
	bh=unPRQlRCJ21nxfJRMtud04497uOiOiOlZ2lRqQFcIcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acBl4Pf1GKgRJiABqGukaNZG59P5iBRIcBAO2a3vMtJLTfAF0Hv/KugslE0SDjHsk9qhuzG7LkN9bxgyJAFjwObT54FdrtyQoXVl3r1bUuWU4RYFvcHM98468JCDHZjkR6ffoMpGErUGnnrYHdw45A2aUC09arAzBfqKoxILliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNsEAXUR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNsEAXUR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso3105964f8f.1
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 04:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762865644; x=1763470444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pixwuy1Oa1ogyBxcT1j1wEd+TT+wyOXiJagDOyZSIQ4=;
        b=FNsEAXURcTFyTUkbRwvcZ4w2qeI3XtaMjXxHo32MFQm0f/+t28CVzuqqmAxR+IZfWs
         BbFj4p37er3X0GKQD/3BjgGpeluVPlKx+bAWM6cJDLtt0N7ZMCjznYrcYUWsUHikHxpi
         uTc45PjnndVraslmw8MAStIuPLHcFV15honrjPip52DBiLKZFID3XrBmEAe3yhBgQUPS
         /Ot0SbRz5gDaz9NNpCoZiKC2RfROvg0BxZYw+J2bK0pZlibLxCSxJHu3OMj4+vLBClf8
         QufKS1lrqmWofaIOLo3LxsMX1a8Z0jTphrNqjyUiPQR4G307QXTj+isUMxle4OpBTVfY
         FTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865644; x=1763470444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pixwuy1Oa1ogyBxcT1j1wEd+TT+wyOXiJagDOyZSIQ4=;
        b=u0slDnNMWzCEQSyWoOamlI496EkMSCXPr1jqGU53uAMSgsT09zzjTc35jvGoh+DMfn
         0eHXc4YgVh2Jz3/yUuPxkPundcrkDMvN15hlUz/tc/raaiM6LQFUVsQ0aJskgscfdtY4
         ocahwwFZpN5rSiq1Xrdcou4E/hHYfcGqwXlsYsVm0uGW5mTJLJtYoj0KqE+VIyzYymqs
         FLtDjAMw5gP6YAQVcFKEB9UTKnWQ/JgZqUrjmRcOOlGh3+b+nC5BbH45ESFWedSKuaxQ
         uyBI1QcD6oRADKptS9VJWnxnVVCRiJ54hjdx7Qr/GOBtRqODfn543gcbU1IrDlPDUw7l
         JnXA==
X-Forwarded-Encrypted: i=1; AJvYcCUS3x3TxNXI83BaJ9W8HhFusgpk+hahER9EyvnqMcT7GAq86W0KZOTe7ccbVJQzmSgKKKdMVe3Ow/jahQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0mDF2WEFKcmqMFxSAjjlM60raojChBGG7015cFqdP2KQlfgTB
	rCxCmS2Q8W4wLXLBm+c/OUyRETY14FXrAVzSjA53srrQPSYrbIj2Xz6UrPYtpU5yox4AHvDvPAW
	uIfcqq6bmTYAbu373tE3ngMGR7ZgN5jE=
X-Gm-Gg: ASbGncv94eXt4lBu/a1YMMJFjRwcTUio2frc9HHbRocxWbAG5I9sFQ4u8LM18sQYRQU
	K78AOlEAnM5z6DFNaHHSge8UJpurFMWsqT9Rt0HugPUhfeQjBfsscPtPvXnQqo94QpSd0ztKjRq
	/ry+wdit3RSAvSH5JslIqY9ErC2KR386keBHgRm4dOmjHPcxmajGQlx5W67Y2MVuTREVrfhWOS6
	OtjST1x4Ck8boBboO9sobTmshxBhmqo8VnSr77pR2SWC76UK3wAXjejgBipGg==
X-Google-Smtp-Source: AGHT+IEj7gx0ZiIu8BHrdAC+RVKzNHGyLsGQt9LcZaen6jm13AdkSwj5HFslTJBizBUrMSWhJo2iezYgOwIO6CC4P5o=
X-Received: by 2002:a05:6000:420b:b0:429:d66b:508f with SMTP id
 ffacd0b85a97d-42b2dc856admr9311463f8f.30.1762865644130; Tue, 11 Nov 2025
 04:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103145629.21588-1-clamor95@gmail.com> <20251103145629.21588-3-clamor95@gmail.com>
 <aRMw_Qre1FY94soi@kekkonen.localdomain>
In-Reply-To: <aRMw_Qre1FY94soi@kekkonen.localdomain>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 11 Nov 2025 14:53:52 +0200
X-Gm-Features: AWmQ_bkRG5HIb_qQVszAElxxq_kW24NtTOJeleHHATd4PPO2npHibxTgWHp68Qw
Message-ID: <CAPVz0n1MokJq6d4s0cS3UdevRt2n-HaicPpwiBu=3HVSKfnzfg@mail.gmail.com>
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

=D0=B2=D1=82, 11 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:5=
0 Sakari Ailus <sakari.ailus@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> A few comments below...
>
> On Mon, Nov 03, 2025 at 04:56:29PM +0200, Svyatoslav Ryhel wrote:
>
> ...
>
> > +static int imx111_set_format(struct v4l2_subdev *sd,
> > +                          struct v4l2_subdev_state *state,
> > +                          struct v4l2_subdev_format *format)
> > +{
> > +     struct imx111 *sensor =3D sd_to_imx111(sd);
> > +     struct v4l2_mbus_framefmt *mbus_fmt =3D &format->format;
> > +     struct v4l2_mbus_framefmt *fmt;
> > +     const struct imx111_mode *mode;
> > +
> > +     mode =3D v4l2_find_nearest_size(imx111_modes, ARRAY_SIZE(imx111_m=
odes),
> > +                                   width, height,
> > +                                   mbus_fmt->width, mbus_fmt->height);
> > +
> > +     fmt =3D v4l2_subdev_state_get_format(state, format->pad);
>
> You should set the fields below after changing the controls. Albeit... it
> won't be perfect in that case either, as only some controls may have been
> applied. How about just moving the lines below after changing the control=
s?
>
> > +
> > +     fmt->code =3D imx111_get_format_code(sensor, mbus_fmt->code, fals=
e);
> > +     fmt->width =3D mode->width;
> > +     fmt->height =3D mode->height;
> > +     fmt->colorspace =3D V4L2_COLORSPACE_RAW;
> > +
> > +     *mbus_fmt =3D *fmt;
> > +
> > +     if (format->which =3D=3D V4L2_SUBDEV_FORMAT_ACTIVE) {
> > +             int ret;
> > +
> > +             sensor->cur_mode =3D mode;
> > +             sensor->data_depth =3D imx111_get_format_bpp(fmt);
> > +
> > +             ret =3D __v4l2_ctrl_s_ctrl_int64(sensor->pixel_rate,
> > +                                            div_u64(sensor->pixel_clk_=
raw,
> > +                                                    2 *
> > +                                                    sensor->data_depth=
));
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D __v4l2_ctrl_modify_range(sensor->vblank,
> > +                                            IMX111_VBLANK_MIN,
> > +                                            IMX111_VTL_MAX - mode->hei=
ght,
> > +                                            1,
> > +                                            mode->vtl_def - mode->heig=
ht);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D __v4l2_ctrl_s_ctrl(sensor->vblank, mode->vtl_def =
-
> > +                                      mode->height);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D __v4l2_ctrl_modify_range(sensor->hblank,
> > +                                            IMX111_HBLANK_MIN,
> > +                                            IMX111_HTL_MAX - mode->wid=
th,
> > +                                            1,
> > +                                            mode->htl_def - mode->widt=
h);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D __v4l2_ctrl_s_ctrl(sensor->hblank, mode->htl_def =
-
> > +                                      mode->width);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +static int imx111_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct imx111 *sensor;
> > +     int ret;
> > +
> > +     sensor =3D devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> > +     if (!sensor)
> > +             return -ENOMEM;
> > +
> > +     sensor->regmap =3D devm_cci_regmap_init_i2c(client, 16);
> > +     if (IS_ERR(sensor->regmap))
> > +             return dev_err_probe(dev, PTR_ERR(sensor->regmap),
> > +                                  "Failed to allocate register map\n")=
;
> > +
> > +     sensor->extclk =3D devm_v4l2_sensor_clk_get(dev, NULL);
> > +     if (IS_ERR(sensor->extclk))
> > +             return dev_err_probe(dev, PTR_ERR(sensor->extclk),
> > +                                  "Failed to get clock\n");
> > +
> > +     sensor->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT=
_LOW);
> > +     if (IS_ERR(sensor->reset))
> > +             return dev_err_probe(dev, PTR_ERR(sensor->reset),
> > +                                  "Failed to get reset GPIO\n");
> > +
> > +     ret =3D devm_regulator_bulk_get_const(dev, ARRAY_SIZE(imx111_supp=
lies),
> > +                                         imx111_supplies,
> > +                                         &sensor->supplies);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Failed to get regulators\=
n");
> > +
> > +     ret =3D imx111_parse_dt(sensor);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D imx111_clk_init(sensor);
> > +     if (ret < 0)
> > +             goto error_ep_free;
> > +
> > +     ret =3D imx111_power_on(sensor);
> > +     if (ret < 0) {
> > +             dev_err_probe(dev, ret, "Could not power on the device\n"=
);
> > +             goto error_ep_free;
> > +     }
> > +
> > +     ret =3D imx111_identify_module(sensor);
> > +     if (ret < 0) {
> > +             dev_err_probe(dev, ret, "Could not identify module\n");
> > +             goto error_power_off;
> > +     }
> > +
> > +     sensor->cur_mode =3D &imx111_modes[IMX111_MODE_3280x2464];
> > +     sensor->data_depth =3D IMX111_DATA_DEPTH_RAW10;
> > +
> > +     ret =3D imx111_initialize(sensor);
> > +     if (ret < 0)
> > +             goto error_power_off;
> > +
> > +     ret =3D imx111_init_subdev(sensor, client);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to init controls: %d", ret);
> > +             goto error_v4l2_ctrl_handler_free;
> > +     }
> > +
> > +     ret =3D v4l2_subdev_init_finalize(&sensor->sd);
> > +     if (ret)
> > +             goto error_v4l2_ctrl_handler_free;
> > +
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_enable(dev);
> > +
> > +     ret =3D v4l2_async_register_subdev_sensor(&sensor->sd);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to register V4L2 subdev: %d", ret);
> > +             goto error_pm;
> > +     }
> > +
> > +     pm_runtime_idle(dev);
> > +     pm_runtime_set_autosuspend_delay(dev, 1000);
> > +     pm_runtime_use_autosuspend(dev);
>
> The autosuspend should be set before pm_runtime_idle() call(), shouldn't
> it?
>
> I can make the two changes before applying, too, if that's ok.

If you don't mind adjusting commit on your own before applying I have
no objections. Thank you very much!

Best regards,
Svyatoslav R.

>
> --
> Regards,
>
> Sakari Ailus
