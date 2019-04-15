Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D4C10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 05:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5543520833
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 05:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Be8HIu9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfDOFc1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:32:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40981 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfDOFc1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 01:32:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so13347941otb.8
        for <linux-media@vger.kernel.org>; Sun, 14 Apr 2019 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3r9tuCSDIx/NLeidbG+C3OPk5P7bSaWRg4fFKktj/BI=;
        b=Be8HIu9JN4Uc7fDJW3KhQ1XR9VT9cF+S5ueDDgqzZ1fbq+5r1AEkLkEwLve5WNAAgs
         0U/KrcNYgByQOBWcUUgoW2LXu3eB6y2EIj5r9MnIzNW+KJkSl8G1hG+aQfssgdCkwNJl
         mh9/NtkTgHpkWam2eo7QLyHPEIIHnJXrZVves=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3r9tuCSDIx/NLeidbG+C3OPk5P7bSaWRg4fFKktj/BI=;
        b=qgrLkDQNn+5tuKIYCvWZgVvHDIZxJZ8dNVW8CI+TlS+3BV+G/iOMi7Vd/wiF6qhY3S
         KVFMGa3DnJGfQq+AY1FzsRi8HysbbQOH7f7hgcKqHx3HIdonINK2nWMUjBnhH+pei9P0
         +bU+9CZs9A4Ebx1vlGBiBBxn9dJqNcBCb3gTaHk47wFUqzJSaXizHQu29vwgg9ekuAXg
         oI2uOPS9Fjy6CRm+e33QrckzDmK4XxeS7R3z0c93lJoAuGFSLOwJ3/Fa5Jlxg42weYRQ
         NI5ifQtpZfJnHzSPrQ7YxYdR3G9Fty+EDu2/9DstfkDYdyYmGTVjZ8mlpJPgDW+A7o5P
         jZPw==
X-Gm-Message-State: APjAAAXs8aKqH8BkxlcS/KM2O38+OCZP9Z9xmLdOA3qx6blrJERh+Ci0
        mGfL4pa9supOR7FvotBgV/zUxMs8NLdkMA==
X-Google-Smtp-Source: APXvYqxGv/y39OWRI5QQ/FApctbGKG2LXY1WkJAwX7jz9YCE5GadqWqPMCqMbrAB6hINI69UgR5cUw==
X-Received: by 2002:a9d:5d0b:: with SMTP id b11mr13836654oti.80.1555306346006;
        Sun, 14 Apr 2019 22:32:26 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id v201sm16314872oia.39.2019.04.14.22.32.24
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 22:32:24 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 103so13351184otd.9
        for <linux-media@vger.kernel.org>; Sun, 14 Apr 2019 22:32:24 -0700 (PDT)
X-Received: by 2002:a9d:6206:: with SMTP id g6mr45426918otj.7.1555306344060;
 Sun, 14 Apr 2019 22:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
 <20190408123256.22868-7-p.zabel@pengutronix.de> <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
 <1554906176.3765.9.camel@pengutronix.de> <863e842a16db5ee6b10a2fd149119ae41ce26de6.camel@ndufresne.ca>
 <5feecd0e-5c7b-27fe-84a0-0bffb04128df@xs4all.nl> <1554970925.6389.1.camel@pengutronix.de>
 <36f792a8-7680-100f-09a4-b9315177c791@xs4all.nl> <1554984042.6389.5.camel@pengutronix.de>
 <1502ac1f39973ad1bf1a4ee9a951c09d88941651.camel@ndufresne.ca>
In-Reply-To: <1502ac1f39973ad1bf1a4ee9a951c09d88941651.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 15 Apr 2019 14:32:12 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bs3tdF+4rK5Uj8W60eBKzBCR-TovDEtAn+vHTsjCFLNA@mail.gmail.com>
Message-ID: <CAAFQd5Bs3tdF+4rK5Uj8W60eBKzBCR-TovDEtAn+vHTsjCFLNA@mail.gmail.com>
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Apr 12, 2019 at 12:53 AM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le jeudi 11 avril 2019 =C3=A0 14:00 +0200, Philipp Zabel a =C3=A9crit :
> > On Thu, 2019-04-11 at 12:18 +0200, Hans Verkuil wrote:
> > > On 4/11/19 10:22 AM, Philipp Zabel wrote:
> > > > On Wed, 2019-04-10 at 18:24 +0200, Hans Verkuil wrote:
> > > > > On 4/10/19 6:11 PM, Nicolas Dufresne wrote:
> > > > > > Le mercredi 10 avril 2019 =C3=A0 16:22 +0200, Philipp Zabel a =
=C3=A9crit :
> > > > > > > On Wed, 2019-04-10 at 15:43 +0200, Hans Verkuil wrote:
> > > > > > > [...]
> > > > > > > > > @@ -1126,12 +1127,32 @@ static int coda_enum_frameinterva=
ls(struct file *file, void *fh,
> > > > > > >
> > > > > > > [...]
> > > > > > > > Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no =
sense for a codec.
> > > > > > > > I'd remove it altogether.
> > > > > >
> > > > > > It does make sense, since framerate is the only information tha=
t can be
> > > > > > used to produce a specific bitrate. If you don't enumerate the =
rates,
> > > > > > then you may endup with a miss-match of what userspace wants, w=
hich
> > > > > > will result in a different rate then what the user-space antici=
pated.
> > > > > > That being said, I expect these intervals to be really wide. Ve=
nus HW
> > > > > > uses a Q16 internally, which is precise enough that we could ju=
st
> > > > > > ignore the interval.
> > > > >
> > > > > So the problem is that for an encoder where you desires a specifi=
c
> > > > > constant bitrate, the encoder also needs to know the framerate.
> > > > >
> > > > > And the driver then would have to support ENUM_FRAMEINTERVALS and=
 the
> > > > > S_PARM ioctl so userspace can set the framerate.
> > > >
> > > > Ah right, that was it. Encoding works fine without ENUM_FRAMEINTERV=
ALS,
> > > > as coda has no meaningful frame rate limitations. I had implemented
> > > > S_PARM since it is required for CBR encoding, and v4l2-compliance t=
hen
> > > > complained about ENUM_FRAMEINTERVALS missing:
> > > >
> > > >   cde29ef313de ("[media] coda: Use S_PARM to set nominal framerate =
for h.264 encoder")
> > > >   07b6080d4e6d ("media: coda: implement ENUM_FRAMEINTERVALS")
> > >
> > > And I think that's right. If you advertise framerate support, then
> > > userspace needs to know about the capabilities.
> > >
> > > I do think ENUM_FRAMEINTERVALS should return some sane values. Right =
now
> > > coda advertises 1/65535 fps to 65535 fps (or thereabout).
> >
> > Those are the limits imposed by the frame rate registers.
> >
> > > I would probably return 1 fps to 200 fps (200 Hz is the highest frame=
rate
> > > defined by CTA-861-G).
> >
> > Why? We can certainly encode more than 200 fps in real time if only the
> > frame size is small enough, and for offline transcoding the nominal
> > frame rate can be anything the coded format supports.
> > Smaller than 1 fps might be useful for time lapse videos as well.
> >
> > > This can also eventually be a helper function in v4l2-mem2mem.c since=
 I expect
> > > this to be the same for all (?) encoders.
> >
> > For example h.264 has an optional 32-bit numerator and denominator
> > (num_units_in_tick and time_scale in the Video Usability Information).
> > I don't see any reason to limit this artificially in the driver.
> >
> > > > Hmm, not necesarily. I hadn't thought about that before, but if the
> > > > decoder supports frame skipping this could be used to advertise
> > > > available reductions in frame rate.
> > >
> > > That assumes that you want to use S_PARM for that as well. And does t=
he decoder
> > > provide the framerate encoded in the bitstream to the driver?
> >
> > That is a difficult question. Yes, depending on CODA hardware variant,
> > codec, and actual bitstream (where this information is optional), the
> > firmware may or may not report the frame rate. Maybe it is fundamentall=
y
> > not a good idea to try to control frame skipping via the nominal frame
> > rate instead of directly.
>
> The Xilinx VCU decoder will allocate a different amount of cores per
> session depending on the framerate we give it. This is how they manage
> to handle more stream for lower rate/resolution etc. And it makes the
> S_PARM call mandatory, since faking one will always lead to some
> streams not to work properly, or less streams being handled in
> parallel.
>
> I personally don't see why we should in anyway be restrictive to the
> information we are allowed to pass to a driver. Specially that is does
> not matter if the driver uses it or not. And because there is no way we
> will be able to think about every possible use cases popping in the
> future, and it does not make backward compatibility to be a little more
> open here.

I think it just boils down to defining the meaning properly,
especially thinking about what ENUM_FRAME_INTERVALS would return.

In particular, I don't think there is any sensible way to guarantee
any performance aspects related to the frame rate conveyed via this
channel, so even if the application sees 200 fps here, it should just
mean that the bit-rate control algorithm can handle 200 fps streams,
but it can actually encode 60 fps (and so not real-time), due to the
hardware performance.

Best regards,
Tomasz
