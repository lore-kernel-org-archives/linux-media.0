Return-Path: <SRS0=XB3O=EL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1026BC388F7
	for <linux-media@archiver.kernel.org>; Thu,  5 Nov 2020 00:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73F120867
	for <linux-media@archiver.kernel.org>; Thu,  5 Nov 2020 00:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbgKEAAf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:00:35 -0500
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:59096 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732923AbgKDX7O (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 4 Nov 2020 18:59:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2A868181D3039;
        Wed,  4 Nov 2020 23:59:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rake48_560ecb1272c5
X-Filterd-Recvd-Size: 2627
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Nov 2020 23:59:12 +0000 (UTC)
Message-ID: <79cad1a6a296761e672cfb0d85e7424fcb740032.camel@perches.com>
Subject: Re: [PATCH v2 1/7] media: uvcvideo: Use pr_cont() macro
From:   Joe Perches <joe@perches.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 04 Nov 2020 15:59:10 -0800
In-Reply-To: <CANiDSCteVWin-Yy2ZVSMUJBPvJ-F0Ti+fEpi26apsDW0XXrpwg@mail.gmail.com>
References: <20201104180734.286789-1-ribalda@chromium.org>
         <20201104180734.286789-2-ribalda@chromium.org>
         <87769d554b4575bf9371380b013e66d70f1b21c4.camel@perches.com>
         <20201104214201.GH29958@pendragon.ideasonboard.com>
         <9d439214e8c83ebf7b93dccca2f848fbaf75b9d4.camel@perches.com>
         <CANiDSCvwvQUTt1QMQGGyZPag9VeHj4Ugmj8QJdBNtw00UNt6Pg@mail.gmail.com>
         <a00078e1311c09361e9e3357ba5dca037d7a8bff.camel@perches.com>
         <CANiDSCteVWin-Yy2ZVSMUJBPvJ-F0Ti+fEpi26apsDW0XXrpwg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2020-11-05 at 00:01 +0100, Ricardo Ribalda wrote:
> Hi Joe
> 
> On Thu, Nov 5, 2020 at 12:00 AM Joe Perches <joe@perches.com> wrote:
> > 
> > On Wed, 2020-11-04 at 23:31 +0100, Ricardo Ribalda wrote:
> > 
> > > I have updated my tree with the dev_ variants
> > > 
> > > https://github.com/ribalda/linux/commit/b8785fd8efb4f2e5bbf5d0f2df3e0d69a5439015
> > 
> > I looked at this link and was confused so you made me look.
> > I think you meant:
> > 
> > https://github.com/ribalda/linux/commit/83cb6eb3a9f7bd1954acbfb4fb3d56ddf54bce73
> 
> Yes, thanks :) Sorry about that
> 
> This is why I should be away from a keyboard after 23:00 :)

Sleep is good.
There are lots of sleep deprived people here in the US today though.

It looks as if all the pr_cont uses in the code are odd and repetitive.

Perhaps it'd be sensible to add something like:

#define uvc_trace_cont(flag, fmt, ...)					\
do {									\
	if (uvc_trace_param & (flag))					\
		pr_cont(fmt, ##__VA_ARGS__);				\
} while (0)

and change all the uses like:

-               if (uvc_trace_param & UVC_TRACE_PROBE)
-                       printk(KERN_CONT " <- SU %d", entity->id);
+               uvc_trace_cont(UVC_TRACE_PROBE, " <- SU %d", entity->id);


