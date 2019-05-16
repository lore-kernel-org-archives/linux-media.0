Return-Path: <SRS0=hQl8=TQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E2C04AAF
	for <linux-media@archiver.kernel.org>; Thu, 16 May 2019 19:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6D520848
	for <linux-media@archiver.kernel.org>; Thu, 16 May 2019 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558034708;
	bh=0uEi4J7khFfjXe9qxf8Sk1N3Y0PkHUY32CgckNXedzM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pGPk8fXoOgfFAZONYf3Z3jzd2qllfFuCQC+TSOGZ0t0gXD1fVoBFnxHvWbOMndx+l
	 YsE4It027SVMk//owPftp3LlKkjPXB3nevgvbQvaLY4PE1q4eTk68hTM/2ilLGuuNV
	 U7P7z1oFtACQesuTCaNKpUu445FhStMMCDXZawb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfEPTZE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 May 2019 15:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfEPTZE (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 May 2019 15:25:04 -0400
Subject: Re: [GIT PULL for v5.2-rc1] media fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558034703;
        bh=0uEi4J7khFfjXe9qxf8Sk1N3Y0PkHUY32CgckNXedzM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N0UZGstP+U4BM24Rrc10C7GEFKVHZGIvQpeqAkouAl3Ej4PRAvuCW1LJWJ21aLr/8
         +bQM8bBVPS3izFOH79RB5CdwoxpkFtsa7m4z1JOBhJaaKUWyLZe3iNUVehgshccCW4
         xTK0WkNXRDjEMWcTZ0hIfrDhb4JwF2vwTgemLm+g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516134902.59a3a855@coco.lan>
References: <20190516134902.59a3a855@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516134902.59a3a855@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 tags/media/v5.2-1
X-PR-Tracked-Commit-Id: fc8670d1f72b746ff3a5fe441f1fca4c4dba0e6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01be377c62210a8d8fef35be906f9349591bb7cd
Message-Id: <155803470363.27329.17010779686105410610.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 19:25:03 +0000
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 13:49:02 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01be377c62210a8d8fef35be906f9349591bb7cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
