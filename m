Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C8DC433FE
	for <linux-media@archiver.kernel.org>; Fri, 30 Sep 2022 11:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiI3L6q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiI3L6l (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 30 Sep 2022 07:58:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF70C163B6A;
        Fri, 30 Sep 2022 04:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B93A6B82871;
        Fri, 30 Sep 2022 11:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF73C433C1;
        Fri, 30 Sep 2022 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664539118;
        bh=/JoIHc1ggg5bLCw9hLumwmcVr0lErgrgTgM1neJhgu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1964jE1CS3t8aoi147COyGJP5FO/cajz4uYy0Xj71C2pVYIeMo38I21w+iwHDUIta
         AICGqePRLGaQ4eP8V5Zb9dQLRIH9W5YgoMAj6ihDTSKUDSm9cQq+xUdwGIsflcriGj
         +NIkeQUtaX85nTYKmsddJeRnVLdHpS2HU9gyB/WE=
Date:   Fri, 30 Sep 2022 13:58:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     linux-usb@vger.kernel.org, linux-media@vger.kernel.org,
        balbi@kernel.org, laurent.pinchart@ideasonboard.com,
        kernel@pengutronix.de
Subject: Re: [PATCH] usb: gadget: uvc: don't put item still in use
Message-ID: <YzbZ62gq3i4n7Vhx@kroah.com>
References: <20220929144124.1365686-1-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929144124.1365686-1-m.grzeschik@pengutronix.de>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Sep 29, 2022 at 04:41:24PM +0200, Michael Grzeschik wrote:
> With the patch "15a286a0bb08 (usb: gadget: uvc: add v4l2 enumeration api
> calls)" the driver is keeping a list of configfs entries currently
> configured. The list is used in uvc_v4l2 on runtime.
> 
> The driver now is giving back the list item just after it was referenced
> with config_item_put. It also calls config_item_put on uvc_free, which
> is the only and right place to give back the reference. This patch fixes
> the issue by removing the extra config_item_put in uvc_alloc.
> 
> Fixes: 15a286a0bb08 (usb: gadget: uvc: add v4l2 enumeration api calls)

This is not a commit in any of my trees.  Are you sure it's a valid one?

thanks,

greg k-h
