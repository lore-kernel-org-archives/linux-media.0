Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D2FC4361B
	for <linux-media@archiver.kernel.org>; Tue, 15 Dec 2020 22:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3092D22582
	for <linux-media@archiver.kernel.org>; Tue, 15 Dec 2020 22:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgLOWIH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:08:07 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:43102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730127AbgLOWHx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 15 Dec 2020 17:07:53 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 55B5F18224D65;
        Tue, 15 Dec 2020 22:07:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jar17_620022f27427
X-Filterd-Recvd-Size: 2324
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 15 Dec 2020 22:07:07 +0000 (UTC)
Message-ID: <75eb199376d65f2c2b4c746ca9be8cfc9f774453.camel@perches.com>
Subject: Re: [PATCH] [media] radio-si470x: remove h from printk format
 specifier
From:   Joe Perches <joe@perches.com>
To:     trix@redhat.com, hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Dec 2020 14:07:05 -0800
In-Reply-To: <20201215213327.2091597-1-trix@redhat.com>
References: <20201215213327.2091597-1-trix@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 2020-12-15 at 13:33 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> See Documentation/core-api/printk-formats.rst.
> 
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
> 
> Standard integer promotion is already done and %hx and %hhx is useless
> so do not encourage the use of %hh[xudi] or %h[xudi].
[]
> diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
[]
> @@ -410,7 +410,7 @@ static int si470x_i2c_probe(struct i2c_client *client)
>  			radio->registers[DEVICEID], radio->registers[SI_CHIPID]);
>  	if ((radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE) < RADIO_FW_VERSION) {
>  		dev_warn(&client->dev,
> -			"This driver is known to work with firmware version %hu,\n",
> +			"This driver is known to work with firmware version %u,\n",
>  			RADIO_FW_VERSION);
>  		dev_warn(&client->dev,
>  			"but the device has firmware version %hu.\n",

Tom?  Do you know why your script missed this %hu?

btw: this would probably better as a single line something like:

		dev_warn(&client->dev,
			 "Firmware version: %u is older than known working version %u\n",
			 radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE
			 RADIO_FW_VERSION);

Also a few lines above is:

	dev_info(&client->dev, "DeviceID=0x%4.4hx ChipID=0x%4.4hx\n",
			radio->registers[DEVICEID], radio->registers[SI_CHIPID])

and these %4.4hx uses are also not changed by this patch.


