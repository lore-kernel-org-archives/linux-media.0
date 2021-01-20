Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C67CC433E0
	for <linux-media@archiver.kernel.org>; Wed, 20 Jan 2021 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176F6233A1
	for <linux-media@archiver.kernel.org>; Wed, 20 Jan 2021 16:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390825AbhATQHV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:07:21 -0500
Received: from gofer.mess.org ([88.97.38.141]:54685 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391207AbhATQC6 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 20 Jan 2021 11:02:58 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id D81EBC63DC; Wed, 20 Jan 2021 16:02:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1611158525; bh=zH70vEl2Nx/rBk75F3slrlnDuHBVtBsrGnI0uNk27fg=;
        h=Date:From:To:Subject:From;
        b=L1hEo8i8Ik7LdLeLOQ5k7OZarCv1QRSOyCMEpgNwwTdfuX+hhmXSk8j0rRjVHdOMF
         qayDJ/z6rf0hgnaTkSPSoMrxUT9u4retbL6Qy/O99FrqFsB42O+DbxLtlESTjLvrLo
         t8qgPXoyAsrRd8J0L0KzNxqVKoRJuw1vJaWkpCRR8jp5RuA/b2Aje4acmHsnnEWLq4
         0ePCzVzoY+wShOPABLhdjuJPR5+4+hU/Bs7v40J81QiLbZF/aHb7Q7NleM4ELbebC/
         1c96qGaHDqDSOp0kB1Y1GTp+JUGGkeEwxWDdtSH+Ts7ZVMwLRbSnkem7gQi6twinKa
         hBrU5x7chatCw==
Date:   Wed, 20 Jan 2021 16:02:05 +0000
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.12] rc & dvb
Message-ID: <20210120160205.GA8993@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Some more rc & dvb fixes.

Thanks,

Sean

The following changes since commit 321af22a3d2f6ed1fb1737c8588c01f6fec8a7b8:

  media: atomisp: convert comma to semicolon (2021-01-14 13:59:46 +0100)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git tags/v5.12b

for you to fetch changes up to 35fb788b18ac64675499e0a923ead2dce1019d11:

  media: lmedm04: Remove lme2510_kill_urb function. (2021-01-20 09:53:51 +0000)

----------------------------------------------------------------
v5.12b

----------------------------------------------------------------
Joe Perches (1):
      media: lmedm04: Fix misuse of comma

Malcolm Priestley (2):
      media: lmedm04: Use GFP_KERNEL for URB allocation/submission.
      media: lmedm04: Remove lme2510_kill_urb function.

Samuel Holland (4):
      media: sunxi-cir: Clean up dead register writes
      media: sunxi-cir: Remove unnecessary spinlock
      media: sunxi-cir: Factor out hardware initialization
      media: sunxi-cir: Implement suspend/resume/shutdown callbacks

Sean Young (1):
      media: mceusb: sanity check for prescaler value

 drivers/media/rc/mceusb.c              |   9 +-
 drivers/media/rc/sunxi-cir.c           | 169 ++++++++++++++++++---------------
 drivers/media/usb/dvb-usb-v2/lmedm04.c |  25 +----
 3 files changed, 106 insertions(+), 97 deletions(-)
