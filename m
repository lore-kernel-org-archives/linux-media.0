Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61897C433DB
	for <linux-media@archiver.kernel.org>; Thu, 24 Dec 2020 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24782224B0
	for <linux-media@archiver.kernel.org>; Thu, 24 Dec 2020 13:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgLXNvW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 24 Dec 2020 08:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLXNvV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 24 Dec 2020 08:51:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FADEC061794;
        Thu, 24 Dec 2020 05:50:41 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 015A7A1D;
        Thu, 24 Dec 2020 14:50:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608817837;
        bh=IP/ZvkSmZQ0efnEqwjeW+tZECf17c54ebNNW8CBkRck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwMgYFYL6VHrvkgXDMhuQ3YHPVbAihS+8Y5Pye7vJD4pvootx/j2ot1d/27E64frb
         7QGqLmveNV54hQSvgBkrVapBY+zsn9vu4rMuBIGHLKnwD72ZLBCrEJt4YBLK8J6Y3v
         WxxOTqYHUsRMsUx+4UXg+yDVNg6lWNFgQ4pKAEgM=
Date:   Thu, 24 Dec 2020 15:50:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 08/12] media: uvcvideo: Use dev_ printk aliases
Message-ID: <X+ScpMyiKFqhySG6@pendragon.ideasonboard.com>
References: <20201223133528.55014-1-ribalda@chromium.org>
 <20201223133528.55014-9-ribalda@chromium.org>
 <CAHp75VeTWUGF0huwLm9OPkDpDiDJ8vtG0W2jzoDohWEfB+L3yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VeTWUGF0huwLm9OPkDpDiDJ8vtG0W2jzoDohWEfB+L3yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Andy,

On Thu, Dec 24, 2020 at 02:59:34PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 23, 2020 at 3:39 PM Ricardo Ribalda wrote:
> >
> > Replace all the uses of printk() and uvc_printk() with its
> > equivalent dev_ alias macros.
> 
> > Modify uvc_warn_once() macro to use dev_info instead printk().
> 
> ...
> 
> > +#define uvc_warn_once(_dev, warn, fmt, ...)                            \
> > +do {                                                                   \
> > +       if (!test_and_set_bit(warn, &(_dev)->warnings))                 \
> > +               dev_info(&(_dev)->udev->dev, fmt, ##__VA_ARGS__);       \
> > +} while (0)
> 
> ...
> 
> Why not to use dev_warn_once() instead?

uvc_warn_once() prints the warning once per device, not once globally.

-- 
Regards,

Laurent Pinchart
