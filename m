Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878A6C3526C
	for <linux-media@archiver.kernel.org>; Sun, 20 Dec 2020 11:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FED233F6
	for <linux-media@archiver.kernel.org>; Sun, 20 Dec 2020 11:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgLTLxE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 20 Dec 2020 06:53:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:7600 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbgLTLxE (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 20 Dec 2020 06:53:04 -0500
IronPort-SDR: ulHYCO2sENqJ+OrjUUWBvKKCX+OXJ5cvTsTENy7/wB0QRU3HbQzTV91cSXr2Vx2Yu8WRL6orIf
 6caiIAnqk20A==
X-IronPort-AV: E=McAfee;i="6000,8403,9840"; a="239716628"
X-IronPort-AV: E=Sophos;i="5.78,434,1599548400"; 
   d="scan'208";a="239716628"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 03:51:17 -0800
IronPort-SDR: kdnMBHoC3Ozpv7vbOEMxKmnWpvHex4g2+/g1DWtvC56YBNqyI/nl5QgU3cXyVGVdBtUU3+hqsD
 a8MvPpOnL48w==
X-IronPort-AV: E=Sophos;i="5.78,434,1599548400"; 
   d="scan'208";a="395611472"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 03:51:15 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id B4724203DF; Sun, 20 Dec 2020 13:51:13 +0200 (EET)
Date:   Sun, 20 Dec 2020 13:51:13 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        syzbot <syzbot+1115e79c8df6472c612b@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH 1/1] v4l: ioctl: Fix memory leak in video_usercopy
Message-ID: <20201220115113.GA26370@paasikivi.fi.intel.com>
References: <20201220110651.13432-1-sakari.ailus@linux.intel.com>
 <CAK8P3a3s=yU=PW7zLc4M83DksxAsb=v8r4U6aAySj2-nmeczjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3s=yU=PW7zLc4M83DksxAsb=v8r4U6aAySj2-nmeczjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Sun, Dec 20, 2020 at 12:36:23PM +0100, Arnd Bergmann wrote:
> On Sun, Dec 20, 2020 at 12:06 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > When an IOCTL with argument size larger than 128 that also used array
> > arguments were handled, two memory allocations were made but alas, only
> > the latter one of them was released. This happened because there was only
> > a single local variable to hold such a temporary allocation.
> >
> > Fix this by adding separate variables to hold the pointers to the
> > temporary allocations.
> >
> > Reported-by: Arnd Bergmann <arnd@kernel.org>
> > Reported-by: syzbot+1115e79c8df6472c612b@syzkaller.appspotmail.com
> > Fixes: d14e6d76ebf7 ("[media] v4l: Add multi-planar ioctl handling code")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

> 
> >  out:
> > +       kvfree(array_buf);
> >         kvfree(mbuf);
> 
> I think it would make sense to change mbuf back to kzalloc()/kfree
> after this, since the size of the ioctl argument has an upper bound
> of 2^_IOC_SIZEBITS (16KB), which does not need the vmalloc
> path, unlike the array args.

Good point. I can send a patch for that, too.

-- 
Sakari Ailus
