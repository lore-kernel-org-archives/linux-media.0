Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362DEC10F0E
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CA420820
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfDDRiX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:38:23 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51249 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDRiX (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 13:38:23 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CAFDDFF803;
        Thu,  4 Apr 2019 17:38:19 +0000 (UTC)
Date:   Thu, 4 Apr 2019 19:39:05 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 4/9] media: vsp1: Add support for missing 32-bit RGB
 formats
Message-ID: <20190404173905.n6mupqzvcr5vwhwu@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-5-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ph2kwcpq6b2xo5tk"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-5-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--ph2kwcpq6b2xo5tk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

HI Laurent,
  if you help me out understanding the bit swapping procedure in VSP
I would be more confident in saying I actually reviewed the series.

On Thu, Mar 28, 2019 at 09:07:18AM +0200, Laurent Pinchart wrote:
> Add support for the V4L2_PIX_FMT_BGRA32, V4L2_PIX_FMT_BGRX32,
> V4L2_PIX_FMT_RGBA32 and V4L2_PIX_FMT_RGBX32 formats to the VSP driver.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_pipe.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
> index 54ff539ffea0..9f08d85e89d7 100644
> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> @@ -68,6 +68,20 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
>  	{ V4L2_PIX_FMT_XBGR32, MEDIA_BUS_FMT_ARGB8888_1X32,
>  	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
>  	  1, { 32, 0, 0 }, false, false, 1, 1, false },
> +	{ V4L2_PIX_FMT_BGRA32, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> +	  1, { 32, 0, 0 }, false, false, 1, 1, true },
> +	{ V4L2_PIX_FMT_BGRX32, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> +	  1, { 32, 0, 0 }, false, false, 1, 1, false },
> +	{ V4L2_PIX_FMT_RGBA32, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
> +	  1, { 32, 0, 0 }, false, false, 1, 1, true },
> +	{ V4L2_PIX_FMT_RGBX32, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
> +	  1, { 32, 0, 0 }, false, false, 1, 1, false },


So, this is how I interpret the above lines for format BGRA32 (the
same applies to RGBA32 fwiw)

        Bytes:          B3      B2      B1      B0
Input: ARGB8888_1X32:   A       R       G       B
Out:   BGRA32           R       G       B       A

If I apply LLS and LWS on the "Input Row", according to the table I get

 Position in Table 32.10:    0  1  2  3
 IN Components ordering:     A  R  G  B  (ARGB8888_1X32
 Position in Table 32.10:    3  2  1  0  (with LLS and LWS applied)
 OUT Components ordering:    B  G  R  A

Which to me is the ordering of components of the format named
V4L2_PIX_FMT_ARGB32 and not BGRA32 which is instead, as reported RGBA
(GREAT naming here!)

What am I doing wrong?

Thanks
  j


>  	{ V4L2_PIX_FMT_ARGB32, MEDIA_BUS_FMT_ARGB8888_1X32,
>  	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
>  	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
> --
> Regards,
>
> Laurent Pinchart
>

--ph2kwcpq6b2xo5tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlymQTkACgkQcjQGjxah
VjwEbA//TRLRwLPmB90lhpfgSKZ95gr4q92lZZ83XieSO4WJCPmMa0lUZXx8zIk2
6Jh8mRuvgtQWbvZeT6YA2E1e5L5w4B2/oaxgYCuYI8r8QJSrZPNhjbsRAMbhDp1S
Y3QzPCMXmmLY1Culb1gC4dRFZdSPjIPxQOyzA21TxaKELgI+UJohgnEEH1uZUHCQ
1i3SYbTIlbbfLmThek/xwIvVZHep4nuZJyG7HOVBhktl+PP6Why5BRyqiPI2JXmV
ysV91XD3EeC10DzZWO8EClct4mhHx5oD890YzxRCQrBWRa65sGNrVahcAaEHaEEg
DvTRrAtPob/NULvYxFg+J8nx0iA1VyLLGpTAYoPbx+rF9ao08AcNlEdqtt9dxzKW
Zal0SoL1DosOGOoptco+V6ULGKufYcZFyRGPkkIcfMliGcMTGtMzEyq1AVH46GUz
WPcjUVDipckl7BgpCcBbDK8uc+WDdPu73hqDYWfDoBhSfvyTjXrWba0Yxh7p55hA
bt5/6QVF70pfTDtHXEXoQJYjPPAKMezceAxvxLS3IyEvy5FThChuMwSt2agQpwdA
/ocyZYH+LGJkoCQWhXCvITJPtpRXycxS5P3GJx3zmIgIq/vnWUikao53bqUhVxOC
eDVQmHeVv6waUVyIa8XDNRcx9JZvv3uQ6swPNXsRLVa7vevMyd4=
=H3mP
-----END PGP SIGNATURE-----

--ph2kwcpq6b2xo5tk--
