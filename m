Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C5C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 12:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B778F206C0
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 12:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfDAMTq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:19:46 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60323 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMTq (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 08:19:46 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 309391C000A;
        Mon,  1 Apr 2019 12:19:42 +0000 (UTC)
Date:   Mon, 1 Apr 2019 14:20:27 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-media@vger.kernel.org
Subject: Re: Baseline for a new i2c sensor driver
Message-ID: <20190401122027.uc7uzqkg4lzaice4@uno.localdomain>
References: <28fbaf9b-474b-5ad2-4bbe-0fcf138e4f78@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cjw6owxz4nbwfksq"
Content-Disposition: inline
In-Reply-To: <28fbaf9b-474b-5ad2-4bbe-0fcf138e4f78@skidata.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--cjw6owxz4nbwfksq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Richard,

On Mon, Apr 01, 2019 at 09:32:41AM +0200, Richard Leitner wrote:
> Hello linux-media world,
> I'm currently working on forward-porting and mainlining a i2c sensor driver
> and would like to know what would be the best reference to base this driver
> on?

Which of the exsisting mainline driver is the best base might depends
on which sensor you're trying to support and on your platform.

Anway, the most recent sensor driver added to linux-media are,
according to 'git log --oneline  --diff-filter=A --stat drivers/media/i2c/':

879347f0c258 media: ov8856: Add support for OV8856 sensor
436190596241 media: imx214: Add imx214 camera sensor driver
df0b5c4a7ddd media: add imx355 camera sensor driver
8a89dc62f28c media: add imx319 camera sensor driver
3ee47cad3e69 media: ov2680: Add Omnivision OV2680 sensor driver
aab7ed1c3927 media: i2c: Add driver for Aptina MT9V111

The list cover sensors from OV, Aptina and Sony.

I would also suggest to look at  drivers/media/i2c/smiapp/ which
Sakari generally updates to the latest features added on the framework
side.

Thanks
   j

>
> Any hints would be greatly appreciated, thanks!
>
> regards;Richard.L

--cjw6owxz4nbwfksq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlyiAgsACgkQcjQGjxah
VjyXAQ//TX6NZcQu32BFI8+159bhR4RsYYWqor6QoTGzQXhSSSedchi8yTLNxXAj
TmeINy0QnZtAWSOeX1hWJ/zumlC5gVagcejtGs23Mvnrx/R2N09TyDJXdd4uRsSw
ee+YkUZ4sP+tDwwqWL3mCyFMAPy+HrJ68q3ertpkM4zZAP/rB9zHNv9QZeHkJolk
JXluEI5ZHQMD7Gc0IcStHuamu+jXPS2DRu17EZFV5qPpo1PhsW3yQxz/WbEPi+ZP
wlWXnXH1SYxMC6/Oweh4d/HlFAuq0R45FPNH+p0IhfFe66p57DpVfzo/wp7sQ6ea
uPUNJETNP8m/5aw5VL7A7ADP4x7kPVDMHo2xHnXXCNfDWPthheu8hyyNxKM+BzkV
zm4hFinwzU5iuL+0Km3N0dMnW6R3aFUbb6mrImqsB+Lhx0iMLLpHwkbCiTOjEdhD
bN8JugxilCZK5e7/G3JILaJzBMesjS+NJkTd5IJeA35tK2L7NbGM3cYBOtUwV3UJ
4q7Mnv1rUvs3CGNuCvgXsUOhG6LcF2V7WVoIH+DyfW0dWbqI7u2oovygYA4pt3U4
Nrc88VekFpghBf7wRqir1GX29XPa/QWg8POYae+62t8SLSZGYxCo71vJ4uOjPUuf
ZK7WWJDupOV2k4Eyr9W0YDFZnpBsSiWcjfZlz4tQuZeWFvsJ66E=
=uSGv
-----END PGP SIGNATURE-----

--cjw6owxz4nbwfksq--
