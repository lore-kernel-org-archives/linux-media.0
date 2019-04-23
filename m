Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58231C282DD
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307A220645
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfDWOEJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:04:09 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41589 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfDWOEJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 10:04:09 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 84DDAFF80B;
        Tue, 23 Apr 2019 14:04:05 +0000 (UTC)
Date:   Tue, 23 Apr 2019 16:05:00 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 7/9] drm: rcar-du: Add support for missing 32-bit RGB
 formats
Message-ID: <20190423140500.yym5wh4frj4vck3n@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-8-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qvj7bn6bfmq5qafs"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-8-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--qvj7bn6bfmq5qafs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Mar 28, 2019 at 09:07:21AM +0200, Laurent Pinchart wrote:
> Add support for the DRM_FORMAT_RGBA8888, DRM_FORMAT_RGBX8888,
> DRM_FORMAT_ABGR8888 and DRM_FORMAT_XBGR8888 formats to the DU driver.
> Those formats are only available on Gen3.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> index f8f7fff34dff..4084136af845 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -133,6 +133,26 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
>  		.v4l2 = V4L2_PIX_FMT_BGR24,
>  		.bpp = 24,
>  		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_RGBA8888,
> +		.v4l2 = V4L2_PIX_FMT_BGRA32,
> +		.bpp = 32,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_RGBX8888,
> +		.v4l2 = V4L2_PIX_FMT_BGRX32,
> +		.bpp = 32,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_ABGR8888,
> +		.v4l2 = V4L2_PIX_FMT_RGBA32,
> +		.bpp = 32,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_XBGR8888,
> +		.v4l2 = V4L2_PIX_FMT_RGBX32,
> +		.bpp = 32,
> +		.planes = 1,

Compared the format definitions between DRM and V4L2 and they seems to
match to me.

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

>  	}, {
>  		.fourcc = DRM_FORMAT_BGRA8888,
>  		.v4l2 = V4L2_PIX_FMT_ARGB32,
> --
> Regards,
>
> Laurent Pinchart
>

--qvj7bn6bfmq5qafs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly/G4wACgkQcjQGjxah
Vjy7Dw/5AW46kVVFibFAwLZQS2RGOd0UXvTUAzhWwwNh3/4bmSQ5eL4npOgGFS5D
gKE6FktJtViDynWR5iIP+VxSzjV4OiBGpEY7j/gSkixLJrfN0hbsEsTHEKzJqZTm
azbTXwxxyDwTIixxqDS99+GwgFCPgZ6qyCC1NLY8R4H1TVQ0pFgVkxJo7AH6KeEG
2HkJE9GM2TXLax3w2wJ0jaqENVDpQ3LME1doKHJ8rT0DofTxq3lQn3oGii2pZ8GE
EOm4gLtQkgd51U6LpeEOMcs4Fx0nFW6gYt73aYIp87DnefNkdixSdnCdoT+Diwc9
CH83VBcqBljjw29vlPxyZV6vMDjvUwOMIoZItptNHGB2dSaM+jVCH3gGwsBM8EsJ
j/TuXxYAL9qbTBkgDqwEPs75922/BdvvPXwTTz54uHmB6WmenT+UgTBS8oXFPNH6
gq1uuIC7k30Jvt5MNWsNJ2A5vtfXF6kiSrltBoFLPl++IVzBGvAsxOVenhFkr9BB
xl0iQThrnnKBjpGdyHOMrYjlbvLebXUcgnaPOIeWD7bj4mdwappxGwPzZRVtpcm4
tA5/FmgK0hX0usyF6dsZo5V8WXEj7A68ZOWB9u8ndZNDwYnWb38k2bGjXELU3Wab
LkS/FhIHJEJI70NCawQN/ILy3axdKGF2sPcZtE0NAMzX4qeSDy8=
=T+a6
-----END PGP SIGNATURE-----

--qvj7bn6bfmq5qafs--
