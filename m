Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0688C4360F
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 11:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A580220856
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 11:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bzA6k4K/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfDBLbn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:31:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60032 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbfDBLbm (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Apr 2019 07:31:42 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 60A6F2F9;
        Tue,  2 Apr 2019 13:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554204700;
        bh=3L/LtSaG/Els9QEGlu1MgdSpM69UYRLdGcRxhDekcUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzA6k4K/QmmlTSvCye460wuNKkU3bgJvW9ifP5JBmOR9TTZBxKXQXtc4ov1K3+2BD
         VL4Ky1Dj99YZAM+zDkKZy6g72YtZ9vWs8cjKZOl7oD6aDEr3RALZMfUdWkDSidfKeg
         yE+D1k0jj+Ccn5Zpcvb3j2TQ3HBWLOMsFAinHiks=
Date:   Tue, 2 Apr 2019 14:31:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     dorodnic@gmail.com, linux-media@vger.kernel.org,
        evgeni.raikhel@intel.com,
        Sergey Dorodnicov <sergey.dorodnicov@intel.com>
Subject: Re: [PATCH] media: Add missing "Auto" option to the power line
 frequency control
Message-ID: <20190402113129.GS4805@pendragon.ideasonboard.com>
References: <1552842085-3439-1-git-send-email-sergey.dorodnicov@intel.com>
 <1552842085-3439-2-git-send-email-sergey.dorodnicov@intel.com>
 <20190402101316.4kli5vqxfkhru33r@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190402101316.4kli5vqxfkhru33r@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

On Tue, Apr 02, 2019 at 01:13:16PM +0300, Sakari Ailus wrote:
> On Sun, Mar 17, 2019 at 01:01:25PM -0400, dorodnic@gmail.com wrote:
> > From: Sergey Dorodnicov <sergey.dorodnicov@intel.com>
> > 
> > Section 4.2.2.3.6 of the USB Device Class Definition for Video Devices,
> > specifies "Auto" as a valid value for the power line frequency control.
> > This makes uvcvideo module consistent with control definition inside
> > /drivers/media/v4l2-core/v4l2-ctrls.c:
> > camera_power_line_frequency[] = {
> > 	"Disabled",
> > 	"50 Hz",
> > 	"60 Hz",
> > 	"Auto",
> > 
> > Signed-off-by: Sergey Dorodnicov <sergey.dorodnicov@intel.com>
> > Signed-off-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 14cff91..a85910a 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -358,6 +358,7 @@ static const struct uvc_menu_info power_line_frequency_controls[] = {
> >  	{ 0, "Disabled" },
> >  	{ 1, "50 Hz" },
> >  	{ 2, "60 Hz" },
> > +	{ 3, "Auto" },
> 
> The auto option appears to have been added by UVC 1.5, so the menu entry
> may only be available for such devices.

That's correct. The power_line_frequency_controls array can always
contain the auto entry, but its availability should be conditioned on
the UVC protocol version. The PU_POWER_LINE_FREQUENCY_CONTROL control
unfortunately doesn't support GET_MAX, so we can't get the information
in a generic way by querying the control.

One option to keep the code generic would be to add protocol version
information to the uvc_control_mapping structure, to condition control
information on the protocol version. It could take the form of a [min,
max] version range for instance. Entries that don't set the min and max
versions would be applicable to all versions.

> 
> >  };
> >  
> >  static const struct uvc_menu_info exposure_auto_controls[] = {

-- 
Regards,

Laurent Pinchart
