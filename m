Return-Path: <SRS0=7+ZA=Y4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54DACA9EC9
	for <linux-media@archiver.kernel.org>; Mon,  4 Nov 2019 22:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F57217F5
	for <linux-media@archiver.kernel.org>; Mon,  4 Nov 2019 22:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="myTmnHU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbfKDWDd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:03:33 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:34726 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389517AbfKDWDc (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 4 Nov 2019 17:03:32 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C5BB52C;
        Mon,  4 Nov 2019 23:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1572905010;
        bh=h3KXRmtDEIdlXTcsCYsoYkoTUu6/37PyFCoRR/oW8N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myTmnHU8Ci+cJErtmEM//B1xxSGcmLBdlo7ii6ugRS4UdrfuMqNT5eaWrXi3utiv2
         9fJQj0qojfeyusRiS7CwSwliiSZu+j8Y8aaFLwWe6PgVzBYOyLJ8p2ochPbDLjfBx7
         42o5A0PDGBBghHRtlpv9Ae52ZSr5BnjjWGBCGLZk=
Date:   Tue, 5 Nov 2019 00:03:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] media: i2c: IMX296 camera sensor driver
Message-ID: <20191104220323.GH4913@pendragon.ideasonboard.com>
References: <20191031132309.10965-1-laurent.pinchart@ideasonboard.com>
 <20191101145246.GA13101@Mani-XPS-13-9360>
 <20191104134206.GC4913@pendragon.ideasonboard.com>
 <CAL_Jsq+R-ndA5s93uXam1F8Bjm=SPV6z1BQvdMGzfHkyYPd2Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+R-ndA5s93uXam1F8Bjm=SPV6z1BQvdMGzfHkyYPd2Hw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Rob,

On Mon, Nov 04, 2019 at 03:08:57PM -0600, Rob Herring wrote:
> On Mon, Nov 4, 2019 at 7:42 AM Laurent Pinchart wrote:
> > On Fri, Nov 01, 2019 at 08:22:46PM +0530, Manivannan Sadhasivam wrote:
> > > Hi Laurent,
> > >
> > > Thanks for the improved version of the driver. I haven't tested it on
> > > my setup yet. Once I do, I'll add a Tested-by tag.
> > >
> > > I just have few minor commments on top of Sakari's review. Overall it
> > > looks good.
> > >
> > > On Thu, Oct 31, 2019 at 03:23:09PM +0200, Laurent Pinchart wrote:
> > > > The IMX296LLR is a monochrome 1.60MP CMOS sensor from Sony. The driver
> > > > supports cropping and binning (but not both at the same time due to
> > > > hardware limitations) and exposure, gain, vertical blanking and test
> > > > pattern controls.
> > > >
> > > > Preliminary support is also included for the color IMX296LQR sensor.
> > > >
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > ---
> 
> > > > +   imx->reset = devm_gpiod_get_optional(&client->dev, "reset",
> > > > +                                        GPIOD_OUT_HIGH);
> > > > +   if (IS_ERR(imx->reset)) {
> > > > +           if (PTR_ERR(imx->reset) != -EPROBE_DEFER)
> > > > +                   dev_err(&client->dev, "failed to get xclr gpio (%ld)\n",
> > >
> > > If you want to keep device specific naming for resources, I'd suggest using
> > > `xclr` instead of `reset` in DT itself.
> >
> > For GPIOs I think there's an overall consensus that standard names are
> > preferred, while I don't think this applies to clocks. It's a bit of a
> > grey area though, so I'm open to change on or the other.
> >
> > Rob, any preference ?
> 
> If in fact that's a reset, then yes, use 'reset-gpios'. 'xclr' is an
> unusual name though.

Vendors are always inventive :-)

How about clock names ? Do you think they should be standardized too,
should we decide on a name for the main functional clock, or should we
use the pin name ?

-- 
Regards,

Laurent Pinchart
