Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADBDC10F0E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B430B206DD
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 15:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDDP46 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:56:58 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:48171 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDP46 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 11:56:58 -0400
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0CC0F200009;
        Thu,  4 Apr 2019 15:56:53 +0000 (UTC)
Date:   Thu, 4 Apr 2019 17:57:39 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 3/9] v4l: Add definitions for missing 16-bit RGB555
 formats
Message-ID: <20190404155739.byhj4hqid2o6aqb4@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-4-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gz2xmslb7qgg4jnc"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-4-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--gz2xmslb7qgg4jnc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent

On Thu, Mar 28, 2019 at 09:07:17AM +0200, Laurent Pinchart wrote:
> The V4L2 API is missing the 16-bit RGB555 formats for the RGBA, RGBX,
> ABGR, XBGR, BGRA and BGRX component orders. Add them, using the same
> 4CCs as DRM.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 138 ++++++++++++++++++
>  include/uapi/linux/videodev2.h                |   6 +
>  2 files changed, 144 insertions(+)
>
> diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> index b475cbba492f..9a9c1993b0fd 100644
> --- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> +++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> @@ -323,6 +323,144 @@ next to each other in memory.
>        - g\ :sub:`4`
>        - g\ :sub:`3`
>        -
> +    * .. _V4L2-PIX-FMT-RGBA555:
> +
> +      - ``V4L2_PIX_FMT_RGBA555``
> +      - 'RA15'
> +
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - a
> +
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      -
> +    * .. _V4L2-PIX-FMT-RGBX555:
> +
> +      - ``V4L2_PIX_FMT_RGBX555``
> +      - 'RX15'
> +
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      -
> +
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      -
> +    * .. _V4L2-PIX-FMT-ABGR555:
> +
> +      - ``V4L2_PIX_FMT_ABGR555``
> +      - 'AB15'
> +
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +
> +      - a
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      -
> +    * .. _V4L2-PIX-FMT-XBGR555:
> +
> +      - ``V4L2_PIX_FMT_XBGR555``
> +      - 'XB15'
> +
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +
> +      -
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      -
> +    * .. _V4L2-PIX-FMT-BGRA555:
> +
> +      - ``V4L2_PIX_FMT_BGRA555``
> +      - 'BA15'
> +
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - a
> +
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      -
> +    * .. _V4L2-PIX-FMT-BGRX555:
> +
> +      - ``V4L2_PIX_FMT_BGRX555``
> +      - 'BX15'
> +
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      -
> +
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      -

I see the last 4 formats are identical in their components
disposition. Is this intended?

                   B1                          B0
          b7                   b0   b7                  b0
ABGR555 | g2 g1 g0 b4 b3 b2 b1 b0 | a r4 r3 r2 r1 r0 g4 g3 |
XBGR555 | g2 g1 g0 b4 b3 b2 b1 b0 | x r4 r3 r2 r1 r0 g4 g3 |
BGRA555 | g2 g1 g0 b4 b3 b2 b1 b0 | a r4 r3 r2 r1 r0 g4 g3 |
BGRX555 | g2 g1 g0 b4 b3 b2 b1 b0 | x r4 r3 r2 r1 r0 g4 g3 |

If there is any correlation with the naming scheme (but I think
there's not, at least not a strict one) 'a' and 'x' of BGR* formats
should be in the most significant bit of Byte 1.

Thanks
  j

>      * .. _V4L2-PIX-FMT-RGB565:
>
>        - ``V4L2_PIX_FMT_RGB565``
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index df9fa78a6ab7..fb6f01a7c91c 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -523,6 +523,12 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_RGB555  v4l2_fourcc('R', 'G', 'B', 'O') /* 16  RGB-5-5-5     */
>  #define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
>  #define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
> +#define V4L2_PIX_FMT_RGBA555 v4l2_fourcc('R', 'A', '1', '5') /* 16  RGBA-5-5-5-1  */
> +#define V4L2_PIX_FMT_RGBX555 v4l2_fourcc('R', 'X', '1', '5') /* 16  RGBX-5-5-5-1  */
> +#define V4L2_PIX_FMT_ABGR555 v4l2_fourcc('A', 'B', '1', '5') /* 16  ABGR-1-5-5-5  */
> +#define V4L2_PIX_FMT_XBGR555 v4l2_fourcc('X', 'B', '1', '5') /* 16  XBGR-1-5-5-5  */
> +#define V4L2_PIX_FMT_BGRA555 v4l2_fourcc('B', 'A', '1', '5') /* 16  BGRA-5-5-5-1  */
> +#define V4L2_PIX_FMT_BGRX555 v4l2_fourcc('B', 'X', '1', '5') /* 16  BGRX-5-5-5-1  */
>  #define V4L2_PIX_FMT_RGB565  v4l2_fourcc('R', 'G', 'B', 'P') /* 16  RGB-5-6-5     */
>  #define V4L2_PIX_FMT_RGB555X v4l2_fourcc('R', 'G', 'B', 'Q') /* 16  RGB-5-5-5 BE  */
>  #define V4L2_PIX_FMT_ARGB555X v4l2_fourcc_be('A', 'R', '1', '5') /* 16  ARGB-5-5-5 BE */
> --
> Regards,
>
> Laurent Pinchart
>

--gz2xmslb7qgg4jnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlymKXMACgkQcjQGjxah
VjzpIQ/+Jq2IEMigJGw79IbTJw4XdlGbBE4PJTunPUtMBwFCVfDw7x+oO+nCQUzy
XlvEytlxYOftDg1I4oADO9hhxZirejAKKJMvEJ2xEnybfn66UbdKV+lihbEjgWrG
zLG8OUVURbAH7hiAleG0JRr7WlEc6MQojknCGKwFLe149iDUq/7OYkYjyaNC9GqC
CjNdb1wfeWYjGBVHOtM+9jHS6hVrSV1CWFtMuVdclEe7WnFveU0sbOrmo0TMG6vH
icrQBtAKzGYedxTp/R6DVh0gWMIx81I84JS7V31m0BhjyBBbAt2Uy9VGGuGWXbme
QN1RQkF8PlQ5jjKCncE7HG+CL0uWehugh/5bfnlBVIES1esh/3wliToqNRDhYuP5
4i7HNX/f9cF1e1D6GqGTXEndszlnpclKVEfRz1iQI3fBTdhPCUSQ+Rzm6wJkxozw
qSsdq0Xs+h1y3MHB4n/Rh4bXa3w+Yv5YM+Kuba4qJtd705LIgSfF1FHj2u96YNzh
ixtIhpjkWPDpQ84BR139s0Y43tBy4eDbDLMhavVpHt4+IVLFXBlY+VwBAqA0LwRO
av//u3ij6fuD20hdbyTmDodk67KfX2M+pvTEAsZ3Cyre6Bz+bSv4f3F03OTLtBx4
JKnGs3GlVxxwFzUrzWsyL0ImOiMIHI5TMgfMDy0UD+gAbxXHo+c=
=H9GR
-----END PGP SIGNATURE-----

--gz2xmslb7qgg4jnc--
