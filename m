Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7607C282DA
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634520880
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="UUgLpf0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDOLVK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:21:10 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:33165 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOLVK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 07:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1555327268;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=93qKTu7ggsYhVjnephg4zOU7OG0v5f+BILksu4mPXN0=;
        b=UUgLpf0u3NHUon3bV29O00fPafYIVfYr02S6gGDssvlwa+hmH/NqlwKiqEYyzd3+yf
        qD9rk7ilL4HVc2ornOcEaSq0vIdG48uGQtY/TlGTwBjnbCvHdG0V+/4V1u5oi+mYVQUh
        KfpEaod/K2ema1n55t9D8pqzWeUfqDKuO4dG48d5ZEYDxt9061f7uvGs5/dquDgX7eO6
        pny0xdtbmOH8cuIAAn3YdoyLsOcv09U4p8RBZbewQhL/wGNkg7kHZbEIARho9gZFDhKi
        CkOMVXOdGdo+4Y6b21Ucch310STh4rs/swFRZWuh8abhlzE3ZSMhjpIPONeNbeUAo8GB
        vTKA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v3FBL8KCD
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Apr 2019 13:21:08 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:21:07 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <1317791671.465071.1555327267988@webmail.strato.com>
In-Reply-To: <20190412234359.5079-2-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-2-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 1/8] rcar-vin: Do not call pm_runtime_{resume,suspend}()
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
> The driver do not implement runtime resume and suspend function so there

"driver does", I presume.

> is little point in trying to call them. This is a leftover from the
> drivers soc_camera beginnings.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/=
platform/rcar-vin/rcar-v4l2.c
> index 7cbdcbf9b090c638..b821ea01786eb1ff 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -798,9 +798,6 @@ static int rvin_initialize_device(struct file *file)
>  =09=09return ret;
> =20
>  =09pm_runtime_enable(&vin->vdev.dev);
> -=09ret =3D pm_runtime_resume(&vin->vdev.dev);
> -=09if (ret < 0 && ret !=3D -ENOSYS)
> -=09=09goto eresume;
> =20
>  =09/*
>  =09 * Try to configure with default parameters. Notice: this is the
> @@ -817,7 +814,6 @@ static int rvin_initialize_device(struct file *file)
>  =09return 0;
>  esfmt:
>  =09pm_runtime_disable(&vin->vdev.dev);
> -eresume:
>  =09rvin_power_off(vin);
> =20
>  =09return ret;
> @@ -868,7 +864,6 @@ static int rvin_release(struct file *file)
>  =09 * Then de-initialize hw module.
>  =09 */
>  =09if (fh_singular) {
> -=09=09pm_runtime_suspend(&vin->vdev.dev);
>  =09=09pm_runtime_disable(&vin->vdev.dev);
>  =09=09rvin_power_off(vin);
>  =09}
> --=20
> 2.21.0
>

With typo fixed,
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
