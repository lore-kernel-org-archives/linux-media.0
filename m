Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A5C10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BAC2082E
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="T5JhLM+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDKPxR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:53:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38327 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKPxR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 11:53:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so7677954qth.5
        for <linux-media@vger.kernel.org>; Thu, 11 Apr 2019 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=k+Y1OcOWgwRgpISI5zqrPx/54l+wLcwRuCAo0t57fHk=;
        b=T5JhLM+8bYHE7gTwzmopnJiqNbRSXirYfVFFnInbFsNaw+mvR6ZfkpvyDGZOg9iVod
         HtofrTzkSQhZEJLyxYjWUWSZYOEjeJqOs3ZCaVf0v5EVmDWavNt/VH7VVZnp9nBU+yQe
         hI5I7oFLYVpbLMeIrXpu10jC9wOPJcos2xAlQdHqMSe7IAQOWHiUS+AAeA0tXSh7a947
         GM/ojaw0iPfO/0k+46Cg+HIFlymT3nU1k39EYam57zRISN8xkD4Pu9Rs8aFoGEl6R207
         NITzoL7WhzBR+6GWjfiuLJ9A+qaNSSVeIgiS1Xme/hFS7IuPU+DIPkL94iU5VOPlrpYk
         wbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=k+Y1OcOWgwRgpISI5zqrPx/54l+wLcwRuCAo0t57fHk=;
        b=AaH+4isqnyDPeGFdCxlb9c+ack08Ddu4qNSsv+fuCFLb6pecMgHU8/5uOeZ41iTrMG
         rCpTU10LUcWXW+FyDoa9pX975SDYZq0mLC4T1unfVYvt9wckotnipQiCrP6NhLxYGBiX
         tmAcrf15UrMRlGEQi3Pr/GjMQmvXnBX5pdtA/2ll11CesefctZsIBscscvUomETwo+g+
         wEPkq9bITZKK37xTS9e2UEXM8PYVdrXaRApRZkD2xpL/OdOHT8zCrz/a6teXdecemo72
         CHhquEwmcuklCwjxip9oSKDdJFY+U0tVvC1lVWfFyvGPRzoounsLtvAXQmS8/x04cOA4
         7gPA==
X-Gm-Message-State: APjAAAXLm+zyFwHNWBjQz4PXHE4Yz4eWhGm3ne54BuFqHWD0qnREhLy0
        tpZgfjrZfl1/hT3OBl/1zsRTfg==
X-Google-Smtp-Source: APXvYqxx75ieYiDoCKTepKxCEXdwQgSPNjczazqHuqWB7zYbpwRrWeAxPkxgMdAmE26QvARv+pPLbQ==
X-Received: by 2002:a0c:9223:: with SMTP id a32mr41843641qva.138.1554997995787;
        Thu, 11 Apr 2019 08:53:15 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id r201sm21762353qke.37.2019.04.11.08.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 08:53:14 -0700 (PDT)
Message-ID: <1502ac1f39973ad1bf1a4ee9a951c09d88941651.camel@ndufresne.ca>
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 11 Apr 2019 11:53:13 -0400
In-Reply-To: <1554984042.6389.5.camel@pengutronix.de>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
         <20190408123256.22868-7-p.zabel@pengutronix.de>
         <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
         <1554906176.3765.9.camel@pengutronix.de>
         <863e842a16db5ee6b10a2fd149119ae41ce26de6.camel@ndufresne.ca>
         <5feecd0e-5c7b-27fe-84a0-0bffb04128df@xs4all.nl>
         <1554970925.6389.1.camel@pengutronix.de>
         <36f792a8-7680-100f-09a4-b9315177c791@xs4all.nl>
         <1554984042.6389.5.camel@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-c35zPUGVZImky5AChZp7"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--=-c35zPUGVZImky5AChZp7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 11 avril 2019 =C3=A0 14:00 +0200, Philipp Zabel a =C3=A9crit :
> On Thu, 2019-04-11 at 12:18 +0200, Hans Verkuil wrote:
> > On 4/11/19 10:22 AM, Philipp Zabel wrote:
> > > On Wed, 2019-04-10 at 18:24 +0200, Hans Verkuil wrote:
> > > > On 4/10/19 6:11 PM, Nicolas Dufresne wrote:
> > > > > Le mercredi 10 avril 2019 =C3=A0 16:22 +0200, Philipp Zabel a =C3=
=A9crit :
> > > > > > On Wed, 2019-04-10 at 15:43 +0200, Hans Verkuil wrote:
> > > > > > [...]
> > > > > > > > @@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals=
(struct file *file, void *fh,
> > > > > >=20
> > > > > > [...]
> > > > > > > Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no se=
nse for a codec.
> > > > > > > I'd remove it altogether.
> > > > >=20
> > > > > It does make sense, since framerate is the only information that =
can be
> > > > > used to produce a specific bitrate. If you don't enumerate the ra=
tes,
> > > > > then you may endup with a miss-match of what userspace wants, whi=
ch
> > > > > will result in a different rate then what the user-space anticipa=
ted.
> > > > > That being said, I expect these intervals to be really wide. Venu=
s HW
> > > > > uses a Q16 internally, which is precise enough that we could just
> > > > > ignore the interval.
> > > >=20
> > > > So the problem is that for an encoder where you desires a specific
> > > > constant bitrate, the encoder also needs to know the framerate.
> > > >=20
> > > > And the driver then would have to support ENUM_FRAMEINTERVALS and t=
he
> > > > S_PARM ioctl so userspace can set the framerate.
> > >=20
> > > Ah right, that was it. Encoding works fine without ENUM_FRAMEINTERVAL=
S,
> > > as coda has no meaningful frame rate limitations. I had implemented
> > > S_PARM since it is required for CBR encoding, and v4l2-compliance the=
n
> > > complained about ENUM_FRAMEINTERVALS missing:
> > >=20
> > >   cde29ef313de ("[media] coda: Use S_PARM to set nominal framerate fo=
r h.264 encoder")
> > >   07b6080d4e6d ("media: coda: implement ENUM_FRAMEINTERVALS")
> >=20
> > And I think that's right. If you advertise framerate support, then
> > userspace needs to know about the capabilities.
> >=20
> > I do think ENUM_FRAMEINTERVALS should return some sane values. Right no=
w
> > coda advertises 1/65535 fps to 65535 fps (or thereabout).
>=20
> Those are the limits imposed by the frame rate registers.
>=20
> > I would probably return 1 fps to 200 fps (200 Hz is the highest framera=
te
> > defined by CTA-861-G).
>=20
> Why? We can certainly encode more than 200 fps in real time if only the
> frame size is small enough, and for offline transcoding the nominal
> frame rate can be anything the coded format supports.
> Smaller than 1 fps might be useful for time lapse videos as well.
>=20
> > This can also eventually be a helper function in v4l2-mem2mem.c since I=
 expect
> > this to be the same for all (?) encoders.
>=20
> For example h.264 has an optional 32-bit numerator and denominator
> (num_units_in_tick and time_scale in the Video Usability Information).
> I don't see any reason to limit this artificially in the driver.
>=20
> > > Hmm, not necesarily. I hadn't thought about that before, but if the
> > > decoder supports frame skipping this could be used to advertise
> > > available reductions in frame rate.
> >=20
> > That assumes that you want to use S_PARM for that as well. And does the=
 decoder
> > provide the framerate encoded in the bitstream to the driver?
>=20
> That is a difficult question. Yes, depending on CODA hardware variant,
> codec, and actual bitstream (where this information is optional), the
> firmware may or may not report the frame rate. Maybe it is fundamentally
> not a good idea to try to control frame skipping via the nominal frame
> rate instead of directly.

The Xilinx VCU decoder will allocate a different amount of cores per
session depending on the framerate we give it. This is how they manage
to handle more stream for lower rate/resolution etc. And it makes the
S_PARM call mandatory, since faking one will always lead to some
streams not to work properly, or less streams being handled in
parallel.

I personally don't see why we should in anyway be restrictive to the
information we are allowed to pass to a driver. Specially that is does
not matter if the driver uses it or not. And because there is no way we
will be able to think about every possible use cases popping in the
future, and it does not make backward compatibility to be a little more
open here.

>=20
> > Using S_PARM for this only works if the driver can know the encoded fra=
merate.
> >=20
> > Anyway, this is probably something to discuss once a driver supports fr=
ame
> > skipping for the decoder.
>=20
> Right. Since the coda driver does not support frame skipping yet, I'll
> return -ENOTTY for decoder ENUM_FRAMEINTERVALS.
>=20
> regards
> Philipp

--=-c35zPUGVZImky5AChZp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXK9i6QAKCRBxUwItrAao
HEriAJ99cuDV8Zw24ZaQ3ACfbWiYw+CqMACgjxxRZ+AWN/1YtO7HMtXPQb3BI2E=
=EDUu
-----END PGP SIGNATURE-----

--=-c35zPUGVZImky5AChZp7--

