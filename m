Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C962BC433E9
	for <linux-media@archiver.kernel.org>; Tue,  2 Feb 2021 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE064E56
	for <linux-media@archiver.kernel.org>; Tue,  2 Feb 2021 19:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhBBThu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbhBBTho (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Feb 2021 14:37:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191E1C061573
        for <linux-media@vger.kernel.org>; Tue,  2 Feb 2021 11:37:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 4732D1F451DF
Message-ID: <d016d339a357e530e8f762905c6729aa8628f5ba.camel@collabora.com>
Subject: Re: [PATCH v2 2/6] media: pxa_camera: Drop the v4l2-clk clock
 register
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Daniel Mack <zonque@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Date:   Tue, 02 Feb 2021 16:36:54 -0300
In-Reply-To: <20210202190756.GD3@valkosipuli.retiisi.org.uk>
References: <20210112194919.50176-1-ezequiel@collabora.com>
         <20210112194919.50176-3-ezequiel@collabora.com>
         <20210202190756.GD3@valkosipuli.retiisi.org.uk>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 2021-02-02 at 21:07 +0200, Sakari Ailus wrote:
> On Tue, Jan 12, 2021 at 04:49:15PM -0300, Ezequiel Garcia wrote:
> > Now that mach-based PXA platforms are registering proper
> > fixed-rate clocks through the CCF, the v4l2-clk clock
> > is no longer required.
> > 
> > Drop this clock, so the driver no longer depends on the
> > legacy v4l2-clk API.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> 
> There was a minor conflict with the recently merged patches. I resolved it
> (second last chunk) here:
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?id=2bd3c6097aaac76c0a7846456820de1ccf48194e>
> 

Looks good.

Thanks,
Ezequiel

