Return-Path: <SRS0=Vslh=VU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF731C7618E
	for <linux-media@archiver.kernel.org>; Tue, 23 Jul 2019 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3CD223BA
	for <linux-media@archiver.kernel.org>; Tue, 23 Jul 2019 09:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfGWJ04 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:26:56 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48717 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfGWJ04 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Jul 2019 05:26:56 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CF66A240004;
        Tue, 23 Jul 2019 09:26:52 +0000 (UTC)
Date:   Tue, 23 Jul 2019 11:26:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
Message-ID: <20190723092652.77lxzokzeo2vk3dz@flea>
References: <20190718192455.31244-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhu7f3hrkea4ohiv"
Content-Disposition: inline
In-Reply-To: <20190718192455.31244-1-maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--zhu7f3hrkea4ohiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2019 at 09:24:55PM +0200, Maxime Ripard wrote:
> Use my kernel.org address instead of the bootlin one.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied through the sunxi tree

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zhu7f3hrkea4ohiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXTbS3AAKCRDj7w1vZxhR
xWGBAQDFpazKhIyWYPqqL2cT/Oa5r36sSgdcPbQqwm7ONpHvjgEAqLNjK0NvTZa8
gBOhiNo9kn4zep/6PXbhCwCdxdhd7w4=
=ueNh
-----END PGP SIGNATURE-----

--zhu7f3hrkea4ohiv--
