Return-Path: <SRS0=ldIY=C5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18B3C43468
	for <linux-media@archiver.kernel.org>; Sun, 20 Sep 2020 08:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A977921BE5
	for <linux-media@archiver.kernel.org>; Sun, 20 Sep 2020 08:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgITIi1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 20 Sep 2020 04:38:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59818 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgITIi0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 20 Sep 2020 04:38:26 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 04:38:25 EDT
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7E5291C0B96; Sun, 20 Sep 2020 10:30:26 +0200 (CEST)
Date:   Sun, 20 Sep 2020 10:30:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     stable@vger.kernel.org, Greg KH <greg@kroah.com>,
        prabhakar.csengg@gmail.com, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 4.19] media: da_vinci: fix code duplication due to missmerge
Message-ID: <20200920083025.GA991@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I'm not sure what went wrong there, but same block of code is there,
twice. Probably some kind of mis-merge.

Fix it.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1633,11 +1633,6 @@ static __init int vpif_probe(struct platform_device =
*pdev)
 		return -EINVAL;
 	}
=20
-	if (!pdev->dev.platform_data) {
-		dev_warn(&pdev->dev, "Missing platform data.  Giving up.\n");
-		return -EINVAL;
-	}
-
 	vpif_dev =3D &pdev->dev;
=20
 	err =3D initialize_vpif();

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9nEyEACgkQMOfwapXb+vK76gCeOZFV7NV44O1PSwX3V1uJhaLK
e3YAnjaATsfy6Wd9PBdkKGSczN6DchHx
=XONN
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
