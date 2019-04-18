Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EA6C10F14
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 05:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0482183F
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 05:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KXyd6qxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfDRF5O (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:57:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57718 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRF5O (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 01:57:14 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 46544306;
        Thu, 18 Apr 2019 07:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555567032;
        bh=Va9PsJ1rB6k6HgP17pCmkM4sulD3RoFEl0Le7P2+q70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXyd6qxdBrwYEH2QsI1G3GnPaV87byaNIfDCl1wE7BHFwB2imSE1efYaiF4ejWtfw
         /ak8Vwo5Qsbm1Kj62pMYdPBh8MXTZpU+P/0SCyS/wO4SmluRBPzXOKY3HPsvq77vlX
         nnDIJH8FeArtdGuNzjVGfqW0HpsSuYJM4aCxQOmY=
Date:   Thu, 18 Apr 2019 08:57:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/9] v4l: Add definitions for missing 16-bit RGB4444
 formats
Message-ID: <20190418055704.GB4806@pendragon.ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-3-laurent.pinchart+renesas@ideasonboard.com>
 <20190404160049.cref72fegfwqiffy@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404160049.cref72fegfwqiffy@uno.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On Thu, Apr 04, 2019 at 06:00:49PM +0200, Jacopo Mondi wrote:
> On Thu, Mar 28, 2019 at 09:07:16AM +0200, Laurent Pinchart wrote:
> > The V4L2 API is missing the 16-bit RGB4444 formats for the RGBA, RGBX,
> > ABGR, XBGR, BGRA and BGRX component orders. Add them, using the same
> > 4CCs as DRM.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> I checked the documentation and it seems right, I cannot relate the
> name to the ordering but I guess this is intended.

The 16-bit RGB V4L2 4CCs are named based on a little endian byte
ordering. If you look at V4L2_PIX_FMT_RGBA444 for instance, we have, in
memory

	bbbbaaaa rrrrgggg

If you read that as a 16-bit integer in little endian order, you get

	rrrrggggbbbbaaaa

hence the name RGBA444.

> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> > ---
> >  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 138 ++++++++++++++++++
> >  include/uapi/linux/videodev2.h                |   6 +
> >  2 files changed, 144 insertions(+)
> >
> > diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > index 055f9c89e787..b475cbba492f 100644
> > --- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > +++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > @@ -139,6 +139,144 @@ next to each other in memory.
> >        - r\ :sub:`1`
> >        - r\ :sub:`0`
> >        -
> > +    * .. _V4L2-PIX-FMT-RGBA444:
> > +
> > +      - ``V4L2_PIX_FMT_RGBA444``
> > +      - 'RA12'
> > +
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      - a\ :sub:`3`
> > +      - a\ :sub:`2`
> > +      - a\ :sub:`1`
> > +      - a\ :sub:`0`
> > +
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      -
> > +    * .. _V4L2-PIX-FMT-RGBX444:
> > +
> > +      - ``V4L2_PIX_FMT_RGBX444``
> > +      - 'RX12'
> > +
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      -
> > +      -
> > +      -
> > +      -
> > +
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      -
> > +    * .. _V4L2-PIX-FMT-ABGR444:
> > +
> > +      - ``V4L2_PIX_FMT_ABGR444``
> > +      - 'AB12'
> > +
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +
> > +      - a\ :sub:`3`
> > +      - a\ :sub:`2`
> > +      - a\ :sub:`1`
> > +      - a\ :sub:`0`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      -
> > +    * .. _V4L2-PIX-FMT-XBGR444:
> > +
> > +      - ``V4L2_PIX_FMT_XBGR444``
> > +      - 'XB12'
> > +
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +
> > +      -
> > +      -
> > +      -
> > +      -
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      -
> > +    * .. _V4L2-PIX-FMT-BGRA444:
> > +
> > +      - ``V4L2_PIX_FMT_BGRA444``
> > +      - 'BA12'
> > +
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +      - a\ :sub:`3`
> > +      - a\ :sub:`2`
> > +      - a\ :sub:`1`
> > +      - a\ :sub:`0`
> > +
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      -
> > +    * .. _V4L2-PIX-FMT-BGRX444:
> > +
> > +      - ``V4L2_PIX_FMT_BGRX444``
> > +      - 'BX12'
> > +
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +      -
> > +      -
> > +      -
> > +      -
> > +
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      -
> >      * .. _V4L2-PIX-FMT-ARGB555:
> >
> >        - ``V4L2_PIX_FMT_ARGB555``
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 4e5222726719..df9fa78a6ab7 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -514,6 +514,12 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_RGB444  v4l2_fourcc('R', '4', '4', '4') /* 16  xxxxrrrr ggggbbbb */
> >  #define V4L2_PIX_FMT_ARGB444 v4l2_fourcc('A', 'R', '1', '2') /* 16  aaaarrrr ggggbbbb */
> >  #define V4L2_PIX_FMT_XRGB444 v4l2_fourcc('X', 'R', '1', '2') /* 16  xxxxrrrr ggggbbbb */
> > +#define V4L2_PIX_FMT_RGBA444 v4l2_fourcc('R', 'A', '1', '2') /* 16  rrrrgggg bbbbaaaa */
> > +#define V4L2_PIX_FMT_RGBX444 v4l2_fourcc('R', 'X', '1', '2') /* 16  rrrrgggg bbbbxxxx */
> > +#define V4L2_PIX_FMT_ABGR444 v4l2_fourcc('A', 'B', '1', '2') /* 16  aaaabbbb ggggrrrr */
> > +#define V4L2_PIX_FMT_XBGR444 v4l2_fourcc('X', 'B', '1', '2') /* 16  xxxxbbbb ggggrrrr */
> > +#define V4L2_PIX_FMT_BGRA444 v4l2_fourcc('B', 'A', '1', '2') /* 16  bbbbgggg rrrraaaa */
> > +#define V4L2_PIX_FMT_BGRX444 v4l2_fourcc('B', 'X', '1', '2') /* 16  bbbbgggg rrrrxxxx */
> >  #define V4L2_PIX_FMT_RGB555  v4l2_fourcc('R', 'G', 'B', 'O') /* 16  RGB-5-5-5     */
> >  #define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
> >  #define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
> > --
> > Regards,
> >
> > Laurent Pinchart
> >



-- 
Regards,

Laurent Pinchart
