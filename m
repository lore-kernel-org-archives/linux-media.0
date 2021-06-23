Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1448C48BC2
	for <linux-media@archiver.kernel.org>; Wed, 23 Jun 2021 21:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CED361241
	for <linux-media@archiver.kernel.org>; Wed, 23 Jun 2021 21:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWVT6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Jun 2021 17:19:58 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40558 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWVT6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Jun 2021 17:19:58 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 13BFE1C0B76; Wed, 23 Jun 2021 23:17:39 +0200 (CEST)
Date:   Wed, 23 Jun 2021 23:17:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Subject: Re: [PATCH 1/1] media: i2c: et8ek8: use DEVICE_ATTR_RO() helper macro
Message-ID: <20210623211738.GJ8540@amd>
References: <20210603071529.11544-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Content-Disposition: inline
In-Reply-To: <20210603071529.11544-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2021-06-03 15:15:29, Zhen Lei wrote:
> Use DEVICE_ATTR_RO() helper macro instead of DEVICE_ATTR(), which is
> simpler and more readable.
>=20
> Due to the name of the read function of the sysfs attribute is normalized,
> there is a natural association.
>=20
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
http://www.livejournal.com/~pavelmachek

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmDTpPIACgkQMOfwapXb+vIINQCgriADcUEzK+FVai7KyIBon8XQ
8J0An3YSNeg8X57rTH20KTYp5jSzDUvr
=44IY
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
