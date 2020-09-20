Return-Path: <SRS0=ldIY=C5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C99C43466
	for <linux-media@archiver.kernel.org>; Sun, 20 Sep 2020 09:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7F320EDD
	for <linux-media@archiver.kernel.org>; Sun, 20 Sep 2020 09:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgITJBl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 20 Sep 2020 05:01:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33134 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgITJBl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 20 Sep 2020 05:01:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0ABE51C0B94; Sun, 20 Sep 2020 11:01:39 +0200 (CEST)
Date:   Sun, 20 Sep 2020 11:01:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     stefanr@s5r6.in-berlin.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: firewire: fix memory leak
Message-ID: <20200920090137.GA4628@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Fix memory leak in node_probe.
   =20
Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/media/firewire/firedtv-fw.c b/drivers/media/firewire/f=
iredtv-fw.c
index 3f1ca40b9b98..8a8585261bb8 100644
--- a/drivers/media/firewire/firedtv-fw.c
+++ b/drivers/media/firewire/firedtv-fw.c
@@ -272,8 +272,10 @@ static int node_probe(struct fw_unit *unit, const stru=
ct ieee1394_device_id *id)
=20
 	name_len =3D fw_csr_string(unit->directory, CSR_MODEL,
 				 name, sizeof(name));
-	if (name_len < 0)
-		return name_len;
+	if (name_len < 0) {
+		err =3D name_len;
+		goto fail_free;
+	}
 	for (i =3D ARRAY_SIZE(model_names); --i; )
 		if (strlen(model_names[i]) <=3D name_len &&
 		    strncmp(name, model_names[i], name_len) =3D=3D 0)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9nGnEACgkQMOfwapXb+vIPDgCbBqZ8DUqfyQuw9h63tNsVmkPG
qZgAnRHF3jWltsW7jYZBydIhezO2zUp0
=lkZZ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
