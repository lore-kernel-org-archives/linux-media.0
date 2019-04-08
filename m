Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024FFC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5768213F2
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 13:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SeQTroiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfDHNJ7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:09:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4152 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHNJ7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 09:09:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cab48230000>; Mon, 08 Apr 2019 06:09:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 08 Apr 2019 06:09:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 08 Apr 2019 06:09:57 -0700
Received: from localhost (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Apr
 2019 13:09:56 +0000
Date:   Mon, 8 Apr 2019 15:09:53 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH 1/7] cec-notifier: add cec_notifier_find_hdmi_dev helper
Message-ID: <20190408130953.GA2219@ulmo>
References: <20190408110401.3345-1-hverkuil-cisco@xs4all.nl>
 <20190408110401.3345-2-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
In-Reply-To: <20190408110401.3345-2-hverkuil-cisco@xs4all.nl>
X-NVConfidentiality: public
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554728995; bh=rL7p5VqpDlGtbmQI5DDtrOI4t1woSE/2KtijfPWNzi8=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=SeQTroiPPsF7H2sI1PaS5YmWn0mCp01OkmQwSBtxOzA2fnNGl0ZH5bNV5cYMt5BF2
         Wmg2DKjGUYcdHOkM0ZNxpHZQFfzEAwz67xgTgEg02yVPqCes9H4pTrqiNcBdgVWWc0
         4rW/VGrVYfgBsopiLelAV4MdTof1UIy/6CMsLan0kMZ3mQyh+qLalg2hFTWpU+yL/E
         nAQNoIXKGUJfTcGTYtbxzEm9uxF8GIgYfqRr6Dtn/77DW5VGORNJe6iQrZbRoKiSXC
         NeXHejo4cajDEe96vMXpb1BRT6x4kIQvSQlqhPr0UmZB/vZ2LGJ9fvgx63zkQ4Ny6d
         oXQBNk4yQxWQA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 01:03:55PM +0200, Hans Verkuil wrote:
> Add helper function to parse the DT for the hdmi-phandle property
> and find the corresponding struct device pointer.
>=20
> It takes care to avoid increasing the device refcount since all
> we need is the device pointer. This pointer is used in the
> notifier list as a key, but it is never accessed by the CEC driver.
>=20
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Reported-by: Wen Yang <wen.yang99@zte.com.cn>
> ---
>  drivers/media/cec/cec-notifier.c | 24 ++++++++++++++++++++++++
>  include/media/cec-notifier.h     | 19 ++++++++++++++++++-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-not=
ifier.c
> index dd2078b27a41..870b3788e9f7 100644
> --- a/drivers/media/cec/cec-notifier.c
> +++ b/drivers/media/cec/cec-notifier.c
> @@ -11,6 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/list.h>
>  #include <linux/kref.h>
> +#include <linux/of_platform.h>
> =20
>  #include <media/cec.h>
>  #include <media/cec-notifier.h>
> @@ -127,3 +128,26 @@ void cec_notifier_unregister(struct cec_notifier *n)
>  	cec_notifier_put(n);
>  }
>  EXPORT_SYMBOL_GPL(cec_notifier_unregister);
> +
> +struct device *cec_notifier_find_hdmi_dev(struct device *dev)

This doesn't really do anything with notifiers, so perhaps rename this
to something more independent?

> +{
> +	struct platform_device *hdmi_pdev;
> +	struct device *hdmi_dev =3D NULL;
> +	struct device_node *np;
> +
> +	np =3D of_parse_phandle(dev->of_node, "hdmi-phandle", 0);
> +
> +	if (!np) {
> +		dev_err(dev, "Failed to find hdmi node in device tree\n");

Perhaps "... to find HDMI node..."? HDMI here doesn't refer to a name,
so I think it's better to use the capitalized abbreviation to avoid any
potential confusion.

> +		return ERR_PTR(-ENODEV);
> +	}
> +	hdmi_pdev =3D of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (hdmi_pdev) {
> +		hdmi_dev =3D &hdmi_pdev->dev;
> +		put_device(hdmi_dev);

Don't you need to hold onto that reference and pass it to the caller?
Otherwise somebody could be dropping the last reference to the struct
device backing the HDMI device after this call finishes.

In conjunction with the above comment, perhaps it'd be clearer if we had
a cec_hdmi_get()/cec_hdmi_put() pair of functions so that callers can
explicitly manage the reference count.

Thierry

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyrSB0ACgkQ3SOs138+
s6HLLg//VEoMkpOriJ2trvxvSSB6LPmOwZnoMV23K81ALfPvn9Q8aLvuC8WGnURk
psYum4MU2d9Xz3w2V1uJFM+PIcWdIcZVvuZoqmH+ccD7vPDdyUBY8q232qcNfxvR
DZtdSQAYUyPRD2cUmy4KrBO35fIfU/4nxqf2RhaWf7xvjnr7hxlMKgGwo0tQVqNd
9/2xi2tcgLaE37p1yZy06FMY2MUkGRNTYnCx2dFds8hTNCf+GK+qkjyA5FwjU51y
LNjJYnOV+gwnTbr7Xobeia3SDZ178TRXHCJb13ynYJ90vXRlcKVpJOjXPDpfBPqS
8Tsns2ATY229mosJzdi8dCMKDi9tl1pCfyOenw6RlRJRRGTstgu0D3TIZAe+jGXq
aac2fuGKbT+0qlVPuEK9HDImSihNRG+7cd8qYshPT5/FqGzgW4Z9K9qKVr/Baa9G
W2WYT9t+w7NfwvXRcQ2uPygpRXdmw1aB0meOyFUIM6xRRPzpuRSr6Z4uttVqIfYL
+saJJD9ZjKmc8wco8+kHFKfZZibj8+TG89PpLVDuiGjk+ig+DBknwu4yE3BIWGcx
1k2GxcSXCGTsT16GSUiGiTmW7aOK8dvEIOJeUGPJP4JWXrMgHP7/6vzJfy3OEr4h
oqymnbIGmejzyajwKEJN3uUG+dVb/OkKnDS9nhTQYwIm1wG/FoA=
=E6jr
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
