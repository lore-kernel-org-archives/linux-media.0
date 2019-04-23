Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211C5C282E1
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AD6217D9
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vfffPQMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfDWOKZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:10:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56112 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfDWOKZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 10:10:25 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E73D5F;
        Tue, 23 Apr 2019 16:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556028623;
        bh=RsDr0+I9oWWQLTfb2BKk/ZrvWy0V0RJbZSdY9HReNus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfffPQMYwSf+AoI4pDlSbx47Z1cNobERjaY0/J2aSQ+cYSZBnJrAAwaFRBPpT0A5L
         giHyJT8UTV+7A6CkVoa7ar1g4hfZ1ic2QJSe7iARE4NPzJT6ig+u6bPq+CTz4pL0/h
         3Qjdf9FPnRG6kfjPb5c5Wa8+Srv2+YBU9KoRvHJA=
Date:   Tue, 23 Apr 2019 17:10:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 4/9] media: vsp1: Add support for missing 32-bit RGB
 formats
Message-ID: <20190423141013.GC4816@pendragon.ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-5-laurent.pinchart+renesas@ideasonboard.com>
 <20190404173905.n6mupqzvcr5vwhwu@uno.localdomain>
 <20190418060645.GC4806@pendragon.ideasonboard.com>
 <20190423132153.xfvy4dn3cflzotuf@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423132153.xfvy4dn3cflzotuf@uno.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On Tue, Apr 23, 2019 at 03:21:53PM +0200, Jacopo Mondi wrote:
> On Thu, Apr 18, 2019 at 09:06:45AM +0300, Laurent Pinchart wrote:
> > On Thu, Apr 04, 2019 at 07:39:05PM +0200, Jacopo Mondi wrote:
> >> HI Laurent,
> >>   if you help me out understanding the bit swapping procedure in VSP
> >> I would be more confident in saying I actually reviewed the series.
> >
> > I'll try my best :-)
> 
> Thanks!
> 
> >> On Thu, Mar 28, 2019 at 09:07:18AM +0200, Laurent Pinchart wrote:
> >>> Add support for the V4L2_PIX_FMT_BGRA32, V4L2_PIX_FMT_BGRX32,
> >>> V4L2_PIX_FMT_RGBA32 and V4L2_PIX_FMT_RGBX32 formats to the VSP driver.
> >>>
> >>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >>> ---
> >>>  drivers/media/platform/vsp1/vsp1_pipe.c | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/vsp1/vsp1_pipe.c
> >>> index 54ff539ffea0..9f08d85e89d7 100644
> >>> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> >>> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> >>> @@ -68,6 +68,20 @@ static const struct vsp1_format_info vsp1_video_formats[] = {
> >>>  	{ V4L2_PIX_FMT_XBGR32, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>>  	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> >>>  	  1, { 32, 0, 0 }, false, false, 1, 1, false },
> >>> +	{ V4L2_PIX_FMT_BGRA32, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> >>> +	  1, { 32, 0, 0 }, false, false, 1, 1, true },
> >>> +	{ V4L2_PIX_FMT_BGRX32, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> >>> +	  1, { 32, 0, 0 }, false, false, 1, 1, false },
> >>> +	{ V4L2_PIX_FMT_RGBA32, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>> +	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
> >>> +	  1, { 32, 0, 0 }, false, false, 1, 1, true },
> >>> +	{ V4L2_PIX_FMT_RGBX32, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>> +	  VI6_FMT_RGBA_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>> +	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
> >>> +	  1, { 32, 0, 0 }, false, false, 1, 1, false },
> >>
> >>
> >> So, this is how I interpret the above lines for format BGRA32 (the
> >> same applies to RGBA32 fwiw)
> >>
> >>         Bytes:          B3      B2      B1      B0
> >> Input: ARGB8888_1X32:   A       R       G       B
> >
> > Note that, at the bus level, there's no byte ordering. Data is
> > transmitted in parallel on a 32-bit bus (at least as far as I know). But
> > this doesn't matter much anyway.
> 
> Indeed, but I should not use this as the description of the input
> format but VI6_FMT_RGBA_8888, as you pointed out, which reads indeed
> as RGBA (out of curiosity, what is the mbus code used for then?)

In the VSP case the media bus format is used to differenciate between
YUV and RGB. Internally after the RPF and before the WPF everything is
transmitted with 32 bits per pixel.

> >> Out:   BGRA32           R       G       B       A
> >>
> >> If I apply LLS and LWS on the "Input Row", according to the table I get
> >>
> >>  Position in Table 32.10:    0  1  2  3
> >>  IN Components ordering:     A  R  G  B  (ARGB8888_1X32
> >>  Position in Table 32.10:    3  2  1  0  (with LLS and LWS applied)
> >>  OUT Components ordering:    B  G  R  A
> >>
> >> Which to me is the ordering of components of the format named
> >> V4L2_PIX_FMT_ARGB32 and not BGRA32 which is instead, as reported RGBA
> >> (GREAT naming here!)
> >>
> >> What am I doing wrong?
> >
> > You need to take entry VI6_FMT_RGBA_8888 (0x14) in table 32.10, which
> > reads R G B A. Applying LLS and LWS but not WDS and BTS swaps the bytes
> > to A B G R (see table 32.13), so the pixel is written to memory in the A
> > B G R order, corresponding to V4L2_PIX_FMT_BGRA32 (I agree with you
> > about the insane naming for the 4CC, but that's not my fault :-().
> 
> Thanks, now that I applied flags to the correct input format, the
> patch seems correct to me.
> 
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> >>>  	{ V4L2_PIX_FMT_ARGB32, MEDIA_BUS_FMT_ARGB8888_1X32,
> >>>  	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS |
> >>>  	  VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,

-- 
Regards,

Laurent Pinchart
