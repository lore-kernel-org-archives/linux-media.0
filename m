Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30D2EB8FD3
	for <linux-media@archiver.kernel.org>; Wed,  6 Sep 2023 13:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbjIFNoa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbjIFNo3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 6 Sep 2023 09:44:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A763ACF1;
        Wed,  6 Sep 2023 06:44:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C7529DE2;
        Wed,  6 Sep 2023 15:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694007775;
        bh=u4Udi0Lh3/ENj11A1kKppoLsDHz9Y54DddubQmo2aOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7bc1uk4DXuH4yd0GClAEj3qP1dWj73gxszSF8o/+J53Rl2++XesBn41s2L54ylVP
         SNZCOlMleMiuE4ckN0SIrIHqQlour1daBPUNTI8+QvIhhoSK0DpR0QBpaktzKcUzlB
         ciklPbA3iPob9lOQVL7NmczZj+Q9XSC5WHewTNw4=
Date:   Wed, 6 Sep 2023 16:44:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: uvcvideo: Fix power line control for a Chicony
 camera
Message-ID: <20230906134435.GA24846@pendragon.ideasonboard.com>
References: <20230817-chicony-v2-1-88335519989d@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817-chicony-v2-1-88335519989d@chromium.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ricardo,

On Tue, Sep 05, 2023 at 03:29:52PM +0000, Ricardo Ribalda wrote:
> The device does not implement the control properly.
> 
> Fixes v4l2-compliance error:
> 
> info: checking control 'Power Line Frequency' (0x00980918)
> fail: v4l2-test-controls.cpp(552): could not set valid menu item 3
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

This still applies :-)

I've taken the patch in my tree and will push it for v6.7.

> ---
> This camera, like other Chicony devices, do not implement properly the
> Power Line Frequency control.
> 
> This time, I do not have direct access to the device, just to the
> report, but since other devices from the same family are showing the
> same error, it is safe to assume that the same fix will work here.
> ---
> Changes in v2:
> - Fix IntefaceProtocol, the camera is uvc1.5
> - I managed to write 0 to the control, so the proper quirk is uvc11 not
>   limited
> - Changes by Laurent:
> 	- Rename device
> 	- s/v4l/v4l2
> - Link to v1: https://lore.kernel.org/r/20230817-chicony-v1-1-76bde4d6ff6b@chromium.org
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..4b5ea3501753 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2592,6 +2592,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> +	/* Chicony Electronics Co., Ltd Integrated Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x04f2,
> +	  .idProduct		= 0xb67c,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
> +	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
>  	/* Chicony EasyCamera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> 
> ---
> base-commit: 4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
> change-id: 20230817-chicony-9c35f2046c6f

-- 
Regards,

Laurent Pinchart
