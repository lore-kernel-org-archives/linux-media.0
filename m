Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5470EECAAD3
	for <linux-media@archiver.kernel.org>; Sun,  4 Sep 2022 07:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiIDHgg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 4 Sep 2022 03:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiIDHgf (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 4 Sep 2022 03:36:35 -0400
Received: from gofer.mess.org (unknown [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB58940BD1
        for <linux-media@vger.kernel.org>; Sun,  4 Sep 2022 00:36:25 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 176AB100073; Sun,  4 Sep 2022 08:36:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1662276969; bh=XFaKvb3Q8NWAAaRxu+VGpL4ksFdkl2m8W36Fd+HOXAI=;
        h=Date:From:To:Subject:From;
        b=qsMuydSBoIfEeJkQxCuyjepIOY2S7XvebNUguD6Lr0kSJEmkpmlQuXJ/xpLw391cQ
         KP8kXCJeMX0IQNJV+1l7f9uvdtghsGD6SRtvI3UIY14l0fhqTxArrDKuGY22IXgziS
         CsUrGmQZ7JO4hx5Me+7QA2xALPFBp6VkbEBBZ4JJnjYU3++9Mcvu+F1H02eVLyA3ht
         fxPwEGmYDYfRTrY5nI9njgWIhuYAJGdrrDO0rxt/Gw3xkpR6QchofEqKx/COnbamrE
         7LJOTy/Fsvlx9qBwpzPU/d81NL/etQgmMoF1YYqHEJ9hbAeC7upeU4LL7HNfW+T/De
         mBM+Q5b66pjSQ==
Date:   Sun, 4 Sep 2022 08:36:08 +0100
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v6.1] rc fixes
Message-ID: <YxRVaCQrySm/Wsjy@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit fbb6c848dd89786fe24856ee6b5e773910ded29c:

  media: destage Hantro VPU driver (2022-08-31 10:23:50 +0200)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git tags/v6.1a

for you to fetch changes up to cb8414d158faaca6bafd3a81c2f3af8a7e98c549:

  media: mceusb: set timeout to at least timeout provided (2022-09-04 08:29:54 +0100)

----------------------------------------------------------------
v6.1a

----------------------------------------------------------------
Alan Stern (1):
      media: mceusb: Use new usb_control_msg_*() routines

Sean Young (1):
      media: mceusb: set timeout to at least timeout provided

ye xingchen (1):
      media: imon: Remove the unneeded result variable

 drivers/media/rc/imon.c   |  4 +---
 drivers/media/rc/mceusb.c | 37 +++++++++++++++----------------------
 2 files changed, 16 insertions(+), 25 deletions(-)
