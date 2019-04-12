Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8AC282CE
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A376220818
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 08:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfDLInC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:43:02 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51715 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDLInB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 04:43:01 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DC057240011;
        Fri, 12 Apr 2019 08:42:56 +0000 (UTC)
Date:   Fri, 12 Apr 2019 10:43:46 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4] rcar-csi2: Propagate the FLD signal for NTSC and PAL
Message-ID: <20190412084346.6lreffkpuuj7slqb@uno.localdomain>
References: <20190411203444.23515-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o7tayqzxuq5fu6kw"
Content-Disposition: inline
In-Reply-To: <20190411203444.23515-1-niklas.soderlund+renesas@ragnatech.se>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--o7tayqzxuq5fu6kw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Niklas,
   I'm rebasing v4l2-mux series on top of your new VIN patches and
on this on I'm not sure how to proceed. Please see below.

Please also note this comment is not strictly on this patch, and should not
block its acceptance...

On Thu, Apr 11, 2019 at 10:34:44PM +0200, Niklas S=C3=B6derlund wrote:
> Depending on which video standard is used the driver needs to setup the
> hardware to correctly handle fields. If stream is identified as NTSC
> or PAL setup field detection and propagate the field detection signal.
>
> Later versions of the datasheet have been updated to make it clear
> that FLD register should be set to 0 when dealing with non-interlaced
> field formats.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/=
platform/rcar-vin/rcar-csi2.c
> index 799e526fd3df5554..c1b38ebd061dbc35 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -68,6 +68,7 @@ struct rcar_csi2;
>  /* Field Detection Control */
>  #define FLD_REG				0x1c
>  #define FLD_FLD_NUM(n)			(((n) & 0xff) << 16)
> +#define FLD_DET_SEL(n)			(((n) & 0x3) << 4)
>  #define FLD_FLD_EN4			BIT(3)
>  #define FLD_FLD_EN3			BIT(2)
>  #define FLD_FLD_EN2			BIT(1)
> @@ -475,7 +476,7 @@ static int rcsi2_calc_mbps(struct rcar_csi2 *priv, un=
signed int bpp)
>  static int rcsi2_start_receiver(struct rcar_csi2 *priv)
>  {
>  	const struct rcar_csi2_format *format;
> -	u32 phycnt, vcdt =3D 0, vcdt2 =3D 0;
> +	u32 phycnt, vcdt =3D 0, vcdt2 =3D 0, fld =3D 0;
>  	unsigned int i;
>  	int mbps, ret;
>
> @@ -507,6 +508,16 @@ static int rcsi2_start_receiver(struct rcar_csi2 *pr=
iv)
>  			vcdt2 |=3D vcdt_part << ((i % 2) * 16);
>  	}
>
> +	if (priv->mf.field =3D=3D V4L2_FIELD_ALTERNATE) {

How would you handle this once priv->mf is expanded to become an array
of 'struct v4l2_mbus_framefmt' entries [1] ? Which of them is relevant for
field detection?


> +		fld =3D FLD_DET_SEL(1) | FLD_FLD_EN4 | FLD_FLD_EN3 | FLD_FLD_EN2
> +			| FLD_FLD_EN;
> +
> +		if (priv->mf.height =3D=3D 240)

Same question here, even if I assume we could cycle on the entries and
collect the maximum size.

Thanks
  j

[1] Introduced by:
"rcar-csi2: use frame description information to configure CSI-2 bus"
> +			fld |=3D FLD_FLD_NUM(0);
> +		else
> +			fld |=3D FLD_FLD_NUM(1);
> +	}
> +
>  	phycnt =3D PHYCNT_ENABLECLK;
>  	phycnt |=3D (1 << priv->lanes) - 1;
>
> @@ -549,8 +560,7 @@ static int rcsi2_start_receiver(struct rcar_csi2 *pri=
v)
>  	rcsi2_write(priv, PHYCNT_REG, phycnt);
>  	rcsi2_write(priv, LINKCNT_REG, LINKCNT_MONITOR_EN |
>  		    LINKCNT_REG_MONI_PACT_EN | LINKCNT_ICLK_NONSTOP);
> -	rcsi2_write(priv, FLD_REG, FLD_FLD_NUM(2) | FLD_FLD_EN4 |
> -		    FLD_FLD_EN3 | FLD_FLD_EN2 | FLD_FLD_EN);
> +	rcsi2_write(priv, FLD_REG, fld);
>  	rcsi2_write(priv, PHYCNT_REG, phycnt | PHYCNT_SHUTDOWNZ);
>  	rcsi2_write(priv, PHYCNT_REG, phycnt | PHYCNT_SHUTDOWNZ | PHYCNT_RSTZ);
>
> --
> 2.21.0
>

--o7tayqzxuq5fu6kw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlywT8IACgkQcjQGjxah
VjxwAg/8C6n3N7RVf1yGzoPnuoSeExnrPROPGD++JHSV0N2NnI0AHYa1rbJkp2ob
XypWZh3nbj3QmQOIlE+Wtlc8N2cG7uLiR8SVajTj0c5ocCtYQHCDSJeZzvBSv/Qm
im/3ijA4GuDVYAqhRmQxabv2890h5s1cbKs73m8zCwUBCf2B4U/lMLmJa2KkQshL
foBVNYFDurgHl4vCc7dAQUJMD4XJp68gV59cKr7SGLsOMTjL12JGrp4WfJAAgDeO
96e45AAGCN50E0XGQhVhXGAIDWKdGhXvTNA4fo55ne3gt2IjenK/6YNuNYIK08XF
hmMkqRFABk8FRYmROqt7CF8rqst2plElkshXAnFPCWLzqLTdr1YWeBRNFDfBJ/pN
djA4OvlBfdCQ8ikT+nVoL8uv/XEGAr0VHl7lgmROAR6OzR4WOndnfpK3uVAixdBI
v0FEMlWUDPF0Sl5j6Pggnil+filEHXuWJnqsvntH2VHsuw0uqT+FHUqE918ddGJE
3zEtJPPNl+vHxEgSRc1VjmwLAyVfPeJl4z4m3BxnpjbJ3TGCIHBkQK7rq+Z4f76G
rkKLDTyAUshrxsiC4ShVmJIXuLNsYT82fuS2Hq3ZrQsP/fUN7j9yEI0+yYS9EW+Y
Ukrest8ETCttQU0qdBE+RMU54oRaGBGRKjrhUbncRYsPhQISCH8=
=6r+o
-----END PGP SIGNATURE-----

--o7tayqzxuq5fu6kw--
