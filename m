Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354AEC4360F
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 11:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B4A20882
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 11:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gs/O8yE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDBLlO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:41:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60150 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDBLlO (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Apr 2019 07:41:14 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE61A2F9;
        Tue,  2 Apr 2019 13:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554205272;
        bh=NQkBg1LNQ5esqD/y0TU09l1EO/NmN9Teb+0xvYBVFrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gs/O8yE8sdmrUHolSLv0umcmyT/RO2bTe6cMLXtJ+Ss6K9OVDM96pwfczb4en16Eg
         fKDOSlT1KcnUUCbWWc0TuSaAUz3HDMJcYDyMUpX2OFJ5rPIjF2d7bNNsrz2knGpMCY
         5m1Hq/ESMSJD9lGtbddP8Ai35Nh6BN9pE7Tyo/ig=
Date:   Tue, 2 Apr 2019 14:41:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Salvador =?utf-8?Q?Fern=C3=A1ndez?= <moltitronico@gmail.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 0/0] media: uvcdriver: add support for Chicony HP Full-HD
 Camera (04f2:b62f)
Message-ID: <20190402114102.GU4805@pendragon.ideasonboard.com>
References: <CAD4B5T8kxWOcEVZVop=u2k1G0wHFv0LSLwbe+MDQ3q-Be5hcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD4B5T8kxWOcEVZVop=u2k1G0wHFv0LSLwbe+MDQ3q-Be5hcOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Salvador,

Thank you for the patch.

On Mon, Apr 01, 2019 at 05:47:26PM +0200, Salvador Fernández wrote:
> Hi developers,
> 
> A very simple patch to add support for newer HP Full-HD Camera.
> Pgp key for signature is
> http://keys.gnupg.net/pks/lookup?op=get&search=0x93360317E5CECDDA

Please see Documentation/process/submitting-patches.rst in the kernel
sources for an explanation on how to submit patches. Your patch needs to
include a Signed-off-by line. I advice using git-send-email to send it
out if you can, as that solves lots of issues with e-mail clients.

Please see below for a few comments.

> Thanks a lot for your work,

You're welcome.

> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 10cfe8e51626..ee9c72543c11 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2510,6 +2510,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_FRAME_RATE) },
> +        /* Chicony HP Full-HD Camera (04f2:b62f) */
> +        { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                                | USB_DEVICE_ID_MATCH_INT_INFO,
> +          .idVendor             = 0x04f2,
> +          .idProduct            = 0xb62f,
> +          .bInterfaceClass      = USB_CLASS_VIDEO,
> +          .bInterfaceSubClass   = 1,
> +          .bInterfaceProtocol   = 0,
> +          .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_FRAME_RATE) },

Is this quirk needed ? What happens if you don't specify it ? What
happens if the whole device entry isn't added, does the uvcvideo driver
print error messages to the kernel log ?

>  	/* Alcor Micro AU3820 (Future Boy PC USB Webcam) */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,


-- 
Regards,

Laurent Pinchart
