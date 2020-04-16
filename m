Return-Path: <SRS0=ht1n=6A=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC7C2BA2B
	for <linux-media@archiver.kernel.org>; Thu, 16 Apr 2020 07:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617F02076A
	for <linux-media@archiver.kernel.org>; Thu, 16 Apr 2020 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587023766;
	bh=295AL3CtxNEQ+kBee4CHp0mkoqtOWsT43wCgLGIEyto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IVM3I3J5ZgtzmaW21vk09RJmv6On9/mL+698IGCtuZcivbKwSFLVOksv4Et2Nt0vK
	 WE4kTuXrsYA2IoBeeSfji6ZRRBJ0JrfLVjjeJk3ASdgBM6nlWRfMbmVm7lseXsMHCu
	 JzH4i8nvjZmA+alL59t3G52H0FPVDri6mHSNB7xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439970AbgDPH4E (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440556AbgDPHz6 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Apr 2020 03:55:58 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE78206E9;
        Thu, 16 Apr 2020 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023758;
        bh=295AL3CtxNEQ+kBee4CHp0mkoqtOWsT43wCgLGIEyto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pywooq2IFFpoNWWoRYD54uwek5gu+lldxC9Xn+jHId9u2Uc7/RJEmdCwW8xfyN/CO
         qat4v6AKWCmiRXynHqNV14BmQ9ZTz6rCP8kza/+uuOfW1Ym8p+6J2NzKoHhib6VvKV
         xXPyCwXstItTE13PAunEk2KFaHdFs/BRR9kO8Wbo=
Date:   Thu, 16 Apr 2020 09:55:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org
Subject: Re: Script to build the media documentation as if it were a single
 book
Message-ID: <20200416095554.53566315@coco.lan>
In-Reply-To: <c55b5aae-ffb5-3ca0-b855-1df4a2da08f9@xs4all.nl>
References: <20200414153739.30b58bdc@coco.lan>
        <e83dbd40-2a34-3bad-be5f-e451c3a5d020@xs4all.nl>
        <20200416092132.2cbfce7e@coco.lan>
        <c55b5aae-ffb5-3ca0-b855-1df4a2da08f9@xs4all.nl>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu, 16 Apr 2020 09:29:45 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> On 16/04/2020 09:21, Mauro Carvalho Chehab wrote:
> > Em Thu, 16 Apr 2020 09:01:55 +0200
> > Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> >   
> >> On 14/04/2020 15:37, Mauro Carvalho Chehab wrote:  
> >   
> >>> ================================
> >>> Linux Kernel Media Documentation
> >>> ================================
> >>>
> >>> .. toctree::
> >>> 	:maxdepth: 4
> >>>
> >>>         admin-guide/index
> >>>         driver-api/index
> >>>         userspace-api/index    
> >>
> >> Wouldn't it make more sense to have the userspace-api before the admin-guide?  
> > 
> > There, I just placed them on alphabetic order.
> > 
> > But answering your question, that depends on the audience ;-)
> > 
> > -
> > 
> > Yet, assuming that we are doing a good job, I would expect a lot more
> > users than developers[1].  
> 
> If you want to see what it looks like with userspace-api on top:
> 
> https://hverkuil.home.xs4all.nl/spec/index.html
> 
> I think it makes more sense that way.

With the current content, I fully agree with you. However, take a look
at the RFC patch I just sent. It is just the start of something
(and it is not aligned yet with the latest Kconfig changes).

Anyway, my plan is to add something that a random media user could
find some useful information, and point to our Wiki pages where
it would make sense.

> 
> Regards,
> 
> 	Hans
> 
> > 
> > [1] Granted, there are lots of gaps there for it to be a generic guide
> >     to media subsystem. I'm planning to improve the admin-guide in order
> >     to make it more consistent and useful for media users.
> > 
> > The order there, IMHO, doesn't matter much, as someone accessing it from
> > LinuxTV.org would likely use this URL:
> > 
> > 	https://linuxtv.org/docs.php
> > 
> > Side note: I need to add a pointer to the admin guide there - and at the
> > wiki pages.
> > 
> > Thanks,
> > Mauro
> >   
> 



Thanks,
Mauro
