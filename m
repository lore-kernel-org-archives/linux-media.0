Return-Path: <SRS0=iMag=6H=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6326C2BA19
	for <linux-media@archiver.kernel.org>; Thu, 23 Apr 2020 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD1C20776
	for <linux-media@archiver.kernel.org>; Thu, 23 Apr 2020 09:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgDWJsE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:48:04 -0400
Received: from gofer.mess.org ([88.97.38.141]:35769 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgDWJsD (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 23 Apr 2020 05:48:03 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 2FC59C6366; Thu, 23 Apr 2020 10:48:02 +0100 (BST)
Date:   Thu, 23 Apr 2020 10:48:01 +0100
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.8] Minor fixes
Message-ID: <20200423094801.GA17856@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Here the smatch fix, coverity fix, and a minor rc-core improvement. The
later is for the use-case "I want all my IR decoders to be BPF".

Thanks,
Sean

The following changes since commit 4bdbff4da40584ec2225bb429b7c66ad54d19cda:

  media: tuners: Kconfig: add some missing VIDEO_V4L2 dependencies (2020-04-23 07:57:27 +0200)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git tags/v5.8c

for you to fetch changes up to 2a3745d69541c7d6d38b94ca8ec89a1a5817d3a1:

  media: si2157: ensure wait_status is initialized (2020-04-23 09:36:19 +0100)

----------------------------------------------------------------
v5.8c

----------------------------------------------------------------
Sean Young (3):
      media: m88ds3103: error in set_frontend is swallowed and not reported
      media: rc: no need for decoder state if decoder not enabled
      media: si2157: ensure wait_status is initialized

 drivers/media/dvb-frontends/m88ds3103.c |  2 ++
 drivers/media/rc/rc-core-priv.h         | 22 ++++++++++++++++++++++
 drivers/media/tuners/si2157.c           |  5 ++++-
 3 files changed, 28 insertions(+), 1 deletion(-)
