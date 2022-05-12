Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4C0C433EF
	for <linux-media@archiver.kernel.org>; Thu, 12 May 2022 13:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354086AbiELND1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 May 2022 09:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352178AbiELND0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 May 2022 09:03:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF4F64BE9
        for <linux-media@vger.kernel.org>; Thu, 12 May 2022 06:03:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B5721F8FB;
        Thu, 12 May 2022 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652360604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=T5uYi+yCDDdRJVyEW3ZrKCKR5rECkhGhNb26kSHUtoE=;
        b=fiha43UgX0NTMUQq/Cjt8yfe0Y8Dz8g/GKxnfoHF/UxMxZIWM4cRlRL8QbNl2uLJhLXp6p
        aP5So8FgeUP6IJ7u0hUzx3A5FFBezstr+gYexFTMAMifSwe4zb3POfRd2o07qBbAB+oocS
        gr+ap+7ruZWCyHE4uq8OqDYLCb5lDgs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09BEE13ABE;
        Thu, 12 May 2022 13:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k8qkAJwFfWLyKAAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 12 May 2022 13:03:24 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     linux-media@vger.kernel.org, mchehab@kernel.org, sean@mess.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] imon_raw: respect DMA coherency
Date:   Thu, 12 May 2022 15:03:21 +0200
Message-Id: <20220512130321.30599-1-oneukum@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

No buffer can be embedded inside a descriptor, not even a simple be64.
Use a separate kmalloc()

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/rc/imon_raw.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/imon_raw.c b/drivers/media/rc/imon_raw.c
index d41580f6e4c7..b7a0c0b34378 100644
--- a/drivers/media/rc/imon_raw.c
+++ b/drivers/media/rc/imon_raw.c
@@ -14,7 +14,7 @@ struct imon {
 	struct device *dev;
 	struct urb *ir_urb;
 	struct rc_dev *rcdev;
-	__be64 ir_buf;
+	__be64 *ir_buf;
 	char phys[64];
 };
 
@@ -137,10 +137,16 @@ static int imon_probe(struct usb_interface *intf,
 	if (!imon->ir_urb)
 		return -ENOMEM;
 
+	imon->ir_buf = kmalloc(sizeof(__be64), GFP_KERNEL);
+	if (!imon->ir_buf) {
+		ret = -ENOMEM;
+		goto free_urb;
+	}
+
 	imon->dev = &intf->dev;
 	usb_fill_int_urb(imon->ir_urb, udev,
 			 usb_rcvintpipe(udev, ir_ep->bEndpointAddress),
-			 &imon->ir_buf, sizeof(imon->ir_buf),
+			 imon->ir_buf, sizeof(__be64),
 			 imon_ir_rx, imon, ir_ep->bInterval);
 
 	rcdev = devm_rc_allocate_device(&intf->dev, RC_DRIVER_IR_RAW);
@@ -177,6 +183,7 @@ static int imon_probe(struct usb_interface *intf,
 
 free_urb:
 	usb_free_urb(imon->ir_urb);
+	kfree(imon->ir_buf);
 	return ret;
 }
 
@@ -186,6 +193,7 @@ static void imon_disconnect(struct usb_interface *intf)
 
 	usb_kill_urb(imon->ir_urb);
 	usb_free_urb(imon->ir_urb);
+	kfree(imon->ir_buf);
 }
 
 static const struct usb_device_id imon_table[] = {
-- 
2.35.3

