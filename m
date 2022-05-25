Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0D9C4332F
	for <linux-media@archiver.kernel.org>; Wed, 25 May 2022 09:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbiEYJNs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 May 2022 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiEYJNT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 May 2022 05:13:19 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77975209;
        Wed, 25 May 2022 02:10:21 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 8A1D0101CCD; Wed, 25 May 2022 10:10:20 +0100 (BST)
Date:   Wed, 25 May 2022 10:10:20 +0100
From:   Sean Young <sean@mess.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL for v5.18-rc1] media updates
Message-ID: <Yo3yfIim58IWf64z@gofer.mess.org>
References: <20220322101406.459e2950@coco.lan>
 <a0470450-ecfd-2918-e04a-7b57c1fd7694@kernel.org>
 <Yo3ddVHgBBlvJEdh@gofer.mess.org>
 <8093277c-5098-e5e3-f606-486de5b2f67b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8093277c-5098-e5e3-f606-486de5b2f67b@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, May 25, 2022 at 10:09:38AM +0200, Jiri Slaby wrote:
> I don't understand how inability to build software is not an uapi breakage
> -- care to elaborate?

So here is a good compromise suggested by Mauro. 

1. We add the following to the lirc.h uapi header.

#define LIRC_CAN_NOTIFY_DECODE 0 
#define LIRC_CAN_SET_REC_FILTER 0 

2. Since lirc daemon is unmaintained, I am happy to take on maintainership.

This may require forking, depending on what the maintainer says.

How does that sound?


Sean
