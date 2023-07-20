Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEDFEB64DA
	for <linux-media@archiver.kernel.org>; Thu, 20 Jul 2023 10:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGTKUG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 20 Jul 2023 06:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGTKUF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 20 Jul 2023 06:20:05 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063CE75
        for <linux-media@vger.kernel.org>; Thu, 20 Jul 2023 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689848403; x=1721384403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MboF/Yj6FZtYzwwj0ID9ddy66mCTdjv++Tu+1ox1wsc=;
  b=FJ1BrggS+voTsBXLGNrbSWMVUAmRR9fiNtV4aNIaTiE0dCtqAMnzrcKR
   OeNJkjuLR/CyHBi3XP88tjulLP+TkqJNon+QIOcaklcCBenJU3LoAgEMD
   cfck5wogGxhOnuCwF/O61x7rFTko9cf9TklaLuhKY4INRpFamVpyN5hfN
   SGkY8T9JM5ruC5v7qyI2aG826zVu+x5YRnr8S/FDdORaECdb+uwe5l/JF
   zMxPVLapJHtMvnUtBrR/i+Y4zHSz+IZqTD+mjR5AFotU4l5E1+1bvnxwl
   9H1AKM23W+GP+KnEcbdAjCw1E0zmPK850K1rY58vYaWS2iLU51heudadK
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684792800"; 
   d="scan'208";a="32030419"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Jul 2023 12:20:01 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 05E90280078;
        Thu, 20 Jul 2023 12:20:01 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] media: imx: imx7-media-csi: Fix applying format constraints
Date:   Thu, 20 Jul 2023 12:19:59 +0200
Message-ID: <2765509.BEx9A2HvPv@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230720074129.3680269-2-alexander.stein@ew.tq-group.com>
References: <20230720074129.3680269-1-alexander.stein@ew.tq-group.com> <20230720074129.3680269-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Am Donnerstag, 20. Juli 2023, 09:41:29 CEST schrieb Alexander Stein:
> v4l_bound_align_image aligns to a multiple power of 2 of walign, but the
> result only needs to be a multiple of walign. Fix this by using
> v4l2_apply_frmsize_constraints() instead.
>=20
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Fixes: 6f482c4729d9 ("media: imx: imx7-media-csi: Get rid of superfluous
> call to imx7_csi_mbus_fmt_to_pix_fmt") Signed-off-by: Alexander Stein
> <alexander.stein@ew.tq-group.com>
> ---
> Tim,
> can you please test if this fixes your problem?
> Apparently this issue only arises under specific conditions, e.g.
> 640/480/8bpp. This issue does not show up for 640/480/10bpp.
>=20
>  drivers/media/platform/nxp/imx7-media-csi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/nxp/imx7-media-csi.c
> b/drivers/media/platform/nxp/imx7-media-csi.c index
> 73f8f2a35422..523e5f039a5a 100644
> --- a/drivers/media/platform/nxp/imx7-media-csi.c
> +++ b/drivers/media/platform/nxp/imx7-media-csi.c
> @@ -1141,8 +1141,8 @@ __imx7_csi_video_try_fmt(struct v4l2_pix_format
> *pixfmt, * TODO: Implement configurable stride support.
>  	 */
>  	walign =3D 8 * 8 / cc->bpp;
> -	v4l_bound_align_image(&pixfmt->width, 1, 0xffff, walign,
> -			      &pixfmt->height, 1, 0xffff, 1, 0);
> +	v4l2_apply_frmsize_constraints(&pixfmt->width, &pixfmt->height,
> +				       &imx7_csi_frmsize_stepwise);

Meh, this essentially removes the walign constraint. I need some more coffe=
e=20
and this some more work.

Sorry for the noise
Alexander

>=20
>  	pixfmt->bytesperline =3D pixfmt->width * cc->bpp / 8;
>  	pixfmt->sizeimage =3D pixfmt->bytesperline * pixfmt->height;


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


