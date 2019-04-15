Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B8EC10F12
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D672087C
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="krskU5bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDOLcC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:32:02 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:24209 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDOLcC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 07:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1555327919;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Tv+0wQw/B/P4QZNtwN/FLumaQSuEHmxrjBHZmTES62w=;
        b=krskU5bXYEtDLTO5YopN7vfbYO4/atBenGDVMjHWv+P+ubnzQD0doJ4fc32gct2lCT
        9jti0wTfn5Wkpd/kk8G3D9kDjK5kMwde0F0Q4DZEOd+ue0b0QaBWM+A5ZoAytj0NKd2c
        u91Lyx1BBL3+RDdtYihvRoHZL9ao2KyGoY+9vOVkfF8Ado106h4c3Yq6wUJfJDw17prT
        BzQC2QGXDfJFm0EoRV5vpcYW0SuGT9GC6HAfsKsz3Yyog263ldI2RRGh3TRPLtWybPnC
        pfX0HG8PDhJzXT7t3E2YOH/kLW5GZp0OtqcovUlaBLY22bJb8nUAVZU2bS8gs29VEJHW
        Iiww==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v3FBVxKMq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Apr 2019 13:31:59 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:31:59 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <1836210583.466069.1555327919451@webmail.strato.com>
In-Reply-To: <20190412234359.5079-6-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-6-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 5/8] rcar-vin: Move pm_runtime_{get,put} out of helpers
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
> The helpers rvin_power_{on,off} deals with both VIN and the parallel
> subdevice power. This makes it hard to merge the Gen2 and Gen3
> open/release functions. Move the VIN power handling directly to the
> open/release functions to prepare for the merge.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 34 +++++++++++++--------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/=
platform/rcar-vin/rcar-v4l2.c
> index 71651c5a69483367..5a9658b7d848fc86 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -754,8 +754,6 @@ static int rvin_power_on(struct rvin_dev *vin)
>  =09int ret;
>  =09struct v4l2_subdev *sd =3D vin_to_source(vin);
> =20
> -=09pm_runtime_get_sync(vin->v4l2_dev.dev);
> -
>  =09ret =3D v4l2_subdev_call(sd, core, s_power, 1);
>  =09if (ret < 0 && ret !=3D -ENOIOCTLCMD && ret !=3D -ENODEV)
>  =09=09return ret;
> @@ -768,9 +766,6 @@ static int rvin_power_off(struct rvin_dev *vin)
>  =09struct v4l2_subdev *sd =3D vin_to_source(vin);
> =20
>  =09ret =3D v4l2_subdev_call(sd, core, s_power, 0);
> -
> -=09pm_runtime_put(vin->v4l2_dev.dev);
> -
>  =09if (ret < 0 && ret !=3D -ENOIOCTLCMD && ret !=3D -ENODEV)
>  =09=09return ret;
> =20
> @@ -802,20 +797,31 @@ static int rvin_open(struct file *file)
> =20
>  =09file->private_data =3D vin;
> =20
> +=09ret =3D pm_runtime_get_sync(vin->dev);
> +=09if (ret < 0)
> +=09=09goto err_unlock;
> +
>  =09ret =3D v4l2_fh_open(file);
>  =09if (ret)
> -=09=09goto unlock;
> +=09=09goto err_pm;
> =20
> -=09if (!v4l2_fh_is_singular_file(file))
> -=09=09goto unlock;
> -
> -=09if (rvin_initialize_device(file)) {
> -=09=09v4l2_fh_release(file);
> -=09=09ret =3D -ENODEV;
> +=09if (v4l2_fh_is_singular_file(file)) {
> +=09=09if (rvin_initialize_device(file)) {
> +=09=09=09ret =3D -ENODEV;
> +=09=09=09goto err_open;
> +=09=09}
>  =09}
> =20
> -unlock:
>  =09mutex_unlock(&vin->lock);
> +
> +=09return 0;
> +err_open:
> +=09v4l2_fh_release(file);
> +err_pm:
> +=09pm_runtime_put(vin->dev);
> +err_unlock:
> +=09mutex_unlock(&vin->lock);
> +
>  =09return ret;
>  }
> =20
> @@ -840,6 +846,8 @@ static int rvin_release(struct file *file)
>  =09if (fh_singular)
>  =09=09rvin_power_off(vin);
> =20
> +=09pm_runtime_put(vin->dev);
> +
>  =09mutex_unlock(&vin->lock);
> =20
>  =09return ret;
> --=20
> 2.21.0
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
