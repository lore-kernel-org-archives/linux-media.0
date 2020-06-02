Return-Path: <SRS0=vtOS=7P=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862C6C433E0
	for <linux-media@archiver.kernel.org>; Tue,  2 Jun 2020 09:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669F12072F
	for <linux-media@archiver.kernel.org>; Tue,  2 Jun 2020 09:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgFBJMP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:12:15 -0400
Received: from gofer.mess.org ([88.97.38.141]:45471 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBJMO (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 2 Jun 2020 05:12:14 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 7F91DC642B; Tue,  2 Jun 2020 10:12:13 +0100 (BST)
Date:   Tue, 2 Jun 2020 10:12:13 +0100
From:   Sean Young <sean@mess.org>
To:     Jan Pieter van Woerkom <jp@jpvw.nl>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH] media: dvbsky: MyGica Mini USB sticks: add DVB-(T/C) to
 dvbsky_id_table
Message-ID: <20200602091213.GA11248@gofer.mess.org>
References: <20200601225006.GA2951@jpvw.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601225006.GA2951@jpvw.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Jan Pieter,

On Tue, Jun 02, 2020 at 12:50:06AM +0200, Jan Pieter van Woerkom wrote:
> MyGica Mini USB sticks: add DVB-(T/C) to dvbsky_id_table
> 
> Signed-off-by: Jan Pieter van Woerkom <jp@jpvw.nl>
> ---
> diff -ru a/drivers/media/usb/dvb-usb-v2/dvbsky.c b/drivers/media/usb/dvb-usb-v2/dvbsky.c
> --- a/drivers/media/usb/dvb-usb-v2/dvbsky.c	2020-06-01 01:49:15.000000000 +0200
> +++ b/drivers/media/usb/dvb-usb-v2/dvbsky.c	2020-06-01 21:01:32.287670677 +0200
> @@ -778,16 +778,16 @@
>  		&dvbsky_s960_props, "Terratec Cinergy S2 Rev.4",
>  		RC_MAP_DVBSKY) },
>  	{ DVB_USB_DEVICE(USB_VID_CONEXANT, USB_PID_MYGICA_T230,
> -		&mygica_t230c_props, "MyGica Mini DVB-T2 USB Stick T230",
> +		&mygica_t230c_props, "MyGica Mini DVB-(T/T2/C) USB Stick T230",
>  		RC_MAP_TOTAL_MEDIA_IN_HAND_02) },
>  	{ DVB_USB_DEVICE(USB_VID_CONEXANT, USB_PID_MYGICA_T230C,
> -		&mygica_t230c_props, "MyGica Mini DVB-T2 USB Stick T230C",
> +		&mygica_t230c_props, "MyGica Mini DVB-(T/T2/C) USB Stick T230C",
>  		RC_MAP_TOTAL_MEDIA_IN_HAND_02) },
>  	{ DVB_USB_DEVICE(USB_VID_CONEXANT, USB_PID_MYGICA_T230C_LITE,
> -		&mygica_t230c_props, "MyGica Mini DVB-T2 USB Stick T230C Lite",
> +		&mygica_t230c_props, "MyGica Mini DVB-(T/T2/C) USB Stick T230C Lite",
>  		NULL) },
>  	{ DVB_USB_DEVICE(USB_VID_CONEXANT, USB_PID_MYGICA_T230C2,
> -		&mygica_t230c_props, "MyGica Mini DVB-T2 USB Stick T230C v2",
> +		&mygica_t230c_props, "MyGica Mini DVB-(T/T2/C) USB Stick T230C v2",

I'm not following this. As far as I can make out, only the names have changed?


Sean
