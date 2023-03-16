Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28459C6FD1F
	for <linux-media@archiver.kernel.org>; Thu, 16 Mar 2023 13:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCPNPT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCPNPR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Mar 2023 09:15:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A3B8570;
        Thu, 16 Mar 2023 06:15:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F9D41FE03;
        Thu, 16 Mar 2023 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678972511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kHLikiOj78KpDaSRuFeAp2LYuAcgKq6uGmUiwSMAIm8=;
        b=BeXr7QysMw8BmjVaU4Kszk+vYNFQT3TVNmhgUenHWOsLh51L7x5VTSXKDzQ++KRPxY4Oj/
        GTUQPUZfbn0D7RLoq+wLVeCt/HSwxh0tbZuxdd9CUNYMsX5r7Pi3rgv8EYdMieGVWCJVPN
        LRE/Al2HiYo7Bprt//F0sifXqU23X0E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D85A913A2F;
        Thu, 16 Mar 2023 13:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EHvvMl4WE2QGQQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 16 Mar 2023 13:15:10 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] usbtv: usbtv_set_regs: the pipe is output
Date:   Thu, 16 Mar 2023 14:15:07 +0100
Message-Id: <20230316131507.26748-1-oneukum@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

We are setting a value. That is output and
the pipe has to match that.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/usb/usbtv/usbtv-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/usbtv/usbtv-core.c b/drivers/media/usb/usbtv/usbtv-core.c
index 2308c0b4f5e7..1f7620cd2996 100644
--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -47,7 +47,7 @@
 int usbtv_set_regs(struct usbtv *usbtv, const u16 regs[][2], int size)
 {
 	int ret;
-	int pipe = usb_rcvctrlpipe(usbtv->udev, 0);
+	int pipe = usb_sndctrlpipe(usbtv->udev, 0);
 	int i;
 
 	for (i = 0; i < size; i++) {
-- 
2.39.2

