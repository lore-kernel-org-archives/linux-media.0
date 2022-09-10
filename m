Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D19C6FA82
	for <linux-media@archiver.kernel.org>; Sat, 10 Sep 2022 16:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiIJQRj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 10 Sep 2022 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIJQRg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 10 Sep 2022 12:17:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28AB491D5
        for <linux-media@vger.kernel.org>; Sat, 10 Sep 2022 09:17:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58D9E440;
        Sat, 10 Sep 2022 18:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662826651;
        bh=xMYcT2GoznLQ3D1APWDBVImbeqmBcaZf/Y/FfZiAVHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWJBilMKH51QY8EvQiiISWkSju1rdZW1Hk3/P3nzW5WVpqdSR4anEEi1MrM20xlGX
         CqSr20b7w4nLKM4hC//2PdFUvw9pd95+NGBZGnGs4flPbrW3Cc4x0vfLBdyYRQJsE1
         OTT7D7FY/6mcwP5X+BHS3CJbLr0npgALf9jYVhPc=
Date:   Sat, 10 Sep 2022 19:17:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hidenori Kobayashi <hidenorik@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Michael Olbrich <m.olbrich@pengutronix.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Scally <djrscally@gmail.com>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin MUGNIER <benjamin.mugnier@foss.st.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [Media Summit] Imaging Sensor functionality
Message-ID: <Yxy4ixiuevMf/fZW@pendragon.ideasonboard.com>
References: <CAPY8ntBGKkg=KOXaP9bBv6Y8c7Mgut0=w-LTsvKHZac=zzdJDQ@mail.gmail.com>
 <29b69b01-15c9-28dc-4e21-7e54be171059@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29b69b01-15c9-28dc-4e21-7e54be171059@xs4all.nl>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

On Sat, Sep 10, 2022 at 02:50:10PM +0200, Hans Verkuil wrote:
> On 06/09/2022 18:14, Dave Stevenson wrote:
> > Hi All.
> > 
> > I realise that I'm in a slightly different position from many mainline
> > Linux-media developers in that I see multiple use cases for the same
> > sensor, rather than a driver predominantly being for one
> > product/platform. I'm therefore wanting to look at generic solutions
> > and fully featured drivers. Users get to decide the use cases, not the
> > hardware designers.
> > 
> > The issues I've raised are things that I've encountered and would
> > benefit from a discussion to get views as to the direction that is
> > perceived to be workable. I appreciate that some can not be solved
> > immediately, but want to avoid too much bikeshedding in the first
> > round of patches.
> > What's realistic, and what pitfalls/limitations immediately jump out at people.
> > 
> > Slides are at https://drive.google.com/file/d/1vjYJjTNRL1P3j6G4Nx2ZpjFtTBTNdeFG/view?usp=sharing
> > 
> > See you on Monday.
> > 
> >   Dave
> 
> Some comments for the meeting on Monday:
> 
> - On-sensor temperature sensing:
> 
> If a control is used to read this, but the value is
> not available yet, then -EACCES can be returned. That's already defined as a valid return
> code in the API, it would just need to be extended for this use-case.
> 
> - Sync sensors:
> 
> Should it be part of the DT? That depends, I think, on whether this is a pure sw mechanism,
> or whether the wiring dictates which sensor can be master and which can be slaves. I assume
> that at the very least there has to be a way to group sensors that are/can be connected to
> the same master sync signal.
> 
> - Lens assemblies:
> 
> For what it is worth, Cisco uses motor controlled lenses and irises. We extended the camera
> controls with these new controls:
> 
> #define V4L2_CID_FOCUS_CURRENT                  (V4L2_CID_CAMERA_CLASS_BASE+36)
> #define V4L2_CID_IRIS_CURRENT                   (V4L2_CID_CAMERA_CLASS_BASE+38)
> #define V4L2_CID_FOCUS_MOTOR_STATUS             (V4L2_CID_CAMERA_CLASS_BASE+41)
> #define V4L2_CID_IRIS_MOTOR_STATUS              (V4L2_CID_CAMERA_CLASS_BASE+43)
> enum v4l2_motor_status {
>         V4L2_MOTOR_STATUS_IDLE                  = (0),
>         V4L2_MOTOR_STATUS_MOVING                = (1 << 0),
>         V4L2_MOTOR_STATUS_FAILED                = (1 << 1),
>         V4L2_MOTOR_STATUS_NOTCALIBRATED         = (1 << 2),
> };
> #define V4L2_CID_FOCUS_MOTOR_SPEED              (V4L2_CID_CAMERA_CLASS_BASE+46)
> #define V4L2_CID_IRIS_MOTOR_SPEED               (V4L2_CID_CAMERA_CLASS_BASE+48)
> 
> This worked well for our use-case, but for us userspace has complete knowledge about
> the camera assembly properties.

Where does userspace get that information from ?

-- 
Regards,

Laurent Pinchart
