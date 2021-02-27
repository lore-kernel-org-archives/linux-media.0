Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA76C433E6
	for <linux-media@archiver.kernel.org>; Sat, 27 Feb 2021 09:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8AD64EBC
	for <linux-media@archiver.kernel.org>; Sat, 27 Feb 2021 09:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhB0JSq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 27 Feb 2021 04:18:46 -0500
Received: from gofer.mess.org ([88.97.38.141]:53621 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhB0JSn (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 27 Feb 2021 04:18:43 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id B2EBCC63D6; Sat, 27 Feb 2021 09:18:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1614417481; bh=VeIYBFiv3bPoUf7V6OuJUjQMfziHbdG36V+f8bChVOY=;
        h=Date:From:To:Subject:From;
        b=r2wlDTDWjjpmXYUYeY5CRP6JD6A0npNJJ1aOQGEw7z8eP1qGGTXtNf1mni1QXVOgb
         s9roemHj+YByBuszgzZwxlUmqXqzj7DriwFipEXv+roFmFkMDvH8lJlZu9ELcIQBX2
         AGn/uc6/qtPiij6jrk/5MiBexTY28amI+El9FhpP7ZNNtTGUWLQzkJmYyYkrjbj2hP
         zHy3W/GmNhYzFpGUep1ZdgFI/2LC+MhJueeiGdh9elNrdkmy5THLGpE+v+MW3n+Awt
         xbMUahXBvJkq8wgI/xyM2KgYOmIvhFgep9TrAs72bWX7P8GRKElYFPBQ6S99FfNaSG
         I3K5Vf15rLI3g==
Date:   Sat, 27 Feb 2021 09:18:01 +0000
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT FIXES FOR v5.12] rc-cec keymap fix
Message-ID: <20210227091801.GA374@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro

This fixes an issue where rc-cec.ko is being loaded in async context.

Thanks
Sean


The following changes since commit 8f202f8e9ff38e29694a4bc0a519b4e03c1726ee:

  media: v4l: async: Fix kerneldoc documentation for async functions (2021-02-15 16:21:54 +0100)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git tags/v5.12d

for you to fetch changes up to b5ae8a7f2acf19bfbb1c42c5be80b4b602a78fd6:

  media: rc: compile rc-cec.c into rc-core (2021-02-26 14:07:05 +0000)

----------------------------------------------------------------
v5.12d

----------------------------------------------------------------
Hans Verkuil (1):
      media: rc: compile rc-cec.c into rc-core

 drivers/media/rc/Makefile         |  1 +
 drivers/media/rc/keymaps/Makefile |  1 -
 drivers/media/rc/keymaps/rc-cec.c | 28 +++++++++++-----------------
 drivers/media/rc/rc-main.c        |  6 ++++++
 include/media/rc-map.h            |  7 +++++++
 5 files changed, 25 insertions(+), 18 deletions(-)
