Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9EFC10F0F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 14:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657842175B
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 14:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfDEOpy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:45:54 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:56043 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOpy (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 10:45:54 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 18F3F3C00C4;
        Fri,  5 Apr 2019 16:45:52 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KHQ58wITMpO0; Fri,  5 Apr 2019 16:45:45 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A6BA53C00C3;
        Fri,  5 Apr 2019 16:45:45 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 5 Apr 2019
 16:45:45 +0200
Date:   Fri, 5 Apr 2019 16:45:41 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        <linux-media@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v14,29/33] rcar-vin: add link notify for Gen3
Message-ID: <20190405144541.GA28024@vmlxhi-102.adit-jv.com>
References: <20180414115726.5075-30-niklas.soderlund+renesas@ragnatech.se>
 <20190405141718.GA19980@vmlxhi-102.adit-jv.com>
 <20190405143407.GF23466@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405143407.GF23466@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Niklas,

Appreciate the swift reply. I confirm the splat goes away after applying
the suggested patch. Thanks!

On Fri, Apr 05, 2019 at 04:34:07PM +0200, Niklas Söderlund wrote:
> Hi Eugeniu,
> 
> Thanks for your report, the issue is known and fixed in [1] which is in 
> the media-tree [2] on it's way to mainline.
> 
> 1. d950fd992ef89f39 ("media: rcar-vin: Fix lockdep warning at stream on")
> 2. https://git.linuxtv.org/media_tree.git/

[..]

> > Best regards,
> > Eugeniu.
