Return-Path: <SRS0=Zegy=33=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE31C352A2
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830B1214AF
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581065361;
	bh=fKnL2CRr/p3Ynn9BAQKWJZUYND7GexEVpqPugeC15VM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BKHmRjUhXoNI7q1yDHCPQPz/mn1LViSc8NeVjuTX1M2H+xvR/Dis7+K+t+lPHXSLj
	 UMwifZ0drL2DEf0B3adE/pnv5pe8O9Nrh8xrjfTHDIrpjty23bSorrp0QgctrZGf8H
	 lW0sAdu+W/FgfhdHA0jH+gz8n7Z8N3tVNO03wz4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGItS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:49:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGItS (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 7 Feb 2020 03:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=Us37pdecYoKH7QA4vbcTJ9ti0z7m+j/ooX2Qwp3N6o8=; b=e/Wo9YyAYeZcM6e5YoyvZjSD59
        Vd5yc6iK9W8LFcfURu1W/X99XDBLej3tl6AKYdktWTJPqtyEaXAza/mxbeeoxdgn6vAt3kF7ceXJ4
        em8ySnx+GrtMEJnkLqtPQ8Yv3S7nc+73yPUF//V456gVCa4VGBaOJdJDPV+cweHltetuWhmGWZ+pu
        VHihVdXXHQIEji9VNPT0OdET0mRClAAuc2nDkdnBgWLYd19LVj9l/eEw4Awhjfk7YD68m15dBInkL
        ck1019XZDjrFQ0oiTti0eB5F6CMiPXqOm2PyH8Hx8tfj39ktoPScVk5HhPmEAb4eZTq3NT5P9y7EP
        J8O/dm8A==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izzK4-0000nd-Jx; Fri, 07 Feb 2020 08:49:12 +0000
Date:   Fri, 7 Feb 2020 09:49:09 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Josef =?UTF-8?B?TcO2bGxlcnM=?= <josef.moellers@suse.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: go7007: Fix URB type for interrupt handling
Message-ID: <20200207094909.7d5b744d@kernel.org>
In-Reply-To: <20200206154527.18171-1-tiwai@suse.de>
References: <20200206154527.18171-1-tiwai@suse.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu,  6 Feb 2020 16:45:27 +0100
Takashi Iwai <tiwai@suse.de> escreveu:

> Josef reported that his old-and-good Plextor ConvertX M402U video
> converter spews lots of WARNINGs on the recent kernels, and it turned
> out that the device uses a bulk endpoint for interrupt handling just
> like 2250 board.
>=20
> For fixing it, generalize the check with the proper verification of
> the endpoint instead of hard-coded board type check.
>=20
> Fixes: 7e5219d18e93 ("[media] go7007: Fix 2250 urb type")
> Reported-and-tested-by: Josef M=C3=B6llers <josef.moellers@suse.com>
> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=3D1162583
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D206427
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>=20
> ---
>  drivers/media/usb/go7007/go7007-usb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/usb/go7007/go7007-usb.c b/drivers/media/usb/go=
7007/go7007-usb.c
> index ff2aa057c1fb..f889c9d740cd 100644
> --- a/drivers/media/usb/go7007/go7007-usb.c
> +++ b/drivers/media/usb/go7007/go7007-usb.c
> @@ -1044,6 +1044,7 @@ static int go7007_usb_probe(struct usb_interface *i=
ntf,
>  	struct go7007_usb *usb;
>  	const struct go7007_usb_board *board;
>  	struct usb_device *usbdev =3D interface_to_usbdev(intf);
> +	struct usb_host_endpoint *ep;
>  	unsigned num_i2c_devs;
>  	char *name;
>  	int video_pipe, i, v_urb_len;
> @@ -1140,7 +1141,8 @@ static int go7007_usb_probe(struct usb_interface *i=
ntf,
>  	if (usb->intr_urb->transfer_buffer =3D=3D NULL)
>  		goto allocfail;
> =20
> -	if (go->board_id =3D=3D GO7007_BOARDID_SENSORAY_2250)
> +	ep =3D usb->usbdev->ep_in[4];

Hmm... why [4] above?

I mean, what other drivers do is something like:

	for (i =3D 0; i < intf->num_altsetting; i++) {
	   for (j =3D 0; j < intf->altsetting[i].desc.bNumEndpoints; j++) {
		ep =3D &intf->altsetting[i].endpoint[j].desc;
		/* some logic to check ep and change alt if needed */
	   }
        }

> +	if (usb_endpoint_type(&ep->desc) =3D=3D USB_ENDPOINT_XFER_BULK)
>  		usb_fill_bulk_urb(usb->intr_urb, usb->usbdev,
>  			usb_rcvbulkpipe(usb->usbdev, 4),
>  			usb->intr_urb->transfer_buffer, 2*sizeof(u16),




Cheers,
Mauro
