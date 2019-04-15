Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDD9C10F12
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1963120833
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="SZyjXEad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfDOMCT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:02:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:31588 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfDOMCT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 08:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1555329736;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Dp739+M3g7T8x/A9MRsCUZ5CgeVOXaZDZnxNH6QnkW0=;
        b=SZyjXEadlE4Uy1hO7dppukAHpXsOd3J2nEPGiyf7SRnWfwEwjPWfQUoOh4+ubS6x/N
        VJQ1KBfbUtDaatkDtDZ7SY7DuY27gX0VX3uIZBDu7sCBOe7xkypq2UhcjKoflbcGt8JB
        ZHP7ytOmLbiNvhd81buKk0n/BygrNWheAtOlYhDObfw0c/gmqfByDLKU4kCiEyumywwT
        iuleyIO2y9zGJje2ms7g3Ovr6iEuKipc606kaYq+JTUXc4ozoC4WZWI3PiDXzIMjB99a
        JtgAXJhKgxjWsNC3RdOfGGi4L+BIwP515FQWhQRFvM52kkhjZ8Mlr/k7CKlqz1sunnqR
        E+aA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v3FC2GKm8
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Apr 2019 14:02:16 +0200 (CEST)
Date:   Mon, 15 Apr 2019 14:02:16 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <13733651.468607.1555329736729@webmail.strato.com>
In-Reply-To: <20190412234359.5079-8-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-8-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 7/8] rcar-vin: Fold rvin_initialize_device() into
 rvin_open()
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
> The function no longer serve a purpose as most tasks it performed have
> been refactored, fold what remains it into the only caller.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/=
platform/rcar-vin/rcar-v4l2.c
> index 3b4624c117aaba18..58d0b59ee1247c8f 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -762,20 +762,6 @@ static int rvin_power_parallel(struct rvin_dev *vin,=
 int on)
>  =09return 0;
>  }
> =20
> -static int rvin_initialize_device(struct file *file)
> -{
> -=09struct rvin_dev *vin =3D video_drvdata(file);
> -=09int ret;
> -
> -=09ret =3D rvin_power_parallel(vin, 1);
> -=09if (ret < 0)
> -=09=09return ret;
> -
> -=09v4l2_ctrl_handler_setup(&vin->ctrl_handler);
> -
> -=09return 0;
> -}
> -
>  static int rvin_open(struct file *file)
>  {
>  =09struct rvin_dev *vin =3D video_drvdata(file);
> @@ -796,10 +782,11 @@ static int rvin_open(struct file *file)
>  =09=09goto err_pm;
> =20
>  =09if (v4l2_fh_is_singular_file(file)) {
> -=09=09if (rvin_initialize_device(file)) {
> -=09=09=09ret =3D -ENODEV;
> +=09=09ret =3D rvin_power_parallel(vin, 1);

"1" -> "true". (See patch 6/8.)

> +=09=09if (ret < 0)
>  =09=09=09goto err_open;
> -=09=09}
> +
> +=09=09v4l2_ctrl_handler_setup(&vin->ctrl_handler);
>  =09}
> =20
>  =09mutex_unlock(&vin->lock);
> --=20
> 2.21.0
>

With the above fixed,
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
