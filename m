Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8278C10F0E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13992082E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 16:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfDDQBY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:01:24 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53473 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDQBX (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 12:01:23 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E10771BF205;
        Thu,  4 Apr 2019 16:01:19 +0000 (UTC)
Date:   Thu, 4 Apr 2019 18:02:05 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/9] v4l: Add definitions for missing 32-bit RGB formats
Message-ID: <20190404160205.abekrybup23fo7ad@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-2-laurent.pinchart+renesas@ideasonboard.com>
 <20190328131543.zlito5lm3n7mjyls@uno.localdomain>
 <20190402121200.GX4805@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kcph5s4d5x473cw2"
Content-Disposition: inline
In-Reply-To: <20190402121200.GX4805@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--kcph5s4d5x473cw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,
   thanks for explaining.

On Tue, Apr 02, 2019 at 03:12:00PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> On Thu, Mar 28, 2019 at 02:15:43PM +0100, Jacopo Mondi wrote:
> > On Thu, Mar 28, 2019 at 09:07:15AM +0200, Laurent Pinchart wrote:
> > > The V4L2 API is missing the 32-bit RGB formats for the ABGR, XBGR, RGBA
> > > and RGBX component orders. Add them, using the same 4CCs as DRM.
> > >
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > >  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 160 ++++++++++++++++++
> > >  include/uapi/linux/videodev2.h                |   4 +
> > >  2 files changed, 164 insertions(+)
> > >
> > > diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > > index 6b3781c04dd5..055f9c89e787 100644
> > > --- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > > +++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > > @@ -453,6 +453,166 @@ next to each other in memory.
> > >        - r\ :sub:`1`
> > >        - r\ :sub:`0`
> > >
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +    * .. _V4L2-PIX-FMT-BGRA32:
> > > +
> > > +      - ``V4L2_PIX_FMT_BGRA32``
> > > +      - 'RA24'
> > > +
> > > +      - a\ :sub:`7`
> > > +      - a\ :sub:`6`
> > > +      - a\ :sub:`5`
> > > +      - a\ :sub:`4`
> > > +      - a\ :sub:`3`
> > > +      - a\ :sub:`2`
> > > +      - a\ :sub:`1`
> > > +      - a\ :sub:`0`
> > > +
> > > +      - b\ :sub:`7`
> > > +      - b\ :sub:`6`
> > > +      - b\ :sub:`5`
> > > +      - b\ :sub:`4`
> > > +      - b\ :sub:`3`
> > > +      - b\ :sub:`2`
> > > +      - b\ :sub:`1`
> > > +      - b\ :sub:`0`
> > > +
> > > +      - g\ :sub:`7`
> > > +      - g\ :sub:`6`
> > > +      - g\ :sub:`5`
> > > +      - g\ :sub:`4`
> > > +      - g\ :sub:`3`
> > > +      - g\ :sub:`2`
> > > +      - g\ :sub:`1`
> > > +      - g\ :sub:`0`
> > > +
> > > +      - r\ :sub:`7`
> > > +      - r\ :sub:`6`
> > > +      - r\ :sub:`5`
> > > +      - r\ :sub:`4`
> > > +      - r\ :sub:`3`
> > > +      - r\ :sub:`2`
> > > +      - r\ :sub:`1`
> > > +      - r\ :sub:`0`
> > > +    * .. _V4L2-PIX-FMT-BGRX32:
> > > +
> > > +      - ``V4L2_PIX_FMT_BGRX32``
> > > +      - 'RX24'
> > > +
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +
> > > +      - b\ :sub:`7`
> > > +      - b\ :sub:`6`
> > > +      - b\ :sub:`5`
> > > +      - b\ :sub:`4`
> > > +      - b\ :sub:`3`
> > > +      - b\ :sub:`2`
> > > +      - b\ :sub:`1`
> > > +      - b\ :sub:`0`
> > > +
> > > +      - g\ :sub:`7`
> > > +      - g\ :sub:`6`
> > > +      - g\ :sub:`5`
> > > +      - g\ :sub:`4`
> > > +      - g\ :sub:`3`
> > > +      - g\ :sub:`2`
> > > +      - g\ :sub:`1`
> > > +      - g\ :sub:`0`
> > > +
> > > +      - r\ :sub:`7`
> > > +      - r\ :sub:`6`
> > > +      - r\ :sub:`5`
> > > +      - r\ :sub:`4`
> > > +      - r\ :sub:`3`
> > > +      - r\ :sub:`2`
> > > +      - r\ :sub:`1`
> > > +      - r\ :sub:`0`
> > > +    * .. _V4L2-PIX-FMT-RGBA32:
> > > +
> > > +      - ``V4L2_PIX_FMT_RGBA32``
> > > +      - 'AB24'
> > > +
> > > +      - r\ :sub:`7`
> > > +      - r\ :sub:`6`
> > > +      - r\ :sub:`5`
> > > +      - r\ :sub:`4`
> > > +      - r\ :sub:`3`
> > > +      - r\ :sub:`2`
> > > +      - r\ :sub:`1`
> > > +      - r\ :sub:`0`
> > > +
> > > +      - g\ :sub:`7`
> > > +      - g\ :sub:`6`
> > > +      - g\ :sub:`5`
> > > +      - g\ :sub:`4`
> > > +      - g\ :sub:`3`
> > > +      - g\ :sub:`2`
> > > +      - g\ :sub:`1`
> > > +      - g\ :sub:`0`
> > > +
> > > +      - b\ :sub:`7`
> > > +      - b\ :sub:`6`
> > > +      - b\ :sub:`5`
> > > +      - b\ :sub:`4`
> > > +      - b\ :sub:`3`
> > > +      - b\ :sub:`2`
> > > +      - b\ :sub:`1`
> > > +      - b\ :sub:`0`
> > > +
> > > +      - a\ :sub:`7`
> > > +      - a\ :sub:`6`
> > > +      - a\ :sub:`5`
> > > +      - a\ :sub:`4`
> > > +      - a\ :sub:`3`
> > > +      - a\ :sub:`2`
> > > +      - a\ :sub:`1`
> > > +      - a\ :sub:`0`
> > > +    * .. _V4L2-PIX-FMT-RGBX32:
> > > +
> > > +      - ``V4L2_PIX_FMT_RGBX32``
> > > +      - 'XB24'
> > > +
> > > +      - r\ :sub:`7`
> > > +      - r\ :sub:`6`
> > > +      - r\ :sub:`5`
> > > +      - r\ :sub:`4`
> > > +      - r\ :sub:`3`
> > > +      - r\ :sub:`2`
> > > +      - r\ :sub:`1`
> > > +      - r\ :sub:`0`
> > > +
> > > +      - g\ :sub:`7`
> > > +      - g\ :sub:`6`
> > > +      - g\ :sub:`5`
> > > +      - g\ :sub:`4`
> > > +      - g\ :sub:`3`
> > > +      - g\ :sub:`2`
> > > +      - g\ :sub:`1`
> > > +      - g\ :sub:`0`
> > > +
> > > +      - b\ :sub:`7`
> > > +      - b\ :sub:`6`
> > > +      - b\ :sub:`5`
> > > +      - b\ :sub:`4`
> > > +      - b\ :sub:`3`
> > > +      - b\ :sub:`2`
> > > +      - b\ :sub:`1`
> > > +      - b\ :sub:`0`
> > > +
> >
> > I'm trying to compare these with the existing 32-bit RGB formats in
> > pixfmt-packed-rgb.rst and I can't get how the orderig of components is
> > defined.
>
> Pixel formats are all a big mess :-)
>
> > Ie your definitions here:
> >
> >         bytes:  B0      B1      B2      B3
> > BGRA32          A       B       G       R
> > BGRX32          x       B       G       R
> > RGBA32          R       G       B       A
> > RGBX32          R       G       B       x
> >
> > In the existing documentation:
> > ABGR32          B       G       R       A
> > XBGR32          B       G       R       x
> > ARGB32          A       R       G       B
> > XRGB32          x       R       G       B
>
> > So you're adding two BGR/RGB variations with 'X' or 'A' moved from the
> > first (for RGB) or last (for BGR) bytes to the last (for RGB) or first
> > (for BGR) bytes.
> >
> > I cannot see a clear pattern (it seems RGB is ordered as you read the
> > components, while BGR is inverted?) so I assume the definition of the
> > component ordering scheme comes from a standard, does it? A reference
> > would help checking for errors :)
>
> The existing formats are pretty inconsistent. I suppose ARGB and XRGB
> were added first, with the format names corresponding to the pixel order
> in memory. Then a need to support BGRA and BGRX arose, and the format
> names were set to ABGR32 and XBGR32 instead of BGRA32 and BGRX32.
> Unfortuantely we can't fix this as it's an ABI, so I had to follow the
> same scheme for the new formats. RGBA and RGBX are fine as the RGBA31
> and RGBX32 names were free, but for ABGR and XBGR I had to use the
> BGRA32 and BGRX32 names.
>

The generated documentation seems good to me.

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

> > >        -
> > >        -
> > >        -
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > > index 1db220da3bcc..4e5222726719 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -528,7 +528,11 @@ struct v4l2_pix_format {
> > >  #define V4L2_PIX_FMT_BGR32   v4l2_fourcc('B', 'G', 'R', '4') /* 32  BGR-8-8-8-8   */
> > >  #define V4L2_PIX_FMT_ABGR32  v4l2_fourcc('A', 'R', '2', '4') /* 32  BGRA-8-8-8-8  */
> > >  #define V4L2_PIX_FMT_XBGR32  v4l2_fourcc('X', 'R', '2', '4') /* 32  BGRX-8-8-8-8  */
> > > +#define V4L2_PIX_FMT_BGRA32  v4l2_fourcc('R', 'A', '2', '4') /* 32  ABGR-8-8-8-8  */
> > > +#define V4L2_PIX_FMT_BGRX32  v4l2_fourcc('R', 'X', '2', '4') /* 32  XBGR-8-8-8-8  */
> > >  #define V4L2_PIX_FMT_RGB32   v4l2_fourcc('R', 'G', 'B', '4') /* 32  RGB-8-8-8-8   */
> > > +#define V4L2_PIX_FMT_RGBA32  v4l2_fourcc('A', 'B', '2', '4') /* 32  RGBA-8-8-8-8  */
> > > +#define V4L2_PIX_FMT_RGBX32  v4l2_fourcc('X', 'B', '2', '4') /* 32  RGBX-8-8-8-8  */
> > >  #define V4L2_PIX_FMT_ARGB32  v4l2_fourcc('B', 'A', '2', '4') /* 32  ARGB-8-8-8-8  */
> > >  #define V4L2_PIX_FMT_XRGB32  v4l2_fourcc('B', 'X', '2', '4') /* 32  XRGB-8-8-8-8  */
> > >
>
> --
> Regards,
>
> Laurent Pinchart

--kcph5s4d5x473cw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlymKn0ACgkQcjQGjxah
VjwOmg//eTZVvHRpyn5I+zODzxs9T7YA5ypGoraIQwsmKqhhisldssm3TRuf1xpg
aOE89YzbhvCrBKfYQdHHgHgPvcqUR34RLe380rYDnj/W/ar+hKCKEAy4QSyI/KJk
hBP6V8Sou4jpoBWze84J4KlB5OqbCrcEt5uaEXhUoVWD5CyTTyV34/EsQBJgfr03
ZBf1gO7+2yUI1rgkw9d4mR9ZSGVfyiBOXkefd23EcS7sGkepXyybqnB/yT+3FAOr
ftg0TF3qV/+IE/+cpvmziVn3MK7BQPU1h0jCU5/e96RfGIiAEp5MweKeS1rbzh2j
j8or3cfgFPx+aurmE7orBtZcff3G6UhsdYHb1IvYWRj8JGpVoXlfr8mhT/BvFZun
4RCuuv+tDKEoln1HASVxT1vWB40xKBrmFGjc/5Pz2bHwCTkYVJejCEstTM9lsFeU
+Oje73NY+Fwuj64cRFzBgDNJARQeeC0BRTx1l2Y/vlro3RcsDZr8PcBiJD9tW8Zw
RyqNU86s6dRJOhboQv7bdO7Tl1dhbVySB2fiLtJEKCeziWW8tpr2uTX/vxx4eFM1
aPfZlgA4Q3bZCH/spinbCujJacoFkAN0JGksPlLZMuauHIbLHM5PMW7m9McOJqzT
QJ0fEfPfkPvNzJe2weCk5bzcmaPCTgtsCjPRHxXM6Bv+EiJQ2Uk=
=k8Wb
-----END PGP SIGNATURE-----

--kcph5s4d5x473cw2--
