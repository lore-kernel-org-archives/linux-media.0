Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25DAC10F0E
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 09:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850BB2184B
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 09:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xi1jG/xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbfDRJWI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:22:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41648 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733049AbfDRJWH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 05:22:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so1131302otb.8
        for <linux-media@vger.kernel.org>; Thu, 18 Apr 2019 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjrP7AjRE5C57dl3TaDE513g5a5EIIy5UXbhoyecM3Y=;
        b=Xi1jG/xj7SfJGUkw9fQezzGTAD2GONRRvICHVCJDcNepxf0hpoRefPue+do1WgwuVI
         vcv9f1o3menb5Gq8kyRLaMZjHt67Lb0jCaGT/jS5qpjUdhiS/17h05Cg2LO6uz2OXVDq
         Cs/VBcfDYx6CalY7k09WOWmKHvzR/5G3JFOIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjrP7AjRE5C57dl3TaDE513g5a5EIIy5UXbhoyecM3Y=;
        b=djU2a/DFzmNkJFUHKKSXcPdaJZub4dblKghrpAi1uo3qDQ20jbRQQlr94nkFnG27YN
         IfaIpLL5V5OVG8qo4arEIW5RJvfwhaElYODUwBe6qTpUOyNLgOJinRycAkUWS7ywLwaC
         tfS3FGM8Hd9P5+Yy74ZFxCdIAp6hc8RjcTKttJ3SPXvcHMcpzw4AsJOfuTqKh9TnBxOp
         aEp2agOgOuLD5RZYCfxe9C5CehzrNBvvG7bz9POoYCpDzEgA5DMDlarMuzojyN02Achv
         d0Z/9Iva3c0M2S535Os9bz05J812O09DcYz58RGhrDEwJ1cAjqNDbrJbYl1m8vO9SSnH
         ajYQ==
X-Gm-Message-State: APjAAAUdBX7aLJb1nJ56UAK+iRHh0HjmGdc5vIqLmhLTz1qfe3RlGfT3
        9jaY92YLDeJlsGfyANUstb/IPiBkQW4=
X-Google-Smtp-Source: APXvYqwkyyFXGkYTuMrpRLmbjcSFNw9BD5Yi9DNXIH8FpSBLKaLMRo0/PUPvvpvqX32aJZYu0iWdag==
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr56035498oti.118.1555579326516;
        Thu, 18 Apr 2019 02:22:06 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id r25sm536337otk.37.2019.04.18.02.22.05
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 02:22:05 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id n187so1074619oih.6
        for <linux-media@vger.kernel.org>; Thu, 18 Apr 2019 02:22:05 -0700 (PDT)
X-Received: by 2002:aca:d8d5:: with SMTP id p204mr1345107oig.26.1555579324600;
 Thu, 18 Apr 2019 02:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local> <522d6a7734a29df47fe11f5f6311b49e14dabae0.camel@bootlin.com>
 <CAAFQd5Bou1abM4QMPFHqEcJnqGW7F1rZdAoLGmjZnVQTPh4WSw@mail.gmail.com> <03187f79f37fdb45f3a774e200e21a29167776a8.camel@bootlin.com>
In-Reply-To: <03187f79f37fdb45f3a774e200e21a29167776a8.camel@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 18 Apr 2019 18:21:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A5=hzCTPd=fCd=L6ZmuSs254dExDUrZ_b25qddWREdew@mail.gmail.com>
Message-ID: <CAAFQd5A5=hzCTPd=fCd=L6ZmuSs254dExDUrZ_b25qddWREdew@mail.gmail.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Apr 18, 2019 at 6:14 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Thu, 2019-04-18 at 18:09 +0900, Tomasz Figa wrote:
> > On Thu, Apr 18, 2019 at 5:55 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > > Hi Daniel,
> > >
> > > On Thu, 2019-04-18 at 10:18 +0200, Daniel Vetter wrote:
> > > > On Wed, Apr 17, 2019 at 08:10:15PM +0200, Paul Kocialkowski wrote:
> > > > > Hi Nicolas,
> > > > >
> > > > > I'm detaching this thread from our V4L2 stateless decoding spec since
> > > > > it has drifted off and would certainly be interesting to DRM folks as
> > > > > well!
> > > > >
> > > > > For context: I was initially talking about writing up support for the
> > > > > Allwinner 2D engine as a DRM render driver, where I'd like to be able
> > > > > to batch jobs that affect the same destination buffer to only signal
> > > > > the out fence once when the batch is done. We have a similar issue in
> > > > > v4l2 where we'd like the destination buffer for a set of requests (each
> > > > > covering one H264 slice) to be marked as done once the set was decoded.
> > > > >
> >
> > Out of curiosity, what area did you find a 2D blitter useful for?
>
> The initial motivation is to bring up a DDX with that for platforms
> that have 2D engines but no free software GPU drivers yet.
>
> I also have a personal project in the works where I'd like to implement
> accelerated UI rendering in 2D. The idea is to avoid using GL entirely.
>
> That last point is in part because I have a GPU-less device that I want
> to get going with mainline: http://linux-sunxi.org/F60_Action_Camera

Okay, thanks.

I feel like the typical DRM model with a render node and a userspace
library would make sense for these specific use cases on these
specific hardware platforms then.

Hopefully the availability of open drivers for 3D engines continues to improve.

Best regards,
Tomasz
