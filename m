Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B832D421
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843702; cv=none; b=idRPjmlT+gOG8nItUqQu9Z+WkfcN1+g3mkBsD1t4aKQQsyOkZXneI1+uvAdEHNHhO7QdVU6AJW3Ub/oHIJ7AJA6yh4R9nRe+nWfD2sCXCIKeMuLfjdHYmnn8bSw7gN/rzfrqfeMHSRMZytXUiUwWV/IZy9ZBK01oFZs2cqHIncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843702; c=relaxed/simple;
	bh=EusY1YtHYQQoikr/c/SlwC/Rh4MX3FMNKsBXoat7rAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEW4s+ZhLktH8q1csxbnCYvueV1S3dB1hs9lAE29jGP5b8NsN4mPx8sgNKbssLwNyT1mVSY3OHnnPijdr8B7pdh21THfmnY0XNVJEop/+00BfYqH9YxwauwXYVl/Gitl7eq+OPX+omi6Xie6mRWsfIZO6py3M8jaJ19k4kPlb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L24wN6So; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L24wN6So"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55953d7486cso2412550e0c.2
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 22:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762843700; x=1763448500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP5GzDPunPhccnuJOs7BSz9jnRuXsEyAOZ/rFAQkjAU=;
        b=L24wN6SoR6HNFQeTDjyb8JN77ELLfJBPw5jOnH+Zvg5Q0SukzGaJCwCqkWePRvbwcL
         Jj6sLqPqYyd4zwPutgPdWyjVk2hUhNiWb+uALe1u0I5DgUmrSXNkxkeBndl60EsFsoo2
         o1mcU3JGcQB66I1Z2/9pbwRWgM2ZNa4/5Q+wlXdzsqtC7E2HfLalhlA5j5qTLHqC7mo/
         p59or+YbeEGjPb9GPLnX+uB64s9i4kdEAu0nY2Z8jL9kFficEXxmx0vNN+S0X6XQGaL9
         hMKGbxJfQPCFKKO4gTCYnP9tRq9AEXWcPo0cHTn0lfGDyeyDhpqo3UGbJduzpleEQ+NL
         ITBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843700; x=1763448500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gP5GzDPunPhccnuJOs7BSz9jnRuXsEyAOZ/rFAQkjAU=;
        b=G4PKqar/v4j778Qk4zSJRWtgfO3pFs8XsLIenFF4kLQDCRRJp4UYy05PRX3A47yiEg
         bdKFbIsYc59iHffe4jNJiMbCelEOr78q9rwSTKhHSeAC1/bzxua148+Uhuj30hsxgQxJ
         jbUZoGe6tgjgMkM34fT1SRJ7uv57UffM7/+4D/l/Fu/X6rws5uM183owuwAEFk9dvlDU
         s3eE4pP9lthM22vYpCLCL1yEp6omY5QlohPLpU1ql0QSC5fd3DcHtEYaG+m+X5YKzDbG
         TfGNnBdiSYpDAxrIALalVRJcI22PScmqxlD6W2WOb3YRduShRK29MEP/G5EsZm08LjjJ
         tKag==
X-Forwarded-Encrypted: i=1; AJvYcCW/LgoWUr63dzXYdxcPYyvuPDRiqivOC/cRzYO5In7pYbqaSxWKFWIWjv9JQFz9QJRgj3slpOj5ZbsNmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkw0xji6yd5czL/00xkLQWggJ17dTraguQweVsLEG5osKae8UE
	W/CEAGssfG5nnWm6zjluzQ9GbfYDD4wqqKWj4MX6KcTowH3+pldtQr9cuL0tiQGLeqvbwbLqw7/
	GkCZitJlRw/yIZ0pp1RaTquSuydxE813wmA==
X-Gm-Gg: ASbGncvsKdc5ClyKlfRM5YI1f8FGxu/UPUQpNvUa+aCnCZm83AljgXLxJDl/1uv8Pcg
	ys8Ioey7OSBslu7yYUGW0aegoobuTtHhO7gLP+Yt8rmYbKn+Swj20BvyYt5aTy6oCFIbKDXz8WX
	obZLUOCHy2l09BDr73rJexmMGQoiV4wfEUkXZLl/VAZy3fLHMWjMfD/gGrOyNmOCEvj2Lbi2zRP
	vdKI8bHpgGViZzhahxWOa/lM75ReaWcGJEmauOgE1bDiofQ7JWxlp6ggZIXJQ==
X-Google-Smtp-Source: AGHT+IHs/HnaXf74BFA+VnF8+OeIWKAvXMura36UhoIxjctf7EXn9XmD5A/bc3vkBxXa3XQ8XxEPTVZlMcq4CJKQuEY=
X-Received: by 2002:a05:6122:220f:b0:544:c8bf:6509 with SMTP id
 71dfb90a1353d-559b31f635emr4247968e0c.4.1762843699910; Mon, 10 Nov 2025
 22:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108232923.2067131-1-alex.t.tran@gmail.com> <aRGe1NkDHYtDOfnw@kekkonen.localdomain>
In-Reply-To: <aRGe1NkDHYtDOfnw@kekkonen.localdomain>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Mon, 10 Nov 2025 22:48:09 -0800
X-Gm-Features: AWmQ_bnpahixUtFQ_QuDroeqIUMnaRfNGFfJK_LBi2sbT7-kLMKFAycskIl2JVM
Message-ID: <CA+hkOd5oxHMaoXMLVFiH=ySiT6f2y+F463KO9xV3o4P7ZKghTw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] media: i2c: et8ek8: et8ek8_driver: add support for
 crc configuration via device tree
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Pavel Machek <pavel@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:14=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Alex,
>
> Thanks for the patch.
>
> On Sat, Nov 08, 2025 at 03:29:23PM -0800, Alex Tran wrote:
> > Retrieve the configuration for CRC from the device tree instead
> > using the hard coded USE_CRC directive. If there is an issue
> > retrieving the endpoint node or the CRC property then the default
> > of 1 is used and the driver does not fail to maintain backward
> > compatibility.
>
> Is there a need for making this configurable? I have to say I can't recal=
l
> the specifics of CCP2 but presumably the receiver side would need to be
> aligned with this as well, requiring such configuration on both sides.
>
> If you want to pursue this further, please also cc me to the DT binding
> patch.
>
> >
> > Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> > ---
> >  drivers/media/i2c/et8ek8/et8ek8_driver.c | 49 +++++++++++++++++++-----
> >  1 file changed, 39 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i=
2c/et8ek8/et8ek8_driver.c
> > index 2cb7b7187..4ef92359c 100644
> > --- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
> > +++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
> > @@ -29,6 +29,7 @@
> >  #include <media/media-entity.h>
> >  #include <media/v4l2-ctrls.h>
> >  #include <media/v4l2-device.h>
> > +#include <media/v4l2-fwnode.h>
> >  #include <media/v4l2-subdev.h>
> >
> >  #include "et8ek8_reg.h"
> > @@ -45,6 +46,7 @@ struct et8ek8_sensor {
> >       struct regulator *vana;
> >       struct clk *ext_clk;
> >       u32 xclk_freq;
> > +     u32 use_crc;
> >
> >       u16 version;
> >
> > @@ -130,8 +132,6 @@ static struct et8ek8_gain {
> >
> >  #define ET8EK8_I2C_DELAY     3       /* msec delay b/w accesses */
> >
> > -#define USE_CRC                      1
> > -
> >  /*
> >   * Register access helpers
> >   *
> > @@ -844,20 +844,16 @@ static int et8ek8_power_on(struct et8ek8_sensor *=
sensor)
> >       if (rval)
> >               goto out;
> >
> > -#ifdef USE_CRC
> >       rval =3D et8ek8_i2c_read_reg(client, ET8EK8_REG_8BIT, 0x1263, &va=
l);
> >       if (rval)
> >               goto out;
> > -#if USE_CRC /* TODO get crc setting from DT */
> > -     val |=3D BIT(4);
> > -#else
> > -     val &=3D ~BIT(4);
> > -#endif
> > +     if (sensor->use_crc)
> > +             val |=3D BIT(4);
> > +     else
> > +             val &=3D ~BIT(4);
> >       rval =3D et8ek8_i2c_write_reg(client, ET8EK8_REG_8BIT, 0x1263, va=
l);
> >       if (rval)
> >               goto out;
> > -#endif
> > -
> >  out:
> >       if (rval)
> >               et8ek8_power_off(sensor);
> > @@ -1396,6 +1392,34 @@ static int __maybe_unused et8ek8_resume(struct d=
evice *dev)
> >       return __et8ek8_set_power(sensor, true);
> >  }
> >
> > +static int et8ek8_parse_fwnode(struct device *dev, struct et8ek8_senso=
r *sensor)
> > +{
> > +     struct v4l2_fwnode_endpoint bus_cfg =3D {
> > +             .bus_type =3D V4L2_MBUS_CCP2,
> > +     };
> > +     struct fwnode_handle *ep;
> > +     int ret;
> > +
> > +     ep =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> > +                                          FWNODE_GRAPH_ENDPOINT_NEXT);
> > +     if (!ep) {
> > +             dev_warn(dev, "could not get endpoint node\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
> > +     if (ret) {
> > +             dev_warn(dev, "parsing endpoint node failed\n");
> > +             goto done;
> > +     }
> > +
> > +     fwnode_property_read_u32(ep, "crc", &sensor->use_crc);
> > +done:
> > +     v4l2_fwnode_endpoint_free(&bus_cfg);
> > +     fwnode_handle_put(ep);
> > +     return ret;
> > +}
> > +
> >  static int et8ek8_probe(struct i2c_client *client)
> >  {
> >       struct et8ek8_sensor *sensor;
> > @@ -1406,6 +1430,11 @@ static int et8ek8_probe(struct i2c_client *clien=
t)
> >       if (!sensor)
> >               return -ENOMEM;
> >
> > +     sensor->use_crc =3D 1;
> > +     ret =3D et8ek8_parse_fwnode(dev, sensor);
> > +     if (ret)
> > +             dev_warn(dev, "parsing endpoint failed\n");
> > +
> >       sensor->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >       if (IS_ERR(sensor->reset)) {
> >               dev_dbg(&client->dev, "could not request reset gpio\n");
>
> --
> Kind regards,
>
> Sakari Ailus

Thanks for the review. It seems like I missed adjusting the change on
the receiver side in omap3isp: isp.c
since the crc is still being defaulted to 1. I'll go ahead and add the
corresponding device tree parsing for the
crc property on the receiver side as well, so both the sensor and ISP
endpoints can be configured consistently.

The threading for this patch series was broken. I'll send in v2 as a 3
patch series with them
properly linked.

Best,
--
Alex Tran
