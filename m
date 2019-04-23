Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DAEC282E1
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 13:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD8520643
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 13:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfDWNyQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:54:16 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35021 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfDWNyQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 09:54:16 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B39CD1C0008;
        Tue, 23 Apr 2019 13:54:12 +0000 (UTC)
Date:   Tue, 23 Apr 2019 15:55:08 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 6/9] media: vsp1: Add support for missing 16-bit RGB555
 formats
Message-ID: <20190423135508.ppdphyqy2z55ewhm@uno.localdomain>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-7-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tseid7vtrv7lhbkk"
Content-Disposition: inline
In-Reply-To: <20190328070723.26553-7-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--tseid7vtrv7lhbkk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Thu, Mar 28, 2019 at 09:07:20AM +0200, Laurent Pinchart wrote:
> Add support for the V4L2_PIX_FMT_RGBA555, V4L2_PIX_FMT_RGBX555,
> V4L2_PIX_FMT_ABGR555, V4L2_PIX_FMT_XBGR555, V4L2_PIX_FMT_BGRA555 and
> V4L2_PIX_FMT_BGRX555 formats to the VSP driver.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_pipe.c | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
> index f6665871aa11..92f71dec99c5 100644
> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> @@ -66,14 +66,46 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
>  	  VI6_FMT_BGRA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
>  	  VI6_RPF_DSWAP_P_WDS,
>  	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> +#define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */

Why is this here? I see the exact same line in videodev2.h.
Is this a leftover?

>  	{ V4L2_PIX_FMT_ARGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
>  	  VI6_FMT_ARGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
>  	  VI6_RPF_DSWAP_P_WDS,
>  	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> +#define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */

same here and below

>  	{ V4L2_PIX_FMT_XRGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
>  	  VI6_FMT_XRGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
>  	  VI6_RPF_DSWAP_P_WDS,
>  	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> +#define V4L2_PIX_FMT_RGBA555 v4l2_fourcc('R', 'A', '1', '5') /* 16  RGBA-5-5-5-1  */
> +	{ V4L2_PIX_FMT_RGBA555, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_RGBA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> +#define V4L2_PIX_FMT_RGBX555 v4l2_fourcc('R', 'X', '1', '5') /* 16  RGBX-5-5-5-1  */
> +	{ V4L2_PIX_FMT_RGBX555, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_RGBX_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> +#define V4L2_PIX_FMT_ABGR555 v4l2_fourcc('A', 'B', '1', '5') /* 16  ABGR-1-5-5-5  */
> +	{ V4L2_PIX_FMT_ABGR555, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_ABGR_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> +#define V4L2_PIX_FMT_XBGR555 v4l2_fourcc('X', 'B', '1', '5') /* 16  XBGR-1-5-5-5  */
> +	{ V4L2_PIX_FMT_XBGR555, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_ABGR_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },

Looks good, additional defines apart

> +#define V4L2_PIX_FMT_BGRA555 v4l2_fourcc('B', 'A', '1', '5') /* 16  BGRA-5-5-5-1  */
> +	{ V4L2_PIX_FMT_BGRA555, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_BGRA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },


As I read this:
V4L2_PIX_FMT_BGRA555            VI6_FMT_BGRA_5551        LLS|LWS|WDS
gggrrrrr abbbbbgg               bbbbbggg ggrrrrra       ggrrrrra bbbbbggg

They seems different to me:
        gggrrrrr abbbbbgg
        ggrrrrra bbbbbggg

But I have not find any better combination from table 23.10 that would
result in the desired 'gggrrrrr abbbbbgg' ordering.

> +#define V4L2_PIX_FMT_BGRX555 v4l2_fourcc('B', 'X', '1', '5') /* 16  BGRX-5-5-5-1  */
> +	{ V4L2_PIX_FMT_BGRX555, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_BGRA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> +	  VI6_RPF_DSWAP_P_WDS,
> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },

Same as above.

The last two entries apart:
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j
>  	{ V4L2_PIX_FMT_RGB565, MEDIA_BUS_FMT_ARGB8888_1X32,
>  	  VI6_FMT_RGB_565, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
>  	  VI6_RPF_DSWAP_P_WDS,
> --
> Regards,
>
> Laurent Pinchart
>

--tseid7vtrv7lhbkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly/GTwACgkQcjQGjxah
VjzUXg//Zc+ekCFVW472VXghJp/YM/CztYZsXsuBk1MRsd6fLxZlOXLyCtJee4eu
1U48ntIfiXfk5w6KC1k/aq5ycLmAkx6PpTjVIYXKE6X/VdW6BRy76zJiYgCqFA05
TDKdL/9L1Dj+veHFYMNiCXdWI58WgT9VfFULh2ajbGJ5GW0Ngaez87Du9Wi2CFoB
AYCGaB/54Bd76MnHJhss7kmHV32r2wX7rl9sh52qBY8RXTPFAT9YGXtyB/brGTqc
LlHztOqbAZ+tMA9PBzxBatlx7CUvd9SySJFthjrwekZiKPa2Q4qZTddZOlLqjMdz
g2FYMPAeT3IbpY5Ciuj1InvnkvjdMRD7DaXGjP8UoEBd1NFs9r4GYJkqwOFk5dLi
gVnHs/wWSwsiQ7uS/UOsVqULXNRpZaibo8iHOFy9Cz3RJvT0qNxWKEAIrTWhSR3r
BpFcTffZl5Vw2TdKM2zct6Mr6dkLJD7ktyKuhzYmq5iCc71N7glRqadbw3rqyUma
HfbD2Uj9yXxQcB7wVTa/wlxdqmG1T/HQusmT8glOa0yc4hftTlhhYm8UiuvpW7wd
mhZYmEl7AtQe93F2gOEoT0uBZL4x+PIsdfZx8PF646VT9izyliGixWVpGtGKFeiM
I/Oi+qJt3ErWh+i4gm82XRZhy35AeMy3eyBcaEXuMBZDpndZGaM=
=LwM8
-----END PGP SIGNATURE-----

--tseid7vtrv7lhbkk--
