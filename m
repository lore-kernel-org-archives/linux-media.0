Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0FDC4727C
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 01:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D59721531
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 01:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgI3B1H (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 29 Sep 2020 21:27:07 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:59788 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbgI3B1H (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 29 Sep 2020 21:27:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 24807100E7B46;
        Wed, 30 Sep 2020 01:27:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: route17_40126172718e
X-Filterd-Recvd-Size: 1691
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 01:27:04 +0000 (UTC)
Message-ID: <723e89d8cce4fed905d11740d855c60b06be2595.camel@perches.com>
Subject: Re: [PATCH 10/20] media: lmedm04: use semicolons rather than commas
 to separate statements
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 29 Sep 2020 18:27:03 -0700
In-Reply-To: <3b7457e4efd04865115152636ca65b5dc9cfe0e4.camel@perches.com>
References: <1601385283-26144-1-git-send-email-Julia.Lawall@inria.fr>
         <1601385283-26144-11-git-send-email-Julia.Lawall@inria.fr>
         <8d73748e-be82-4c30-4550-b5f4eecb3055@wanadoo.fr>
         <c79b36c12c978d38f3ad89b1c659871a@perches.com>
         <alpine.DEB.2.22.394.2009291843560.2808@hadrien>
         <3b7457e4efd04865115152636ca65b5dc9cfe0e4.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 2020-09-29 at 15:21 -0700, Joe Perches wrote:
> I did not send a patch for this one.

Well, I guess I did and forgot.

I thought this was about the braces and semicolons
addition around multi-statement commas, and I
didn't send a patch for this file for that.

cheers, Joe


