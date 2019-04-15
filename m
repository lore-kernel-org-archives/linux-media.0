Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41754C10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA820833
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="BEeuCmGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDOMGu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:06:50 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:27473 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOMGt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 08:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1555330005;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Kka9gvxa+UVkOkOcGadNZjRh56Wj8f6IFlQCR8GfwGk=;
        b=BEeuCmGKDOnPkbXVatsAz7gJ+YZQGK3y4QY7AVdFsOZje4P5VtTeFe5DLrVanrhcQ7
        X7xbUdftyIRfc8Y0ajxFHTu1hEf2LHmnHAjVaiBe53I2yE80FBSHG2S6Kl9vOzG3nfGa
        MFUIzvMV/zTFn4XJLbvVt1OamwLjJ0tpgzW20xl49L1BBPwaK+5V05dLOfiCQTaSuwpZ
        PIeCfet8xmgUctGRzOcxm6bbOvNyXnI4VXxCp3Y83ub8aYo3Kf5X9TEG13aEtaCSVgwX
        G5AcKNf9kUZUZsBUfC7YONN56ZVYXhFG+fp7TJGRGcrk7w8yCfP46Q3l+gvNH4vIkr/2
        LSeA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v3FC6jKnX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Apr 2019 14:06:45 +0200 (CEST)
Date:   Mon, 15 Apr 2019 14:06:45 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <233617345.468984.1555330005337@webmail.strato.com>
In-Reply-To: <20190412234359.5079-9-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-9-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 8/8] rcar-vin: Merge Gen2 and Gen3 file operations
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
> After the rework of the Gen2 file operations it's now trivial to merge
> the Gen2 and Gen3 versions.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 96 ++++-----------------
>  1 file changed, 16 insertions(+), 80 deletions(-)
>=20
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/=
platform/rcar-vin/rcar-v4l2.c
> index 58d0b59ee1247c8f..2c9cae4b7abe925c 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -781,14 +781,19 @@ static int rvin_open(struct file *file)
>  =09if (ret)
>  =09=09goto err_pm;
> =20
> -=09if (v4l2_fh_is_singular_file(file)) {
> -=09=09ret =3D rvin_power_parallel(vin, 1);
> +=09if (vin->info->use_mc) {
> +=09=09ret =3D v4l2_pipeline_pm_use(&vin->vdev.entity, 1);
>  =09=09if (ret < 0)
>  =09=09=09goto err_open;
> +=09} else {
> +=09=09if (v4l2_fh_is_singular_file(file)) {
> +=09=09=09ret =3D rvin_power_parallel(vin, 1);

"1" -> "true". (See patch 6/8).

> +=09=09=09if (ret < 0)
> +=09=09=09=09goto err_open;
> =20
> -=09=09v4l2_ctrl_handler_setup(&vin->ctrl_handler);
> +=09=09=09v4l2_ctrl_handler_setup(&vin->ctrl_handler);
> +=09=09}
>  =09}
> -
>  =09mutex_unlock(&vin->lock);
> =20
>  =09return 0;
> @@ -816,12 +821,12 @@ static int rvin_release(struct file *file)
>  =09/* the release helper will cleanup any on-going streaming */
>  =09ret =3D _vb2_fop_release(file, NULL);
> =20
> -=09/*
> -=09 * If this was the last open file.
> -=09 * Then de-initialize hw module.
> -=09 */
> -=09if (fh_singular)
> -=09=09rvin_power_parallel(vin, 0);
> +=09if (vin->info->use_mc) {
> +=09=09v4l2_pipeline_pm_use(&vin->vdev.entity, 0);
> +=09} else {
> +=09=09if (fh_singular)
> +=09=09=09rvin_power_parallel(vin, 0);

"0" -> "false".

> +=09}
> =20
>  =09pm_runtime_put(vin->dev);
> =20
> @@ -840,74 +845,6 @@ static const struct v4l2_file_operations rvin_fops =
=3D {
>  =09.read=09=09=3D vb2_fop_read,
>  };
> =20
> -/* ---------------------------------------------------------------------=
--------
> - * Media controller file operations
> - */
> -
> -static int rvin_mc_open(struct file *file)
> -{
> -=09struct rvin_dev *vin =3D video_drvdata(file);
> -=09int ret;
> -
> -=09ret =3D mutex_lock_interruptible(&vin->lock);
> -=09if (ret)
> -=09=09return ret;
> -
> -=09ret =3D pm_runtime_get_sync(vin->dev);
> -=09if (ret < 0)
> -=09=09goto err_unlock;
> -
> -=09ret =3D v4l2_pipeline_pm_use(&vin->vdev.entity, 1);
> -=09if (ret < 0)
> -=09=09goto err_pm;
> -
> -=09file->private_data =3D vin;
> -
> -=09ret =3D v4l2_fh_open(file);
> -=09if (ret)
> -=09=09goto err_v4l2pm;
> -
> -=09mutex_unlock(&vin->lock);
> -
> -=09return 0;
> -err_v4l2pm:
> -=09v4l2_pipeline_pm_use(&vin->vdev.entity, 0);
> -err_pm:
> -=09pm_runtime_put(vin->dev);
> -err_unlock:
> -=09mutex_unlock(&vin->lock);
> -
> -=09return ret;
> -}
> -
> -static int rvin_mc_release(struct file *file)
> -{
> -=09struct rvin_dev *vin =3D video_drvdata(file);
> -=09int ret;
> -
> -=09mutex_lock(&vin->lock);
> -
> -=09/* the release helper will cleanup any on-going streaming. */
> -=09ret =3D _vb2_fop_release(file, NULL);
> -
> -=09v4l2_pipeline_pm_use(&vin->vdev.entity, 0);
> -=09pm_runtime_put(vin->dev);
> -
> -=09mutex_unlock(&vin->lock);
> -
> -=09return ret;
> -}
> -
> -static const struct v4l2_file_operations rvin_mc_fops =3D {
> -=09.owner=09=09=3D THIS_MODULE,
> -=09.unlocked_ioctl=09=3D video_ioctl2,
> -=09.open=09=09=3D rvin_mc_open,
> -=09.release=09=3D rvin_mc_release,
> -=09.poll=09=09=3D vb2_fop_poll,
> -=09.mmap=09=09=3D vb2_fop_mmap,
> -=09.read=09=09=3D vb2_fop_read,
> -};
> -
>  void rvin_v4l2_unregister(struct rvin_dev *vin)
>  {
>  =09if (!video_is_registered(&vin->vdev))
> @@ -948,6 +885,7 @@ int rvin_v4l2_register(struct rvin_dev *vin)
>  =09snprintf(vdev->name, sizeof(vdev->name), "VIN%u output", vin->id);
>  =09vdev->release =3D video_device_release_empty;
>  =09vdev->lock =3D &vin->lock;
> +=09vdev->fops =3D &rvin_fops;
>  =09vdev->device_caps =3D V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
>  =09=09V4L2_CAP_READWRITE;
> =20
> @@ -959,10 +897,8 @@ int rvin_v4l2_register(struct rvin_dev *vin)
>  =09vin->format.colorspace =3D RVIN_DEFAULT_COLORSPACE;
> =20
>  =09if (vin->info->use_mc) {
> -=09=09vdev->fops =3D &rvin_mc_fops;
>  =09=09vdev->ioctl_ops =3D &rvin_mc_ioctl_ops;
>  =09} else {
> -=09=09vdev->fops =3D &rvin_fops;
>  =09=09vdev->ioctl_ops =3D &rvin_ioctl_ops;
>  =09=09rvin_reset_format(vin);
>  =09}
> --=20
> 2.21.0
>

With those fixed,
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
