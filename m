Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C8C41513
	for <linux-media@archiver.kernel.org>; Fri, 13 Oct 2023 16:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMQj6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 Oct 2023 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjJMQj5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 Oct 2023 12:39:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69DAD;
        Fri, 13 Oct 2023 09:39:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B307BC433C7;
        Fri, 13 Oct 2023 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215195;
        bh=YIyodcYU7tvuNNX91+0d1//LTYc1g53rjS6Ls2vn/Wo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fPZTlwLE1re1ZiCQmwPuirxRneb4I7ltQq1T8z6RSxDdVyiGObu2QdQOI7nacPTGv
         R9UkPPMJak5jYHX7AzwTzdoaLp44MW5Xld7Ar7LS11xjaHcxCou7xTgMvRjC5nwNAC
         0T5t57T/pxhcviMkeouj/KJozv69ZvjCE/7lB8eTQZu0w/EyNbRRgfKl9eR8GoXOms
         A/hXPzjh+EK++qSTYPEFLhSkMqwKALCNdgJAphjTdW2sJQ2cAr+AEmLRYXj2YN8fti
         cxAYj7AdkxIA+hQO5v0NCd7cgnvjVUa8cvzH2xoMV8PRAqTgMZ9ExwV1gE2zrmsohg
         quika6xgqtzcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 936F5C691EF;
        Fri, 13 Oct 2023 16:39:55 +0000 (UTC)
Subject: Re: [GIT PULL for v6.6-rc6] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231013131141.669dc1c9@sal.lan>
References: <20231013131141.669dc1c9@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231013131141.669dc1c9@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-5
X-PR-Tracked-Commit-Id: c46f16f156ac58afcf4addc850bb5dfbca77b9fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c367d8eadc00ff04bfab184ccd07b34ea89661a
Message-Id: <169721519559.5219.1754295751090358749.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 16:39:55 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 13:11:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c367d8eadc00ff04bfab184ccd07b34ea89661a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
