Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B42C433FE
	for <linux-media@archiver.kernel.org>; Tue,  1 Mar 2022 12:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiCAMUH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 1 Mar 2022 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiCAMUG (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 1 Mar 2022 07:20:06 -0500
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E2A56C2C;
        Tue,  1 Mar 2022 04:19:22 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id D81C1C3F2A54;
        Tue,  1 Mar 2022 13:19:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D81C1C3F2A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1646137161; bh=kSabZj2uSQjgkFczSZMvF3bJRihRCuN2IOOpNDYapls=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=npohYuiYKQrXVL3bxAXH92cQ4bKwu1JU2dbQkAHuNe2mbrOCzB4CGM7rSyiUvFgRi
         00EWp3RezZb3EjsKrDNR0lV6Q7xFr80zE3T/6Zh2dj7UkGMlu4y8y4KfYtB54dAlxX
         9Qnl2Rvf+QHYzZlTkCE9cMR7N7CVV+291V3beeIM=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 2/2] Driver for ON Semi AR0521 camera sensor
References: <m3czl9eylt.fsf@t19.piap.pl> <m34k6leyb1.fsf@t19.piap.pl>
        <20220109153439.bfnfigocaeeeghmp@uno.localdomain>
        <m35yp387n4.fsf@t19.piap.pl>
        <20220301090132.g5xsodoeotcm6h2q@uno.localdomain>
Sender: khalasa@piap.pl
Date:   Tue, 01 Mar 2022 13:19:20 +0100
In-Reply-To: <20220301090132.g5xsodoeotcm6h2q@uno.localdomain> (Jacopo Mondi's
        message of "Tue, 1 Mar 2022 10:01:32 +0100")
Message-ID: <m3czj57tmf.fsf@t19.piap.pl>
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

>> They can. It appears, though, that clusters aren't about controls which
>> can't change independently. Both of the two are written to the hardware
>> at the same time, which appears to be a valid reason to combine them
>> into a cluster.
>
> Is there a reason to write them to hw at the same time ? :)

Sure, they are written in a single merged burst on I2C.

> As it doesn't seem to me you access registers during probe (to
> identify the sensor in example) there's no need to power up the device
> during probe, but should be enough to let runtime_pm do so when
> requested.

Yes, in fact I never try to read anything from the sensor :-)
Unfortunately I'm not sure how to initialize the (possibly nonexistent)
PM without powering it up, cleanly, in all kernel configs. I mean, I can
check if PM failed and power it up "by hand", but it's a bit messy.

Suggestions are welcome, though.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
