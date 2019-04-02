Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005BCC10F00
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 12:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C604A2147C
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 12:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZCuhpRTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfDBMMO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:12:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60656 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBMMN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Apr 2019 08:12:13 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C5CFD2F9;
        Tue,  2 Apr 2019 14:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554207130;
        bh=pkpyD5lYRIxkxqxJmBI9ULU1MiB58uHAcPt1TEeNBGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCuhpRTf8XyHNMPqWQtmraOqHCriDPbqvCA9wWXaYSGCXBRxqB/zxeFRG3l42PAD0
         vOIP8YV5SIYUZBz82t6ponp6+yJ4iT9tTnDnkbKXIlXqwUFX/pjQLIZTgfy3CygqYW
         nM3L8iqd1yfH6CuVSNZrX2i0vKmZWv623Wu3Gsz8=
Date:   Tue, 2 Apr 2019 15:12:00 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/9] v4l: Add definitions for missing 32-bit RGB formats
Message-ID: <20190402121200.GX4805@pendragon.ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-2-laurent.pinchart+renesas@ideasonboard.com>
 <20190328131543.zlito5lm3n7mjyls@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328131543.zlito5lm3n7mjyls@uno.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On Thu, Mar 28, 2019 at 02:15:43PM +0100, Jacopo Mondi wrote:
> On Thu, Mar 28, 2019 at 09:07:15AM +0200, Laurent Pinchart wrote:
> > The V4L2 API is missing the 32-bit RGB formats for the ABGR, XBGR, RGBA
> > and RGBX component orders. Add them, using the same 4CCs as DRM.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 160 ++++++++++++++++++
> >  include/uapi/linux/videodev2.h                |   4 +
> >  2 files changed, 164 insertions(+)
> >
> > diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > index 6b3781c04dd5..055f9c89e787 100644
> > --- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > +++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > @@ -453,6 +453,166 @@ next to each other in memory.
> >        - r\ :sub:`1`
> >        - r\ :sub:`0`
> >
> > +      -
> > +      -
> > +      -
> > +      -
> > +      -
> > +      -
> > +      -
> > +      -
> > +    * .. _V4L2-PIX-FMT-BGRA32:
> > +
> > +      - ``V4L2_PIX_FMT_BGRA32``
> > +      - 'RA24'
> > +
> > +      - a\ :sub:`7`
> > +      - a\ :sub:`6`
> > +      - a\ :sub:`5`
> > +      - a\ :sub:`4`
> > +      - a\ :sub:`3`
> > +      - a\ :sub:`2`
> > +      - a\ :sub:`1`
> > +      - a\ :sub:`0`
> > +
> > +      - b\ :sub:`7`
> > +      - b\ :sub:`6`
> > +      - b\ :sub:`5`
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +
> > +      - g\ :sub:`7`
> > +      - g\ :sub:`6`
> > +      - g\ :sub:`5`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +
> > +      - r\ :sub:`7`
> > +      - r\ :sub:`6`
> > +      - r\ :sub:`5`
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +    * .. _V4L2-PIX-FMT-BGRX32:
> > +
> > +      - ``V4L2_PIX_FMT_BGRX32``
> > +      - 'RX24'
> > +
> > +      -
> > +      -
> > +      -
> > +      -
> > +      -
> > +      -
> > +      -
> > +      -
> > +
> > +      - b\ :sub:`7`
> > +      - b\ :sub:`6`
> > +      - b\ :sub:`5`
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +
> > +      - g\ :sub:`7`
> > +      - g\ :sub:`6`
> > +      - g\ :sub:`5`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +
> > +      - r\ :sub:`7`
> > +      - r\ :sub:`6`
> > +      - r\ :sub:`5`
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +    * .. _V4L2-PIX-FMT-RGBA32:
> > +
> > +      - ``V4L2_PIX_FMT_RGBA32``
> > +      - 'AB24'
> > +
> > +      - r\ :sub:`7`
> > +      - r\ :sub:`6`
> > +      - r\ :sub:`5`
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +
> > +      - g\ :sub:`7`
> > +      - g\ :sub:`6`
> > +      - g\ :sub:`5`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +
> > +      - b\ :sub:`7`
> > +      - b\ :sub:`6`
> > +      - b\ :sub:`5`
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +
> > +      - a\ :sub:`7`
> > +      - a\ :sub:`6`
> > +      - a\ :sub:`5`
> > +      - a\ :sub:`4`
> > +      - a\ :sub:`3`
> > +      - a\ :sub:`2`
> > +      - a\ :sub:`1`
> > +      - a\ :sub:`0`
> > +    * .. _V4L2-PIX-FMT-RGBX32:
> > +
> > +      - ``V4L2_PIX_FMT_RGBX32``
> > +      - 'XB24'
> > +
> > +      - r\ :sub:`7`
> > +      - r\ :sub:`6`
> > +      - r\ :sub:`5`
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +
> > +      - g\ :sub:`7`
> > +      - g\ :sub:`6`
> > +      - g\ :sub:`5`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +
> > +      - b\ :sub:`7`
> > +      - b\ :sub:`6`
> > +      - b\ :sub:`5`
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +
> 
> I'm trying to compare these with the existing 32-bit RGB formats in
> pixfmt-packed-rgb.rst and I can't get how the orderig of components is
> defined.

Pixel formats are all a big mess :-)

> Ie your definitions here:
> 
>         bytes:  B0      B1      B2      B3
> BGRA32          A       B       G       R
> BGRX32          x       B       G       R
> RGBA32          R       G       B       A
> RGBX32          R       G       B       x
> 
> In the existing documentation:
> ABGR32          B       G       R       A
> XBGR32          B       G       R       x
> ARGB32          A       R       G       B
> XRGB32          x       R       G       B

> So you're adding two BGR/RGB variations with 'X' or 'A' moved from the
> first (for RGB) or last (for BGR) bytes to the last (for RGB) or first
> (for BGR) bytes.
> 
> I cannot see a clear pattern (it seems RGB is ordered as you read the
> components, while BGR is inverted?) so I assume the definition of the
> component ordering scheme comes from a standard, does it? A reference
> would help checking for errors :)

The existing formats are pretty inconsistent. I suppose ARGB and XRGB
were added first, with the format names corresponding to the pixel order
in memory. Then a need to support BGRA and BGRX arose, and the format
names were set to ABGR32 and XBGR32 instead of BGRA32 and BGRX32.
Unfortuantely we can't fix this as it's an ABI, so I had to follow the
same scheme for the new formats. RGBA and RGBX are fine as the RGBA31
and RGBX32 names were free, but for ABGR and XBGR I had to use the
BGRA32 and BGRX32 names.

> >        -
> >        -
> >        -
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 1db220da3bcc..4e5222726719 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -528,7 +528,11 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_BGR32   v4l2_fourcc('B', 'G', 'R', '4') /* 32  BGR-8-8-8-8   */
> >  #define V4L2_PIX_FMT_ABGR32  v4l2_fourcc('A', 'R', '2', '4') /* 32  BGRA-8-8-8-8  */
> >  #define V4L2_PIX_FMT_XBGR32  v4l2_fourcc('X', 'R', '2', '4') /* 32  BGRX-8-8-8-8  */
> > +#define V4L2_PIX_FMT_BGRA32  v4l2_fourcc('R', 'A', '2', '4') /* 32  ABGR-8-8-8-8  */
> > +#define V4L2_PIX_FMT_BGRX32  v4l2_fourcc('R', 'X', '2', '4') /* 32  XBGR-8-8-8-8  */
> >  #define V4L2_PIX_FMT_RGB32   v4l2_fourcc('R', 'G', 'B', '4') /* 32  RGB-8-8-8-8   */
> > +#define V4L2_PIX_FMT_RGBA32  v4l2_fourcc('A', 'B', '2', '4') /* 32  RGBA-8-8-8-8  */
> > +#define V4L2_PIX_FMT_RGBX32  v4l2_fourcc('X', 'B', '2', '4') /* 32  RGBX-8-8-8-8  */
> >  #define V4L2_PIX_FMT_ARGB32  v4l2_fourcc('B', 'A', '2', '4') /* 32  ARGB-8-8-8-8  */
> >  #define V4L2_PIX_FMT_XRGB32  v4l2_fourcc('B', 'X', '2', '4') /* 32  XRGB-8-8-8-8  */
> >

-- 
Regards,

Laurent Pinchart
