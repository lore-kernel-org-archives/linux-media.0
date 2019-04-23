Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC4C282E1
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B4021773
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 13:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfDWNhs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:37:48 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55627 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfDWNhr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 09:37:47 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BF17E240007;
        Tue, 23 Apr 2019 13:37:44 +0000 (UTC)
Date:   Tue, 23 Apr 2019 15:38:39 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 5/9] media: vsp1: Add support for missing 16-bit RGB444
 formats
Message-ID: <20190423133839.ksf5bavnkxvgx2ja@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-6-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrpsspb5nsdywooe"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-6-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--nrpsspb5nsdywooe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Mar 28, 2019 at 09:07:19AM +0200, Laurent Pinchart wrote:
> Add support for the V4L2_PIX_FMT_RGBA444, V4L2_PIX_FMT_RGBX444,
> V4L2_PIX_FMT_ABGR444, V4L2_PIX_FMT_XBGR444, V4L2_PIX_FMT_BGRA444 and
> V4L2_PIX_FMT_BGRX444 formats to the VSP driver.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_pipe.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
> index 9f08d85e89d7..f6665871aa11 100644
> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> @@ -42,6 +42,30 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
>  	  VI6_FMT_XRGB_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
>  	  VI6_RPF_DSWAP_P_WDS,
>  	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> +	{ V4L2_PIX_FMT_RGBA444, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_RGBA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> +	{ V4L2_PIX_FMT_RGBX444, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_RGBX_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> +	{ V4L2_PIX_FMT_ABGR444, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_ABGR_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> +	{ V4L2_PIX_FMT_XBGR444, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  V4L2_PIX_FMT_ABGR444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |

I assume s/V4L2_PIX_FMT_ABGR444/VI6_FMT_ABGR_4444/

The other entries looks fine to me (by comparing the destination pixel
format with the input one with the DSWAP flags applied).

With the above fixed:
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j


> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> +	{ V4L2_PIX_FMT_BGRA444, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_BGRA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> +	{ V4L2_PIX_FMT_BGRX444, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_BGRA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
>  	{ V4L2_PIX_FMT_ARGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
>  	  VI6_FMT_ARGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
>  	  VI6_RPF_DSWAP_P_WDS,
> --
> Regards,
>
> Laurent Pinchart
>

--nrpsspb5nsdywooe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly/FV8ACgkQcjQGjxah
VjwDyA/+IvTCWQrtxriV9eNEOfk7StIic6E662buFLKFPv86WxfGaUopjHFUlpqp
tEaPvnaOcGBjCWQl9BLyCKEVtgRDfjnlYHOzV8YiMlrjGQXah5OigOunTLImstjG
7dxaPSOIascHX4hwW5adHNsDt46QwP0ICRiUSS9fVH4WmkyyOt15opW/FbPRjlcx
nyOq/VkeUsJ44I7d9+bmRYd7TGoN53beeNFxlkGSZUJ8hySv2dlZACB7v3jvUrQq
82eqwbDiwMsKkm8zWfY1pL5/sBGiwwzJEMWj2L2T5k0U1ojUHver1bGxg/e4J95p
+k2obMhAwBJ6CR70sWxQZrgG7/VBYzP6gEo9gGy2//V7FznJShkPszHQw8m+jsc/
qRziCv8Bb1ZEEVu9hg1QwWjbm+h4LNW/CpYVfgnSyRutGvBV7HD0kkZA4VAC0lW8
edLnyeTrneQGUfGq6qjQxjCdIo/ZiVXstWAWrmQX6PnW9ekbpyCQUF063XN3fO1I
qiCZru0lBW4S3EpDc8+cQi3ngc5LiknQuBOGMUGlsCKCfAkjSubDd+m9GEUVjYim
rO3fnmB8MA9IUXfSzja46DiZEEDeHJ510mdYb/yjZhFfUgGNf1rta8qBIaK/AwJ1
E1+afhbXtKO2PRPTjoxYIHSm8KIxBSQIurcfbVmQ6OYWbAEpSI4=
=V0xv
-----END PGP SIGNATURE-----

--nrpsspb5nsdywooe--
