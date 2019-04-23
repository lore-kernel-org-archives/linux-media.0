Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8AFC282DD
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B02217D9
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfDWOF6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:05:58 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60963 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWOF6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 10:05:58 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 05EB7C001B;
        Tue, 23 Apr 2019 14:05:53 +0000 (UTC)
Date:   Tue, 23 Apr 2019 16:06:49 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 8/9] drm: rcar-du: Add support for missing 16-bit RGB4444
 formats
Message-ID: <20190423140649.mv4twq5kayuigzd6@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-9-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4onpjwnw7z3tcjql"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-9-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--4onpjwnw7z3tcjql
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Mar 28, 2019 at 09:07:22AM +0200, Laurent Pinchart wrote:
> Add support for the DRM_FORMAT_RGBA4444, DRM_FORMAT_RGBX4444,
> DRM_FORMAT_ABGR4444, DRM_FORMAT_XBGR4444, DRM_FORMAT_BGRA4444 and
> DRM_FORMAT_BGRX4444 formats to the DU driver. Those formats are only
> available on Gen3.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 30 +++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> index 4084136af845..4aaf623cbcd1 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -123,6 +123,36 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
>  		.v4l2 = V4L2_PIX_FMT_XRGB444,
>  		.bpp = 16,
>  		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_RGBA4444,
> +		.v4l2 = V4L2_PIX_FMT_RGBA444,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_RGBX4444,
> +		.v4l2 = V4L2_PIX_FMT_RGBX444,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_ABGR4444,
> +		.v4l2 = V4L2_PIX_FMT_ABGR444,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_XBGR4444,
> +		.v4l2 = V4L2_PIX_FMT_XBGR444,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_BGRA4444,
> +		.v4l2 = V4L2_PIX_FMT_BGRA444,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_BGRX4444,
> +		.v4l2 = V4L2_PIX_FMT_BGRX444,
> +		.bpp = 16,
> +		.planes = 1,

Compared the DRM and V4L2 format definitions, they look sane to me!

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

--4onpjwnw7z3tcjql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly/G/kACgkQcjQGjxah
Vjwc/g/+Id9tYTMmMTNwLkxbhbkgdaBqp4RuUPnvjoi8yeO2UNIKg6y5J/tjTlS4
bUlT2eun1IWRk78U0CUSK19bZiclCpB3SHJOX89M8ESyWeG+P9zqr3qhnNYvd4ld
dnaPZ14BVa8e+ejQ5PKvSDMIxndDEFD4kKCV2rbIpiWoBltqqUDTF0kCkJ6f94r9
y3Asvv72BIgmK5mwg3L+vJFbZHn6gsDHo8MQWS9XAfrcpyEKinSt7o4S/9G/5Oa/
dPDt63+PZbauu161iGpz8feBeqg6eXc5080/C2yywaRdvgXEcM9kwBXJDwbYPxi1
GEazlWe04O1u9yC3MZthCq4a0Z5RND75KzMbFUiC+8B5FZvIwIRAALLLRUkL2AHD
iYunW/VlJzDPedsxwMbce4FE80od4AEDaYHUNiokmgvWqQwGsxCjQb47m2RsAPyN
+nvOpB6yLP1UUFJTROn8cf86UdncUo4UklXHGaBMgHdE0PWmf7OQwrIdwUAM+sHW
pnCE2c87lGf0ouxylaXwXchUyWW5Y6Ns06YRz593XoK9pGLrhQ4ReT17tYEEPE8b
V8iJ1V28xmH32H8i3qjfcNbVv85ArT1WTQ0OlnP3wkxTw6Ra8YQctKqXwpzg94tl
eIBetLbnjbKwGZsQQezQIDi0lx6ObASVhC7bUhUwFatIeulMWPw=
=gvvN
-----END PGP SIGNATURE-----

--4onpjwnw7z3tcjql--
