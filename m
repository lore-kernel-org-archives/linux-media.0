Return-Path: <SRS0=8QUH=US=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1771AC31E49
	for <linux-media@archiver.kernel.org>; Wed, 19 Jun 2019 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D3B2166E
	for <linux-media@archiver.kernel.org>; Wed, 19 Jun 2019 14:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlgsbTM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfFSOb4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:31:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40048 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOb4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 19 Jun 2019 10:31:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so7328209pla.7
        for <linux-media@vger.kernel.org>; Wed, 19 Jun 2019 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXioLI4ccNXuZ33HgVEpCi8jpqiCJ00T1WpUkqmwUYw=;
        b=hlgsbTM5UcZQlT+as20mX6TTptl1Oi2Jaf5ZfM41SkZNzwroOKbCyFsCv4fU3KXz1V
         1WRllA1Chn6owFJRI/EXKOz5vkPIYIbsYtzfKd2SXLbQtRbYPzn7zmN59pGuJFjl4z3b
         o8lR9ehnDTdPGftISnLyR0GJlitieRuHdgjPTrkEN5ReXu8Ekhi8vOWoHfiCus23XaZL
         41mzUm8VWcBkGVaP7pN2+DmjaLEw0CsA6xOgJP4Iqz8bXkP71Z4lO0Z8xOmP15BNsV8J
         kcM2tlqkyySFNqsvzwANLL7W/mG9/YQce1x2mbO+jI+0Z+AWDeV/lyuXZJbmoJjWhejy
         LLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXioLI4ccNXuZ33HgVEpCi8jpqiCJ00T1WpUkqmwUYw=;
        b=ktV25qOYciKvi2/u6jElFGNw9nb0SO6afCj4xB8j9LAt96CLl60kRMzG+4b1nUtXXN
         RfLnE86iYswAvvt3S/UMaTLs1NMR5jzDR6uucUdXSMDLjr2LASN21mt6U6bM4RqlbLJ/
         6tJHNNv/+L0XL2/sLFbnjxUHHdysTWj9Rg5H1CGOPBNSMgOHBX20wjaLYksgiptxhczZ
         EXdth66E5gdQLVhH4OIlQObRpKhlbVIOBaLbcxp5y1UcNSEVmenq1YNZdDbXZ2RpKVQD
         ZXfzeQi9W2euDQqHBDWTYrxxYWsCABgK3XRejHe4f2bjreBB30dSNVKsv4VooIR7Zv+v
         kTAg==
X-Gm-Message-State: APjAAAUWckY3Fhbm/bVvGC13/h8m4Vx7okg1mRbxggPjKsTHJL6BZ3Qj
        kgtzpqXJxtePg43kNun8EYnJnPO1hYNqSeBrtc+K/g==
X-Google-Smtp-Source: APXvYqyJiPokAPdYnARPmPP+MPZ8yDlJF09SJR7TRCKGI9xwpOutJFrHS7Faa3PFxAG0K9j5yvqYCtIAFr24I5AEEak=
X-Received: by 2002:a17:902:4183:: with SMTP id f3mr3933700pld.336.1560954715477;
 Wed, 19 Jun 2019 07:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <b3761c6479a49b60316325ebc22da904e36d4538.1556813333.git.andreyknvl@google.com>
 <20190502163907.GA14995@kroah.com> <CAAeHK+w9xGtaQ5oSCq-=1YNk_11T2Tz9LKehkL7ZsAz-XwKajw@mail.gmail.com>
In-Reply-To: <CAAeHK+w9xGtaQ5oSCq-=1YNk_11T2Tz9LKehkL7ZsAz-XwKajw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 19 Jun 2019 16:31:44 +0200
Message-ID: <CAAeHK+w-Ok_3_ath67u5=J71cd7pEBw5iobFj_2VLhH6ZcqeCw@mail.gmail.com>
Subject: Re: [PATCH] media: pvrusb2: use a different format for warnings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>, linux-media@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com>,
        syzbot <syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Jun 19, 2019 at 4:30 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, May 2, 2019 at 6:39 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 02, 2019 at 06:09:26PM +0200, Andrey Konovalov wrote:
> > > When the pvrusb2 driver detects that there's something wrong with the
> > > device, it prints a warning message. Right now those message are
> > > printed in two different formats:
> > >
> > > 1. ***WARNING*** message here
> > > 2. WARNING: message here
> > >
> > > There's an issue with the second format. Syzkaller recognizes it as a
> > > message produced by a WARN_ON(), which is used to indicate a bug in the
> > > kernel. However pvrusb2 prints those warnings to indicate an issue with
> > > the device, not the bug in the kernel.
> > >
> > > This patch changes the pvrusb2 driver to consistently use the first
> > > warning message format. This will unblock syzkaller testing of this
> > > driver.
> > >
> > > Reported-by: syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com
> > > Reported-by: syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I don't think I see this patch picked up anywhere. Should this fix go
> through the USB or some media tree?

Ah, found something here:
https://www.spinics.net/lists/linux-media/msg151398.html

I guess it'll go in with 5.3.
