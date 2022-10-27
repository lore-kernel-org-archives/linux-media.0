Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE7FA3740
	for <linux-media@archiver.kernel.org>; Thu, 27 Oct 2022 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiJ0U7l (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiJ0U7I (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 27 Oct 2022 16:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42732C06A1;
        Thu, 27 Oct 2022 13:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DBB6254F;
        Thu, 27 Oct 2022 20:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56A15C433D6;
        Thu, 27 Oct 2022 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666903832;
        bh=kjuaZC+e9iLzNBTl4Bido8MKqXt632oaiFekeZp8Ce8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fhgmoo5eRhkLpRVYc5RXtG/O/vMzS90yMcXU58V1VZmx+Ybhcaj8eYkJEu9s7o9LA
         9XMz/p2cdCupext3Fzg1rtF8VPwOkgdTEjBmiL4YDzKFktX4MRv8lLuydOCEyVJ7Ue
         koelaCFKUAS2rNgXPSWYpNKE/HXVPNd8QPDY8T8EtlpaAiVBZdo6uUSHaGH6fs298V
         U208VYf0/SxbkmMunEsWQ/meiVjJMZsXqV0UXqWT3r4PcbTMU9u6JNpdP9IXBmefDs
         10Z2+aNM8t79euFOT3GHxN5IjpyL/GYA2v1Mcb20DzNBNU66yIFZd4JnGVnE9CfZA9
         2hOgVLw4VkyfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 406AEC73FFC;
        Thu, 27 Oct 2022 20:50:32 +0000 (UTC)
Subject: Re: [GIT PULL for v6.1-rc3] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221027181714.3d12aba5@sal.lan>
References: <20221027181714.3d12aba5@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221027181714.3d12aba5@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-3
X-PR-Tracked-Commit-Id: de547896aac606a00435a219757a940ece142bf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f9a7cd690c7d59cde03027aee9bebd83b4a9dc6
Message-Id: <166690383225.21870.10307097459248589933.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Oct 2022 20:50:32 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pull request you sent on Thu, 27 Oct 2022 18:17:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f9a7cd690c7d59cde03027aee9bebd83b4a9dc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
