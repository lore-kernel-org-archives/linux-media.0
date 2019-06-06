Return-Path: <SRS0=7IOK=UF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D180DC04AB5
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5422083D
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 14:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfFFO7V (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:59:21 -0400
Received: from gofer.mess.org ([88.97.38.141]:60889 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfFFO7V (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 6 Jun 2019 10:59:21 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 93E4B6031C; Thu,  6 Jun 2019 15:59:20 +0100 (BST)
Date:   Thu, 6 Jun 2019 15:59:20 +0100
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.3] rc/dvb fixes
Message-ID: <20190606145920.eua4a65ezrwishom@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

A change to use rc-core for the av7110 IR receiver, which removes a procfs
file. Also some tiny steps changes towards moving away from dvb_attach.

Thanks,
Sean

The following changes since commit edadd68031e5b7c1ba0c413a9549dce62a02844c:

  media: MAINTAINERS: update email address (2019-06-05 15:58:40 -0400)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git for-v5.3c

for you to fetch changes up to d43979016ee22b724174a4003da12670b5e51a41:

  media: ttpci: use rc-core for the IR receiver (2019-06-06 15:48:11 +0100)

----------------------------------------------------------------
Sean Young (1):
      media: ttpci: use rc-core for the IR receiver

Tobias Klausmann (2):
      media: stv6110x: Implement probe/remove for stv6110x
      media: stv090x: Implement probe/remove for stv090x

 drivers/media/dvb-frontends/stv090x.c       | 198 +++++++++----
 drivers/media/dvb-frontends/stv090x.h       |   3 +
 drivers/media/dvb-frontends/stv090x_priv.h  |   2 +-
 drivers/media/dvb-frontends/stv6110x.c      | 135 +++++++--
 drivers/media/dvb-frontends/stv6110x.h      |   3 +
 drivers/media/dvb-frontends/stv6110x_priv.h |   3 +-
 drivers/media/pci/ttpci/av7110.c            |  14 +-
 drivers/media/pci/ttpci/av7110.h            |  21 +-
 drivers/media/pci/ttpci/av7110_ir.c         | 423 +++++++---------------------
 drivers/media/rc/keymaps/rc-hauppauge.c     |   1 +
 10 files changed, 380 insertions(+), 423 deletions(-)
