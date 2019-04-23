Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86987C282E1
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB4E21738
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 16:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfDWQzI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:55:08 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51819 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfDWQzI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 12:55:08 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1BB15240003;
        Tue, 23 Apr 2019 16:55:04 +0000 (UTC)
Date:   Tue, 23 Apr 2019 18:56:00 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 6/9] media: vsp1: Add support for missing 16-bit RGB555
 formats
Message-ID: <20190423165600.vavevn5iemzkzu5t@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-7-laurent.pinchart+renesas@ideasonboard.com>
 <20190423135508.ppdphyqy2z55ewhm@uno.localdomain>
 <20190423144651.GA16111@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="har4go3hnnokobjr"
Content-Disposition: inline
In-Reply-To: <20190423144651.GA16111@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--har4go3hnnokobjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Tue, Apr 23, 2019 at 05:46:51PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> On Tue, Apr 23, 2019 at 03:55:08PM +0200, Jacopo Mondi wrote:
> > On Thu, Mar 28, 2019 at 09:07:20AM +0200, Laurent Pinchart wrote:
> > > Add support for the V4L2_PIX_FMT_RGBA555, V4L2_PIX_FMT_RGBX555,
> > > V4L2_PIX_FMT_ABGR555, V4L2_PIX_FMT_XBGR555, V4L2_PIX_FMT_BGRA555 and
> > > V4L2_PIX_FMT_BGRX555 formats to the VSP driver.
> > >
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > >  drivers/media/platform/vsp1/vsp1_pipe.c | 32 +++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > >
> > > diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
> > > index f6665871aa11..92f71dec99c5 100644
> > > --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> > > +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> > > @@ -66,14 +66,46 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
> > >  	  VI6_FMT_BGRA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > >  	  VI6_RPF_DSWAP_P_WDS,
> > >  	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> > > +#define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
> >
> > Why is this here? I see the exact same line in videodev2.h.
> > Is this a leftover?
>
> Oops. It is. I'm sorry, I'll remove that.
>
> > >  	{ V4L2_PIX_FMT_ARGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
> > >  	  VI6_FMT_ARGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > >  	  VI6_RPF_DSWAP_P_WDS,
> > >  	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> > > +#define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
> >
> > same here and below
> >
> > >  	{ V4L2_PIX_FMT_XRGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
> > >  	  VI6_FMT_XRGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > >  	  VI6_RPF_DSWAP_P_WDS,
> > >  	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> > > +#define V4L2_PIX_FMT_RGBA555 v4l2_fourcc('R', 'A', '1', '5') /* 16  RGBA-5-5-5-1  */
> > > +	{ V4L2_PIX_FMT_RGBA555, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_RGBA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > > +	  VI6_RPF_DSWAP_P_WDS,
> > > +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> > > +#define V4L2_PIX_FMT_RGBX555 v4l2_fourcc('R', 'X', '1', '5') /* 16  RGBX-5-5-5-1  */
> > > +	{ V4L2_PIX_FMT_RGBX555, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_RGBX_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > > +	  VI6_RPF_DSWAP_P_WDS,
> > > +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> > > +#define V4L2_PIX_FMT_ABGR555 v4l2_fourcc('A', 'B', '1', '5') /* 16  ABGR-1-5-5-5  */
> > > +	{ V4L2_PIX_FMT_ABGR555, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_ABGR_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > > +	  VI6_RPF_DSWAP_P_WDS,
> > > +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> > > +#define V4L2_PIX_FMT_XBGR555 v4l2_fourcc('X', 'B', '1', '5') /* 16  XBGR-1-5-5-5  */
> > > +	{ V4L2_PIX_FMT_XBGR555, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_ABGR_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > > +	  VI6_RPF_DSWAP_P_WDS,
> > > +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> >
> > Looks good, additional defines apart
> >
> > > +#define V4L2_PIX_FMT_BGRA555 v4l2_fourcc('B', 'A', '1', '5') /* 16  BGRA-5-5-5-1  */
> > > +	{ V4L2_PIX_FMT_BGRA555, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_BGRA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > > +	  VI6_RPF_DSWAP_P_WDS,
> > > +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> >
> >
> > As I read this:
> > V4L2_PIX_FMT_BGRA555            VI6_FMT_BGRA_5551        LLS|LWS|WDS
> > gggrrrrr abbbbbgg               bbbbbggg ggrrrrra       ggrrrrra bbbbbggg
>
> Isn't V4L2_PIX_FMT_BGRA555 is defined as
>
> g1 g0 r4 r3 r2 r1 r0 a | b4 b3 b2 b1 b0 g4 g3 g2
>
Ah yes, I got fooled by how it is described in the documentation

    * .. _V4L2-PIX-FMT-BGRA555:

      - ``V4L2_PIX_FMT_BGRA555``
      - 'BA15'

      - g\ :sub:`2`
      - g\ :sub:`1`
      - g\ :sub:`0`
      - r\ :sub:`4`
      - r\ :sub:`3`
      - r\ :sub:`2`
      - r\ :sub:`1`
      - r\ :sub:`0`
      - a

      - b\ :sub:`4`
      - b\ :sub:`3`
      - b\ :sub:`2`
      - b\ :sub:`1`
      - b\ :sub:`0`
      - g\ :sub:`4`
      - g\ :sub:`3`
      -

The empty line between 'a' and b4 made me think those were 2 bytes,
but apparently, they're not.

So, it's fine! Thanks for checking!

> ?
>
> > They seems different to me:
> >         gggrrrrr abbbbbgg
> >         ggrrrrra bbbbbggg
> >
> > But I have not find any better combination from table 23.10 that would
> > result in the desired 'gggrrrrr abbbbbgg' ordering.
> >
> > > +#define V4L2_PIX_FMT_BGRX555 v4l2_fourcc('B', 'X', '1', '5') /* 16  BGRX-5-5-5-1  */
> > > +	{ V4L2_PIX_FMT_BGRX555, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_BGRA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > > +	  VI6_RPF_DSWAP_P_WDS,
> > > +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> >
> > Same as above.
> >
> > The last two entries apart:
> > Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> >
> > >  	{ V4L2_PIX_FMT_RGB565, MEDIA_BUS_FMT_ARGB8888_1X32,
> > >  	  VI6_FMT_RGB_565, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > >  	  VI6_RPF_DSWAP_P_WDS,
>
> --
> Regards,
>
> Laurent Pinchart

--har4go3hnnokobjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly/Q6AACgkQcjQGjxah
VjwWxQ/+MG/hVRrXltTZ6KDFfvVbD811vLBM7jxF9KvoYyVbpTpBOBvPo8a2IsXn
GY2IOWGWeABzMYWbjZMpvLY40ysq2nGZ+xc+8em6I5IRJ5thGmksYLwA1zeuKEgC
d+OkxUXa0zB6PrzQtcqmQuQd3xKzpTuCTeP8guK/C7nwS5B2RhnChWuH2UKCqZZL
d7oGMb/YVOXftxEEC4t+NM8Mp3Sb0ZSZTy8yD6Rti6LLRC179ixm/XlNTvIYh7B4
5JvcQKKpKhhTkF0uhcnKEPlbXJsevtcWLaq6H8Ava0MzPAObYMJ7mKWKUz37qZTL
EGtHp5/BgBXgHqdYDtton1FEiws5qXDN7PQrdefqTOloDBu4p9ZE/DZe/1R9arh6
Dhbz0AyPTXYQVbsfMi5kyjb4Qq9J6QS4d6j1lJKR/B6kfYirLmkPjusw0CNhJyet
uKuI4QFjt/npSsDYJw9vDJM6C6BRT7kiC9ii79e603FWQl+fGw8nXRxT86dK3cpe
AOxEboriVaY287XDJvr+1/E0nyNiQEX7TkQII4TI/jFwsbpR7yhCUFWGG8QI2zBK
UznjBe5ok2qi5nRjZCegsibB0+21J9cOJZAsZmxKj2huktXuu2kP2Z6LOen6jftm
iepF8CrCbXQr9cG2JkpcptBvNr3r9qaP0gaeHY22kcXPwz5C1dE=
=Byj4
-----END PGP SIGNATURE-----

--har4go3hnnokobjr--
