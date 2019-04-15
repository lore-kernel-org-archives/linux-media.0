Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB2C282DA
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E78120833
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="kdl0Qw8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfDOL7b (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:59:31 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:20349 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfDOL7b (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 07:59:31 -0400
X-Greylist: delayed 2263 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 07:59:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1555329566;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=W7QXT+Pucrk0mIj+oo/RK8RsqwAkqP4VykjJ7cxvv/Q=;
        b=kdl0Qw8vhoRas0I+RPFSeoLttulFFdNTWAfyrJcYEyobo9PhNJCUfm5Fqwuw06wBdg
        xa3mRKE6g33EhV8GuPMybNy/pOEZjxQFO7gB33vPBygLyIgl7FHIYd2v6Io82EiqayQV
        OiPP1fnsfKpTKirSmSJgyFFH23bG+bhHGfSN+Uri534kWfBuzUtcqiuVfbP8NWsEfsOk
        ae0/EoQhvDJlejWEMKHPwoqdEIrtjWiu7W1Gs6OHxUz6JvcboV5qHI7OE4phklG4VVNM
        dNLF8iLIj87xVHlvSCbpLnZ4f/5XjAR0Fmw4kyKYx+cSh/z3JPOWA3luGG9nD4dQuvhJ
        bo2g==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v3FBxQKl7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Apr 2019 13:59:26 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:59:26 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <400802600.468396.1555329566400@webmail.strato.com>
In-Reply-To: <20190412234359.5079-7-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-7-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 6/8] rcar-vin: Merge helpers dealing with powering the
 parallel subdevice
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev55
X-Originating-IP: 85.212.102.112
X-Originating-Client: open-xchange-appsuite
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


> On April 13, 2019 at 1:43 AM Niklas S=C3=B6derlund <niklas.soderlund+rene=
sas@ragnatech.se> wrote:
>=20
>=20
> The two power helpers are now only dealing with the parallel subdevice,
> merge them into a single rvin_power_parallel() helper to reduce code
> duplication.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/=
platform/rcar-vin/rcar-v4l2.c
> index 5a9658b7d848fc86..3b4624c117aaba18 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -749,23 +749,13 @@ static const struct v4l2_ioctl_ops rvin_mc_ioctl_op=
s =3D {
>   * File Operations
>   */
> =20
> -static int rvin_power_on(struct rvin_dev *vin)
> +static int rvin_power_parallel(struct rvin_dev *vin, int on)

"int on" -> "bool on".

>  {
> -=09int ret;
>  =09struct v4l2_subdev *sd =3D vin_to_source(vin);
> -
> -=09ret =3D v4l2_subdev_call(sd, core, s_power, 1);
> -=09if (ret < 0 && ret !=3D -ENOIOCTLCMD && ret !=3D -ENODEV)
> -=09=09return ret;
> -=09return 0;
> -}
> -
> -static int rvin_power_off(struct rvin_dev *vin)
> -{
> +=09int power =3D on ? 1 : 0;
>  =09int ret;
> -=09struct v4l2_subdev *sd =3D vin_to_source(vin);
> =20
> -=09ret =3D v4l2_subdev_call(sd, core, s_power, 0);
> +=09ret =3D v4l2_subdev_call(sd, core, s_power, power);
>  =09if (ret < 0 && ret !=3D -ENOIOCTLCMD && ret !=3D -ENODEV)
>  =09=09return ret;
> =20
> @@ -777,7 +767,7 @@ static int rvin_initialize_device(struct file *file)
>  =09struct rvin_dev *vin =3D video_drvdata(file);
>  =09int ret;
> =20
> -=09ret =3D rvin_power_on(vin);
> +=09ret =3D rvin_power_parallel(vin, 1);

"1" -> "true".

>  =09if (ret < 0)
>  =09=09return ret;
> =20
> @@ -844,7 +834,7 @@ static int rvin_release(struct file *file)
>  =09 * Then de-initialize hw module.
>  =09 */
>  =09if (fh_singular)
> -=09=09rvin_power_off(vin);
> +=09=09rvin_power_parallel(vin, 0);

"0" -> "false".

> =20
>  =09pm_runtime_put(vin->dev);
> =20
> --=20
> 2.21.0
>

CU
Uli
