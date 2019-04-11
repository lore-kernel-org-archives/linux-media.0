Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12681C10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 08:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8412082E
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 08:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfDKIWJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:22:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39461 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKIWI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 04:22:08 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEUyE-0007Wu-7i; Thu, 11 Apr 2019 10:22:06 +0200
Message-ID: <1554970925.6389.1.camel@pengutronix.de>
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 11 Apr 2019 10:22:05 +0200
In-Reply-To: <5feecd0e-5c7b-27fe-84a0-0bffb04128df@xs4all.nl>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
         <20190408123256.22868-7-p.zabel@pengutronix.de>
         <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
         <1554906176.3765.9.camel@pengutronix.de>
         <863e842a16db5ee6b10a2fd149119ae41ce26de6.camel@ndufresne.ca>
         <5feecd0e-5c7b-27fe-84a0-0bffb04128df@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 2019-04-10 at 18:24 +0200, Hans Verkuil wrote:
> On 4/10/19 6:11 PM, Nicolas Dufresne wrote:
> > Le mercredi 10 avril 2019 à 16:22 +0200, Philipp Zabel a écrit :
> > > On Wed, 2019-04-10 at 15:43 +0200, Hans Verkuil wrote:
> > > [...]
> > > > > @@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
> > > 
> > > [...]
> > > > Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no sense for a codec.
> > > > I'd remove it altogether.
> > 
> > It does make sense, since framerate is the only information that can be
> > used to produce a specific bitrate. If you don't enumerate the rates,
> > then you may endup with a miss-match of what userspace wants, which
> > will result in a different rate then what the user-space anticipated.
> > That being said, I expect these intervals to be really wide. Venus HW
> > uses a Q16 internally, which is precise enough that we could just
> > ignore the interval.
> 
> So the problem is that for an encoder where you desires a specific
> constant bitrate, the encoder also needs to know the framerate.
> 
> And the driver then would have to support ENUM_FRAMEINTERVALS and the
> S_PARM ioctl so userspace can set the framerate.

Ah right, that was it. Encoding works fine without ENUM_FRAMEINTERVALS,
as coda has no meaningful frame rate limitations. I had implemented
S_PARM since it is required for CBR encoding, and v4l2-compliance then
complained about ENUM_FRAMEINTERVALS missing:

  cde29ef313de ("[media] coda: Use S_PARM to set nominal framerate for h.264 encoder")
  07b6080d4e6d ("media: coda: implement ENUM_FRAMEINTERVALS")

> For decoders this would not make any sense AFAIKS, so this is encoder
> specific.

Hmm, not necesarily. I hadn't thought about that before, but if the
decoder supports frame skipping this could be used to advertise
available reductions in frame rate.

> Do I understand this correctly?
> 
> What should the default framerate be? 24 or 29.97 fps?

Driver specific? Max nominal real time capable frame rate? 30 fps?

> This should be documented in the stateful encoder spec. I never realized
> that this would be needed...
> 
> Philipp, based on this information I would say that ENUM_FRAMEINTERVALS
> can stay in the coda drivers, but for encoders only.

Ok.

regards
Philipp
