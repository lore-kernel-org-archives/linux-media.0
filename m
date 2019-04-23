Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B7C10F14
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F06C217D9
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfDWOIq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:08:46 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35449 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfDWOIq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 10:08:46 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id BE2091C001B;
        Tue, 23 Apr 2019 14:08:43 +0000 (UTC)
Date:   Tue, 23 Apr 2019 16:09:39 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 9/9] drm: rcar-du: Add support for missing 16-bit RGB1555
 formats
Message-ID: <20190423140939.gp2rtnbyspzcbzpd@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-10-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xsot2cdl72g2muyj"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-10-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--xsot2cdl72g2muyj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Mar 28, 2019 at 09:07:23AM +0200, Laurent Pinchart wrote:
> Add support for the DRM_FORMAT_RGBA5551, DRM_FORMAT_RGBX5551,
> DRM_FORMAT_ABGR1555, DRM_FORMAT_XBGR1555, DRM_FORMAT_BGRA5551 and
> DRM_FORMAT_BGRX5551 formats to the DU driver. Those formats are only
> available on Gen3.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 30 +++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> index 4aaf623cbcd1..adbc4f5d8fc5 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -153,6 +153,36 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
>  		.v4l2 = V4L2_PIX_FMT_BGRX444,
>  		.bpp = 16,
>  		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_RGBA5551,
> +		.v4l2 = V4L2_PIX_FMT_RGBA555,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_RGBX5551,
> +		.v4l2 = V4L2_PIX_FMT_RGBX555,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_ABGR1555,
> +		.v4l2 = V4L2_PIX_FMT_ABGR555,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_XBGR1555,
> +		.v4l2 = V4L2_PIX_FMT_XBGR555,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_BGRA5551,
> +		.v4l2 = V4L2_PIX_FMT_BGRA555,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_BGRX5551,
> +		.v4l2 = V4L2_PIX_FMT_BGRX555,
> +		.bpp = 16,
> +		.planes = 1,

I have compared the format definitions and they seems fine to me!

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

>  	}, {
>  		.fourcc = DRM_FORMAT_BGR888,
>  		.v4l2 = V4L2_PIX_FMT_RGB24,
> --
> Regards,
>
> Laurent Pinchart
>

--xsot2cdl72g2muyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly/HKMACgkQcjQGjxah
VjwsIxAAsi2REZPG6BVz2/e7PFy7rZrsKMr3EI/26WmbmT1SfR3LVkRYq2D+FjnM
0q9F+TT8sEbjQWjwkt0JvFxllvVER/azcBQpw0S22gAKATBkrOJgrnBYn2skXAVG
s3lqeGsCDUfCM88kD0evcDz/4QaAgp1O+8Wa/9oA02ngcrG/jTjgl/dLZdalPi+t
bQp4E4Aenx6JTujYUgnOlrFgBWwep7AvdIRCpo8POFmNDs9pbaalMeWNprTs+12O
z0tm4thYEPpdA84gWa5eYu4HN7d+6OSJmsOMq01gPNw04m8CFl9or29wKkbWSD1a
tpfbs4+VMUsoVK0SdYMc8RfO2ocJ1WcFsoIR6D7i4HMwD2osSAyD/7j02iJpDf58
ja6u9z81gertSn99vz1XQCQx1SWYIKgO+l1p2YuUlBhr24pxhdLZ7x4k5V7dh5TA
GiUqUvujJrj18efeDRBog3PJ8R9k1QJIEHF6WrIBxyLyBpEvmLcoO2cjZmDEX4lw
Tlw+/zd3m5ZmUbDIbk7sDTtdbItf0EU6j6ueb2xPZaecp0n1RZu4R0uduMuKKbI5
uHoBDeKgvRjcq6I0eOwr6q/J1Db70ekNzQ1iopnzwlqaxnwzuyJZMwci7NTo4J+Z
s1EH6eEdOCK4QtK7hCFT5xt1J2My6iJMW/zYa6bS34C1R0GAg5U=
=FeWy
-----END PGP SIGNATURE-----

--xsot2cdl72g2muyj--
