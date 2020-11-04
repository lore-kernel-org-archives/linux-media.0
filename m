Return-Path: <SRS0=eCLo=EK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE83C4741F
	for <linux-media@archiver.kernel.org>; Wed,  4 Nov 2020 21:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA8520709
	for <linux-media@archiver.kernel.org>; Wed,  4 Nov 2020 21:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgKDVvc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:51:32 -0500
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:55118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726777AbgKDVvc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 4 Nov 2020 16:51:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9427C18224D7B;
        Wed,  4 Nov 2020 21:51:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: quilt95_2215801272c4
X-Filterd-Recvd-Size: 2373
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Nov 2020 21:51:30 +0000 (UTC)
Message-ID: <9d439214e8c83ebf7b93dccca2f848fbaf75b9d4.camel@perches.com>
Subject: Re: [PATCH v2 1/7] media: uvcvideo: Use pr_cont() macro
From:   Joe Perches <joe@perches.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Nov 2020 13:51:29 -0800
In-Reply-To: <20201104214201.GH29958@pendragon.ideasonboard.com>
References: <20201104180734.286789-1-ribalda@chromium.org>
         <20201104180734.286789-2-ribalda@chromium.org>
         <87769d554b4575bf9371380b013e66d70f1b21c4.camel@perches.com>
         <20201104214201.GH29958@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 2020-11-04 at 23:42 +0200, Laurent Pinchart wrote:
> Hi Joe,

Hi Laurent.

> On Wed, Nov 04, 2020 at 11:29:30AM -0800, Joe Perches wrote:
> > On Wed, 2020-11-04 at 19:07 +0100, Ricardo Ribalda wrote:
> > > Replace all the uses of printk(KERN_CONT ... with pr_cont().
> > 
> > Perhaps remove the uvc_printk macro and uses and use the more
> > common pr_fmt and pr_<level> mechanisms.
> 
> I'd actually go for dev_* instead, to give some context. It's fairly
> common to have multiple UVC devices connected to a system, so printing
> the device name would be useful. It can still be wrapped with
> uvc_printk() if we want to wrap the cast from uvc_device to a struct
> device (we should actually try to get the device corresponding to the
> USB interface where available, so we should use uvc_streaming->intf->dev
> where possible, and fallback to uvc_device->udev->dev otherwise), or
> drop the wrapper completely.

Of course yes.  I was not going to look around and update the existing
call sites to find whatever controlling uvc_device * or other struct *
to a real device that exists though.

It's not even clear from the changes that an appropriate pointer to
some struct exists in all the functions.

That's work for someone that knows the actual subsystem and I do not.

cheers, Joe

