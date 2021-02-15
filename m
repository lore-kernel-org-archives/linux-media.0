Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E788BC433E6
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 16:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36C564E02
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 16:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhBOQ6c (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:58:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:49898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhBOQ5O (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Feb 2021 11:57:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613408187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sk8qUrPJZWxKa/TvMeFDlCqiCauZmvQznULXwnUKwQQ=;
        b=Qpp87nDLCMujBlD0Vj2Nz+5mlV6Bj2a/8bDSjHnP3Hu2p61LPT9F9/fZEwZwLig3xnJGQL
        XIvmqR7XcGQCSdiT2d1O4raUauBf8bpqReAMql93HNnIVEncxdC0aXnX5ImoJpjHNv2/GS
        hnEkVr6wlZQA4Aelm2v3E2goC5oeZoE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B94ADACD9;
        Mon, 15 Feb 2021 16:56:27 +0000 (UTC)
Date:   Mon, 15 Feb 2021 17:56:27 +0100
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
Subject: Re: [PATCH v7 2/3] v4l: ioctl: Use %p4cc printk modifier to print
 FourCC codes
Message-ID: <YCqnu61J2Q8rsrZa@alley>
References: <20210215114030.11862-1-sakari.ailus@linux.intel.com>
 <20210215114030.11862-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215114030.11862-3-sakari.ailus@linux.intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon 2021-02-15 13:40:29, Sakari Ailus wrote:
> Now that we can print FourCC codes directly using printk, make use of the
> feature in V4L2 core.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am curious whether I could take this via printk tree or if Mauro
would prefer to take this via his tree.

Anyway, there will be v8 with small changes in the 1st patch.

Best Regards,
Petr
