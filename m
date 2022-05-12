Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC8FC4332F
	for <linux-media@archiver.kernel.org>; Thu, 12 May 2022 12:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353820AbiELMeF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 May 2022 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353806AbiELMeB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 May 2022 08:34:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91436644C3
        for <linux-media@vger.kernel.org>; Thu, 12 May 2022 05:33:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4226F21C73;
        Thu, 12 May 2022 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652358838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cl1chpKtxWdZhiKHeu+ldZiumzQWQfZbSHf2WvQ8XlY=;
        b=r2GKhCmjlgRCPLUTdHQY9JIbQWdQZ3MUyuW6xuzFwbmBzmpfK7GjwZ5rpg90z2wt4wCmY2
        GHgIumcEyXHMJBtA7YXuY+IcXNOmTKf4K4Lgt7GpMpkzEeWtFygOK7KPB2btIUDd/Lj1uT
        Zw1mkVGRLYXdJoOAe7f9CHPsKcjGPg8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1385113ABE;
        Thu, 12 May 2022 12:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aFMAA7b+fGL+GAAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 12 May 2022 12:33:58 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     linux-media@vger.kernel.org, mchehab@kernel.org, sean@mess.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/3] igorplugusb: break cyclical race on disconnect
Date:   Thu, 12 May 2022 14:33:53 +0200
Message-Id: <20220512123354.25766-2-oneukum@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512123354.25766-1-oneukum@suse.com>
References: <20220512123354.25766-1-oneukum@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The driver uses a timer, that may submit the URB and
the URB may start the timer. No simple order of killing
can break te cycle. Poison the URB before killing
the timer.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/rc/igorplugusb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index 1afba95409ff..b2245849f7aa 100644
--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -126,7 +126,7 @@ static void igorplugusb_cmd(struct igorplugusb *ir, int cmd)
 	ir->request.bRequest = cmd;
 	ir->urb->transfer_flags = 0;
 	ret = usb_submit_urb(ir->urb, GFP_ATOMIC);
-	if (ret)
+	if (ret && ret != -EPERM)
 		dev_err(ir->dev, "submit urb failed: %d", ret);
 }
 
@@ -223,7 +223,9 @@ static int igorplugusb_probe(struct usb_interface *intf,
 
 	return 0;
 fail:
+	usb_poison_urb(ir->urb);
 	del_timer(&ir->timer);
+	usb_unpoison_urb(ir->urb);
 	usb_free_urb(ir->urb);
 	rc_free_device(ir->rc);
 	kfree(ir->buf_in);
@@ -236,9 +238,10 @@ static void igorplugusb_disconnect(struct usb_interface *intf)
 	struct igorplugusb *ir = usb_get_intfdata(intf);
 
 	rc_unregister_device(ir->rc);
+	usb_poison_urb(ir->urb);
 	del_timer_sync(&ir->timer);
 	usb_set_intfdata(intf, NULL);
-	usb_kill_urb(ir->urb);
+	usb_unpoison_urb(ir->urb);
 	usb_free_urb(ir->urb);
 	kfree(ir->buf_in);
 }
-- 
2.35.3

