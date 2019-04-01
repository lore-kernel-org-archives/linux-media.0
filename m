Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337EEC43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B83D20896
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 18:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfDASaJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:30:09 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47899 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfDASaI (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 14:30:08 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A3DA1240005;
        Mon,  1 Apr 2019 18:30:06 +0000 (UTC)
Date:   Mon, 1 Apr 2019 20:30:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        kernel@collabora.com
Subject: Re: [PATCH 0/2] media: Introduce pixel format helpers
Message-ID: <20190401183006.kxm3jcm5owevueze@flea>
References: <20190328180704.24761-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2p5jfpa6mbjjypxo"
Content-Disposition: inline
In-Reply-To: <20190328180704.24761-1-ezequiel@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--2p5jfpa6mbjjypxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ezequiel,

On Thu, Mar 28, 2019 at 03:07:02PM -0300, Ezequiel Garcia wrote:
> Following the "Add MPEG-2 decoding to Rockchip VPU"[1], and given we want to start
> using the pixel format helpers rather soon, I've decided to submit them separatedly.
>
> Aside from documenting the block_w and block_h, as suggested by Emil Velikov, these
> two patches are unmodified compared to v2 [1].
>
> This series contains the minimum patches to introduce the pixel format
> helpers, it currently will have no users, but we expect users to start
> popping-up soon.
> very shortly [2].
>
> To avoid confusing the patches here with those on v2 [1], I'm marking them as v3.

You might have missed it, but have you looked at the RFC "drm: Split
out the formats API and move it to a common place" I sent a couple of
weeks ago? It seems to cover the same use cases.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2p5jfpa6mbjjypxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKJYrQAKCRDj7w1vZxhR
xV17AQC8dn9esikQ1AzQbOVidWJFJy0VADHWaNVMIGIte/h3uwEAhpRFrEtNV+t3
BPdTeS033kIx7Ut6CJ4RujcH7NXh+AQ=
=qX5Y
-----END PGP SIGNATURE-----

--2p5jfpa6mbjjypxo--
