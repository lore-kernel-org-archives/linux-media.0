Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88969EE4993
	for <linux-media@archiver.kernel.org>; Sat, 19 Aug 2023 11:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjHSLVb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 19 Aug 2023 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjHSLVa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 19 Aug 2023 07:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D01B27D24;
        Sat, 19 Aug 2023 04:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE2ED60BC0;
        Sat, 19 Aug 2023 11:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48828C433C8;
        Sat, 19 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692443992;
        bh=sebaFZtFyNbdvyQFAws1jOFrUmWSioNftD0Z9MnsDo0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PZCG+Vj/mZ097Ne8P1lP3KlOVLnWSlV0lcnJA+fpf2MobGN055w+SzXdhO5G90rkX
         63KYPEDtn89Jd2lEmguJECj9wCkzhfuDiYi1BT2M2ORDarpNnC8RVUMPsqQvQA8pyV
         lAxilNhUHupl6wiOByoUK1y881KNOgsXaAwlR/75SZoVotmQ7FYKivRYcbAbHSTnX1
         UpV2SIlIKX9WMK5JalVG4sygPeoiFUBpGIxlXCpJiWVWjihYTVZdkDMFPSVwnvJLvA
         VY/qiRPYt8HK3ty2saULl1O5ErVpyHtRu3TI3aGjaOF1+CLj4aL4+h6Ull33Csq5jc
         M6mqyzhE6bpqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 230E3C59A4C;
        Sat, 19 Aug 2023 11:19:52 +0000 (UTC)
Subject: Re: [GIT PULL for v6.5-rc7] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230819125707.25397dd9@coco.lan>
References: <20230819125707.25397dd9@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230819125707.25397dd9@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-3
X-PR-Tracked-Commit-Id: 2908042a37b56d6a9a595eca946e187e9d2df39a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa9ea98cca3a56869df1dc6347f3e3bfe0c01f44
Message-Id: <169244399213.16209.12106383347754725903.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Aug 2023 11:19:52 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pull request you sent on Sat, 19 Aug 2023 12:57:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa9ea98cca3a56869df1dc6347f3e3bfe0c01f44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
