Return-Path: <SRS0=XB3O=EL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58924C55178
	for <linux-media@archiver.kernel.org>; Thu,  5 Nov 2020 18:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063D12151B
	for <linux-media@archiver.kernel.org>; Thu,  5 Nov 2020 18:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgKES6t (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:58:49 -0500
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:53966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgKES6t (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 5 Nov 2020 13:58:49 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 110091802914B;
        Thu,  5 Nov 2020 18:58:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fall10_5f020ee272cc
X-Filterd-Recvd-Size: 3471
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Nov 2020 18:58:46 +0000 (UTC)
Message-ID: <92c85080ad6e1ded9c15479efe79a7eb7b0c7ee2.camel@perches.com>
Subject: Re: [PATCH v2 1/7] media: uvcvideo: Use pr_cont() macro
From:   Joe Perches <joe@perches.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 05 Nov 2020 10:58:45 -0800
In-Reply-To: <CANiDSCt8twP=JTkGjSVKdDwRhuHb7Jkv+=08U6oFdGtAjtrELw@mail.gmail.com>
References: <20201104180734.286789-1-ribalda@chromium.org>
         <20201104180734.286789-2-ribalda@chromium.org>
         <87769d554b4575bf9371380b013e66d70f1b21c4.camel@perches.com>
         <20201104214201.GH29958@pendragon.ideasonboard.com>
         <9d439214e8c83ebf7b93dccca2f848fbaf75b9d4.camel@perches.com>
         <CANiDSCvwvQUTt1QMQGGyZPag9VeHj4Ugmj8QJdBNtw00UNt6Pg@mail.gmail.com>
         <a00078e1311c09361e9e3357ba5dca037d7a8bff.camel@perches.com>
         <CANiDSCteVWin-Yy2ZVSMUJBPvJ-F0Ti+fEpi26apsDW0XXrpwg@mail.gmail.com>
         <79cad1a6a296761e672cfb0d85e7424fcb740032.camel@perches.com>
         <CANiDSCt8twP=JTkGjSVKdDwRhuHb7Jkv+=08U6oFdGtAjtrELw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2020-11-05 at 10:50 +0100, Ricardo Ribalda wrote:
> Hi Joe

Rehi Ricardo.
 
> On Thu, Nov 5, 2020 at 12:59 AM Joe Perches <joe@perches.com> wrote:
> > It looks as if all the pr_cont uses in the code are odd and repetitive.
> > 
> > Perhaps it'd be sensible to add something like:
> 
> Looks like a great idea. Queued for my v3
> 
> https://github.com/ribalda/linux/commit/1623b648331d7f69c8a9f6b199e119f6c8ee61c6
> 
> I let Laurent decide if we should squash with the previous patch or not.
> 
> Thanks!
> 
> > 
> > #define uvc_trace_cont(flag, fmt, ...)                                  \
> > do {                                                                    \
> >         if (uvc_trace_param & (flag))                                   \
> >                 pr_cont(fmt, ##__VA_ARGS__);                            \
> > } while (0)
> > 
> > and change all the uses like:
> > 
> > -               if (uvc_trace_param & UVC_TRACE_PROBE)
> > -                       printk(KERN_CONT " <- SU %d", entity->id);
> > +               uvc_trace_cont(UVC_TRACE_PROBE, " <- SU %d", entity->id);
> > 

While I know the only uses of uvc_trace_cont are with UVC_TRACE_PROBE,
there are other existing uvc_trace(flag, ...) uses.

I think the uvc_trace_cont mechanism should require a flag and not
assume UVC_TRACE_PROBE so it's possible, even though currently unused,
for other uvc_trace calls to be continued.

$ git grep -Poh '\buvc_trace\(\w+' drivers/media | sort | uniq -c
      1 uvc_trace(flag
      6 uvc_trace(UVC_TRACE_CALLS
      1 uvc_trace(UVC_TRACE_CAPTURE
      2 uvc_trace(UVC_TRACE_CLOCK
     15 uvc_trace(UVC_TRACE_CONTROL
     42 uvc_trace(UVC_TRACE_DESCR
      6 uvc_trace(UVC_TRACE_FORMAT
     12 uvc_trace(UVC_TRACE_FRAME
      7 uvc_trace(UVC_TRACE_PROBE
      1 uvc_trace(UVC_TRACE_STATS
      6 uvc_trace(UVC_TRACE_STATUS
      4 uvc_trace(UVC_TRACE_SUSPEND
      6 uvc_trace(UVC_TRACE_VIDEO


