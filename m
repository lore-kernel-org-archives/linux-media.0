Return-Path: <SRS0=PL4U=DB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F63C2D0E2
	for <linux-media@archiver.kernel.org>; Thu, 24 Sep 2020 16:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B2323A5C
	for <linux-media@archiver.kernel.org>; Thu, 24 Sep 2020 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600964862;
	bh=eYqkWXjkcREEjH5Q7FlhcRqSh+vyLejDfJdgNEbo6aI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aWGV1fsmkxsas8rvO87Jz7ZmmTjYhpGr1/34y78+J64REz5id1XgPM24rOMsWqFXm
	 5i8KvsaKQPe9S0rt6prAX700IOhfGFuNkdtC7SNBOq4nFtn7Qc1eucXQF8/ei4E/sF
	 CRYv3iWCgJt4BWEzj1Ta4pvLbuLuhXSVlM99LXQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgIXQ1f (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgIXQ1d (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 24 Sep 2020 12:27:33 -0400
Subject: Re: [GIT PULL for v5.9-rc7] media fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964852;
        bh=eYqkWXjkcREEjH5Q7FlhcRqSh+vyLejDfJdgNEbo6aI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D4Buy9GS24U1IJut0lhdj/FKzs4xmuXxW2DzO8li42nFgFDnfZZLcnodRzUKlgAgR
         N8Cj6bNlejEU7QtUld3idAQTLNhML8ZOM0AKhRruab6WMDzVGRA7xAMFdHrZ48mtiL
         vtOBCJJQcsLNTs/zdl0u0wZia2siZ/xaAqYewZIg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200924143834.79ef0744@coco.lan>
References: <20200924143834.79ef0744@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200924143834.79ef0744@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.9-3
X-PR-Tracked-Commit-Id: d0254f82d702a1d0d92e42f87676111de88846cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fa5960f575995bc8f3beb6b36c5aa6c61e7cdc0
Message-Id: <160096485251.7937.15001290524683409638.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Sep 2020 16:27:32 +0000
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pull request you sent on Thu, 24 Sep 2020 14:38:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fa5960f575995bc8f3beb6b36c5aa6c61e7cdc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
