Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EFEC433DB
	for <linux-media@archiver.kernel.org>; Fri, 26 Mar 2021 07:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD40E61A1E
	for <linux-media@archiver.kernel.org>; Fri, 26 Mar 2021 07:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhCZHLw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Mar 2021 03:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhCZHLX (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Mar 2021 03:11:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C59CB61A1E;
        Fri, 26 Mar 2021 07:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616742683;
        bh=I7kuNHjnR8hZ/+AWif4Y6XFeN71YYYkFveVnCl2inWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOD7i3E8ZGoiNthpVUq7/st5v3JKreQURE4vVgSvLVhUOBgVT9ibX3AsAchD4dN5u
         FWXFHBtvDVuQfLkv8vf2zc5EUB+4YC8oaVmqWSq0/ElyKyDIWlfUTj7q7sF8JLXj1O
         4es+8LnIGykxJ/cTAxl2aXtd4A3b9vJmlgnhe5/M=
Date:   Fri, 26 Mar 2021 08:11:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Emad <alaaemadhossney.ae@gmail.com>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com,
        syzbot+a4e309017a5f3a24c7b3@syzkaller.appspotmail.com
Subject: Re: [PATCH] media: sq905.c: fix uninitialized variable
Message-ID: <YF2JF+UMdt/icEMj@kroah.com>
References: <20210325212202.142945-1-alaaemadhossney.ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212202.142945-1-alaaemadhossney.ae@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Mar 25, 2021 at 11:22:02PM +0200, Alaa Emad wrote:
> Reported-by: syzbot+a4e309017a5f3a24c7b3@syzkaller.appspotmail.com
> Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>
> ---

I know I do not take patches with no changelog text, but other
maintainers might be more leniant :(

thanks,

greg k-h
