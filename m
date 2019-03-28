Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6CCC10F06
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E82D2173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553803477;
	bh=rLNyC3bikETWFYgDZih39XlXJb2rdBk7aUBhoO1YTN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y08yidfZi3dtJRScm/YxLZ5qkGD1RdZTs+sK8nDtEvf1OVVZKmSgW7nmaIFoEZkEL
	 44fNPc4LHwrM+x5kl1NamchKmwSkqlKMcA+/gEliebZz94dkyeZFKwnl/z24Tm9IsD
	 L1UgcqK8xNzcAgqIdYRr1NEJDiRogrp5KQv+lN5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfC1UEg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:04:36 -0400
Received: from casper.infradead.org ([85.118.1.10]:60696 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfC1UEf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2+elwt3uF+8XIr2FWOchhqe0TNM8KMg7cs9XRwNSTwE=; b=X00z0qmevLS4rUwF0A+ai2jXT3
        XqLLeBB758r5ghlrhn+IAMX6Q7ezbvg1GS4JGtgFLq/wrXbOVwbYb7AkdCeUnbAovUWu5pcmAOgxi
        DKsEjNM31FNRyl4khh/9MaXqIQ0vyMPDBkZjICq46NgX5skEK3gl/C2FkEkfs/yBT6IfwwksFvTap
        gWVF4Yy64oI4tA6H1RLktTYMYnXw1sAwKOb2BcC3ZXbSkGKhsnZ5Sq9yINYKGmL0+OLRpYOr9eNwm
        5mK2xS2dskNWrRjkxzY2YCWPNJCUO2rUNywPrccrBaiQoJmV9CKADy/mHiLfefRIegkjGFaIxUJ7X
        l2QZFOIQ==;
Received: from [179.183.99.176] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9bGL-0004mA-4P; Thu, 28 Mar 2019 20:04:33 +0000
Date:   Thu, 28 Mar 2019 17:04:29 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Gregor Jasny <gjasny@googlemail.com>
Cc:     Samuel CHEMLA <chemla.samuel@gmail.com>,
        Sean Young <sean@mess.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [Bug report] dvbv5-zap crash dvb-tool ARMHF builds
Message-ID: <20190328170429.2ad3a7f4@coco.lan>
In-Reply-To: <62429f4e-eabb-8ee9-4137-47540e8131ef@googlemail.com>
References: <20190315223425.hiq3qcjhjnirsizh@gofer.mess.org>
        <20190317065242.137cb095@coco.lan>
        <20190319164507.7f95af89@coco.lan>
        <a1f296ba-3c27-ed2c-3912-4edbeeb21eba@googlemail.com>
        <20190321094127.ysurm4u26zugmnmv@gofer.mess.org>
        <20190321083044.621f1922@coco.lan>
        <35ba4e81-fc2a-87ed-8da7-43cc4543de51@googlemail.com>
        <CANJnhGfRtEwAony5Z4rFMPcu58aF2k0G+9NSkMKsq_PhfmSNqw@mail.gmail.com>
        <20190325140838.71f88eac@coco.lan>
        <CANJnhGc_qx32nm7yZheC2ioHOij8QELbnwyJkZ83G9uYTxqwtA@mail.gmail.com>
        <20190326132643.r3svehoa764xagje@gofer.mess.org>
        <CANJnhGfgzrLZedeoCOq3L-MaEgjtHm1Bwn1cRPr54LvwZ=RBMQ@mail.gmail.com>
        <20190326123115.5d83f450@coco.lan>
        <CANJnhGe+nyq6a43BnPmGxb6_9JinFyy1EC=6Xo6K4RUpshm8Ow@mail.gmail.com>
        <20190328161758.2da2bf4e@coco.lan>
        <62429f4e-eabb-8ee9-4137-47540e8131ef@googlemail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu, 28 Mar 2019 20:48:34 +0100
Gregor Jasny <gjasny@googlemail.com> escreveu:

> Hello,
> 
> On 28.03.19 20:17, Mauro Carvalho Chehab wrote:
> > Em Thu, 28 Mar 2019 19:48:35 +0100
> > Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:  
> >> 1) I did reproduce the bug with a serial console, but the serial
> >> console was also frozen, and there was no message before freeze.  
> > 
> > The only way for a machine to freeze even on serial console is due to
> > a very serious Kernel or hardware bug, like a bad lock/semaphore.  
> 
> Does anything speak against upgrading Debian to latest 1.16.5 release?

I don't think so. The changes we did were just at memory allocation/free
with standard glibc malloc()/calloc()/free() functions.

The kind of errors Samuel are experiencing are machine freezes. 
dvbv5-utils can't cause such kind of errors, as it doesn't run in 
privileged mode, nor do anything potentially harmful.

So, even the most serious issue there won't cause a machine crash.

For a machine to crash, it has to be triggering a Kernel bug
or some memory corruption outside its memory space (e.g. triggering
some glibc bug - with also seems very unlikely).

Thanks,
Mauro
