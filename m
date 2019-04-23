Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B99C282E1
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 11:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA89121738
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 11:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDWLwq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:52:46 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45399 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWLwp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 07:52:45 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3945620003;
        Tue, 23 Apr 2019 11:52:42 +0000 (UTC)
Date:   Tue, 23 Apr 2019 13:53:37 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v1.1 3/9] v4l: Add definitions for missing 16-bit RGB555
 formats
Message-ID: <20190423115337.2ve2j6cg254yduor@uno.localdomain>
References: <20190328070723.26553-4-laurent.pinchart+renesas@ideasonboard.com>
 <20190418062711.15224-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s3taerhrz7gu7vqs"
Content-Disposition: inline
In-Reply-To: <20190418062711.15224-1-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--s3taerhrz7gu7vqs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Apr 18, 2019 at 09:27:11AM +0300, Laurent Pinchart wrote:
> The V4L2 API is missing the 16-bit RGB555 formats for the RGBA, RGBX,
> ABGR, XBGR, BGRA and BGRX component orders. Add them, using the same
> 4CCs as DRM.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
> Changes since v1:
>
> - Fixed the BGRA555 and BGRX555 formats

With this fixed (happy my wrong comment lead to an actual fix :p )

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

> ---
>  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 138 ++++++++++++++++++
>  include/uapi/linux/videodev2.h                |   6 +
>  2 files changed, 144 insertions(+)
>
> diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> index b475cbba492f..624c3700110f 100644
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
> +      - g\ :sub:`2`
> +      -
> +    * .. _V4L2-PIX-FMT-BGRX555:
> +
> +      - ``V4L2_PIX_FMT_BGRX555``
> +      - 'BX15'
> +
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
> +      - g\ :sub:`2`
> +      -
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

--s3taerhrz7gu7vqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly+/MEACgkQcjQGjxah
Vjzn3Q/7Bz3/dTYf7Ggn+HPBIb3xo7Fs91Xd8x4u9Q51/WmTVRyovqFjQnI5I0/X
yY+fDeWfb7ik61zsw/eWaYA2h3EXueF/UoW6T6g0YAqPMcpw1tFzAPLQDiurM71k
dGUgZLRJc9ovb6zNFAncasv7qmGRGkY4Z3KeWreFnOgPvyFuYPc3zEHowvSZ8+CU
vcaE7Xgj5LSy++s5eUS0a5DG72aK9CmOHCkn1hGYVCQSlGU1+wIv3GK0UvmiyZtW
zMgoyaRD/06DhfrWfLwZalof+qO5kpeML1572Rr8Q5T9j33EY8esOBh5Jp3NkSZH
XD7yPlOxSzoQli6tNzAZ7YGM8cUDN8KJuDVR2gyovSDISFyHz1sbx9fZ/EXRsprh
55oPUolFfxeX2KGGP7i1egSeCE4opf6O8QyQkdMBaLIrmCCpe4d2oXTmKOpmMZLj
8Az7y1JuUNAam5DM1U5cP/PkwkrrEs1xS39HTDphINjBF1td7VB20u4hKpatA0m5
eXscYh0i8ioyfqQZE8QdX+WLsTSB6z2AQ8LL8PF8EMr5HLwAjmHR9EyTWQbkzQBJ
O2sds9zC4OW7TMHf+jNniHdBcaLn375C0H9+xZa6+5QiMqVTrDrWExCsGl3yFqtF
8d/N9+foYwY0KQ3hpQwlyxiINFJSsEfUDu32GDLbr//3NUcqz5o=
=z85e
-----END PGP SIGNATURE-----

--s3taerhrz7gu7vqs--
