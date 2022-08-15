Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97414C00140
	for <linux-media@archiver.kernel.org>; Mon, 15 Aug 2022 03:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiHODo5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Aug 2022 23:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiHODo4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Aug 2022 23:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBD213F20;
        Sun, 14 Aug 2022 20:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2283861010;
        Mon, 15 Aug 2022 03:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75AF9C433B5;
        Mon, 15 Aug 2022 03:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535094;
        bh=v1UpnqbLfX1UxbGmg2rizCP8urRBvwY7qMqiSCMGPGk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XCT6HMjsFWmo9IVWaFReUsGC/pH0JN942VzEM34kSVVIuAMcsD+kwQoolC6Z0riC3
         01eBaq7Ouy9jUBERIz8+3v6+3XMMUJaniPZgV7IpaG1Z1LWyn4fK7f/d8CWKATt6/k
         9V0EY9P0rRydRbu0auk+GrAIsuLONvtomhP3/kdtAbGiqGcZ1oSM6s6FUyMsqWOOoG
         /2uzK1cKeTJGhQMwLkdXZdPwQWrLuJRSVBEyUeMs1ONrfZysjPgRiNA9Ua1/3XMD5y
         qjrYInpczbeSsCgHYtrxcO9VbbZcprwvy0P9d3SLS8T6p5ELEOFsoh3mYyQJhllSQP
         xdv+uK5bSI1vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55133E2A04E;
        Mon, 15 Aug 2022 03:44:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v3] media: platform: cros-ec: Add moli to the match table
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166053509434.30867.9008839806122771715.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 03:44:54 +0000
References: <20220520110831.29502-1-scott_chao@wistron.corp-partner.google.com>
In-Reply-To: <20220520110831.29502-1-scott_chao@wistron.corp-partner.google.com>
To:     Scott Chao <scott_chao@wistron.corp-partner.google.com>
Cc:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org, bleung@chromium.org,
        groeck@chromium.org, zhuohao@chromium.org,
        linux-media@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Mauro Carvalho Chehab <mchehab@kernel.org>:

On Fri, 20 May 2022 19:08:31 +0800 you wrote:
> The Google Moli device uses the same approach as the Google Brask
> which enables the HDMI CEC via the cros-ec-cec driver.
> 
> Signed-off-by: Scott Chao <scott_chao@wistron.corp-partner.google.com>
> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [v3] media: platform: cros-ec: Add moli to the match table
    https://git.kernel.org/chrome-platform/c/a1a9b71ebd65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


