Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF4FC43462
	for <linux-media@archiver.kernel.org>; Tue,  4 May 2021 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411C8613D0
	for <linux-media@archiver.kernel.org>; Tue,  4 May 2021 17:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhEDRxq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 4 May 2021 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhEDRxp (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 4 May 2021 13:53:45 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C54C061574;
        Tue,  4 May 2021 10:52:49 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 32A38C644F; Tue,  4 May 2021 18:52:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1620150765; bh=RDRCncvHWekH9yIbPPVAdzAcalVTY5F39kQIM1Ytnao=;
        h=From:To:Subject:Date:From;
        b=qbzr/0/h00Zl2AXrHreEIs6qVoDUwC+0rrgMgmwuBpJr/bUw9LILeZmiN8SSP7hAN
         EXBQkmhdAIhiHaW4kPTdzfgoX1hx8RvvkGeorKDQfpyP0Ndz/S8pjxaEaa4t/UrrXe
         8Q0OL9bpwWh/LzjOSgFoOJ/Jmx9phk0IrSYJ1QTCFZ/MyIBlaO1CjTihlBeK+MkCDJ
         yOMYRqc9rG8D+MIEWPStrMJua5R7E6ErSXSOrCKgrV0RLsTzTx6Z5rmbAKxJzfuFmM
         jpWEpzbXGVc3EIIAKj7JkjSXlzLeK95HEeq0vX5o3sB64gDYYTcQ6daOnNhDkoxK7A
         fhraRgFnMfSgQ==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Rhees <support@usbuirt.com>
Subject: [PATCH 0/3] IR driver for USB-UIRT device
Date:   Tue,  4 May 2021 18:52:42 +0100
Message-Id: <cover.1620149665.git.sean@mess.org>
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

Sean Young (3):
  USB: serial: move ftdi_sio.h into include directories
  media: rc: new driver for USB-UIRT device
  USB: serial: blacklist USB-UIRT when driver is selected

 drivers/media/rc/Kconfig                      |  11 +
 drivers/media/rc/Makefile                     |   1 +
 drivers/media/rc/uirt.c                       | 737 ++++++++++++++++++
 drivers/usb/serial/ftdi_sio.c                 |  10 +-
 .../serial => include/linux/usb}/ftdi_sio.h   |   0
 5 files changed, 758 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/rc/uirt.c
 rename {drivers/usb/serial => include/linux/usb}/ftdi_sio.h (100%)

-- 
2.31.1

