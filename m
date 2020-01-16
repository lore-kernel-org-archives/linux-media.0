Return-Path: <SRS0=OtTt=3F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782FC33CB1
	for <linux-media@archiver.kernel.org>; Thu, 16 Jan 2020 12:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C35C207E0
	for <linux-media@archiver.kernel.org>; Thu, 16 Jan 2020 12:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgAPMPy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:15:54 -0500
Received: from gofer.mess.org ([88.97.38.141]:37813 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPMPy (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Jan 2020 07:15:54 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 60F5311A001; Thu, 16 Jan 2020 12:15:53 +0000 (GMT)
Date:   Thu, 16 Jan 2020 12:15:53 +0000
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.6] DVB & RC (d)
Message-ID: <20200116121553.GA5889@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Some last small changes for v5.6. Should not be controversial.

Thanks
Sean

The following changes since commit 2a0a0bc7020ef7e66c9569d8229d79fa72e3d659:

  media: MAINTAINERS: add entry for Rockchip ISP1 driver (2020-01-09 16:45:01 +0100)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git tags/v5.6d

for you to fetch changes up to 4c0bb9b24a027500803e2635720f00d9a51e9af3:

  arm64: dts: allwinner: h6: tanix-tx6: Add IR remote mapping (2020-01-16 09:10:36 +0000)

----------------------------------------------------------------
v5.6d

----------------------------------------------------------------
Colin Ian King (1):
      media: drxj: remove redundant assignments to variable rc

Jernej Skrabec (2):
      media: dt-bindings: media: add new rc map name
      arm64: dts: allwinner: h6: tanix-tx6: Add IR remote mapping

Johan Hovold (2):
      media: flexcop-usb: fix endpoint sanity check
      media: dib0700: fix rc endpoint lookup

Mohammad Rasim (1):
      media: rc: add keymap for Videostrong KII Pro

 Documentation/devicetree/bindings/media/rc.yaml    |  1 +
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts     |  1 +
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |  4 +-
 drivers/media/rc/keymaps/Makefile                  |  1 +
 drivers/media/rc/keymaps/rc-videostrong-kii-pro.c  | 83 ++++++++++++++++++++++
 drivers/media/usb/b2c2/flexcop-usb.c               |  6 +-
 drivers/media/usb/dvb-usb/dib0700_core.c           |  4 +-
 include/media/rc-map.h                             |  1 +
 8 files changed, 94 insertions(+), 7 deletions(-)
 create mode 100644 drivers/media/rc/keymaps/rc-videostrong-kii-pro.c
