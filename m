Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCDC282DD
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF8421850
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NJGJJrMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDWT3P (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:29:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59526 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWT3P (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 15:29:15 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94CBD5F;
        Tue, 23 Apr 2019 21:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556047751;
        bh=Unb4Ilyu7XD4W82UTfeJgzKzhu03zQVJ83Slvu2HB9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJGJJrMVVXCpzJY28/esLIieNQL1Q6bXiVbVUiEQCRXvzjnAqdwvzxWHSzKR2nEQ7
         pBhLOdC8ojMPL+nlYDfEgVfbBU3dcE03n4aO/qsrgu4lU+WxygtJezkb+5F/rNneSy
         KL/ffo0NM5TMwr8GwVt8McCQNyU8bmBMHftuPyHk=
Date:   Tue, 23 Apr 2019 22:29:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 6/9] media: vsp1: Add support for missing 16-bit RGB555
 formats
Message-ID: <20190423192901.GA5082@pendragon.ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-7-laurent.pinchart+renesas@ideasonboard.com>
 <20190423135508.ppdphyqy2z55ewhm@uno.localdomain>
 <20190423144651.GA16111@pendragon.ideasonboard.com>
 <20190423165600.vavevn5iemzkzu5t@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423165600.vavevn5iemzkzu5t@uno.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Tue, Apr 23, 2019 at 06:56:00PM +0200, Jacopo Mondi wrote:
> On Tue, Apr 23, 2019 at 05:46:51PM +0300, Laurent Pinchart wrote:
> > On Tue, Apr 23, 2019 at 03:55:08PM +0200, Jacopo Mondi wrote:
> >> On Thu, Mar 28, 2019 at 09:07:20AM +0200, Laurent Pinchart wrote:
> >>> Add support for the V4L2_PIX_FMT_RGBA555, V4L2_PIX_FMT_RGBX555,
> >>> V4L2_PIX_FMT_ABGR555, V4L2_PIX_FMT_XBGR555, V4L2_PIX_FMT_BGRA555 and
> >>> V4L2_PIX_FMT_BGRX555 formats to the VSP driver.
> >>>
> >>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >>> ---
> >>>  drivers/media/platform/vsp1/vsp1_pipe.c | 32 +++++++++++++++++++++++++
> >>>  1 file changed, 32 insertions(+)
> >>>
> >>> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
> >>> index f6665871aa11..92f71dec99c5 100644
> >>> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> >>> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> >>> @@ -66,14 +66,46 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
> >>>  	  VI6_FMT_BGRA_4444, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>>  	  VI6_RPF_DSWAP_P_WDS,
> >>>  	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> >>> +#define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
> >>
> >> Why is this here? I see the exact same line in videodev2.h.
> >> Is this a leftover?
> >
> > Oops. It is. I'm sorry, I'll remove that.
> >
> >>>  	{ V4L2_PIX_FMT_ARGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>>  	  VI6_FMT_ARGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>>  	  VI6_RPF_DSWAP_P_WDS,
> >>>  	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> >>> +#define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
> >>
> >> same here and below
> >>
> >>>  	{ V4L2_PIX_FMT_XRGB555, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>>  	  VI6_FMT_XRGB_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>>  	  VI6_RPF_DSWAP_P_WDS,
> >>>  	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> >>> +#define V4L2_PIX_FMT_RGBA555 v4l2_fourcc('R', 'A', '1', '5') /* 16  RGBA-5-5-5-1  */
> >>> +	{ V4L2_PIX_FMT_RGBA555, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_RGBA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>> +	  VI6_RPF_DSWAP_P_WDS,
> >>> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> >>> +#define V4L2_PIX_FMT_RGBX555 v4l2_fourcc('R', 'X', '1', '5') /* 16  RGBX-5-5-5-1  */
> >>> +	{ V4L2_PIX_FMT_RGBX555, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_RGBX_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>> +	  VI6_RPF_DSWAP_P_WDS,
> >>> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> >>> +#define V4L2_PIX_FMT_ABGR555 v4l2_fourcc('A', 'B', '1', '5') /* 16  ABGR-1-5-5-5  */
> >>> +	{ V4L2_PIX_FMT_ABGR555, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_ABGR_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>> +	  VI6_RPF_DSWAP_P_WDS,
> >>> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> >>> +#define V4L2_PIX_FMT_XBGR555 v4l2_fourcc('X', 'B', '1', '5') /* 16  XBGR-1-5-5-5  */
> >>> +	{ V4L2_PIX_FMT_XBGR555, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_ABGR_1555, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>> +	  VI6_RPF_DSWAP_P_WDS,
> >>> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> >>
> >> Looks good, additional defines apart
> >>
> >>> +#define V4L2_PIX_FMT_BGRA555 v4l2_fourcc('B', 'A', '1', '5') /* 16  BGRA-5-5-5-1  */
> >>> +	{ V4L2_PIX_FMT_BGRA555, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_BGRA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>> +	  VI6_RPF_DSWAP_P_WDS,
> >>> +	  1, { 16, 0, 0 }, false, false, 1, 1, true },
> >>
> >>
> >> As I read this:
> >> V4L2_PIX_FMT_BGRA555            VI6_FMT_BGRA_5551        LLS|LWS|WDS
> >> gggrrrrr abbbbbgg               bbbbbggg ggrrrrra       ggrrrrra bbbbbggg
> >
> > Isn't V4L2_PIX_FMT_BGRA555 is defined as
> >
> > g1 g0 r4 r3 r2 r1 r0 a | b4 b3 b2 b1 b0 g4 g3 g2
> >
> Ah yes, I got fooled by how it is described in the documentation
> 
>     * .. _V4L2-PIX-FMT-BGRA555:
> 
>       - ``V4L2_PIX_FMT_BGRA555``
>       - 'BA15'
> 
>       - g\ :sub:`2`
>       - g\ :sub:`1`
>       - g\ :sub:`0`
>       - r\ :sub:`4`
>       - r\ :sub:`3`
>       - r\ :sub:`2`
>       - r\ :sub:`1`
>       - r\ :sub:`0`
>       - a
> 
>       - b\ :sub:`4`
>       - b\ :sub:`3`
>       - b\ :sub:`2`
>       - b\ :sub:`1`
>       - b\ :sub:`0`
>       - g\ :sub:`4`
>       - g\ :sub:`3`
>       -
> 
> The empty line between 'a' and b4 made me think those were 2 bytes,
> but apparently, they're not.

I have this in my tree:

+    * .. _V4L2-PIX-FMT-BGRA555:
+
+      - ``V4L2_PIX_FMT_BGRA555``
+      - 'BA15'
+
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - a
+
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      -

Were you looking at v1 instead of v1.1 ?

> So, it's fine! Thanks for checking!
> 
> > ?
> >
> >> They seems different to me:
> >>         gggrrrrr abbbbbgg
> >>         ggrrrrra bbbbbggg
> >>
> >> But I have not find any better combination from table 23.10 that would
> >> result in the desired 'gggrrrrr abbbbbgg' ordering.
> >>
> >>> +#define V4L2_PIX_FMT_BGRX555 v4l2_fourcc('B', 'X', '1', '5') /* 16  BGRX-5-5-5-1  */
> >>> +	{ V4L2_PIX_FMT_BGRX555, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_BGRA_5551, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>> +	  VI6_RPF_DSWAP_P_WDS,
> >>> +	  1, { 16, 0, 0 }, false, false, 1, 1, false },
> >>
> >> Same as above.
> >>
> >> The last two entries apart:
> >> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> >>
> >>>  	{ V4L2_PIX_FMT_RGB565, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>>  	  VI6_FMT_RGB_565, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>>  	  VI6_RPF_DSWAP_P_WDS,

-- 
Regards,

Laurent Pinchart
