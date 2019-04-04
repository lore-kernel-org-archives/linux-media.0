Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB962C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 14:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9403E2147C
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 14:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfDDOjI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:39:08 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40903 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDOjH (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 10:39:07 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D3EBAFF973;
        Thu,  4 Apr 2019 14:39:01 +0000 (UTC)
Date:   Thu, 4 Apr 2019 16:39:47 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        rmfrfs@gmail.com, zhengsq@rock-chips.com,
        prabhakar.csengg@gmail.com, corbet@lwn.net,
        wenyou.yang@microchip.com, lkundrak@v3.sk,
        hverkuil-cisco@xs4all.nl, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/6] media: v4l2-subdev: add stubs for
 v4l2_subdev_get_try_*
Message-ID: <20190404143947.do4lmvxrvnzubtl7@uno.localdomain>
References: <20190404074002.18730-1-m.felsch@pengutronix.de>
 <20190404074002.18730-2-m.felsch@pengutronix.de>
 <20190404083933.33ejwyko4xoittux@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t7eyulkiye2oena4"
Content-Disposition: inline
In-Reply-To: <20190404083933.33ejwyko4xoittux@paasikivi.fi.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--t7eyulkiye2oena4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Marco, Sakari,

On Thu, Apr 04, 2019 at 11:39:34AM +0300, Sakari Ailus wrote:
> Hi Marco,
>
> On Thu, Apr 04, 2019 at 09:39:57AM +0200, Marco Felsch wrote:
> > In case of missing CONFIG_VIDEO_V4L2_SUBDEV_API those helpers aren't
> > available. So each driver have to add ifdefs around those helpers or
> > add the CONFIG_VIDEO_V4L2_SUBDEV_API as dependcy.
> >
> > Make these helpers available in case of CONFIG_VIDEO_V4L2_SUBDEV_API
> > isn't set to avoid ifdefs. This approach is less error prone too.
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > The patch was previously part of series [1]. Since I want to get
> > series [1] merged in 5.2 I split this possible stopper out of the
> > serie and prepared a own series for it. I applied Jacopos comments and
> > switched to Lubomir's approach [2]. During discussion on series [2]
> > Sakari pointed out Hans approach [3] which didn't got into the kernel
> > due to Mauro's concerns. So I think this would be the smalles common
> > dennominator.
> >
> > [1] https://patchwork.kernel.org/cover/10786553/
> > [2] https://patchwork.kernel.org/patch/10703029/
> > [3] https://patchwork.linuxtv.org/patch/53370/
> > ---
> >  include/media/v4l2-subdev.h | 29 ++++++++++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> > index a7fa5b80915a..eea792757426 100644
> > --- a/include/media/v4l2-subdev.h
> > +++ b/include/media/v4l2-subdev.h
> > @@ -984,7 +984,34 @@ static inline struct v4l2_rect
> >  		pad = 0;
> >  	return &cfg[pad].try_compose;
> >  }
> > -#endif
> > +
> > +#else /* !defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
> > +
> > +static inline struct v4l2_mbus_framefmt
> > +*v4l2_subdev_get_try_format(struct v4l2_subdev *sd,
> > +			    struct v4l2_subdev_pad_config *cfg,
> > +			    unsigned int pad)
> > +{
> > +	return ERR_PTR(-ENOTTY);
> > +}
>
> Almost all users of these functions directly use the struct pointer they
> receive from the said functions, without checks for the pointer value.
>
> These drivers now depend on CONFIG_VIDEO_V4L2_SUBDEV_API, but for new
> drivers it could be possible to miss that, leading to dereferencing
> ERR_PTR(-ENOTTY) as a result if the sub-device API isn't enabled.
>
> I have to say I'm not a huge fan of such a change; it's one more such thing
> to remember that results in a kernel crash if you get it wrong.
>

Unfortunately, I have to agree with Sakari here

> I wonder if v4l2_subdev_call() could become a bit smarter about this;
> checking whether the try format is attempted to be obtained without the
> sub-device API being enabled, and returning an error in that case without
> passing the IOCTL to the driver at all.

I'm not much excited by the idea of specializing v4l2_subdev_call(), I
had a try and I would be ashemed of sharing that code. If someone
could come up with something nice we could consider this too.

For the record, it is not enough to check for V4L2_SUBDEV_API and try
format, as a few (1?) bridge drivers calls the subdev operation providing a
'v4l2_subdev_pad_config' argument, that could be used by the sensor
drivers in place of the one returned from v4l2_subdev_get_try_*, if
V4L2_SUBDEV_API is not available

Caller:
https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/renesas-ceu.c#L858
Sensor:
https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/mt9v111.c#L792

As I wrote both, they could be very well be wrong, but if they're not,
one other option would be to refuse NULL v4l2_subdev_pad_config arguments
(changing most of the bridge drivers in mainline) and move the code
linked above here from the mt9v111 driver to the v4l2_subdev_get_try_*
functions.

>
> Just an idea. It doesn't have to be in the same patchset.
>
> I'd still prefer enabling subdev API always to decrease the number of
> possible different kernel configurations.

That would be best imho, but Hans' attempt didn't go very far because
of the issue Marco reported in his cover letter.

Thanks
  j

>
> I wonder what others think.
>
> > +
> > +static inline struct v4l2_rect
> > +*v4l2_subdev_get_try_crop(struct v4l2_subdev *sd,
> > +			  struct v4l2_subdev_pad_config *cfg,
> > +			  unsigned int pad)
> > +{
> > +	return ERR_PTR(-ENOTTY);
> > +}
> > +
> > +static inline struct v4l2_rect
> > +*v4l2_subdev_get_try_compose(struct v4l2_subdev *sd,
> > +			     struct v4l2_subdev_pad_config *cfg,
> > +			     unsigned int pad)
> > +{
> > +	return ERR_PTR(-ENOTTY);
> > +}
> > +
> > +#endif /* defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
> >
> >  extern const struct v4l2_file_operations v4l2_subdev_fops;
> >
>
> --
> Regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com

--t7eyulkiye2oena4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlymFzMACgkQcjQGjxah
Vjw8xBAAhUm6pUdVp4F0lw2ixGLMfUG49133bKXXFA+gsY0MkExGDpnQi6Djl+aN
f2PZ+muZZP5Zi82iiuxu2yae+WKW4clivHEQWPfL6FvPp7ST+DrDnYw7oKRGs9uF
iJ6lPKpi7vJXzOM7OakL/DByc/osYuXDzcfc9s91Yf8eBWnT0CIKqtGKnuAjgkSx
jkUnpIjzZkSDPrbaxcKqNkFoHSnzQuwyQwDuvMoVVxMIt4zAXBOuG35E33T+d9hU
U3Q/zTeGC5/5DXGEKIfUdHFmmsasfYeisUQwJDcH/RLHNXqXMLEciAY9aBeF3JRp
8wOgu33lv4ajD/nIee6Gk3ndD5WzJdGDYJAW06Ckg2LDV7mTN+01kj3Y5rcANoXR
DNhRSO1APCsyTZLG11KmXbSEYD0Q+dvIsBtQQVoKBs0qzmB3blHigoKdQ7s5xVbm
jRe/fPI1aSj6mXFwLTuyIXqWYiLZ9joW8XAy8dhgJ6JydiMoElaNmtW86TQZXJMr
1MMn27pqsdSNw1HuKlBi3hrdHLYNfOvcaKuopA1mfGaaE9GSLm/QgJB/EtFkNvno
OjbZ3e8kjbFUzla7K8TaEv9g5maFJKzUzBq5n1ogwacAyUt96YmknZv695Iwh0h/
6ZfpFq47WcNlS9WI/E9RuEKdlgWhZtUW7S3d7fEB9AQZMUGOUUs=
=SKhm
-----END PGP SIGNATURE-----

--t7eyulkiye2oena4--
