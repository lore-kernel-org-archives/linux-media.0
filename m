Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709DFC10F14
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 06:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40441217D7
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 06:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SbE1mRNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfDRGZQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:25:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57836 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfDRGZQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 02:25:16 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 67DFA306;
        Thu, 18 Apr 2019 08:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555568713;
        bh=6L+lXE2vKB5SQF0A/4pEae2+Y/4jxxyT3BJ10IcFyCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbE1mRNwYUCXlGLK5wpBrW/oJKE45smwgTMB1fzRdOfuc1LrtuWRyuXpmPtbNtL0y
         0yM1bY5Xd88wqlMr7j3zlAYsszT1n4p0VD/7wq6aAJahLfPncdmjIk6qgw+wmMwT4u
         HNvTa/sATY5Go4DBqP2VV0dfWoKgzdbISl7IXpgY=
Date:   Thu, 18 Apr 2019 09:25:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 3/9] v4l: Add definitions for missing 16-bit RGB555
 formats
Message-ID: <20190418062505.GD4806@pendragon.ideasonboard.com>
References: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
 <20190328070723.26553-4-laurent.pinchart+renesas@ideasonboard.com>
 <20190404155739.byhj4hqid2o6aqb4@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404155739.byhj4hqid2o6aqb4@uno.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On Thu, Apr 04, 2019 at 05:57:39PM +0200, Jacopo Mondi wrote:
> On Thu, Mar 28, 2019 at 09:07:17AM +0200, Laurent Pinchart wrote:
> > The V4L2 API is missing the 16-bit RGB555 formats for the RGBA, RGBX,
> > ABGR, XBGR, BGRA and BGRX component orders. Add them, using the same
> > 4CCs as DRM.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 138 ++++++++++++++++++
> >  include/uapi/linux/videodev2.h                |   6 +
> >  2 files changed, 144 insertions(+)
> >
> > diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > index b475cbba492f..9a9c1993b0fd 100644
> > --- a/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > +++ b/Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst
> > @@ -323,6 +323,144 @@ next to each other in memory.
> >        - g\ :sub:`4`
> >        - g\ :sub:`3`
> >        -
> > +    * .. _V4L2-PIX-FMT-RGBA555:
> > +
> > +      - ``V4L2_PIX_FMT_RGBA555``
> > +      - 'RA15'
> > +
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      - a
> > +
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      -
> > +    * .. _V4L2-PIX-FMT-RGBX555:
> > +
> > +      - ``V4L2_PIX_FMT_RGBX555``
> > +      - 'RX15'
> > +
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      -
> > +
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      - g\ :sub:`2`
> > +      -
> > +    * .. _V4L2-PIX-FMT-ABGR555:
> > +
> > +      - ``V4L2_PIX_FMT_ABGR555``
> > +      - 'AB15'
> > +
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +
> > +      - a
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      -
> > +    * .. _V4L2-PIX-FMT-XBGR555:
> > +
> > +      - ``V4L2_PIX_FMT_XBGR555``
> > +      - 'XB15'
> > +
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +
> > +      -
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      -
> > +    * .. _V4L2-PIX-FMT-BGRA555:
> > +
> > +      - ``V4L2_PIX_FMT_BGRA555``
> > +      - 'BA15'
> > +
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +      - a
> > +
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      -
> > +    * .. _V4L2-PIX-FMT-BGRX555:
> > +
> > +      - ``V4L2_PIX_FMT_BGRX555``
> > +      - 'BX15'
> > +
> > +      - g\ :sub:`2`
> > +      - g\ :sub:`1`
> > +      - g\ :sub:`0`
> > +      - r\ :sub:`4`
> > +      - r\ :sub:`3`
> > +      - r\ :sub:`2`
> > +      - r\ :sub:`1`
> > +      - r\ :sub:`0`
> > +      -
> > +
> > +      - b\ :sub:`4`
> > +      - b\ :sub:`3`
> > +      - b\ :sub:`2`
> > +      - b\ :sub:`1`
> > +      - b\ :sub:`0`
> > +      - g\ :sub:`4`
> > +      - g\ :sub:`3`
> > +      -
> 
> I see the last 4 formats are identical in their components
> disposition. Is this intended?
> 
>                    B1                          B0
>           b7                   b0   b7                  b0
> ABGR555 | g2 g1 g0 b4 b3 b2 b1 b0 | a r4 r3 r2 r1 r0 g4 g3 |
> XBGR555 | g2 g1 g0 b4 b3 b2 b1 b0 | x r4 r3 r2 r1 r0 g4 g3 |

Unless I'm mistaken, these two are defined in the patch as

  ABGR555 | g2 g1 g0 r4 r3 r2 r1 r0 | a  b4 b3 b2 b1 b0 g4 g3 |
  XBGR555 | g2 g1 g0 r4 r3 r2 r1 r0 | x  b4 b3 b2 b1 b0 g4 g3 |

> BGRA555 | g2 g1 g0 b4 b3 b2 b1 b0 | a r4 r3 r2 r1 r0 g4 g3 |
> BGRX555 | g2 g1 g0 b4 b3 b2 b1 b0 | x r4 r3 r2 r1 r0 g4 g3 |

These two formats are defined as

  BGRA555 | g2 g1 g0 r4 r3 r2 r1 r0 | a  b4 b3 b2 b1 b0 g4 g3 |
  BGRX555 | g2 g1 g0 r4 r3 r2 r1 r0 | x  b4 b3 b2 b1 b0 g4 g3 |

as well, while they should be defined as

  BGRA555 | g1 g0 r4 r3 r2 r1 r0 a  | b4 b3 b2 b1 b0 g4 g3 g2 |
  BGRX555 | g1 g0 r4 r3 r2 r1 r0 x  | b4 b3 b2 b1 b0 g4 g3 g2 |

I will fix this.

> If there is any correlation with the naming scheme (but I think
> there's not, at least not a strict one) 'a' and 'x' of BGR* formats
> should be in the most significant bit of Byte 1.

Did you mean the least significant bit ?

> >      * .. _V4L2-PIX-FMT-RGB565:
> >
> >        - ``V4L2_PIX_FMT_RGB565``
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index df9fa78a6ab7..fb6f01a7c91c 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -523,6 +523,12 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_RGB555  v4l2_fourcc('R', 'G', 'B', 'O') /* 16  RGB-5-5-5     */
> >  #define V4L2_PIX_FMT_ARGB555 v4l2_fourcc('A', 'R', '1', '5') /* 16  ARGB-1-5-5-5  */
> >  #define V4L2_PIX_FMT_XRGB555 v4l2_fourcc('X', 'R', '1', '5') /* 16  XRGB-1-5-5-5  */
> > +#define V4L2_PIX_FMT_RGBA555 v4l2_fourcc('R', 'A', '1', '5') /* 16  RGBA-5-5-5-1  */
> > +#define V4L2_PIX_FMT_RGBX555 v4l2_fourcc('R', 'X', '1', '5') /* 16  RGBX-5-5-5-1  */
> > +#define V4L2_PIX_FMT_ABGR555 v4l2_fourcc('A', 'B', '1', '5') /* 16  ABGR-1-5-5-5  */
> > +#define V4L2_PIX_FMT_XBGR555 v4l2_fourcc('X', 'B', '1', '5') /* 16  XBGR-1-5-5-5  */
> > +#define V4L2_PIX_FMT_BGRA555 v4l2_fourcc('B', 'A', '1', '5') /* 16  BGRA-5-5-5-1  */
> > +#define V4L2_PIX_FMT_BGRX555 v4l2_fourcc('B', 'X', '1', '5') /* 16  BGRX-5-5-5-1  */
> >  #define V4L2_PIX_FMT_RGB565  v4l2_fourcc('R', 'G', 'B', 'P') /* 16  RGB-5-6-5     */
> >  #define V4L2_PIX_FMT_RGB555X v4l2_fourcc('R', 'G', 'B', 'Q') /* 16  RGB-5-5-5 BE  */
> >  #define V4L2_PIX_FMT_ARGB555X v4l2_fourcc_be('A', 'R', '1', '5') /* 16  ARGB-5-5-5 BE */

-- 
Regards,

Laurent Pinchart
