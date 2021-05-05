Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A9C43461
	for <linux-media@archiver.kernel.org>; Wed,  5 May 2021 21:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD61613D6
	for <linux-media@archiver.kernel.org>; Wed,  5 May 2021 21:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhEEV6R (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 5 May 2021 17:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhEEV6Q (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 5 May 2021 17:58:16 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7378DC06174A;
        Wed,  5 May 2021 14:57:19 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 8AE80C64B8; Wed,  5 May 2021 22:57:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1620251835; bh=JMWfX+q+aMYsZ0MVl68mCaxcNqtZHTceFaUjEMOgszY=;
        h=From:To:Subject:Date:From;
        b=Oleg0/ZiS/ZuK7SQ47L51R5NyPM6/mceNOFIsJgMWwXgQ+HHQdub7pIJZH0iXN3aR
         SZY7oBZqTASvWS9tC+zHVeBd29FXpuMrtAqVOWj8r5ecptETsnZgFWYtC5NX8ugpqq
         F5Hzx/Rv5sswRlE9/CIwUY3CT3MRt1/MrBdeIjDka92nlsz90ijvDTgs/uv5hq9exn
         dOtRLxiDJMTb6GT3yELXWa234oqBk97IR4ut9RNLee5RzVxPDEaRIpUwssgDx5Jc5R
         8g7tYsJ2QFg4q2QtBAiN+oFvp/Z2UZqDW1976/flf0NWMA/l5EUbPhT/VcvJ2n7aPs
         upawllJ1+aPRg==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Rhees <support@usbuirt.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH v2 0/3] IR driver for USB-UIRT device
Date:   Wed,  5 May 2021 22:57:12 +0100
Message-Id: <cover.1620251141.git.sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This is a new rc-core driver for the USB-UIRT which you can see here
http://www.usbuirt.com/

This device is supported in lirc, via the usb serial kernel driver. This
driver is both for rc-core, which means it can use kernel/BPF decoding
ec. Also this implement is superior because it can:
 - support learning mode
 - setting transmit carrier
 - larger transmits using streaming tx command

Changes since v1:
 - Review comments from Oliver Neukum
 - Simplified wideband read function

Sean Young (3):
  USB: serial: move ftdi_sio.h into include directories
  media: rc: new driver for USB-UIRT device
  USB: serial: blacklist USB-UIRT when driver is selected

 drivers/media/rc/Kconfig                      |  11 +
 drivers/media/rc/Makefile                     |   1 +
 drivers/media/rc/uirt.c                       | 727 ++++++++++++++++++
 drivers/usb/serial/ftdi_sio.c                 |  10 +-
 .../serial => include/linux/usb}/ftdi_sio.h   |   0
 5 files changed, 748 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/rc/uirt.c
 rename {drivers/usb/serial => include/linux/usb}/ftdi_sio.h (100%)

-- 
2.31.1

