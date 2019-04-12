Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED76C282CE
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 14:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1801920850
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 14:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfDLOMY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:12:24 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:38124 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOMX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 10:12:23 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 9BA4F3C014A;
        Fri, 12 Apr 2019 16:12:19 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hv4hAqIRyFng; Fri, 12 Apr 2019 16:12:09 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 2EBA33C0149;
        Fri, 12 Apr 2019 16:12:09 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 12 Apr
 2019 16:12:08 +0200
Date:   Fri, 12 Apr 2019 16:12:05 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "George G. Davis" <george_davis@mentor.com>,
        <linux-media@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        <harsha.manjulamallikarjun@in.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
Message-ID: <20190412141205.GA17075@vmlxhi-102.adit-jv.com>
References: <20190405161639.GA10433@vmlxhi-102.adit-jv.com>
 <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
 <20190408111241.GF15350@bigcity.dyn.berto.se>
 <df6fa3bf-bf21-50b0-2cad-a613e2a43ce0@gmail.com>
 <20190409205745.GB9750@pendragon.ideasonboard.com>
 <3c2c2d04-8028-3511-aba0-0ea6dd5bdc50@mentor.com>
 <20190409225948.GD9750@pendragon.ideasonboard.com>
 <69091709-a63f-6a11-4b4b-13fcf8d3e40a@gmail.com>
 <20190411202819.GA8006@vmlxhi-102.adit-jv.com>
 <20190411204237.GH30887@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411204237.GH30887@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Niklas,

On Thu, Apr 11, 2019 at 10:42:37PM +0200, Niklas Söderlund wrote:
> Hi Eugenie,
> 
> On 2019-04-11 22:28:19 +0200, Eugeniu Rosca wrote:
> > Hi Niklas,
> > 
> > Two simple questions:
> >  - I can only clone git://git.ragnatech.se/linux, but can't access it on
> >    the web, does it have some web interface?
> 
> There should be a gitweb instance running at https://git.ragnatech.se/ 
> if not let me know since then something is wrong ;-)

Yes, I am able to access the gitweb instance too :)

> 
> >  - Browsing through your v4l2/next/csi2/upport branch, it looks to be
> >    targeted for upstream. Could we rely on those commits already or
> >    they are still in development/testing?
> 
> The patches in that branch are target for upstreaming but sometime 
> changes due to review comments. Best check the media-tree of what have 
> accepted and the patchwork instance if you want day fresh statuses. I 
> also rebase the branch from time to time on-top of the media-tree so you 
> should not depend on it much I'm afraid.
> 
> If you plan to do some work on the rcar-csi2 driver you can always reach 
> out and check what the status is if you are unsure.

Understood. Thanks. Since I've gone off-topic quite a bit already, may I
have your feedback on below questions sitting in the back of my mind for
some time:

 - There seem to be quite a number of non-mainlined rcar-vin patches
   sitting on top of v4.14.75-ltsi and part of rcar-3.9.x release. With
   some false positives, around 35-40 such commits can be identified as
   shown in [1]. Based on my checks, only a small subset of them are
   (actively) discussed in linux-media/linux-renesas-soc ML and for most
   of them I can't find any trace. I am just curious if there is any
   background force driving the upstreaming of those patches or the
   submissions/discussions happen rather by accident?

 - I am seeing two sets of rcar-vin tests [2-3] and I think there is a
   parent/fork relationship between them, but now they appear to be
   diverged. Which one would you recommend? What's the test coverage
   provided by these suites? Do you see room/chance for something like
   drivers/gpu/drm/selftests in rcar-vin in future (maybe using
   the upcoming kunit [4] approach?). BTW, we've been using the
   vsp-tests for quite some time and they've been extremely useful in
   pointing out regressions in our own patches. So, many thanks for
   sharing those too.

> 
> -- 
> Regards,
> Niklas Söderlund

[1] git log --oneline --cherry-pick --right-only \
    torvalds/master...rcar-3.9.4 -- drivers/media/platform/rcar-vin/
[2] https://git.ragnatech.se/vin-tests/
[3] http://jmondi.org/git/vin-tests/
[4] https://patchwork.kernel.org/cover/10704157/

Best regards,
Eugeniu.
