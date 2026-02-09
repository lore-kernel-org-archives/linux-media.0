Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49A22D7B5;
	Mon,  9 Feb 2026 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770612966; cv=none; b=kILJCv4vaMUrReNGkKgbJSU+P8pW1MHPbu7fcFHR7MKQ5YFpfZzGq0v4XXzMUXrai0ed6au9t3mEeOBB4EAgkj8TW7EJiDH95f3++ceFrICkiKBtkosgdFshH+5PemVKOPdk9HUo7h73qj0PiHUTvn9UeTz9mOksRZLhrOwi2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770612966; c=relaxed/simple;
	bh=L2XWRgZBpfGeDrrF1Hfctg8cLpF6eRs50E+8vIoi1/Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAkrlqvQ7IarZHEXtp8aQytq0GJS6s2NJtTrdCqFINK3bcTbAKxQF/HXgFA8i4RkBqKPoWYQ8VbYjNFOXYOE9i3ug6GU2tdC2bvM55psWqeM/c2HTPVYN2O+uER+QATR8F3vstes2gnjmf3DlM07cS2xYco5jqldJ3orkoGhhrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ohxorud.com; spf=pass smtp.mailfrom=ohxorud.com; dkim=pass (2048-bit key) header.d=ohxorud.com header.i=@ohxorud.com header.b=nsYTejQ7; arc=none smtp.client-ip=79.135.106.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ohxorud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ohxorud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ohxorud.com header.i=@ohxorud.com header.b="nsYTejQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ohxorud.com;
	s=protonmail3; t=1770612957; x=1770872157;
	bh=bd1J8yDoqJcD18lGY26OEVIQN82JJLBJNW/uwMqLBn4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nsYTejQ7DK5f3yzzMtFsCeitfUkPeCwQVGdaHA0BX4e7lIJz9iKJdV2K0Zb5sCxVc
	 Mix5lnAUTjIcZJD8ZyLqK0PzOVZ8RAJI+eCj4n8vlJz3hq6vcSl/h7+LlqUjvG5TFT
	 iCbxxnaVC7IhHqqVvPb+ciNJbtyj6MiUGVxAzkJYdUSqKuuN1rOEeh4eo7IJKlYgUS
	 nUDhGTweXWBqIPlljLGfiGa8BAlAjhRrPBlnl2oexsin8cdHua9CWCTag+KuDLJmeD
	 w26qemw7i5ZR4G5kZBzhcvDFls+7gxBc+Kikpq75YJvnoCDD5Y2zO/ZHxTVxNoduFT
	 DD8KM37jH74GQ==
Date: Mon, 09 Feb 2026 04:55:53 +0000
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy@kernel.org>
From: Taekyung Oh <ohxorud@ohxorud.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Taekyung Oh <ohxorud@ohxorud.com>
Subject: [PATCH 1/2] staging: media: atomisp: fix block comment style in ov2722.h
Message-ID: <20260209045514.40352-2-ohxorud@ohxorud.com>
In-Reply-To: <20260209045514.40352-1-ohxorud@ohxorud.com>
References: <20260209045514.40352-1-ohxorud@ohxorud.com>
Feedback-ID: 133357498:user:proton
X-Pm-Message-ID: 721434065051da4bf27c92b9f98bbdb440c753f6
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fix coding style warnings reported by checkpatch.pl.
Move the comments above the corresponding code lines.

Signed-off-by: Taekyung Oh <ohxorud@ohxorud.com>
---
 drivers/staging/media/atomisp/i2c/ov2722.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/ov2722.h b/drivers/staging/m=
edia/atomisp/i2c/ov2722.h
index 00317d105..c69f0086c 100644
--- a/drivers/staging/media/atomisp/i2c/ov2722.h
+++ b/drivers/staging/media/atomisp/i2c/ov2722.h
@@ -566,8 +566,8 @@ static const struct ov2722_reg ov2722_VGA_30fps[] =3D {
 #endif
=20
 static const struct ov2722_reg ov2722_1632_1092_30fps[] =3D {
-=09{OV2722_8BIT, 0x3021, 0x03}, /* For stand wait for
-=09=09=09=09a whole frame complete.(vblank) */
+    /* For stand wait for a whole frame complete.(vblank) */
+=09{OV2722_8BIT, 0x3021, 0x03},
 =09{OV2722_8BIT, 0x3718, 0x10},
 =09{OV2722_8BIT, 0x3702, 0x24},
 =09{OV2722_8BIT, 0x373a, 0x60},
@@ -668,8 +668,8 @@ static const struct ov2722_reg ov2722_1632_1092_30fps[]=
 =3D {
 };
=20
 static const struct ov2722_reg ov2722_1452_1092_30fps[] =3D {
-=09{OV2722_8BIT, 0x3021, 0x03}, /* For stand wait for
-=09=09=09=09a whole frame complete.(vblank) */
+    /* For stand wait for a whole frame complete.(vblank) */
+=09{OV2722_8BIT, 0x3021, 0x03},
 =09{OV2722_8BIT, 0x3718, 0x10},
 =09{OV2722_8BIT, 0x3702, 0x24},
 =09{OV2722_8BIT, 0x373a, 0x60},
@@ -878,8 +878,8 @@ static const struct ov2722_reg ov2722_1M3_30fps[] =3D {
 #endif
=20
 static const struct ov2722_reg ov2722_1080p_30fps[] =3D {
-=09{OV2722_8BIT, 0x3021, 0x03}, /* For stand wait for a whole
-=09=09=09=09=09frame complete.(vblank) */
+    /* For stand wait for a whole frame complete.(vblank) */
+=09{OV2722_8BIT, 0x3021, 0x03},
 =09{OV2722_8BIT, 0x3718, 0x10},
 =09{OV2722_8BIT, 0x3702, 0x24},
 =09{OV2722_8BIT, 0x373a, 0x60},
--=20
2.50.1 (Apple Git-155)


