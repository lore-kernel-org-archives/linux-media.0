Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633E0C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEF1206B6
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 16:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="GmTfRoVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfDJQLS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:11:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33964 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfDJQLS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 12:11:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id n68so1579055qka.1
        for <linux-media@vger.kernel.org>; Wed, 10 Apr 2019 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=Ghohe2s0N3NVUJRqWsNA5pO7MIyhwo+asKQukAHX6lw=;
        b=GmTfRoVhNK4F4Zy4Ip2bzysBzdUmAlR+PAm/jDa0ydvgGUjjYyJ7JzU/rUmEia4HFa
         +lbbtPwbKJuzo9wwVgEyia822Xs+gaMua3GHNWajLVP4/oOpJU70bPrQlKOVJJnTDsSt
         mmxESDfMKvHRuHr3GmgfULbxPkuI+NcSw5DlEGsLV5wavaRhuyvU9gOzCGY4N6uPl2DV
         Xsnchf38sCnzULLGcmXPBysiWX3cS41BK71XFsEuGvJ39ll+bvFqNLnHLPB3+vlLlsl4
         /IRFqGqzH84H0DhyP+vr0ohWz9MBP+QM8vMaxUrcoVPXZ+zU447OAzP8nmlsRfGgj14S
         KUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Ghohe2s0N3NVUJRqWsNA5pO7MIyhwo+asKQukAHX6lw=;
        b=A1LIhJA8IoFbBwtQvjpo9tuIn+clHVwuxlGx2+LncdVHb7c9WAygHTGHfKGzcxF+i1
         wIzPVIMUyUX/cP3NtwBU4ao7QPiT4TzAsbrcAtmQoHZmkWOBfU/rzC0KcOd0FHigkuL7
         ektzY8LDQstLpJ5xQjFDt7ZsjZVugbJ7QQfZ6C+ZsnztUIcJQi1wpgX4XcRGTMnLcNJx
         GBI8OX4tq6szFelB0q6tMkFKalIjgPRFPN0p0igsQky6a0XNcePS43M4vxhVem2GkYSs
         qRnKIcwIxwQF6xqYy+2uh30M07E4Qgi5uTwFeN3Zo9gBRAR/WiZs0EFnF7rzgKWXUMWM
         UjRA==
X-Gm-Message-State: APjAAAWER47rDKWEiOKODKZ+OBqRGQ8lGbVJl9AnZ6PF5/c1RZUjkvdL
        0Tw9BWHe/K6fziSdAOrw1ca21Q==
X-Google-Smtp-Source: APXvYqw8NbgmN8DQHZATaQ8GtbUbsso0UpKYDh2UG9l2QYSQDID+v8mr2NcDJK006JAGCjiBERFfmA==
X-Received: by 2002:a37:9b46:: with SMTP id d67mr35483072qke.276.1554912677314;
        Wed, 10 Apr 2019 09:11:17 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id r201sm19596029qke.37.2019.04.10.09.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 09:11:16 -0700 (PDT)
Message-ID: <863e842a16db5ee6b10a2fd149119ae41ce26de6.camel@ndufresne.ca>
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Wed, 10 Apr 2019 12:11:15 -0400
In-Reply-To: <1554906176.3765.9.camel@pengutronix.de>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
         <20190408123256.22868-7-p.zabel@pengutronix.de>
         <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
         <1554906176.3765.9.camel@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-JK3XuRWLElvf4nLrTrFw"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--=-JK3XuRWLElvf4nLrTrFw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 10 avril 2019 =C3=A0 16:22 +0200, Philipp Zabel a =C3=A9crit :
> On Wed, 2019-04-10 at 15:43 +0200, Hans Verkuil wrote:
> [...]
> > > @@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals(struct fi=
le *file, void *fh,
> [...]
> > Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no sense for a =
codec.
> > I'd remove it altogether.

It does make sense, since framerate is the only information that can be
used to produce a specific bitrate. If you don't enumerate the rates,
then you may endup with a miss-match of what userspace wants, which
will result in a different rate then what the user-space anticipated.
That being said, I expect these intervals to be really wide. Venus HW
uses a Q16 internally, which is precise enough that we could just
ignore the interval.

>=20
> It returns the range supported by the frame rate registers that can be
> set for constant bitrate encoding. I think the idea was to let the
> GStreamer v4l2 elements know about possible frame rate range.
> I think I should be able to remove it without any negative effects.

As long as we can still set the framerate.

>=20
> regards
> Philipp

--=-JK3XuRWLElvf4nLrTrFw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXK4VowAKCRBxUwItrAao
HKHhAKDfkVnDO5fFI+l6GgvUJZUE+AfptgCg0L+mWZLEkkfnwOiQitUNUhgI1/g=
=WvFo
-----END PGP SIGNATURE-----

--=-JK3XuRWLElvf4nLrTrFw--

