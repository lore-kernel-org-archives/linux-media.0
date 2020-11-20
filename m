Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1735DC56201
	for <linux-media@archiver.kernel.org>; Fri, 20 Nov 2020 15:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA19E22201
	for <linux-media@archiver.kernel.org>; Fri, 20 Nov 2020 15:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q/moGA/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgKTP5m (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 20 Nov 2020 10:57:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:51608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbgKTP5m (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 20 Nov 2020 10:57:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605887860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USMB2Oora/OLgO94kKepkF0GaoTAGWU9NisPoIPkkqg=;
        b=q/moGA/bK2sKeDvBbfEkntpJdbns+bY/vXpEOE0JtTKwNwHvuxWKS9RVyq55QbKF/tpv7y
        JABpMkFz69lxH2n+9ym1DvD9OWJTYiHQLxePs8ItANAKq2xetUg1AhTxa7bCeCuhBhnYCe
        PKUwuTmFKMeZGvcANi4Bn4NNQQoZni0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C3AFACBA;
        Fri, 20 Nov 2020 15:57:40 +0000 (UTC)
Date:   Fri, 20 Nov 2020 16:57:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v5 1/1] lib/vsprintf: Add support for printing V4L2 and
 DRM fourccs
Message-ID: <X7fnc+xsVXPg4Op6@alley>
References: <20201113105441.1427-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113105441.1427-1-sakari.ailus@linux.intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri 2020-11-13 12:54:41, Sakari Ailus wrote:
> Add a printk modifier %p4cc (for pixel format) for printing V4L2 and DRM
> pixel formats denoted by fourccs. The fourcc encoding is the same for both
> so the same implementation can be used.
> 
> Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

The last version looks fine to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
