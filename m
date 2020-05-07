Return-Path: <SRS0=aOuj=6V=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E1C38A2A
	for <linux-media@archiver.kernel.org>; Thu,  7 May 2020 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AD32082E
	for <linux-media@archiver.kernel.org>; Thu,  7 May 2020 13:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgEGNxk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 7 May 2020 09:53:40 -0400
Received: from gofer.mess.org ([88.97.38.141]:44657 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgEGNxj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 7 May 2020 09:53:39 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id B8616C6419; Thu,  7 May 2020 14:53:37 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 1/3] input: add support for the USB IR Toy and USB IR Droid
Date:   Thu,  7 May 2020 14:53:35 +0100
Message-Id: <20200507135337.2343-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add new serio ID for the USB IR Toy and IR Droid IR transceivers.

More information about the hardware:

http://dangerousprototypes.com/docs/USB_Infrared_Toy
https://www.irdroid.com/irdroid-usb-ir-transceiver/

Signed-off-by: Sean Young <sean@mess.org>
---
 include/uapi/linux/serio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/serio.h b/include/uapi/linux/serio.h
index ed2a96f43ce4f..00c0be2546e93 100644
--- a/include/uapi/linux/serio.h
+++ b/include/uapi/linux/serio.h
@@ -83,5 +83,6 @@
 #define SERIO_PULSE8_CEC	0x40
 #define SERIO_RAINSHADOW_CEC	0x41
 #define SERIO_FSIA6B	0x42
+#define SERIO_IRTOY	0x43
 
 #endif /* _UAPI_SERIO_H */
-- 
2.26.2

