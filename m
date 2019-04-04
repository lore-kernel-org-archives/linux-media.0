Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB6C10F0E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F2020855
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDDQAG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:00:06 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41087 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDQAG (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 12:00:06 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3C3D420058;
        Thu,  4 Apr 2019 16:00:03 +0000 (UTC)
Date:   Thu, 4 Apr 2019 18:00:49 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/9] v4l: Add definitions for missing 16-bit RGB4444
 formats
Message-ID: <20190404160049.cref72fegfwqiffy@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-3-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eg4rmzo2hyharnnz"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-3-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--eg4rmzo2hyharnnz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Mar 28, 2019 at 09:07:16AM +0200, Laurent Pinchart wrote:
> The V4L2 API is missing the 16-bit RGB4444 formats for the RGBA, RGBX,
> ABGR, XBGR, BGRA and BGRX component orders. Add them, using the same
> 4CCs as DRM.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I checked the documentation and it seems right, I cannot relate the
name to the ordering but I guess this is intended.

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j
> ---
>  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 138 ++++++++++++++++++
>  include/uapi/linux/videodev2.h                |   6 +
>  2 files changed, 144 insertions(+)
>
> diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> index 055f9c89e787..b475cbba492f 100644
> --- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> +++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> @@ -139,6 +139,144 @@ next to each other in memory.
>        - r\ :sub:`1`
>        - r\ :sub:`0`
>        -
> +    * .. _V4L2-PIX-FMT-RGBA444:
> +
> +      - ``V4L2_PIX_FMT_RGBA444``
> +      - 'RA12'
> +
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - a\ :sub:`3`
> +      - a\ :sub:`2`
> +      - a\ :sub:`1`
> +      - a\ :sub:`0`
> +
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      -
> +    * .. _V4L2-PIX-FMT-RGBX444:
> +
> +      - ``V4L2_PIX_FMT_RGBX444``
> +      - 'RX12'
> +
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      -
> +      -
> +      -
> +      -
> +
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      -
> +    * .. _V4L2-PIX-FMT-ABGR444:
> +
> +      - ``V4L2_PIX_FMT_ABGR444``
> +      - 'AB12'
> +
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +
> +      - a\ :sub:`3`
> +      - a\ :sub:`2`
> +      - a\ :sub:`1`
> +      - a\ :sub:`0`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      -
> +    * .. _V4L2-PIX-FMT-XBGR444:
> +
> +      - ``V4L2_PIX_FMT_XBGR444``
> +      - 'XB12'
> +
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +
> +      -
> +      -
> +      -
> +      -
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      -
> +    * .. _V4L2-PIX-FMT-BGRA444:
> +
> +      - ``V4L2_PIX_FMT_BGRA444``
> +      - 'BA12'
> +
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - a\ :sub:`3`
> +      - a\ :sub:`2`
> +      - a\ :sub:`1`
> +      - a\ :sub:`0`
> +
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      -
> +    * .. _V4L2-PIX-FMT-BGRX444:
> +
> +      - ``V4L2_PIX_FMT_BGRX444``
> +      - 'BX12'
> +
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      -
> +      -
> +      -
> +      -
> +
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      -
>      * .. _V4L2-PIX-FMT-ARGB555:
>
>        - ``V4L2_PIX_FMT_ARGB555``
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 4e5222726719..df9fa78a6ab7 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -514,6 +514,12 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_RGB444  v4l2_fourcc('R', '4', '4', '4') /* 16  xxxxrrrr ggggbbbb */
>  #define V4L2_PIX_FMT_ARGB444 v4l2_fourcc('A', 'R', '1', '2') /* 16  aaaarrrr ggggbbbb */
>  #define V4L2_PIX_FMT_XRGB444 v4l2_fourcc('X', 'R', '1', '2') /* 16  xxxxrrrr ggggbbbb */
> +#define V4L2_PIX_FMT_RGBA444 v4l2_fourcc('R', 'A', '1', '2') /* 16  rrrrgggg bbbbaaaa */
> +#define V4L2_PIX_FMT_RGBX444 v4l2_fourcc('R', 'X', '1', '2') /* 16  rrrrgggg bbbbxxxx */
> +#define V4L2_PIX_FMT_ABGR444 v4l2_fourcc('A', 'B', '1', '2') /* 16  aaaabbbb ggggrrrr */
> +#define V4L2_PIX_FMT_XBGR444 v4l2_fourcc('X', 'B', '1', '2') /* 16  xxxxbbbb ggggrrrr */
> +#define V4L2_PIX_FMT_BGRA444 v4l2_fourcc('B', 'A', '1', '2') /* 16  bbbbgggg rrrraaaa */
> +#define V4L2_PIX_FMT_BGRX444 v4l2_fourcc('B', 'X', '1', '2') /* 16  bbbbgggg rrrrxxxx */
>  #define V4L2_PIX_FMT_RGB555  v4l2_fourcc('R', 'G', 'B', 'O') /* 16  RGB-5-5-5     */
>  #define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
>  #define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
> --
> Regards,
>
> Laurent Pinchart
>

--eg4rmzo2hyharnnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlymKjAACgkQcjQGjxah
VjzqmA//efK6SohvLYy9x5UMX5e6Y1NbI5u3O+N6j9xLUfDNgLvGM8Oc/9XGBSOX
cISIOsfIVfSzTd9TPy5S15/cXhConcaMZeeIdO+j6KFk0iak3HAnevxEjXnSgxEx
8+UFrpgsP9dN8sDuhisxswzX8gcwqHYuWYK2qcICHQS2+WwxP4kxx5TtCDAay7u6
dHyfOve8EWGes4a/DhqBycl3osSqW9iJP0yJc/t+nrKXxjM0I/QIcNEfBc1ripQT
imWsQFxakOXPXJbgNI6KClR02fxchcpPNRnde3aP4R2e5PnTh0qgoQWTV5yOEw9z
NO8mdgmXFqxIJ4PyfaK5SB8NkkB3qeejgiLTb2Z++0U3H4P41VTIRYLj60Xkpt9m
kMKW8yCyJE7tbcPfcEKnXPzaqLPTeFw/QwbCkC7z3mVUzY5HtXT3PpVjySEVbG3x
IT2SLG2nePtuUN2zoi11/Prl5M8kMvCmOuHslFD8tcYRqwBK2StaPweVUXHfYHFr
MZObAfDaQpbh28o0bfXikCNKBhLfkeHtLq1RKSHeXObUX7qctoSw+QyLxSS2O5NB
e0/qakqqyi6NtknmFbxQ2aLJi8C8h2wUu6PSJgQFanDO6x1EEPKo+vaHnMWlVHAc
7FbqzfANgjmdlvA79IMGue7Bb3lmv3eXr1wHL+6ceWi9p3seCmE=
=xMMM
-----END PGP SIGNATURE-----

--eg4rmzo2hyharnnz--
