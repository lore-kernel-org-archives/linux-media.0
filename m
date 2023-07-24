Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF876C0015E
	for <linux-media@archiver.kernel.org>; Mon, 24 Jul 2023 16:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjGXQjx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGXQjd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 Jul 2023 12:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12ED18E;
        Mon, 24 Jul 2023 09:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F5EB6126E;
        Mon, 24 Jul 2023 16:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3BC6C433C9;
        Mon, 24 Jul 2023 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690216767;
        bh=37s4TxYwzRRPRfHRgS8f9yeg9LcCDjhWrxKYuAsrmT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uGHcN02axiexiW/uqwYz33z+hqLrgR0vAtlZi3VqUjxFZGe3KO8wRMCkYWaDe7SmN
         2OfC0mroXBiFEUAMfNIUV6f79006q9ENJrP3Ukkd1hBwnmQrhQ9ooWrDSaGTZWUdje
         w7t0Srf/ChaiRxPNv2H32O6EdFyKzth62SeRqz4b3tqPJK9hYS/2e4ttFqYJoBdc79
         E0Rr7BUR/PKMffRYB56w2JqaTgUnFn6Pgq0qlD79kg9fDMu1oEh0peCUvTtmrPIjXJ
         CngbNAHCniKUxTrzTm1+XyiepTmi5aQrPaXhP+EgoxlmgGWOYrnsIIJ1EtCjLSxA6n
         gNhuKTA3t2E0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6192E1F65A;
        Mon, 24 Jul 2023 16:39:27 +0000 (UTC)
Subject: Re: [GIT PULL for v6.5-rc4] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230724121150.1d55ce6b@coco.lan>
References: <20230724121150.1d55ce6b@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230724121150.1d55ce6b@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-2
X-PR-Tracked-Commit-Id: 0cb1d9c845110ce638a43a1417c7df5968d1daa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e0ee0c7545c7ec012a53878e7687e05b87abc75
Message-Id: <169021676780.29251.11317321803832138971.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Jul 2023 16:39:27 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pull request you sent on Mon, 24 Jul 2023 12:11:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e0ee0c7545c7ec012a53878e7687e05b87abc75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
