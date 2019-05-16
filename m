Return-Path: <SRS0=hQl8=TQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF04C04AB4
	for <linux-media@archiver.kernel.org>; Thu, 16 May 2019 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701292087B
	for <linux-media@archiver.kernel.org>; Thu, 16 May 2019 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="WlXyvNkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfEPH7H (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 May 2019 03:59:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:25406 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPH7H (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 May 2019 03:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1557993542;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Fld6kegWQPEsPuDbweEnabf1p3ko9B1BtxGvj5xjvsg=;
        b=WlXyvNkIB4Z1jfDlKxN1/LZ9vIXtsQ/CqQwe6NTslftH8JQSbbHhF+4n6bEoroy2HE
        a98yxbLYWSrWJH+eBDagsQLqn3UYz70VRGrfu61TSH75fWOvvmgp76AmPQ5SANeRV2IZ
        eI2IDyTTRgI23yipDq9yGYAiyPYiVepZAMf4Vfqp8StuuJZSIrh1aWN+tao+PDU3btZR
        I4X6VNcDLd0T0GTBcw/chSwq1JwrJsafpHug7XNl4W2DXqcGs0EnUurn0aFUYMadnPPu
        el6W6b/k92kzcQ7aPaD0Xn19raZlepLS55Nskp5exXnZu1LAjcX0WciTwJw/mgk+3deB
        BYIA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp02-01.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id y08c83v4G7x2sEL
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Thu, 16 May 2019 09:59:02 +0200 (CEST)
Date:   Thu, 16 May 2019 09:59:02 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
Message-ID: <1010579666.68696.1557993542697@webmail.strato.com>
In-Reply-To: <20190516003803.808-1-niklas.soderlund+renesas@ragnatech.se>
References: <20190516003803.808-1-niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH] dt-bindings: rcar-{csi2,vin}: Rename bindings
 documentation files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev57
X-Originating-IP: 85.212.214.135
X-Originating-Client: open-xchange-appsuite
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


> On May 16, 2019 at 2:38 AM Niklas S=C3=B6derlund <niklas.soderlund+renesa=
s@ragnatech.se> wrote:
>=20
>=20
> Renesas media binding documentation files uses a naming schema of
> 'renesas,<module>.txt'. Rename VIN and CSI-2 files to match this
> pattern.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  .../media/{renesas,rcar-csi2.txt =3D> renesas,csi2.txt}         | 0
>  .../bindings/media/{rcar_vin.txt =3D> renesas,vin.txt}          | 0
>  MAINTAINERS                                                   | 4 ++--
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/media/{renesas,rcar-csi2.txt =
=3D> renesas,csi2.txt} (100%)
>  rename Documentation/devicetree/bindings/media/{rcar_vin.txt =3D> renesa=
s,vin.txt} (100%)
>=20
> diff --git a/Documentation/devicetree/bindings/media/renesas,rcar-csi2.tx=
t b/Documentation/devicetree/bindings/media/renesas,csi2.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt
> rename to Documentation/devicetree/bindings/media/renesas,csi2.txt
> diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Docum=
entation/devicetree/bindings/media/renesas,vin.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/media/rcar_vin.txt
> rename to Documentation/devicetree/bindings/media/renesas,vin.txt
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 878588cfb453d83c..c3a23726472d7d4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9629,8 +9629,8 @@ L:=09linux-media@vger.kernel.org
>  L:=09linux-renesas-soc@vger.kernel.org
>  T:=09git git://linuxtv.org/media_tree.git
>  S:=09Supported
> -F:=09Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt
> -F:=09Documentation/devicetree/bindings/media/rcar_vin.txt
> +F:=09Documentation/devicetree/bindings/media/renesas,csi2.txt
> +F:=09Documentation/devicetree/bindings/media/renesas,vin.txt
>  F:=09drivers/media/platform/rcar-vin/
> =20
>  MEDIA DRIVERS FOR RENESAS - VSP1
> --=20
> 2.21.0
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
