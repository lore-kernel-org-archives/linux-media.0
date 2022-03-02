Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91466C433F5
	for <linux-media@archiver.kernel.org>; Wed,  2 Mar 2022 06:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbiCBGkG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiCBGkF (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 2 Mar 2022 01:40:05 -0500
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661813DDE;
        Tue,  1 Mar 2022 22:39:18 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 89A65C3F2A7E;
        Wed,  2 Mar 2022 07:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 89A65C3F2A7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1646203154; bh=OcVjSJrpbMzkhVX/KDX2bnT/GcEUx0IXPdnnvyHgVkc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lF8TK0mCeRtOLkD+G2tOYdU+4hK0Z/R5AsC3cJJRyZUtyhbgUTpLihWt0xb2BIuKh
         0YAB5xiOal6DrfBQoddS/VtionNS5jMz5gpggna31ad3m2tS6kRzBVCvMHwQoFx03u
         RQ324uVKPAM2UZBYXKXGMCyKIxX7djUNBeuF16EA=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
References: <m3pmn66pie.fsf@t19.piap.pl> <m3h78i6p4t.fsf@t19.piap.pl>
        <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
        <m38rtt7sx7.fsf@t19.piap.pl>
        <20220301143044.2l4vlwbnh5n3g5ng@uno.localdomain>
Sender: khalasa@piap.pl
Date:   Wed, 02 Mar 2022 07:39:14 +0100
In-Reply-To: <20220301143044.2l4vlwbnh5n3g5ng@uno.localdomain> (Jacopo Mondi's
        message of "Tue, 1 Mar 2022 15:30:44 +0100")
Message-ID: <m34k4g7t9p.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Jacopo Mondi <jacopo@jmondi.org> writes:

> The warning suggests to go for
>
>         /*
>          * This when a comment
>          * spans on multiple lines
>          */
>
> instead of
>
>         /* Going for this style when
>            a comment is on multiple lines */
>

That's exactly what I meant (except that it calls it "block comment",
not multiple lines).
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
