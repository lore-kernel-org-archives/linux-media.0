Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD1C4360F
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 10:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA372082C
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 10:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfDBKNt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:13:49 -0400
Received: from retiisi.org.uk ([95.216.213.190]:37072 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbfDBKNt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 2 Apr 2019 06:13:49 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 1FDF7634C7D;
        Tue,  2 Apr 2019 13:13:16 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hBGPs-0001Nd-UC; Tue, 02 Apr 2019 13:13:16 +0300
Date:   Tue, 2 Apr 2019 13:13:16 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     dorodnic@gmail.com
Cc:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        evgeni.raikhel@intel.com,
        Sergey Dorodnicov <sergey.dorodnicov@intel.com>
Subject: Re: [PATCH] media: Add missing "Auto" option to the power line
 frequency control
Message-ID: <20190402101316.4kli5vqxfkhru33r@valkosipuli.retiisi.org.uk>
References: <1552842085-3439-1-git-send-email-sergey.dorodnicov@intel.com>
 <1552842085-3439-2-git-send-email-sergey.dorodnicov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552842085-3439-2-git-send-email-sergey.dorodnicov@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sergey,

Thanks for the patch.

On Sun, Mar 17, 2019 at 01:01:25PM -0400, dorodnic@gmail.com wrote:
> From: Sergey Dorodnicov <sergey.dorodnicov@intel.com>
> 
> Section 4.2.2.3.6 of the USB Device Class Definition for Video Devices,
> specifies "Auto" as a valid value for the power line frequency control.
> This makes uvcvideo module consistent with control definition inside
> /drivers/media/v4l2-core/v4l2-ctrls.c:
> camera_power_line_frequency[] = {
> 	"Disabled",
> 	"50 Hz",
> 	"60 Hz",
> 	"Auto",
> 
> Signed-off-by: Sergey Dorodnicov <sergey.dorodnicov@intel.com>
> Signed-off-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 14cff91..a85910a 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -358,6 +358,7 @@ static const struct uvc_menu_info power_line_frequency_controls[] = {
>  	{ 0, "Disabled" },
>  	{ 1, "50 Hz" },
>  	{ 2, "60 Hz" },
> +	{ 3, "Auto" },

The auto option appears to have been added by UVC 1.5, so the menu entry
may only be available for such devices.

>  };
>  
>  static const struct uvc_menu_info exposure_auto_controls[] = {

-- 
Kind regards,

Sakari Ailus
