Return-Path: <SRS0=ibS4=TA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A4C43219
	for <linux-media@archiver.kernel.org>; Tue, 30 Apr 2019 12:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5D320835
	for <linux-media@archiver.kernel.org>; Tue, 30 Apr 2019 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556627548;
	bh=cYohTiC94hsor/UlXtiau3nZ4ANvQqFDD0hgoNFoZxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oFQcbF/RD6PhVrODrTI5H5ip9FBi08dWeYODxnb98Vi8d2l/KBARKuDf12per/Pjm
	 keMvIvOhC+Xpr/4who3PGvFhOBMK28k3sctpy9LECk1CO9ZY0hPN9d7v0mSDOvQw8v
	 HlHVnk+oiPPvKFO1hVPcUexxjF10p8WEoKK1N08M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfD3Mc1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:32:27 -0400
Received: from casper.infradead.org ([85.118.1.10]:49524 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3Mc1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 30 Apr 2019 08:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=etMO82D5DKeYgWLp4/yrF2Joo/sxqEqWZEvenjMVkcY=; b=kkckXcbH8cEcueGe9Z3+t+4c8E
        990SSyCbC23C9+x6Fa3zaF4vM2hCyZgmx0JG6R9U9HtYrM37f08qnZc0fytI624JW9NQZ7GcgO274
        b7x/4JLmIvAgyGiwFuqQVB1Bw94/U2vVXYWfgh0zxUe5kX/QJGhoE1lx91R+BEvFmo+DkW2AgCSWY
        yVzKXeEVom1FzimPnf/U48ni+DB0ib3qWDgSbg2h9RCxUKcKl+M/3cxqFDqn9M+MQfax2dC3ddEHy
        LCuuP14Z0bEaHn++loS4jC0dOJh7OdH4xJFyN1QGS6AdPRstfZdWcQZxv/MrWKIr0njJdjNWmnfzQ
        Jf5CTPKA==;
Received: from [179.179.39.157] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLRvt-00031U-4c; Tue, 30 Apr 2019 12:32:25 +0000
Date:   Tue, 30 Apr 2019 09:32:21 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCHv3] dvb: usb: fix use after free in dvb_usb_device_exit
Message-ID: <20190430093221.22c18c21@coco.lan>
In-Reply-To: <20190430121607.4279-1-oneukum@suse.com>
References: <20190430121607.4279-1-oneukum@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 30 Apr 2019 14:16:07 +0200
Oliver Neukum <oneukum@suse.com> escreveu:

> dvb_usb_device_exit() frees and uses the device name in that order
> Fix by storing the name in a buffer before freeing it
> 
> v2: fixed style issues
> v3: strscpy used and variable names changed
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Reported-by: syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com
> ---
>  drivers/media/usb/dvb-usb/dvb-usb-init.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> index 99951e02a880..48d17736db5d 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> @@ -287,12 +287,15 @@ EXPORT_SYMBOL(dvb_usb_device_init);
>  void dvb_usb_device_exit(struct usb_interface *intf)
>  {
>  	struct dvb_usb_device *d = usb_get_intfdata(intf);
> -	const char *name = "generic DVB-USB module";
> +	const char *default_name = "generic DVB-USB module";
> +	char name[40];
>  
>  	usb_set_intfdata(intf, NULL);
>  	if (d != NULL && d->desc != NULL) {
> -		name = d->desc->name;
> +		strscpy(name, d->desc->name, sizeof(name));
>  		dvb_usb_exit(d);
> +	} else {
> +		memcpy(name, default_name, sizeof(name));

Please use strscpy() here too, as we're using it everywhere 
when a string requires copy inside media.

>  	}
>  	info("%s successfully deinitialized and disconnected.", name);
>  



Thanks,
Mauro
