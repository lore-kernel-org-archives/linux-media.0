Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ED3C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAD62133D
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 22:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDJWPs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:15:48 -0400
Received: from gofer.mess.org ([88.97.38.141]:39587 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJWPs (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 18:15:48 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id CB4B9603EC; Wed, 10 Apr 2019 23:15:46 +0100 (BST)
Date:   Wed, 10 Apr 2019 23:15:46 +0100
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.2] dvb & rc fixes
Message-ID: <20190410221546.fal7j4zbycht4htp@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Just some minor fixes. Note that the seco-cec fix was already sent as a
GIT FIXES request but seems to have been lost, so now resending with stable
tag.

Sean

The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git for-v5.2b

for you to fetch changes up to e8fbee102d9fccb9737509ba23334578ae2ea37f:

  media: seco-cec: fix building with RC_CORE=m (2019-04-10 23:05:41 +0100)

----------------------------------------------------------------
Arnd Bergmann (1):
      media: seco-cec: fix building with RC_CORE=m

Matthias Reichl (1):
      media: rc: xbox_remote: add protocol and set timeout

Yizhuo (1):
      media: ts2020: Variable "utmp" in function ts2020_set_tuner_rf() could be uninitialized

YueHaibing (1):
      media: si2165: fix platform_no_drv_owner.cocci warnings

 Documentation/media/lirc.h.rst.exceptions | 1 +
 drivers/media/dvb-frontends/si2165.c      | 1 -
 drivers/media/dvb-frontends/ts2020.c      | 3 +++
 drivers/media/platform/Kconfig            | 2 +-
 drivers/media/rc/keymaps/rc-xbox-dvd.c    | 2 +-
 drivers/media/rc/rc-main.c                | 2 ++
 drivers/media/rc/xbox_remote.c            | 6 ++++--
 include/media/rc-map.h                    | 4 +++-
 include/uapi/linux/lirc.h                 | 2 ++
 9 files changed, 17 insertions(+), 6 deletions(-)
