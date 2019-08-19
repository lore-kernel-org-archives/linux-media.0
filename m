Return-Path: <SRS0=OySw=WP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D92C3A59D
	for <linux-media@archiver.kernel.org>; Mon, 19 Aug 2019 11:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEED82086C
	for <linux-media@archiver.kernel.org>; Mon, 19 Aug 2019 11:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfHSLb2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:31:28 -0400
Received: from gofer.mess.org ([88.97.38.141]:52165 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSLb2 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Aug 2019 07:31:28 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id F187660E3B; Mon, 19 Aug 2019 12:31:26 +0100 (BST)
Date:   Mon, 19 Aug 2019 12:31:26 +0100
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.4] Various fixes DVB/RC
Message-ID: <20190819113126.fo3dvsux5eogcq5b@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

This PR includes A Sun's re-write of mceusb Tx, some new keymaps and some
of fixes.

Thanks,
Sean

The following changes since commit 31d5d15dfc3418a57cfab419a353d8dc5f5698b5:

  media: MAINTAINERS: Add entry for the ov5670 driver (2019-08-15 08:17:04 -0300)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git tags/v5.4d

for you to fetch changes up to 3bd8a3e22d3bb4b04604c1f35905a2083ce4600e:

  media: dvb-core: fix a memory leak bug (2019-08-19 12:08:24 +0100)

----------------------------------------------------------------
A Sun (1):
      mceusb: fix (eliminate) TX IR signal length limit

Christian Hewitt (7):
      media: rc: add keymap for Amediatech X96-MAX remote
      media: rc: add keymap for Khadas VIM/EDGE remote
      media: rc: add keymap for Tanix TX3 mini remote
      media: rc: add keymap for Tanix TX5 max remote
      media: rc: add keymap for WeTek Hub remote
      media: rc: add keymap for WeTeK Play 2 remote
      media: rc: add keymap for HardKernel ODROID remote

Marc Gonzalez (1):
      media: si2168: Refactor command setup code

Sean Young (2):
      media: dvb-frontends: use ida for pll number
      media: ttpci: unknown protocol is rc-mm-32

Wenwen Wang (3):
      media: dvb-frontends: fix memory leaks
      media: dvb-frontends: fix a memory leak bug
      media: dvb-core: fix a memory leak bug

 drivers/media/dvb-core/dvbdev.c             |   4 +-
 drivers/media/dvb-frontends/cx24117.c       |   4 +-
 drivers/media/dvb-frontends/dib7000p.c      |   7 +-
 drivers/media/dvb-frontends/dvb-pll.c       |  40 ++--
 drivers/media/dvb-frontends/si2168.c        | 159 ++++---------
 drivers/media/pci/ttpci/av7110_ir.c         |  14 +-
 drivers/media/rc/keymaps/Makefile           |   7 +
 drivers/media/rc/keymaps/rc-khadas.c        |  54 +++++
 drivers/media/rc/keymaps/rc-odroid.c        |  54 +++++
 drivers/media/rc/keymaps/rc-tanix-tx3mini.c |  77 +++++++
 drivers/media/rc/keymaps/rc-tanix-tx5max.c  |  68 ++++++
 drivers/media/rc/keymaps/rc-wetek-hub.c     |  53 +++++
 drivers/media/rc/keymaps/rc-wetek-play2.c   |  93 ++++++++
 drivers/media/rc/keymaps/rc-x96max.c        |  83 +++++++
 drivers/media/rc/mceusb.c                   | 334 ++++++++++++++++------------
 include/media/rc-map.h                      |   7 +
 16 files changed, 781 insertions(+), 277 deletions(-)
 create mode 100644 drivers/media/rc/keymaps/rc-khadas.c
 create mode 100644 drivers/media/rc/keymaps/rc-odroid.c
 create mode 100644 drivers/media/rc/keymaps/rc-tanix-tx3mini.c
 create mode 100644 drivers/media/rc/keymaps/rc-tanix-tx5max.c
 create mode 100644 drivers/media/rc/keymaps/rc-wetek-hub.c
 create mode 100644 drivers/media/rc/keymaps/rc-wetek-play2.c
 create mode 100644 drivers/media/rc/keymaps/rc-x96max.c
