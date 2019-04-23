Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28621C282E1
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027A520645
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 13:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfDWNVC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:21:02 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38575 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfDWNVC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 09:21:02 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 78FDB240007;
        Tue, 23 Apr 2019 13:20:58 +0000 (UTC)
Date:   Tue, 23 Apr 2019 15:21:53 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 4/9] media: vsp1: Add support for missing 32-bit RGB
 formats
Message-ID: <20190423132153.xfvy4dn3cflzotuf@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-5-laurent.pinchart+renesas@ideasonboard.com>
 <20190404173905.n6mupqzvcr5vwhwu@uno.localdomain>
 <20190418060645.GC4806@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hd3bbrbxqcyzbszl"
Content-Disposition: inline
In-Reply-To: <20190418060645.GC4806@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--hd3bbrbxqcyzbszl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Apr 18, 2019 at 09:06:45AM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> On Thu, Apr 04, 2019 at 07:39:05PM +0200, Jacopo Mondi wrote:
> > HI Laurent,
> >   if you help me out understanding the bit swapping procedure in VSP
> > I would be more confident in saying I actually reviewed the series.
>
> I'll try my best :-)
>

Thanks!

> > On Thu, Mar 28, 2019 at 09:07:18AM +0200, Laurent Pinchart wrote:
> > > Add support for the V4L2_PIX_FMT_BGRA32, V4L2_PIX_FMT_BGRX32,
> > > V4L2_PIX_FMT_RGBA32 and V4L2_PIX_FMT_RGBX32 formats to the VSP driver.
> > >
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > >  drivers/media/platform/vsp1/vsp1_pipe.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
> > > index 54ff539ffea0..9f08d85e89d7 100644
> > > --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> > > +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> > > @@ -68,6 +68,20 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
> > >  	{ V4L2_PIX_FMT_XBGR32, MEDIA_BUS_FMT_ARGB8888_1X32,
> > >  	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> > >  	  1, { 32, 0, 0 }, false, false, 1, 1, false },
> > > +	{ V4L2_PIX_FMT_BGRA32, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> > > +	  1, { 32, 0, 0 }, false, false, 1, 1, true },
> > > +	{ V4L2_PIX_FMT_BGRX32, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> > > +	  1, { 32, 0, 0 }, false, false, 1, 1, false },
> > > +	{ V4L2_PIX_FMT_RGBA32, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > > +	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
> > > +	  1, { 32, 0, 0 }, false, false, 1, 1, true },
> > > +	{ V4L2_PIX_FMT_RGBX32, MEDIA_BUS_FMT_ARGB8888_1X32,
> > > +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > > +	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
> > > +	  1, { 32, 0, 0 }, false, false, 1, 1, false },
> >
> >
> > So, this is how I interpret the above lines for format BGRA32 (the
> > same applies to RGBA32 fwiw)
> >
> >         Bytes:          B3      B2      B1      B0
> > Input: ARGB8888_1X32:   A       R       G       B
>
> Note that, at the bus level, there's no byte ordering. Data is
> transmitted in parallel on a 32-bit bus (at least as far as I know). But
> this doesn't matter much anyway.
>

Indeed, but I should not use this as the description of the input
format but VI6_FMT_RGBA_8888, as you pointed out, which reads indeed
as RGBA (out of curiosity, what is the mbus code used for then?)

> > Out:   BGRA32           R       G       B       A
> >
> > If I apply LLS and LWS on the "Input Row", according to the table I get
> >
> >  Position in Table 32.10:    0  1  2  3
> >  IN Components ordering:     A  R  G  B  (ARGB8888_1X32
> >  Position in Table 32.10:    3  2  1  0  (with LLS and LWS applied)
> >  OUT Components ordering:    B  G  R  A
> >
> > Which to me is the ordering of components of the format named
> > V4L2_PIX_FMT_ARGB32 and not BGRA32 which is instead, as reported RGBA
> > (GREAT naming here!)
> >
> > What am I doing wrong?
>
> You need to take entry VI6_FMT_RGBA_8888 (0x14) in table 32.10, which
> reads R G B A. Applying LLS and LWS but not WDS and BTS swaps the bytes
> to A B G R (see table 32.13), so the pixel is written to memory in the A
> B G R order, corresponding to V4L2_PIX_FMT_BGRA32 (I agree with you
> about the insane naming for the 4CC, but that's not my fault :-().

Thanks, now that I applied flags to the correct input format, the
patch seems correct to me.

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

>
> > >  	{ V4L2_PIX_FMT_ARGB32, MEDIA_BUS_FMT_ARGB8888_1X32,
> > >  	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> > >  	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
>
> --
> Regards,
>
> Laurent Pinchart

--hd3bbrbxqcyzbszl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly/EXEACgkQcjQGjxah
VjxbvA/7BIwZm1EDAo7PUFrBQv1Pa6DMs0hXy3LhsACmId9B6f4yLsrFtyma1+GT
iyyx2ngkEQTuiGImRrGun8GSEmMxJfNtPrNbDDro9lobJqa+79lcopGmbgos3dqe
2cywc45xsVinSCtcA1u10v+40Rii2dcx0z6bPnzVXz/amQH59nKgo3+Kyk+LwDJu
ysfjXXvDw3Av1SwktuC8jLmuzbKamGAu37AM31YpAkl42UVPXSbTj71KOKrE2+Ja
tV+9xMjTIeVn5DryU4Hm0+n9Jtjx45dqfNOCB9Kux0mqARfJ27quHmkKXi6jJRm2
a/16X2ITWPJTKXYdyV7ANh8mCDm4cCTax8ZJ6shcwggsS0SJ0rOPOzQ5se+5LAIU
lSWT9UW6o8+T+sPk/qz+lTnP5W/OKKf8tliRhNNiB3lAhuj0/SeO66dS46H1woaA
YGevU7I5i2eqn5lGLBHOBp7UatJR3vSQaPf7uXs2WK2BsX9LkMu3RRwIbkq4UH6Y
ihZ1P3A+2uTQHKbm5Vu4iFQW3OqJVZLavHSqBdLdVt0aFby6xlVzE7m6rQspEDN+
fh093RNL6JPYjwkBqkjvrMIl78WC+XR6dfIMPnBXdHk+SEuHc/9IacuhWMSGEYNb
DVcW0ZFOierI/fzPqNPJJgBFsXGpejzIB9Ov0M3nLQ4QcWGBEF4=
=SYcg
-----END PGP SIGNATURE-----

--hd3bbrbxqcyzbszl--
