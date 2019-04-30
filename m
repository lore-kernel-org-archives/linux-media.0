Return-Path: <SRS0=ibS4=TA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDD8C43219
	for <linux-media@archiver.kernel.org>; Tue, 30 Apr 2019 11:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3C920675
	for <linux-media@archiver.kernel.org>; Tue, 30 Apr 2019 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556623788;
	bh=MUvE4ySkPzKAUnd62vNEHwBqXeNB6l4YkYR77AEHhas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OGqnWi6ardX+KirHgJnExEUkyn9uSFDGz9BP5oP6/lrvO8Gu9cW9rkVccNRXJ/DZ7
	 x0z2ywUoxIYIO525hWBbAlNjUyGKLIL496MyfLd6LWaSqjxZuPXaSeo74LumEz8FUy
	 vsjz3bv1CZ1mMts7wMb/ShHdESa3cqpJgrHN0jTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfD3L3s (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:29:48 -0400
Received: from casper.infradead.org ([85.118.1.10]:42834 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfD3L3r (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 30 Apr 2019 07:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1BO1lcxgWswL5KnO+dbIXBf54H5L4BjWIrNuiE+lbqI=; b=E2vGxiqEmj/MuL4OvEqoRsAY0d
        vcGhc98UKTXPTX/uZtzg2JNA8uxwpQc3lyJav6Iw8riiwRXwIOniohjgiVwrctzN2p2um64hW1I95
        jvGRoKv6lrksMLQ8I/gaZy6ToLk2ilDMqL5iyboHFhstV1bVBNk2YrWo0wDiA2HKjDnmqaPcSyroz
        9B6v5lcGs1xJWVUi5mzm+Igp+Yq7cqEZR5Ak/rX917QMYfl/rHVgGbPedzNVh7RTF2N2ZQjWKgyGl
        yObCldeJDkZsuzha/hUWhN32jx2z000rJrUwWZMpd9tNy2fo9/DyyhUQF1k1IfgBKXvZRLuCWkHDW
        /FKseuQQ==;
Received: from [179.179.39.157] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQxE-0000WV-IG; Tue, 30 Apr 2019 11:29:45 +0000
Date:   Tue, 30 Apr 2019 08:29:39 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCHv2] dvb: usb: fix use after free in dvb_usb_device_exit
Message-ID: <20190430082939.6e89ec41@coco.lan>
In-Reply-To: <20190430104358.8526-1-oneukum@suse.com>
References: <20190430104358.8526-1-oneukum@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 30 Apr 2019 12:43:58 +0200
Oliver Neukum <oneukum@suse.com> escreveu:

> dvb_usb_device_exit() frees and uses the device name in that order
> Fix by storing the name in a buffer before freeing it
> 
> v2: fixed style issues
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Reported-by: syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com
> ---
>  drivers/media/usb/dvb-usb/dvb-usb-init.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> index 99951e02a880..959bbdad8f00 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> @@ -288,13 +288,18 @@ void dvb_usb_device_exit(struct usb_interface *intf)
>  {
>  	struct dvb_usb_device *d = usb_get_intfdata(intf);
>  	const char *name = "generic DVB-USB module";

I would change this to default_name;

> +	char identifier[40];

And use name here, instead of identifier.

IMO, this makes easier to understand the code, as it is a common practice
to call "name" for such kind of var.

>  
>  	usb_set_intfdata(intf, NULL);

>  	if (d != NULL && d->desc != NULL) {
>  		name = d->desc->name;
> +		memcpy(identifier, name, 39);
> +		identifier[39] = 0;

Please use instead (considering the rename I proposed before):

	strscpy(name, d->desc->name, sizeof(name));

>  		dvb_usb_exit(d);
> +	} else {
> +		memcpy(identifier, name, 39);

And here:

	strscpy(name, default_name, sizeof(name));

>  	}

> -	info("%s successfully deinitialized and disconnected.", name);
> +	info("%s successfully deinitialized and disconnected.", identifier);

Dropping this change.

>  
>  }
>  EXPORT_SYMBOL(dvb_usb_device_exit);



Thanks,
Mauro
