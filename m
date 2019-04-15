Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EEAC10F12
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28855206B6
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="PCzXTo/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfDOL1h (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:27:37 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:13845 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOL1h (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 07:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1555327655;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=H22v/e2vHZ8iRQVEexZ9Fwxi9+Qz082+F+luABjtQfg=;
        b=PCzXTo/vDWxFIgOfrinp7BgxjhFjZpmdIQ/1yL7VuCv21GYNvFKIBzlvygi3bBoxYG
        ERGpzSnbK4Z2iMrhr5i7sJ8+WfGgV2lwFSKLtGcH785WRhJ4uso+o3D4hrHDKDN1pXOv
        vPbwNPCepp7U3nikZFLKMl0fTJsUKDbWCeRCIuzXGq/qFOtkyxaD6Q+uglrUG2mTtn+q
        kQ003fNzayYooTh7ykAikYMr8jvCF+78omI74tc7Eyx0XYRsrCCDW6y6AJXFpqsoXYeD
        Bnuk1Rj6gRqTjLHEPOha6UYSRFE9cxf9h1ez8g06fAv0Z5BySLuaFZxlILNtRnqGwlgb
        2hSA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v3FBLMKCM
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Apr 2019 13:21:22 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:21:22 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <1183091662.465085.1555327282821@webmail.strato.com>
In-Reply-To: <20190412234359.5079-3-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-3-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 2/8] rcar-vin: Remove unneeded calls to
 pm_runtime_{enable,disable}
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
> Runtime PM is already enable unconditionally when the driver is probed
> and disabled when it's removed. There is no point in doing it again for
> Gen2 when opening and closing the video device.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/=
platform/rcar-vin/rcar-v4l2.c
> index b821ea01786eb1ff..0841f1a0bfd7ba3a 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -797,8 +797,6 @@ static int rvin_initialize_device(struct file *file)
>  =09if (ret < 0)
>  =09=09return ret;
> =20
> -=09pm_runtime_enable(&vin->vdev.dev);
> -
>  =09/*
>  =09 * Try to configure with default parameters. Notice: this is the
>  =09 * very first open, so, we cannot race against other calls,
> @@ -813,7 +811,6 @@ static int rvin_initialize_device(struct file *file)
> =20
>  =09return 0;
>  esfmt:
> -=09pm_runtime_disable(&vin->vdev.dev);
>  =09rvin_power_off(vin);
> =20
>  =09return ret;
> @@ -863,10 +860,8 @@ static int rvin_release(struct file *file)
>  =09 * If this was the last open file.
>  =09 * Then de-initialize hw module.
>  =09 */
> -=09if (fh_singular) {
> -=09=09pm_runtime_disable(&vin->vdev.dev);
> +=09if (fh_singular)
>  =09=09rvin_power_off(vin);
> -=09}
> =20
>  =09mutex_unlock(&vin->lock);
> =20
> --=20
> 2.21.0
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
