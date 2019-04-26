Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975F1C43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675D820B7C
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556304564;
	bh=tkpgRPjpxcrus50L+k6ajSzp1mBt+zxa6/mfAHOtfyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y1muKGzcax9kgJfLMyp+rIqWoppfe9wp+UVGPGJ5pazKPpkYNLzhNYw2nJYJhpdad
	 DWlxTY9WGDSz3J0eNF8J4+3FJBv/xZXa9l0uv4EAnJ6D1nfJYI/WE+x86zDImO6H9Z
	 SLsH4jNxozDDipl3h2wGS4/eNPH7zrr4qakPLEMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDZStY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:49:24 -0400
Received: from casper.infradead.org ([85.118.1.10]:36082 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZStX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 14:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ztG/Swnwe9pSqO3CoHrtVEjbONSknRON3i7WdgQagkw=; b=tZc+GWoQBT6YRGVzx8wTLKH9pz
        nOXeV6r8xX2f7nmDSII5JFljmRERcABSJOnL2Zhg0VAQrFQIZ3ISSRQrsV/B0YBCfXQXmNgUdo4nI
        LpZ8Ty/BBfO+TNLhT75bvFErldcJlckKKLeG5cII4wdo59MkqnHJMWXZ5RdqNKOas9u6H0iBJfwF6
        VfK9WVJ01oIdrD2ORbLSjZWv4qErRjz6ynT6Ye6YtIx3KWWviZ3NRwS6JyrxcF3ftdekGZrx+y3UF
        tGl2YNCuZzH46Z5/1eLPzOIr6ox/d1gQR81Xw/x3R52mkl6Dv59n71bT2/gX6VogYlF+5YyvdVjI2
        EfPXaoGQ==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK5uT-0005zH-EI; Fri, 26 Apr 2019 18:49:22 +0000
Date:   Fri, 26 Apr 2019 15:49:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Gregor Jasny <gjasny@googlemail.com>
Cc:     Sean Young <sean@mess.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH v4l-utils] libdvbv5: leaks and double free in
 dvb_fe_open_fname()
Message-ID: <20190426154917.75adc64a@coco.lan>
In-Reply-To: <CAJxGH0_bmRiGKCtOf_jFZh_wVsyKR4s1DoDcSvYF7UYx8JNS0g@mail.gmail.com>
References: <20190317163220.1881-1-sean@mess.org>
        <20190426121344.510ef576@coco.lan>
        <20190426124217.55ae71cc@coco.lan>
        <CAJxGH0_bmRiGKCtOf_jFZh_wVsyKR4s1DoDcSvYF7UYx8JNS0g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Fri, 26 Apr 2019 18:08:22 +0200
Gregor Jasny <gjasny@googlemail.com> escreveu:

> Hello,
> 
> On Fri, 26 Apr 2019, 17:42 Mauro Carvalho Chehab, <
> mchehab+samsung@kernel.org> wrote:  
> 
> > Gregor,
> >
> > This patch messed with all branches since stable-1.12. I applied the revert
> > patch already on all affected stable branches.
> >
> > We should probably release a new fix for them soon.
> >
> > Sorry for not looking this earlier.. I got some vacations earlier
> > this month.
> >  
> 
> I also got a report in Debian:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=927341
> 
> I'm wondering if we could improve code quality by doing some automated
> testing. 

That's my dream as well.

> Is there a dummy dvb driver like vivi available?

Unfortunately, we don't have a full dummy dvb driver. There are some
dummy DVB frontend drivers, but they're really dummy do-nothing
drivers. We would need to add more stuff there for them to work, and
then add a virtual DVB driver on the top of it.

Doable, but requires someone with time for coding that.

To be fair, a DVB dummy driver is a lot easier than a V4L2 one, as
the DVB core already handles most of the stuff. The most complex
part would likely to use the vivid image generator converting it
into some video stream supported by DVB apps (the best would be
to encode it as MPEG-2 - as all apps support). We could use, on
a first version, some previously encoded video - or - even easier
- to just stream empty frames.

Thanks,
Mauro
