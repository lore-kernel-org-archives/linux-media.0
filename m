Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B64EB64DA
	for <linux-media@archiver.kernel.org>; Fri, 16 Jun 2023 03:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbjFPDKX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 15 Jun 2023 23:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbjFPDKT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 15 Jun 2023 23:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E696F297F;
        Thu, 15 Jun 2023 20:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 753AB624E3;
        Fri, 16 Jun 2023 03:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0808C433C0;
        Fri, 16 Jun 2023 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686885017;
        bh=Urkn7w/gCujuzVzsD62vYANPn6pMOymn6mnoP0nXIik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uXA2+6bfg+tHCk2ZqZ4D7q2qfkdej2qfMLFScZpx99OsavxSypitJ8cdS943hkZFF
         yNP4BVYU7TGHX7e/RPkyIsJ+3LexmRzulxwQdvfjG9WrH0uPZYp8e4+VQGue5Dw2tE
         k0lp92HbzNsxeGN39Kuv5uWctHTZI5+jcpC1Q0n86Q2Bq9gX2IfPGQY1abyV0Kbe7G
         4nfWVahsJdRJQunJ3TNp/lufuF5Yg6I2bSPabLFOczQogQw1CGLwlBDvEJpvjHB79z
         yhZ9xyfSoWhU0vBa/sScrhDZrEuKgNuUq2MKk7SP8EVrkyYrlNAWhe6JIAeuJc1voG
         uraI9K7YAIydA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90485C3274B;
        Fri, 16 Jun 2023 03:10:17 +0000 (UTC)
Subject: Re: [GIT PULL for v6.4-rc5] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230604140137.1f160782@sal.lan>
References: <20230604140137.1f160782@sal.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230604140137.1f160782@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-4
X-PR-Tracked-Commit-Id: 899e373ef0b0d3f1c2712a849f019de4f46bfa02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b0a5014ee2b0984f2410d657dc582a8387585ae
Message-Id: <168688501757.31465.7761977128116634058.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 03:10:17 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pull request you sent on Sun, 4 Jun 2023 14:01:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b0a5014ee2b0984f2410d657dc582a8387585ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
