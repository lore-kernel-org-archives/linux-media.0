Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF79C10F14
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 16:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A9620854
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 16:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="GLswLMu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbfDJQCD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:02:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38421 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfDJQCD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 12:02:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so3486072qth.5
        for <linux-media@vger.kernel.org>; Wed, 10 Apr 2019 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=N/elo7ELkFveK6dhAF3bL4PH83SxQ3NT+VDOoPzNQms=;
        b=GLswLMu8C3GSs16PLXbllyf2e1lLKSa5lIYRD3qBivnsz23ZtiZ+6ErmGb8JrTtLYY
         Xb+TLugBhUZoGVDLA7iuyIude4UfnXbgCCEpEPeCXFUhfOvEYQRstdRNOyqpkBWGRyRK
         /ST1kRBfBsuJamU3IwrCyPAtYMw+XAnDlnpIkaz0GdN2T6wpnlAeVGr0MBfKMXAIU2RW
         F1atkQE+tjWOXDbL3LpNU8dLHqmBdkdfENWnBs3eoDTpYW1NgJnYrByy7uEHI3856ymL
         +OD+Lg0k/ZPR3Ujk4JfDRmPntVGWkxvFzp+tHF34n7S8TAloJgZWxAE0IT8abgdLfdbQ
         JJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=N/elo7ELkFveK6dhAF3bL4PH83SxQ3NT+VDOoPzNQms=;
        b=qjuOn/KrPJiUMSdcRpIAl7jvT5SmLdHLWrpmCpO6NoUPx2vHWKKhcz8f1J1RaMuEOU
         oZFDZzEAl42jfq8Es0d5jmP2ARARgDNYbj2LaPjElMc/tL/kZt6+EDWBUcIFG3/V5zFb
         5iCdVvhk8lGIOXi1QqtQGxHpVFaV9A3Cn4q/ZoBeoZjXarGk4evTBvCzIMlaNCxv8Bgb
         r6Ek7DZGyg6rebCnAJGj0gQ1d3o+3zHlwS7XhEL4byUysl7CWgiy3tPuRx5xZAtTpFSq
         VLeQP1YEz5PiPm5EaTfCjqZ0E6pesF6ucQoDqNiNAxINV3hiHLr+jEniL3Jw3csKejS/
         GopA==
X-Gm-Message-State: APjAAAV0+ieFDEdMFqJkQah11uyb9we6JZ+rGLrzD1R9R7adjJ6Q6ij8
        sF9/Qg4CkRff2ap2PMgqMdXNb3XFPoEmXg==
X-Google-Smtp-Source: APXvYqxraIzWkfD5vfNUNR1jyGthCdBCx6xOtWKjn78neMOEzi4yK5blxnmUsFZ4BlC03bLsajhzKA==
X-Received: by 2002:ac8:196b:: with SMTP id g40mr35606476qtk.218.1554912122202;
        Wed, 10 Apr 2019 09:02:02 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id q51sm25412496qte.29.2019.04.10.09.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 09:02:00 -0700 (PDT)
Message-ID: <7fec1a2101ec1304d35d5c757cc98f916eda20c6.camel@ndufresne.ca>
Subject: Re: [PATCH v3 0/9] [WIP]: rockchip mpp for v4l2 video deocder
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     ayaka <ayaka@soulik.info>, linux-media@vger.kernel.org
Cc:     randy.li@rock-chips.com, hverkuil@xs4all.nl,
        maxime.ripard@bootlin.com, joro@8bytes.org,
        jernej.skrabec@gmail.com, paul.kocialkowski@bootlin.com,
        thomas.petazzoni@bootlin.com, mchehab@kernel.org,
        ezequiel@collabora.com, posciak@chromium.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org
Date:   Wed, 10 Apr 2019 12:01:59 -0400
In-Reply-To: <20190410124226.8612-1-ayaka@soulik.info>
References: <20190410124226.8612-1-ayaka@soulik.info>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-pIvjADjkwwidUay+FFhS"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--=-pIvjADjkwwidUay+FFhS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 10 avril 2019 =C3=A0 20:42 +0800, ayaka a =C3=A9crit :
> From: Randy 'ayaka' Li <ayaka@soulik.info>
>=20
> Although I really hate the bitstream construction in kernel and I think
> many people realise its problems, I still take the advise from ndufresne =
to
> release this version. This should be released in a early week but
> I was sick that time.
>=20
> After reviewed the documents from Rockchip and I have confirmed that with
> some rockchip staff, those documents are not update to date. So you may
> find some part is different comparing to official document.
>=20
> The v4l2-request-test from bootlin won't work. Its slice data doesn't
> have a start code which making it not a complete nal unit. And I found
> its slice header information may not be correct. Even comparing to the
> Big buck bunny's origin files, neither the slice data nor sequence
> information matches.

The un-ordered reflist table generated by these tests or the v4l2 VAAPI
driver are known to be broken. They have never been tested. Ezequiel
and I are going to validate against MVPP userspace if this un-ordered
list effectively what we think it is, and will try and get some fixes
in at least one selected userspace. Otherwise it's not possible to test
easily.

>=20
> I extracted a slice data from Rockchip mpp to verify my driver, it work
> fine, you can find it on my github. I only verified the I slice now,
> I have not verified P or B slice. Hopefully it would work.

If you have some information to share it would be nice. I'm sure we can
cooperate on this if you are willing to.

>=20
> I have the same problem with v4l2-request-test on HEVC as well so even
> this version shipped with HEVC bitstream construction, I didn't know
> whether it would work.
>=20
> I need some time to prepare the userspace tool or it is really hard for
> HEVC to write slice info manually.
>=20
> Changlog
> v3: add AVC support for rkvdec
> v2: add MPEG-2 support for vdpu2
> v1: inital version
>=20
> Randy Li (7):
>   staging: video: rockchip: add v4l2 decoder
>   rockchip: mpp: rkvdec: rbsp
>   [WIP]: rockchip: mpp: HEVC decoder ctrl data
>   [TEST]: rockchip: mpp: support qtable
>   [TEST]: rockchip: mpp: vdpu2: move qtable to input buffer
>   arm64: dts: rockchip: boost clocks for rk3328
>   arm64: dts: rockchip: add video codec for rk3328
>=20
> ayaka (2):
>   [WIP]: rockchip: mpp: H.264 decoder ctrl data
>   [TEST]: rkvdec: spspps address alignment
>=20
>  arch/arm64/boot/dts/rockchip/rk3328-evb.dts   |   32 +
>  .../arm64/boot/dts/rockchip/rk3328-rock64.dts |   32 +
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  112 +-
>  drivers/staging/Kconfig                       |    2 +
>  drivers/staging/Makefile                      |    1 +
>  drivers/staging/rockchip-mpp/Kconfig          |   33 +
>  drivers/staging/rockchip-mpp/Makefile         |   12 +
>  drivers/staging/rockchip-mpp/mpp_debug.h      |   87 +
>  drivers/staging/rockchip-mpp/mpp_dev_common.c | 1390 +++++++
>  drivers/staging/rockchip-mpp/mpp_dev_common.h |  215 +
>  drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c |  924 +++++
>  drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c  |  607 +++
>  drivers/staging/rockchip-mpp/mpp_service.c    |  197 +
>  drivers/staging/rockchip-mpp/mpp_service.h    |   38 +
>  .../staging/rockchip-mpp/rkvdec/avc-data.c    |  239 ++
>  .../staging/rockchip-mpp/rkvdec/avc-data.h    |   40 +
>  drivers/staging/rockchip-mpp/rkvdec/avc.c     |  259 ++
>  drivers/staging/rockchip-mpp/rkvdec/cabac.h   | 3614 +++++++++++++++++
>  drivers/staging/rockchip-mpp/rkvdec/hal.h     |   70 +
>  .../staging/rockchip-mpp/rkvdec/hevc-data.c   |  208 +
>  .../staging/rockchip-mpp/rkvdec/hevc-data.h   |   27 +
>  drivers/staging/rockchip-mpp/rkvdec/hevc.c    |  169 +
>  drivers/staging/rockchip-mpp/rkvdec/rbsp.c    |   96 +
>  drivers/staging/rockchip-mpp/rkvdec/rbsp.h    |   30 +
>  drivers/staging/rockchip-mpp/rkvdec/regs.h    |  377 ++
>  drivers/staging/rockchip-mpp/vdpu2/avc.c      |  165 +
>  drivers/staging/rockchip-mpp/vdpu2/hal.h      |   52 +
>  drivers/staging/rockchip-mpp/vdpu2/mpeg2.c    |  277 ++
>  drivers/staging/rockchip-mpp/vdpu2/regs.h     |  670 +++
>  include/uapi/video/rk_vpu_service.h           |  101 +
>  30 files changed, 10072 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/staging/rockchip-mpp/Kconfig
>  create mode 100644 drivers/staging/rockchip-mpp/Makefile
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_debug.h
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_common.c
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_common.h
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_service.c
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_service.h
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/avc-data.c
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/avc-data.h
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/avc.c
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/cabac.h
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hal.h
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hevc-data.c
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hevc-data.h
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hevc.c
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/rbsp.c
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/rbsp.h
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/regs.h
>  create mode 100644 drivers/staging/rockchip-mpp/vdpu2/avc.c
>  create mode 100644 drivers/staging/rockchip-mpp/vdpu2/hal.h
>  create mode 100644 drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
>  create mode 100644 drivers/staging/rockchip-mpp/vdpu2/regs.h
>  create mode 100644 include/uapi/video/rk_vpu_service.h
>=20

--=-pIvjADjkwwidUay+FFhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXK4TdwAKCRBxUwItrAao
HFzHAJ0ZlWlov89bs1RHL8p3HuV8gZj/fACg3GX56DjmMvA1rqJ4Qx6bgx/yLIs=
=UooA
-----END PGP SIGNATURE-----

--=-pIvjADjkwwidUay+FFhS--

