Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C67C4360F
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 13:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC66D21773
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 13:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfC1NPF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:15:05 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36109 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1NPF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 09:15:05 -0400
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E0D4B20000C;
        Thu, 28 Mar 2019 13:15:00 +0000 (UTC)
Date:   Thu, 28 Mar 2019 14:15:43 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/9] v4l: Add definitions for missing 32-bit RGB formats
Message-ID: <20190328131543.zlito5lm3n7mjyls@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-2-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xqwfstqlwmdumfuz"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-2-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--xqwfstqlwmdumfuz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Mar 28, 2019 at 09:07:15AM +0200, Laurent Pinchart wrote:
> The V4L2 API is missing the 32-bit RGB formats for the ABGR, XBGR, RGBA
> and RGBX component orders. Add them, using the same 4CCs as DRM.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 160 ++++++++++++++++++
>  include/uapi/linux/videodev2.h                |   4 +
>  2 files changed, 164 insertions(+)
>
> diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> index 6b3781c04dd5..055f9c89e787 100644
> --- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> +++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> @@ -453,6 +453,166 @@ next to each other in memory.
>        - r\ :sub:`1`
>        - r\ :sub:`0`
>
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +    * .. _V4L2-PIX-FMT-BGRA32:
> +
> +      - ``V4L2_PIX_FMT_BGRA32``
> +      - 'RA24'
> +
> +      - a\ :sub:`7`
> +      - a\ :sub:`6`
> +      - a\ :sub:`5`
> +      - a\ :sub:`4`
> +      - a\ :sub:`3`
> +      - a\ :sub:`2`
> +      - a\ :sub:`1`
> +      - a\ :sub:`0`
> +
> +      - b\ :sub:`7`
> +      - b\ :sub:`6`
> +      - b\ :sub:`5`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +
> +      - g\ :sub:`7`
> +      - g\ :sub:`6`
> +      - g\ :sub:`5`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +
> +      - r\ :sub:`7`
> +      - r\ :sub:`6`
> +      - r\ :sub:`5`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +    * .. _V4L2-PIX-FMT-BGRX32:
> +
> +      - ``V4L2_PIX_FMT_BGRX32``
> +      - 'RX24'
> +
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +
> +      - b\ :sub:`7`
> +      - b\ :sub:`6`
> +      - b\ :sub:`5`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +
> +      - g\ :sub:`7`
> +      - g\ :sub:`6`
> +      - g\ :sub:`5`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +
> +      - r\ :sub:`7`
> +      - r\ :sub:`6`
> +      - r\ :sub:`5`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +    * .. _V4L2-PIX-FMT-RGBA32:
> +
> +      - ``V4L2_PIX_FMT_RGBA32``
> +      - 'AB24'
> +
> +      - r\ :sub:`7`
> +      - r\ :sub:`6`
> +      - r\ :sub:`5`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +
> +      - g\ :sub:`7`
> +      - g\ :sub:`6`
> +      - g\ :sub:`5`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +
> +      - b\ :sub:`7`
> +      - b\ :sub:`6`
> +      - b\ :sub:`5`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +
> +      - a\ :sub:`7`
> +      - a\ :sub:`6`
> +      - a\ :sub:`5`
> +      - a\ :sub:`4`
> +      - a\ :sub:`3`
> +      - a\ :sub:`2`
> +      - a\ :sub:`1`
> +      - a\ :sub:`0`
> +    * .. _V4L2-PIX-FMT-RGBX32:
> +
> +      - ``V4L2_PIX_FMT_RGBX32``
> +      - 'XB24'
> +
> +      - r\ :sub:`7`
> +      - r\ :sub:`6`
> +      - r\ :sub:`5`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +
> +      - g\ :sub:`7`
> +      - g\ :sub:`6`
> +      - g\ :sub:`5`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +
> +      - b\ :sub:`7`
> +      - b\ :sub:`6`
> +      - b\ :sub:`5`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +
I'm trying to compare these with the existing 32-bit RGB formats in
pixfmt-packed-rgb.rst and I can't get how the orderig of components is
defined.

Ie your definitions here:

        bytes:  B0      B1      B2      B3
BGRA32          A       B       G       R
BGRX32          x       B       G       R
RGBA32          R       G       B       A
RGBX32          R       G       B       x

In the existing documentation:
ABGR32          B       G       R       A
XBGR32          B       G       R       x
ARGB32          A       R       G       B
XRGB32          x       R       G       B

So you're adding two BGR/RGB variations with 'X' or 'A' moved from the
first (for RGB) or last (for BGR) bytes to the last (for RGB) or first
(for BGR) bytes.

I cannot see a clear pattern (it seems RGB is ordered as you read the
components, while BGR is inverted?) so I assume the definition of the
component ordering scheme comes from a standard, does it? A reference
would help checking for errors :)

Thanks
   j

>        -
>        -
>        -
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 1db220da3bcc..4e5222726719 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -528,7 +528,11 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_BGR32   v4l2_fourcc('B', 'G', 'R', '4') /* 32  BGR-8-8-8-8   */
>  #define V4L2_PIX_FMT_ABGR32  v4l2_fourcc('A', 'R', '2', '4') /* 32  BGRA-8-8-8-8  */
>  #define V4L2_PIX_FMT_XBGR32  v4l2_fourcc('X', 'R', '2', '4') /* 32  BGRX-8-8-8-8  */
> +#define V4L2_PIX_FMT_BGRA32  v4l2_fourcc('R', 'A', '2', '4') /* 32  ABGR-8-8-8-8  */
> +#define V4L2_PIX_FMT_BGRX32  v4l2_fourcc('R', 'X', '2', '4') /* 32  XBGR-8-8-8-8  */
>  #define V4L2_PIX_FMT_RGB32   v4l2_fourcc('R', 'G', 'B', '4') /* 32  RGB-8-8-8-8   */
> +#define V4L2_PIX_FMT_RGBA32  v4l2_fourcc('A', 'B', '2', '4') /* 32  RGBA-8-8-8-8  */
> +#define V4L2_PIX_FMT_RGBX32  v4l2_fourcc('X', 'B', '2', '4') /* 32  RGBX-8-8-8-8  */
>  #define V4L2_PIX_FMT_ARGB32  v4l2_fourcc('B', 'A', '2', '4') /* 32  ARGB-8-8-8-8  */
>  #define V4L2_PIX_FMT_XRGB32  v4l2_fourcc('B', 'X', '2', '4') /* 32  XRGB-8-8-8-8  */
>
> --
> Regards,
>
> Laurent Pinchart
>

--xqwfstqlwmdumfuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlycyP8ACgkQcjQGjxah
VjyMdw/+No2e7HnP4Xc9CRlr0/8v5CT3zSDfrKiZnsqOcrzXDmoSyg4LDmMwzZSU
cAOZUN+2/tQ9A4az3jkXizxcy9+8Oh18LpMkzr3yn48/vKnYmKqyExf0FcAlzbxg
fB6lvwT2+Mp9x3GGjMcge85N9RfcVaaiLTXwbKlNfkBW5SDhY89B3PYTmMMhclt3
bX235JE27MYUDYuENl7Ib57PwhzJK4gAdQXHOgXIs/oveuC6lPzxML6qGhIADrSl
pmul8kdLDQDNhU4QWolwoGmYB/9wtWJ/zzLF9RYg+GxVfkL9JwoR7qU3PGt3ASzn
4pa2gXd3MvP2/M4r5DjxjxRxx2/AodJAuqeD7h2XcqptWkfj/7x/u4Cw1aFhmy6g
0Ef6UDRwTN2TUtd4R4d2KiYq7A3Z/ydDJYxq51mlLjoINzAkT5Pdbu/ZFFLKUGe/
M5lYlJRxi2bExHeWbimbhYAHBMzzgWZX7YJqkYpQLwvMHodcGtpORMxtZQL/gAr6
md3P3nF77kAzwPp9+2wPhr7+jn0Cd1aSxCueOtl7dKLAsFaCHjkBwiPZUDkEYDaX
rWn/zZIPyrGAxDC2SwkcyWvXY1oTFl0pP4VebtJcun93VzQLXAYzSCGq3EiArGCR
E6gUK1g3Y1WO3d0kEIxg2xKUN0iGHyWX2WxrxqoAdZn6r3FeyX4=
=C2KS
-----END PGP SIGNATURE-----

--xqwfstqlwmdumfuz--
