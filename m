Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA6FC43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCB62075E
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 14:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfC1Oyl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:54:41 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59247 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfC1Oyl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 10:54:41 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 279B11BF204;
        Thu, 28 Mar 2019 14:54:36 +0000 (UTC)
Date:   Thu, 28 Mar 2019 15:55:19 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     vinodkumart@bel.co.in
Cc:     linux-media@vger.kernel.org
Subject: Re: TW9910 Video decoder
Message-ID: <20190328145519.cwrkp232y6taeoei@uno.localdomain>
References: <46caa7792a2305cc62841c1ee3d10638.squirrel@bemail.bel.co.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="si22xgnw3q3bd52p"
Content-Disposition: inline
In-Reply-To: <46caa7792a2305cc62841c1ee3d10638.squirrel@bemail.bel.co.in>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--si22xgnw3q3bd52p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Vinod,

On Thu, Mar 28, 2019 at 09:39:35AM +0530, vinodkumart@bel.co.in wrote:
> HI,
>
> Are you still maintaining TW9910 Video decoder. We would like to use this
> IC in our project.

I'm replying as I think I'm one of the last who touched that driver when
the soc_camera based version was ported to be a standard V4L2 driver.

Are you interested in the latest available version or on the
soc_camera one? I guess it depends on what your BSP offers, right?

The new version has been ported to be standard V4L2 driver during the
last year, and I think it might benefit from more testing indeed.

Thanks
   j

PS:
In future please use scripts/get_maintainers.pl and Cc the people/list
reported by the tool :)

>
>
> Best Regards
> T.Vinod Kumar
> Senior Engineer
> Bharat Electronics Limited
> Ministry of Defence, Govt. of India
> Machilipatnam
> Andhra Pradesh- 521001
> INDIA
> Contact: 0866-2527363
>
>
> =E0=A4=95=E0=A4=BE=E0=A4=97=E0=A4=9C=E0=A4=BC =E0=A4=95=E0=A5=87 3000 =E0=
=A4=AA=E0=A4=A8=E0=A5=8D=E0=A4=A8=E0=A5=8B=E0=A4=82 =E0=A4=95=E0=A5=87 =E0=
=A4=B2=E0=A4=BF=E0=A4=8F =E0=A4=8F=E0=A4=95 =E0=A4=AA=E0=A5=87=E0=A4=A1=E0=
=A4=BC =E0=A4=95=E0=A5=8B =E0=A4=95=E0=A4=BE=E0=A4=9F=E0=A4=BE =E0=A4=9C=E0=
=A4=BE=E0=A4=A4=E0=A4=BE =E0=A4=B9=E0=A5=88... =E0=A4=AA=E0=A5=87=E0=A4=A1=
=E0=A4=BC =E0=A4=AC=E0=A4=9A=E0=A4=BE=E0=A4=8F=E0=A4=81... =E0=A4=AA=E0=A5=
=87=E0=A4=A1=E0=A4=BC=E0=A5=8B=E0=A4=82 =E0=A4=95=E0=A4=BE =E0=A4=B8=E0=A4=
=82=E0=A4=B0=E0=A4=95=E0=A5=8D=E0=A4=B7=E0=A4=A3 =E0=A4=95=E0=A4=B0=E0=A5=
=87=E0=A4=82... =E0=A4=B9=E0=A4=B0=E0=A4=BF=E0=A4=AF=E0=A4=BE=E0=A4=B2=E0=
=A5=80 =E0=A4=B2=E0=A4=BE=E0=A4=8F=E0=A4=81... =E0=A4=87=E0=A4=B8 =E0=A4=AE=
=E0=A5=87=E0=A4=B2 =E0=A4=95=E0=A4=BE =E0=A4=AF=E0=A4=BE =E0=A4=87=E0=A4=B8=
=E0=A4=95=E0=A5=80 =E0=A4=95=E0=A4=BF=E0=A4=B8=E0=A5=80 =E0=A4=AB=E0=A4=BE=
=E0=A4=87=E0=A4=B2 =E0=A4=95=E0=A4=BE =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=BF=
=E0=A4=82=E0=A4=9F =E0=A4=A4=E0=A4=AC =E0=A4=A4=E0=A4=95 =E0=A4=A8 =E0=A4=
=B2=E0=A5=87=E0=A4=82 =E0=A4=9C=E0=A4=AC =E0=A4=A4=E0=A4=95 =E0=A4=B8=E0=A4=
=9A=E0=A4=AE=E0=A5=81=E0=A4=9A =E0=A4=9C=E0=A4=BC=E0=A4=B0=E0=A5=82=E0=A4=
=B0=E0=A4=A4 =E0=A4=A8 =E0=A4=B9=E0=A5=8B !!!!
>
>
> Every 3000 Sheets of paper costs us a tree.. Save trees... Conserve
> Trees. Don't print this email or any Files unless you really need to!!!!
>
> Confidentiality Notice/=E0=A4=97=E0=A5=8B=E0=A4=AA=E0=A4=A8=E0=A5=80=E0=
=A4=AF =E0=A4=B8=E0=A5=82=E0=A4=9A=E0=A4=A8=E0=A4=BE
>
> =E0=A4=87=E0=A4=B8 =E0=A4=87=E0=A4=B2=E0=A5=87=E0=A4=95=E0=A5=8D=E0=A4=9F=
=E0=A5=8D=E0=A4=B0=E0=A5=89=E0=A4=A8=E0=A4=BF=E0=A4=95 =E0=A4=B8=E0=A4=82=
=E0=A4=A6=E0=A5=87=E0=A4=B6 =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=B6=E0=A4=BE=
=E0=A4=AE=E0=A4=BF=E0=A4=B2 =E0=A4=9C=E0=A4=BE=E0=A4=A8=E0=A4=95=E0=A4=BE=
=E0=A4=B0=E0=A5=80 =E0=A4=94=E0=A4=B0 =E0=A4=87=E0=A4=B8 =E0=A4=B8=E0=A4=82=
=E0=A4=A6=E0=A5=87=E0=A4=B6 =E0=A4=95=E0=A5=87 =E0=A4=B8=E0=A4=BE=E0=A4=A5 =
=E0=A4=A6=E0=A4=BF=E0=A4=AF=E0=A4=BE =E0=A4=97=E0=A4=AF=E0=A4=BE =E0=A4=B8=
=E0=A4=82=E0=A4=B2=E0=A4=97=E0=A5=8D=E0=A4=A8=E0=A4=95 =E0=A4=95=E0=A5=87=
=E0=A4=B5=E0=A4=B2
> =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A5=87=E0=A4=B7=E0=A4=BF=E0=A4=A4=E0=A5=80 =
=E0=A4=95=E0=A5=87 =E0=A4=85=E0=A4=A8=E0=A4=A8=E0=A5=8D=E0=A4=AF =E0=A4=87=
=E0=A4=B8=E0=A5=8D=E0=A4=A4=E0=A5=87=E0=A4=AE=E0=A4=BE=E0=A4=B2 =E0=A4=95=
=E0=A5=87 =E0=A4=B2=E0=A4=BF=E0=A4=8F =E0=A4=B9=E0=A5=88 =E0=A4=94=E0=A4=B0=
 =E0=A4=87=E0=A4=B8=E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=97=E0=A5=8B=E0=A4=AA=
=E0=A4=A8=E0=A5=80=E0=A4=AF =E0=A4=AF=E0=A4=BE =E0=A4=B5=E0=A4=BF=E0=A4=B6=
=E0=A5=87=E0=A4=B7=E0=A4=BE=E0=A4=A7=E0=A4=BF=E0=A4=95=E0=A4=BE=E0=A4=B0 =
=E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=BE=E0=A4=AA=E0=A5=8D=E0=A4=A4 =E0=A4=9C=
=E0=A4=BE=E0=A4=A8=E0=A4=95=E0=A4=BE=E0=A4=B0=E0=A5=80
> =E0=A4=B6=E0=A4=BE=E0=A4=AE=E0=A4=BF=E0=A4=B2 =E0=A4=B9=E0=A5=8B =E0=A4=
=B8=E0=A4=95=E0=A4=A4=E0=A5=80 =E0=A4=B9=E0=A5=88 =E0=A5=A4 =E0=A4=AF=E0=A4=
=A6=E0=A4=BF =E0=A4=86=E0=A4=AA =E0=A4=86=E0=A4=B6=E0=A4=AF=E0=A4=BF=E0=A4=
=A4 =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=BE=E0=A4=AA=E0=A5=8D=E0=A4=A4=E0=A4=
=95=E0=A4=B0=E0=A5=8D=E0=A4=A4=E0=A4=BE =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=
=82 =E0=A4=B9=E0=A5=88=E0=A4=82, =E0=A4=A4=E0=A5=8B =E0=A4=95=E0=A5=83=E0=
=A4=AA=E0=A4=AF=E0=A4=BE =E0=A4=A4=E0=A5=81=E0=A4=B0=E0=A4=82=E0=A4=A4 =E0=
=A4=AD=E0=A4=BE=E0=A4=B0=E0=A4=A4 =E0=A4=87=E0=A4=B2=E0=A5=87=E0=A4=95=E0=
=A5=8D=E0=A4=9F=E0=A5=8D=E0=A4=B0=E0=A5=89=E0=A4=A8=E0=A4=BF=E0=A4=95=E0=A5=
=8D=E0=A4=B8 =E0=A4=95=E0=A5=87 =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A5=87=E0=A4=
=B7=E0=A4=95 =E0=A4=95=E0=A5=8B =E0=A4=AC=E0=A4=A4=E0=A4=BE=E0=A4=8F=E0=A4=
=81
> =E0=A4=AF=E0=A4=BE support@bel.co.in =E0=A4=AA=E0=A4=B0 =E0=A4=AE=E0=A5=
=87=E0=A4=B2 =E0=A4=A6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B0=E0=A4=BE =E0=A4=
=B8=E0=A5=82=E0=A4=9A=E0=A4=BF=E0=A4=A4 =E0=A4=95=E0=A4=B0=E0=A5=87=E0=A4=
=82 =E0=A4=94=E0=A4=B0 =E0=A4=87=E0=A4=B8 =E0=A4=B8=E0=A4=82=E0=A4=A6=E0=A5=
=87=E0=A4=B6 =E0=A4=95=E0=A5=80 =E0=A4=B8=E0=A4=AD=E0=A5=80 =E0=A4=AA=E0=A5=
=8D=E0=A4=B0=E0=A4=A4=E0=A4=BF=E0=A4=AF=E0=A4=BE=E0=A4=81 =E0=A4=94=E0=A4=
=B0 =E0=A4=89=E0=A4=B8=E0=A4=95=E0=A5=87 =E0=A4=B8=E0=A4=BE=E0=A4=A5 =E0=A4=
=B2=E0=A4=97=E0=A5=87 =E0=A4=B8=E0=A4=82=E0=A4=B2=E0=A4=97=E0=A5=8D=E0=A4=
=A8=E0=A4=95=E0=A5=8B=E0=A4=82 =E0=A4=95=E0=A5=8B =E0=A4=A8=E0=A4=B7=E0=A5=
=8D=E0=A4=9F =E0=A4=95=E0=A4=B0 =E0=A4=A6=E0=A5=87=E0=A4=82 =E0=A5=A4
> The information contained in this electronic message and any
> attachments to this message are intended for the exclusive use of
> the addressee(s) and may contain confidential or privileged
> information. If you are not the intended recipient, please notify
> the sender at Bharat Electronics  or support@bel.co.in immediately
> and destroy all copies of this message and any attachments.
>
>

--si22xgnw3q3bd52p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlyc4FcACgkQcjQGjxah
VjzetBAAvLFa/G4YuMaJ/maXCbw/zcj7q/ZV45pTCUaSyCSV+/17xOxb7V/21sGG
rl5KV85hA26ajN2w41HaCrJPA24HknA1WYY9uPIEzArSpW6/CyTsAMGlxpDKRnV1
4WFVrQT5nbA7aBPzgtQasRLfk+8xp0RzEQc4WbnobJ3LGn5/yQZ3YjpgXQ3b0Qbg
4MhphQmw0iihwqk1Xsb9WrKQWRFPAV9TkW/4hlADu7by748VG7SFVv2AhcPkdQfj
WnygkzHOJCKQprP32Tiqi6FChOHRMwCIjAqdZCgZe8Q3jjgtQPsI8NwgMsrtaHiT
VWMS189rM0rGtLbEVLtqiJU+W1nsecE9P4LSGVzfiYWG3F0CiVM3Z6goWJl1lxAs
c4a7dX/8tR6t5x8sNA33jNSpTmBVpaCU5Plbbk50ezxqpKSqzOPRTW9uTWBKbTn2
rKCAxf8JTxKkgOFlr2cziiBCsMS1UtNYmJioTuTyGvGr/RS86V6rOkl2CYxBG253
TKR6lBBP1FQ+pekjeTSlzHkxjvGzmJlN/EZFyIDyiK3Wh9MpKe9be3VMf67ODphA
3+E4IMZ2le2/pO1+Ik1BbLIMt5qw71UMkHHA8NNK8CTwPe6GNNcAfw+EyiUjLMn0
nL2PRZIfj4lsACVPQ+RhwMiR+vXZkCK7PPqYuX7cqoIUXOlZZ6w=
=Bldm
-----END PGP SIGNATURE-----

--si22xgnw3q3bd52p--
