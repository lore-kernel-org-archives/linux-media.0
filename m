Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F49AC10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AC3206B6
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 11:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="fheX5k2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfDOL2H (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:28:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:33564 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOL2H (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 07:28:07 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 07:28:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1555327685;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=B7m7we5cmB8+MXblA18pY6abTlR+GCZvvRft8a50dCs=;
        b=fheX5k2yf5y/snz8c4k8LXQnbuap4EmCogngi2c6JekqwEfrqtbwGLvY/2jj8JTBVM
        r+onOh2OpcrpkkRCcTFnKLrPOsH+rfvIksg03TGHzpU1NVZex0ymLFQRBvdQpdGgzcVz
        lnTZITC2E7L9NcLqIvoDmreofvse/t0aWa8vsM0Z/gR6K9W/qITCPTaoPlKzGV0ROqHD
        OdzVuZaeYx3egdyDPOjUjRijwfKymJSERUZyJt4CTXLIjhv5ihefwKIpjQdpL/utoi+I
        RJlmCtLOz3DF3DNNYFXhp5rxFQnbGUP2ptVgJ0JnBqb9dGHLlF2cFiHST5TSxtwnYgZ5
        YFpQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v3FBLkKCo
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Apr 2019 13:21:46 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:21:46 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <112705735.465123.1555327306392@webmail.strato.com>
In-Reply-To: <20190412234359.5079-4-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-4-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 3/8] rcar-vin: Allow interrupting lock when trying to
 open the video device
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
> The user should be allowed to break waiting for the lock when opening
> the video device.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/=
platform/rcar-vin/rcar-v4l2.c
> index 0841f1a0bfd7ba3a..f67cef97b89a3bd4 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -821,7 +821,9 @@ static int rvin_open(struct file *file)
>  =09struct rvin_dev *vin =3D video_drvdata(file);
>  =09int ret;
> =20
> -=09mutex_lock(&vin->lock);
> +=09ret =3D mutex_lock_interruptible(&vin->lock);
> +=09if (ret)
> +=09=09return ret;
> =20
>  =09file->private_data =3D vin;
> =20
> --=20
> 2.21.0
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
