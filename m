Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C08C433DB
	for <linux-media@archiver.kernel.org>; Sun, 27 Dec 2020 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F041207E8
	for <linux-media@archiver.kernel.org>; Sun, 27 Dec 2020 13:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgL0Npp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 27 Dec 2020 08:45:45 -0500
Received: from gofer.mess.org ([88.97.38.141]:43109 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgL0Npo (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 27 Dec 2020 08:45:44 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 82A21C634D; Sun, 27 Dec 2020 13:45:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1609076702; bh=U5FwOOLb7pgg8vrdfl12PWCnlc5piNmkT5R2/yMxG8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnBh7tm4xaYRafGn76R/MeqvRc/jS3iZgzPXV92hl+Rkts+GqYrJ+9616DM+uiE8/
         BaP0QiBhFYp4CnATy+U8ORQ7QZUAUyMlEDmphtaooW0e8L9snRX5hBVDKOPerUXbIo
         H6Bm4HiTqkYJrvx1mn0KfAeeYttNV3eOYAbU4Xld03pvy14uSes0ycXjYmOM94W+uA
         65s3FFXeb8mmqs8SKzM8XqSKkBG8Gb+pv+A3PNiHbSWDUUFtlqaz1yNVtJfq/TBTXS
         /QchDjq3ln99oUv29seAfieM+KwUFITnz+JDzuEII1NYbRhSxKzMpxlIotYieuEDDv
         fSA/AaZ9sjqGQ==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Georgi Bakalski <georgi.bakalski@gmail.com>
Subject: [PATCH 2/2] cdc-acm: blacklist another IR Droid device
Date:   Sun, 27 Dec 2020 13:45:02 +0000
Message-Id: <20201227134502.4548-2-sean@mess.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201227134502.4548-1-sean@mess.org>
References: <20201227134502.4548-1-sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This device is supported by the IR Toy driver.

Reported-by: Georgi Bakalski <georgi.bakalski@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/usb/class/cdc-acm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index f52f1bc0559f..781905745812 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1895,6 +1895,10 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x04d8, 0xfd08),
 	.driver_info = IGNORE_DEVICE,
 	},
+
+	{ USB_DEVICE(0x04d8, 0xf58b),
+	.driver_info = IGNORE_DEVICE,
+	},
 #endif
 
 	/*Samsung phone in firmware update mode */
-- 
2.29.2

