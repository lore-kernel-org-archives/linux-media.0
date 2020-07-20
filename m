Return-Path: <SRS0=qdh+=A7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56F5C433DF
	for <linux-media@archiver.kernel.org>; Mon, 20 Jul 2020 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C101E22482
	for <linux-media@archiver.kernel.org>; Mon, 20 Jul 2020 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGTPg6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:36:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57142 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgGTPg5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 20 Jul 2020 11:36:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 0F608283D0A
Message-ID: <1562ccc496b7c584a0bd0123ad4c804bc77fafd1.camel@collabora.com>
Subject: Re: [PATCH 2/2] media: coda: Add more H264 levels for CODA960
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Robert Beckett <bob.beckett@collabora.com>,
        kernel@collabora.com, stable@vger.kernel.org
Date:   Mon, 20 Jul 2020 11:36:52 -0400
In-Reply-To: <dd59520cfcfd4c93ad9cb54116f0234a706a0bd5.camel@pengutronix.de>
References: <20200717034923.219524-1-ezequiel@collabora.com>
         <20200717034923.219524-2-ezequiel@collabora.com>
         <05184a7c923c7e2aacca9da2bafe338ff5a7c16d.camel@pengutronix.de>
         <f409d4ddad0a352ca7ec84699c94a64e5dbf0407.camel@collabora.com>
         <dd59520cfcfd4c93ad9cb54116f0234a706a0bd5.camel@pengutronix.de>
Organization: Collabora
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-/OtHpkQJH3tGpBJ0SOOf"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--=-/OtHpkQJH3tGpBJ0SOOf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 20 juillet 2020 =C3=A0 10:31 +0200, Philipp Zabel a =C3=A9crit :
> > Considering how buggy and inconcistent this is going to be in decoder d=
rivers,
> > I'm tempted to just drop that restriction in GStreamer v4l2 decoders (w=
as added
> > by Philippe Normand from Igalia). Specially the bitrate limits, since i=
t is
> > quite clear from testing that this limits is only related to real-time
> > performance, and that offline decoding should still be possible. Meanwh=
ile, the
> > driver should still advertise 4.1 and 4.2 decoding. But we should check=
 the
> > decoding/encoding levels are actually not the same, that I haven't chec=
ked, the
> > code is a bit ... kindly said ... hairy.
>=20
>=20
> I think negotiation is important for sources that can provide multiple
> levels, to choose the right level for the decoder. If there is a given
> stream with a fixed level, it might indeed be better to not fail
> negotiation (maybe have a warning instead) and just hope for the best,
> as for some streams it might just work.

Yes, agreed, but I didn't want to use the linux-media list to discuss
GStreamer designs. I have a soltion for that, I'll send a MR and will
CC you. For the general idea, I'll try and keep the levels as
"preferred" capabilities while allowing any levels. Same mechanism used
to proposed an unscaled display resolution, even though scaling might
be supported.

Nicolas

--=-/OtHpkQJH3tGpBJ0SOOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXxW6FAAKCRBxUwItrAao
HDB4AKDFGeV5l5ovPT+9eQY8NKo2pRZsfQCeKPBzYvH1phd7EITxcoFDH92mHLQ=
=YJHS
-----END PGP SIGNATURE-----

--=-/OtHpkQJH3tGpBJ0SOOf--

