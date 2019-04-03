Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16595C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EE32075E
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN+NhD1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfDCNkZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:40:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35147 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCNkY (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 09:40:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id s39so14976874edb.2
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kl55FoeBils/W/CEbGoW8mstIpzEN8voixzlOHR3PlY=;
        b=PN+NhD1MWGya9OAEq+Im0xvNGTVkPoCKcXxpBBmkzBreAwinVjNVw/+F3y2VqSWdkG
         d21+WmqYiU4su1Pd7HsaJ7mh7PUdeK2ZBZ7D0fEQduXKnHosLYqxMwXShY1/+pixy/6w
         S4AxGIOhKGutX87h9e1jyzZpRpfkrorEtABU+ymx+aUBrFKjGqy5iVnAFnHWaRHHWYvb
         Wv7rieX5u3/O7aCWmeLvcn5k+jj5cQml3Y/ES/LQgRzmBLk64u502YQgO2Xm3lsuoFLx
         Uw9tBpWqN5uU5wDYP9KaXG5RqeCz/2qvNWGpkfyWYdDJ71bv1LqvxvVM9t/dAyPhlI4e
         cn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kl55FoeBils/W/CEbGoW8mstIpzEN8voixzlOHR3PlY=;
        b=IHQbIk8no3mt/vHvrsGVK2QzX1sA9FC/UWIsRoCIgrgWQbl6UGRlhumn66VxhAQrLt
         VKQ6Yx6D9f6uPIdjUQ/V0PHw3ynszrOtl9br6rIJYAq0hSFGT+8w+ErwwOBI8aw28Q4a
         3AZDsPa0UgVSvYJnpGvGxgME5QLTHWjGGaQ1j/2Vs0qL49rq+zJxVwv9G7ci8qIq070y
         GfD46i9Nijh1PaWEskwmP0MMbgvCqatpcmECn4LihoXfZ30bBJzXgsdpKKcS0qsM8nVu
         GD7dfJSTi4XqRrreXf6Q5ivE07iKvBIroFpnf+tXYwCcsfpqCGEFo0AW6xrup599WRYC
         KOdA==
X-Gm-Message-State: APjAAAXzpndEpZAr69dC4RivHWXt24bMt2p6znNvpi4KDRJVpnVmQ9Sf
        WtwX4Mbu16129kYB1LJIT/IW8aeL8YVbCzweD6Iyf6zP
X-Google-Smtp-Source: APXvYqzU68dneArw0apTq7VaXXO7smNFfXvMmO+FYznntw8+YAPg6DD09Yc3PC/EUPbLbRJ6mQXpw8p5/3eqKnLNL7A=
X-Received: by 2002:a05:6402:608:: with SMTP id n8mr51053754edv.136.1554298823167;
 Wed, 03 Apr 2019 06:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAD4B5T8kxWOcEVZVop=u2k1G0wHFv0LSLwbe+MDQ3q-Be5hcOQ@mail.gmail.com>
 <20190402114102.GU4805@pendragon.ideasonboard.com>
In-Reply-To: <20190402114102.GU4805@pendragon.ideasonboard.com>
From:   =?UTF-8?Q?Salvador_Fern=C3=A1ndez?= <moltitronico@gmail.com>
Date:   Wed, 3 Apr 2019 15:40:11 +0200
Message-ID: <CAD4B5T-O+V0De9mzRUGWzVoGwkFcTdAi7rDg=a9MH9tPP7za5g@mail.gmail.com>
Subject: Re: [PATCH 0/0] media: uvcdriver: add support for Chicony HP Full-HD
 Camera (04f2:b62f)
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Laurent,

Sorry for the delay.

El mar., 2 abr. 2019 a las 13:41, Laurent Pinchart
(<laurent.pinchart@ideasonboard.com>) escribi=C3=B3:
>
> Hi Salvador,
>
> Thank you for the patch.
>
> On Mon, Apr 01, 2019 at 05:47:26PM +0200, Salvador Fern=C3=A1ndez wrote:
> > Hi developers,
> >
> > A very simple patch to add support for newer HP Full-HD Camera.
> > Pgp key for signature is
> > http://keys.gnupg.net/pks/lookup?op=3Dget&search=3D0x93360317E5CECDDA
>
> Please see Documentation/process/submitting-patches.rst in the kernel
> sources for an explanation on how to submit patches. Your patch needs to
> include a Signed-off-by line. I advice using git-send-email to send it
> out if you can, as that solves lots of issues with e-mail clients.

Next patch will follow your instructions.

Regarding your requests, I will recompile the kernel three times. One
without the patch, another with it and the last one with the options
that you indicate to me. I will send you the results / logs in each
case.
The only problem I see is that the kernel is 4.9.0-3, the debian stable one=
.

Time to recompile!

>
> Please see below for a few comments.
>
> > Thanks a lot for your work,
>
> You're welcome.
>
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc=
/uvc_driver.c
> > index 10cfe8e51626..ee9c72543c11 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2510,6 +2510,15 @@ static const struct usb_device_id uvc_ids[] =3D =
{
> >         .bInterfaceSubClass   =3D 1,
> >         .bInterfaceProtocol   =3D 0,
> >         .driver_info          =3D UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_FRA=
ME_RATE) },
> > +        /* Chicony HP Full-HD Camera (04f2:b62f) */
> > +        { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                                | USB_DEVICE_ID_MATCH_INT_INFO,
> > +          .idVendor             =3D 0x04f2,
> > +          .idProduct            =3D 0xb62f,
> > +          .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +          .bInterfaceSubClass   =3D 1,
> > +          .bInterfaceProtocol   =3D 0,
> > +          .driver_info          =3D UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_=
FRAME_RATE) },
>
> Is this quirk needed ? What happens if you don't specify it ? What
> happens if the whole device entry isn't added, does the uvcvideo driver
> print error messages to the kernel log ?
>
> >       /* Alcor Micro AU3820 (Future Boy PC USB Webcam) */
> >       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> >                               | USB_DEVICE_ID_MATCH_INT_INFO,
>
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Un saludo,

Salva
