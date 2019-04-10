Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE1C10F0E
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 02:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A582084F
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 02:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WpZFaXOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDJCcn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:32:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37594 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfDJCcm (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 22:32:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id c16so554807otn.4
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c7jMKnq23CGWwaNQQLm6FufWISDLtAz8taBEk3kMjzQ=;
        b=WpZFaXOH6GYIsMsfZSj/QWBBuoEA6TA3r3GQu822Eqz9sEp4p/dKbnhdAWw5FTTZ3V
         KX7yA7lFsf0vCmhYz5Jm17zRWEt9NiIMZU/uXhB0vcpx5YuSILfjvI9jWX8HLfFb8VA9
         XqHSZIvr54cfORTXhBhCxzJdqUVnZAPwJ1VV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c7jMKnq23CGWwaNQQLm6FufWISDLtAz8taBEk3kMjzQ=;
        b=kyYmviEZ1imhuhgBnfThU45/9NIQVGZS5Qhi4R/xAgV8sVdgqzpRIROtAOuhffSrQe
         gbQ5KYHVCI/ht00G3zzmsAF2r+VrJ0S5kb/hcUGhFxpRuBVv2pM6F8tjYeZpskRmCwuh
         Cc+uUKIwfQy9qlYYZZ0C0OP/k4I0GwvcIcc9yAYmD6ptoo9pEfMV9Mgq4O/C33OhR23D
         4w1JUPYyYqHKhKHeRwlqwiajjXkmXaDlpQIAoAAEJe/uPMe5Hc8BdU+LnIAh31skKcw6
         ZLGR1clx6VUtb4agk3hz7Ne22Q1PKYCaB6X1Az4j9mLcbgjJIVgPVFwCyNQRxAY29iqd
         qAUg==
X-Gm-Message-State: APjAAAWwz9FrG6+3sHbMg9m6IJOGX523eP2VDvLKhcfhPXC6vaeilgp3
        5VbDlr0L7vl9wKO+4M+77QYf55682AI=
X-Google-Smtp-Source: APXvYqz4oG671fYn5RJwsuYfQkPuQBPHTiXa4XuisauFcV3DevyPCPhHVh1h1NW/Z9Dc++xiQrnrfQ==
X-Received: by 2002:a9d:6850:: with SMTP id c16mr27113527oto.226.1554863561209;
        Tue, 09 Apr 2019 19:32:41 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id n3sm13428791oia.46.2019.04.09.19.32.39
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:32:40 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id v7so425334oie.8
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 19:32:39 -0700 (PDT)
X-Received: by 2002:aca:a894:: with SMTP id r142mr1009226oie.112.1554863559054;
 Tue, 09 Apr 2019 19:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org> <CAAFQd5Cm1zyPzJnixwNmWzxn2zh=63YrA+ZzH-arW-VZ_x-Awg@mail.gmail.com>
 <28069a44-b188-6b89-2687-542fa762c00e@linaro.org> <CAAFQd5BevOV2r1tqmGPnVtdwirGMWU=ZJU85HjfnH-qMyQiyEg@mail.gmail.com>
 <affce842d4f015e13912b2c3941c9bf02e84d194.camel@ndufresne.ca>
 <CAAFQd5Ahg4Di+SBd+-kKo4PLVyvqLwcuG6MphU5Rz1PFXVuamQ@mail.gmail.com>
 <e8a90694c306fde24928a569b7bcb231b86ec73b.camel@ndufresne.ca>
 <CAAFQd5DFfQRd1VoN7itVXnWGKW_WBKU-sm6vo5CdgjkzjEEkFg@mail.gmail.com>
 <57419418d377f32d0e6978f4e4171c0da7357cbb.camel@ndufresne.ca>
 <1548938556.4585.1.camel@pengutronix.de> <CAAFQd5Aih7cWu-cfwBvNdwhHHYEaMF0SFebrYfdNXD9qKu8fxw@mail.gmail.com>
 <1f8485785a21c0b0e071a3a766ed2cbc727e47f6.camel@ndufresne.ca>
 <CAAFQd5CPKm1ES8c9Lab63Lr8ZfWRckHmJ99SVRYi6Hpe7hzy+g@mail.gmail.com>
 <f1e9dc99-4fcb-dee1-4279-ac0cf1d1fd6e@xs4all.nl> <CAAFQd5B+bt3SV_WRw1=2agZk=Q+Enbkv=nXCrbXX=+MNpeSpCg@mail.gmail.com>
 <cb8cda5d-e714-6019-4a76-3853ea49c4a6@xs4all.nl> <CAAFQd5BZhhX6Cjj7GhbaY_G7ERksyKne6hxKFCuTJoOnamoQ=A@mail.gmail.com>
 <CAAFQd5Ar9c91G66oFMYGj59n+_NScB_QyZB2yF_y+=Y_64pWqA@mail.gmail.com> <7773688904e78fb1a467d4afa5988e2f0648b54f.camel@ndufresne.ca>
In-Reply-To: <7773688904e78fb1a467d4afa5988e2f0648b54f.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 10 Apr 2019 11:32:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5COFnupWNRW3brwz5_BxUeO6MVk_KYrQvPFHmP6dJ2Ngw@mail.gmail.com>
Message-ID: <CAAFQd5COFnupWNRW3brwz5_BxUeO6MVk_KYrQvPFHmP6dJ2Ngw@mail.gmail.com>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Apr 10, 2019 at 1:31 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mardi 09 avril 2019 =C3=A0 18:59 +0900, Tomasz Figa a =C3=A9crit :
> > On Thu, Feb 7, 2019 at 4:33 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > > On Tue, Feb 5, 2019 at 7:35 PM Hans Verkuil <hverkuil@xs4all.nl> wrot=
e:
> > > > On 2/5/19 10:31 AM, Tomasz Figa wrote:
> > > > > On Tue, Feb 5, 2019 at 6:00 PM Hans Verkuil <hverkuil@xs4all.nl> =
wrote:
> > > > > > On 2/5/19 7:26 AM, Tomasz Figa wrote:
> > > > > > > On Fri, Feb 1, 2019 at 12:18 AM Nicolas Dufresne <nicolas@ndu=
fresne.ca> wrote:
> > > > > > > > Le jeudi 31 janvier 2019 =C3=A0 22:34 +0900, Tomasz Figa a =
=C3=A9crit :
> > > > > > > > > On Thu, Jan 31, 2019 at 9:42 PM Philipp Zabel <p.zabel@pe=
ngutronix.de> wrote:
> > > > > > > > > > Hi Nicolas,
> > > > > > > > > >
> > > > > > > > > > On Wed, 2019-01-30 at 10:32 -0500, Nicolas Dufresne wro=
te:
> > > > > > > > > > > Le mercredi 30 janvier 2019 =C3=A0 15:17 +0900, Tomas=
z Figa a =C3=A9crit :
> > > > > > > > > > > > > I don't remember saying that, maybe I meant to sa=
y there might be a
> > > > > > > > > > > > > workaround ?
> > > > > > > > > > > > >
> > > > > > > > > > > > > For the fact, here we queue the headers (or first=
 frame):
> > > > > > > > > > > > >
> > > > > > > > > > > > > https://gitlab.freedesktop.org/gstreamer/gst-plug=
ins-good/blob/master/sys/v4l2/gstv4l2videodec.c#L624
> > > > > > > > > > > > >
> > > > > > > > > > > > > Then few line below this helper does G_FMT intern=
ally:
> > > > > > > > > > > > >
> > > > > > > > > > > > > https://gitlab.freedesktop.org/gstreamer/gst-plug=
ins-good/blob/master/sys/v4l2/gstv4l2videodec.c#L634
> > > > > > > > > > > > > https://gitlab.freedesktop.org/gstreamer/gst-plug=
ins-good/blob/master/sys/v4l2/gstv4l2object.c#L3907
> > > > > > > > > > > > >
> > > > > > > > > > > > > And just plainly fails if G_FMT returns an error =
of any type. This was
> > > > > > > > > > > > > how Kamil designed it initially for MFC driver. T=
here was no other
> > > > > > > > > > > > > alternative back then (no EAGAIN yet either).
> > > > > > > > > > > >
> > > > > > > > > > > > Hmm, was that ffmpeg then?
> > > > > > > > > > > >
> > > > > > > > > > > > So would it just set the OUTPUT width and height to=
 0? Does it mean
> > > > > > > > > > > > that gstreamer doesn't work with coda and mtk-vcode=
c, which don't have
> > > > > > > > > > > > such wait in their g_fmt implementations?
> > > > > > > > > > >
> > > > > > > > > > > I don't know for MTK, I don't have the hardware and d=
idn't integrate
> > > > > > > > > > > their vendor pixel format. For the CODA, I know it wo=
rks, if there is
> > > > > > > > > > > no wait in the G_FMT, then I suppose we are being rea=
lly lucky with the
> > > > > > > > > > > timing (it would be that the drivers process the SPS/=
PPS synchronously,
> > > > > > > > > > > and a simple lock in the G_FMT call is enough to wait=
). Adding Philipp
> > > > > > > > > > > in CC, he could explain how this works, I know they u=
se GStreamer in
> > > > > > > > > > > production, and he would have fixed GStreamer already=
 if that was
> > > > > > > > > > > causing important issue.
> > > > > > > > > >
> > > > > > > > > > CODA predates the width/height=3D0 rule on the coded/OU=
TPUT queue.
> > > > > > > > > > It currently behaves more like a traditional mem2mem de=
vice.
> > > > > > > > >
> > > > > > > > > The rule in the latest spec is that if width/height is 0 =
then CAPTURE
> > > > > > > > > format is determined only after the stream is parsed. Oth=
erwise it's
> > > > > > > > > instantly deduced from the OUTPUT resolution.
> > > > > > > > >
> > > > > > > > > > When width/height is set via S_FMT(OUT) or output crop =
selection, the
> > > > > > > > > > driver will believe it and set the same (rounded up to =
macroblock
> > > > > > > > > > alignment) on the capture queue without ever having see=
n the SPS.
> > > > > > > > >
> > > > > > > > > That's why I asked whether gstreamer sets width and heigh=
t of OUTPUT
> > > > > > > > > to non-zero values. If so, there is no regression, as the=
 specs mimic
> > > > > > > > > the coda behavior.
> > > > > > > >
> > > > > > > > I see, with Philipp's answer it explains why it works. Note=
 that
> > > > > > > > GStreamer sets the display size on the OUTPUT format (in fa=
ct we pass
> > > > > > > > as much information as we have, because a) it's generic cod=
e and b) it
> > > > > > > > will be needed someday when we enable pre-allocation (REQBU=
FS before
> > > > > > > > SPS/PPS is passed, to avoid the setup delay introduce by al=
location,
> > > > > > > > mostly seen with CMA base decoder). In any case, the driver=
 reported
> > > > > > > > display size should always be ignored in GStreamer, the onl=
y
> > > > > > > > information we look at is the G_SELECTION for the case the =
x/y or the
> > > > > > > > cropping rectangle is non-zero.
> > > > > > > >
> > > > > > > > Note this can only work if the capture queue is not affecte=
d by the
> > > > > > > > coded size, or if the round-up made by the driver is bigger=
 or equal to
> > > > > > > > that coded size. I believe CODA falls into the first catego=
ry, since
> > > > > > > > the decoding happens in a separate set of buffers and are t=
hen de-tiled
> > > > > > > > into the capture buffers (if understood correctly).
> > > > > > >
> > > > > > > Sounds like it would work only if coded size is equal to the =
visible
> > > > > > > size (that GStreamer sets) rounded up to full macroblocks. No=
n-zero x
> > > > > > > or y in the crop could be problematic too.
> > > > > > >
> > > > > > > Hans, what's your view on this? Should we require G_FMT(CAPTU=
RE) to
> > > > > > > wait until a format becomes available or the OUTPUT queue run=
s out of
> > > > > >
> > > > > > You mean CAPTURE queue? If not, then I don't understand that pa=
rt.
> > > > >
> > > > > No, I exactly meant the OUTPUT queue. The behavior of s5p-mfc in =
case
> > > > > of the format not being detected yet is to waits for any pending
> > > > > bitstream buffers to be processed by the decoder before returning=
 an
> > > > > error.
> > > > >
> > > > > See https://elixir.bootlin.com/linux/v5.0-rc5/source/drivers/medi=
a/platform/s5p-mfc/s5p_mfc_dec.c#L329
> > > >
> > > > It blocks?! That shouldn't happen. Totally against the spec.
> > > >
> > >
> > > Yeah and that's what this patch tries to implement in venus as well
> > > and is seemingly required for compatibility with gstreamer...
> > >
> > > > > .
> > > > >
> > > > > > > buffers?
> > > > > >
> > > > > > First see my comment here regarding G_FMT returning an error:
> > > > > >
> > > > > > https://www.spinics.net/lists/linux-media/msg146505.html
> > > > > >
> > > > > > In my view that is a bad idea.
> > > > >
> > > > > I don't like it either, but it seemed to be the most consistent a=
nd
> > > > > compatible behavior, but I'm not sure anymore.
> > > > >
> > > > > > What G_FMT should return between the time a resolution change w=
as
> > > > > > detected and the CAPTURE queue being drained (i.e. the old or t=
he new
> > > > > > resolution?) is something I am not sure about.
> > > > >
> > > > > Note that we're talking here about the initial stream information
> > > > > detection, when the driver doesn't have any information needed to
> > > > > determine the CAPTURE format yet.
> > > >
> > > > IMHO the driver should just start off with some default format, it
> > > > really doesn't matter what that is.
> > > >
> > >
> > > I guess that's fine indeed.
> > >
> > > > This initial situation is really just a Seek operation: you have a =
format,
> > > > you seek to a new position and when you find the resolution of the
> > > > first frame in the bitstream it triggers a SOURCE_CHANGE event. Act=
ually,
> > > > to be really consistent with the Seek: you only need to trigger thi=
s event
> > > > if 1) the new resolution is different from the current format, or 2=
) the
> > > > capture queue is empty. 2) will never happen during a normal Seek, =
so
> > > > that's a little bit special to this initial situation.
> > >
> > > Having the error returned allowed the applications to handle the
> > > initial parsing without the event, though. It could have waited for
> > > all the OUTPUT buffers to be dequeued and then call G_FMT to check if
> > > that was enough data to obtain the format.
> > >
> >
> > Actually, I'm not sure whether triggering the event only if the
> > resolution changed is a good idea. It makes the application have no
> > idea when it can actually start preparing the CAPTURE queue. Any
> > thoughts?
>
> Oh, I was assuming with the new event we'd get the event the first time
> the decoder have a sync (e.g. for H.264 a set of PPS/SPS is activated)
> and later on, each time the capture format need to change.

Yes, that was my idea as well, but Hans' suggestion seemed to be different.

>
> I don't expect the current method implemented in GStreamer to work with
> random initial frames. Right now it only works if you have a parser to
> handle the sync and hide it from the decoder. But simpler userspace
> should be able to just frame the data and let the decoder find the sync
> (it's stateful after all).
>
> >
> > Should it just try to allocate instantly and then reallocate? That
> > would be a waste of time, though, especially since allocations are not
> > cheap.
>
> For compatibility with GStreamer, and simply to allow pre-allocation
> for application that knows) it would be nice to let userspace do that.
> That being to just allocate base on whatever information was set on
> OUTPUT queue (like CODA does). But newer userspace should not have to
> do that. They should be able to wait for a sync.

Assuming that we signal regardless of whether the resolution actually
changed or not. Otherwise the userspace has no way to distinguish the
two cases of a) the stream not being parsed yet and b) being parsed
and matching the initially set resolution.

Best regards,
Tomasz
