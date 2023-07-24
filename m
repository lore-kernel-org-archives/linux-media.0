Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD8C001DF
	for <linux-media@archiver.kernel.org>; Mon, 24 Jul 2023 14:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGXOD1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 Jul 2023 10:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGXOD1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 Jul 2023 10:03:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128DBE53;
        Mon, 24 Jul 2023 07:03:26 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:580::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7CEBD66070F8;
        Mon, 24 Jul 2023 15:03:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690207404;
        bh=CNNPojrBe3GA3r7vdLKDeTK/xNBXO1fhCqhqF3pFqnY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=huBFHz/NfJne0+D5ND0Q6u0orbbn4VkeBRCpEa0aAJXHQ99o6YdbyTVv0/z+gfUAU
         ygPL0RGKgu2zokA7gzKvgHFQOiYL6kxLCpoVLO18E+AF98XiKCN/NBqzhu22cK0ZDO
         KBXz6q9pBBx+FiUG7LQmHQEDf881uUTBuO625J+48BXpcoV9bZA7qrCeY186pBsE2s
         huJ3WDnYDPj/YOTVV0AbGDSAdaWAquJRIfQs+1WJwWaXqeBpkW1id36y8Y3AxaGQLs
         GQvBncsNndDg+aYeNcI9xSit/7tZywiDkMIk5kFhkZst+tgOJR8S9jsHihb4w9iqHY
         gAxc7Bnp9NhWw==
Message-ID: <c6a222be5eee962581cf5dcb9a1473cf45ff303c.camel@collabora.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Michael Grzeschik <mgr@pengutronix.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Mon, 24 Jul 2023 10:03:12 -0400
In-Reply-To: <20230721181951.GL12001@pengutronix.de>
References: <ZK2NiQd1KnraAr20@aptenodytes>
         <20230721181951.GL12001@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Le vendredi 21 juillet 2023 =C3=A0 20:19 +0200, Michael Grzeschik a =C3=A9c=
rit=C2=A0:
> > As a result, we cannot expect that any given encoder is able to produce=
 frames
> > for any set of headers. Reporting related constraints and limitations (=
beyond
> > profile/level) seems quite difficult and error-prone.
> >=20
> > So it seems that keeping header generation in-kernel only (close to whe=
re the
> > hardware is actually configured) is the safest approach.
>=20
> For the case with the rkvenc, the headers are also not created by the
> kernel driver. Instead we use the gst_h264_bit_writer_sps/pps functions
> that are part of the codecparsers module.

One level of granularity we can add is split headers (like SPS/PPS) and
slice/frame headers. It remains that in some cases, like HEVC, when the sli=
ce
header is byte aligned, it can be nice to be able to handle it at applicati=
on
side in order to avoid limiting SVC support (and other creative features) b=
y our
API/abstraction limitations. I think a certain level of "per CODEC" reasoni=
ng is
also needed. Just like, I would not want to have to ask the kernel to gener=
ate
user data SEI and other in-band data.

regards,
Nicolas
