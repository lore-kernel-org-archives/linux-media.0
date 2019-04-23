Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E6C282DD
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 16:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D84020811
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 16:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="qY8y5Y7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfDWQCw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:02:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33067 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWQCw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 12:02:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so14058881ljc.0
        for <linux-media@vger.kernel.org>; Tue, 23 Apr 2019 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mjSEdl2bHOdc9zUaXJvV57aQi9xzuQIo11CUWnvHwo=;
        b=qY8y5Y7+pFkoDUCu5qAAdGClW2u9gdVzifvnirmoig97yNpy85QBKOavjvkEW8FMRL
         gJMHNQCx5ZtKBPdYK5eNyg3S8UEuJ+sHKqHmyukm0OaeWTAWp31n6/HHaywJLAdXbJvQ
         ckgotEvA/zsobgd5s+xNeiBeg77Gd/RF+geUrcpno/XhWMFXgnV1XW4kw+z2leqvHi3s
         tmlyRIWnJpZwg+GM5aAXLdMW8wrcVeq3ygKvJnk0YHKJK6ewvMkCDajMZ5GAwKYuZ51N
         tC4nAhyjrJulA5g2ENtFfJFX3Kv/OuVrxM6G+Z4Ih5rrqxsZb2ydl8LpVBXlwqqCbxAd
         e6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mjSEdl2bHOdc9zUaXJvV57aQi9xzuQIo11CUWnvHwo=;
        b=K5FziOjdy/m4jp9A9U3hWxiW5Mh/l790oVY7GeHtEfH3tl5HY+PYedyYmEZqrBYWS/
         jVcvs8Qer/odk4Htxy+EeLWtIgsQ/6VvQxxlSrRsFO6NsajI02VwAtyyde9cvPaHzR/T
         L/CFNLg9HmpErxR4k5tyAgO2kXNpUc0wmgSsHBaHxo7t52etqEsLgrS1JPwe0jmyGKJQ
         e9XuASX9dXvqJ81PlXJfesfTcmk2A+fgApLx0Iyd6NKTa7F5yJOnfS8/nL/v6FaFxGKv
         WkJCaGT1i0C0E3LMW8RBufhHH5MLh4JJ/rylGjsil2ODMAmvEPOa+iKKyLHDdHqq3Ddo
         9TLA==
X-Gm-Message-State: APjAAAVL+K/tHFX4KrCc9E1/TGJrZGef/7dNSX13Z5kow08kutfao7/E
        aUjt4XrhHJ8AfAZXGYVhuyLpkkBsYA9LF/cSJBW7IQ==
X-Google-Smtp-Source: APXvYqyO0Z7AZuogTJR/TgrdZXDnfJydBfKtPSGc7kpwt+P98SlU6lR+bjd1zNPOXSeo3/NgpkGOoVRF/qVvwqW6x1o=
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr2699587ljh.80.1556035369344;
 Tue, 23 Apr 2019 09:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local> <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea> <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
 <20190420225904.GZ4964@pendragon.ideasonboard.com> <20190423072554.GW13337@phenom.ffwll.local>
 <CAPj87rMWdjEvTJWRvdMLTZyw7pZpo5PpPr0FWcALNRe_D8cYqw@mail.gmail.com> <20190423155416.GI16111@pendragon.ideasonboard.com>
In-Reply-To: <20190423155416.GI16111@pendragon.ideasonboard.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Tue, 23 Apr 2019 17:02:27 +0100
Message-ID: <CAPj87rOyX_6X-UbgPVrU-uGeeyqgTnp57UYD3QUJeiCWDfk9Kg@mail.gmail.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Laurent,

On Tue, 23 Apr 2019 at 16:54, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, Apr 23, 2019 at 09:59:37AM +0100, Daniel Stone wrote:
> > On Tue, 23 Apr 2019 at 08:26, Daniel Vetter <daniel@ffwll.ch> wrote:
> > Totally. Let's take DRM_FORMAT_XRGB8888 + I915_FORMAT_MOD_Y_TILED as
> > an example. [... details ...]
>
> Looks like we have different kinds of metadata to consider. On the V4L2
> side metadata usually refers to the context in which a frame was
> captured, it doesn't tell how to interpret the contents of the pixels.
> In the case you just described, the metadata is part of the frame
> contents. I agree that this is a proper use case for storing such
> metadata in a plane. What I wouldn't like to see being stored in a plane
> is for instance gamma tables or similar data that configures the
> processing pipeline in the display engine (I know we have an API for
> gamma tables, this is just an example).
>
> > It would be good to understand what you had in mind when you said that
> > using multiple planes created a mess. I haven't touched media
> > encode/decode units at a low level for quite a while (hooray for
> > gst-v4l2!), but I remember that they often used padding areas around
> > the buffer for scratch space - maybe motion vectors or similar? That
> > case is quite different to something like CCS, since the data is only
> > meaningful to the media engine and must be ignored (but preserved) by
> > everyone else. Using multiple planes in that case isn't appropriate,
> > since it's very specific to how that hardware unit deals with that
> > buffer, instead of something that every consumer needs to understand
> > in order to use it.
>
> With metadata unrelated to the pixel content, using a separate plane in
> the same buffer resulted in an explosion of the number of combinations
> that we would need to support, and ultimately led to a very ill-defined
> API. We decided to convey metadata related to the frame capture context
> (e.g. what exposure time was used for the frame) and processing pipeline
> configuration data in different buffers than the frame itself.

Yeah, that makes sense. It's not really that different from what
happens with GPUs either: the final colour buffer the display
controller gets from a game is the product of a _lot_ of other work
which is invisible to the display controller, including things like
depth and stencil buffers, command buffers, etc etc. Those are closely
related to the frame production, but totally irrelevant for exchanging
the colour buffer with other subsystems.

I think we should look at the metadata buffers you're describing in
the same way. Perhaps each V4L2 buffer could have driver-private
auxiliary buffer storage, or perhaps it's something you need to
separately expose to userspace as auxiliary data which must be
preserved but ignored. But modifiers are really only about what you
need when exchanging image colour buffers between subsystems, not
anything else.

You're pretty close with gamma tables as well; for HDR and other kinds
of complex colour management, we need to carry a fair bit of auxiliary
information in order to display the image correctly. These have quite
different uses though: normally the colour buffer is produced by the
hardware and the primaries/whitepoints/etc are produced by software,
with the colour-management details remaining static across the life of
a swapchain even as you flip between multiple buffers. Given that, it
doesn't really make sense to try to stuff them into the same storage.

Cheers,
Daniel
