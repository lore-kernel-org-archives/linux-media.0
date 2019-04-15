Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D098C10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2323206B6
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="UIKxjXlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfDOL1i (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:27:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36052 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOL1i (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 07:27:38 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 07:27:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1555327656;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=sQ+1v2gu2M+OaikuITabnVAeZcNP8XiVBXMADSjHEZk=;
        b=UIKxjXlw/mxXKvmdAIBKlzMfjREDrJLE/1eCmCkXaUdQ/2TV0W3qku2KlZdWSS+hVK
        CxCZm/CnnW5zK+kiRKh6A0oFLL62/IRZ/aqEwIUsZ/qdMFKAYzeoHPVS/CvwIQy4Eewu
        bxZtqsEFhIzMVMc5O2/zAp4AWACHIGDTo4IuS9ekEF3aLFLYH9a5Jfa9NfURkxp5BWG4
        kGbNld9GPKN8nhqSxSJM0sNDlUoL3BE9vCKVWXRsR/D6Py2wgKnyTCUqfwuqucUhvDzH
        NSnH+QZu0uqXMs8AELtbBxhpLPYOk55/e8oLMD8ktH27HAwBbKGhIH6xRvW6HxHD9O24
        D0Eg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v3FBOJKFO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Apr 2019 13:24:19 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:24:19 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <1707991043.465380.1555327459891@webmail.strato.com>
In-Reply-To: <20190412234359.5079-5-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-5-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 4/8] rcar-vin: Do not sync subdevice format when opening
 the video device
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
> The format is already synced when the subdevice is bound, there is no
> need to do do it every time the video device is opened.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 25 ---------------------
>  1 file changed, 25 deletions(-)
>=20
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/=
platform/rcar-vin/rcar-v4l2.c
> index f67cef97b89a3bd4..71651c5a69483367 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -782,38 +782,13 @@ static int rvin_initialize_device(struct file *file=
)
>  =09struct rvin_dev *vin =3D video_drvdata(file);
>  =09int ret;
> =20
> -=09struct v4l2_format f =3D {
> -=09=09.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE,
> -=09=09.fmt.pix =3D {
> -=09=09=09.width=09=09=3D vin->format.width,
> -=09=09=09.height=09=09=3D vin->format.height,
> -=09=09=09.field=09=09=3D vin->format.field,
> -=09=09=09.colorspace=09=3D vin->format.colorspace,
> -=09=09=09.pixelformat=09=3D vin->format.pixelformat,
> -=09=09},
> -=09};
> -
>  =09ret =3D rvin_power_on(vin);
>  =09if (ret < 0)
>  =09=09return ret;
> =20
> -=09/*
> -=09 * Try to configure with default parameters. Notice: this is the
> -=09 * very first open, so, we cannot race against other calls,
> -=09 * apart from someone else calling open() simultaneously, but
> -=09 * .host_lock is protecting us against it.
> -=09 */
> -=09ret =3D rvin_s_fmt_vid_cap(file, NULL, &f);
> -=09if (ret < 0)
> -=09=09goto esfmt;
> -
>  =09v4l2_ctrl_handler_setup(&vin->ctrl_handler);
> =20
>  =09return 0;
> -esfmt:
> -=09rvin_power_off(vin);
> -
> -=09return ret;
>  }
> =20
>  static int rvin_open(struct file *file)
> --=20
> 2.21.0
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
