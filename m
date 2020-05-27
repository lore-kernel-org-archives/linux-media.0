Return-Path: <SRS0=QBGf=7J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA94C433E0
	for <linux-media@archiver.kernel.org>; Wed, 27 May 2020 15:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83950207CB
	for <linux-media@archiver.kernel.org>; Wed, 27 May 2020 15:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbgE0PGI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 27 May 2020 11:06:08 -0400
Received: from gofer.mess.org ([88.97.38.141]:51467 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389316AbgE0PGH (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 27 May 2020 11:06:07 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 438CEC635E; Wed, 27 May 2020 16:06:06 +0100 (BST)
Date:   Wed, 27 May 2020 16:06:06 +0100
From:   Sean Young <sean@mess.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] media: rc: add support for Infrared Toy and IR
 Droid devices
Message-ID: <20200527150606.GA18902@gofer.mess.org>
References: <20200527094107.11936-1-sean@mess.org>
 <20200527094107.11936-2-sean@mess.org>
 <1590578201.2838.69.camel@suse.com>
 <20200527122822.GA14488@gofer.mess.org>
 <1590584422.2838.76.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590584422.2838.76.camel@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On Wed, May 27, 2020 at 03:00:22PM +0200, Oliver Neukum wrote:
> Am Mittwoch, den 27.05.2020, 13:28 +0100 schrieb Sean Young:
> > > This violates the DMA coherency rules. The buffers must be
> > > allocated separately with kmalloc().
> > 
> > Right, I'll fix this and send out a v3. There are other usb drivers in
> > drivers/media/rc/.. that break this rule too.
> 
> Unfortunately.

Yes, I'll go through them in the near future and makes fixes based on this
thread -- thanks!


Sean
