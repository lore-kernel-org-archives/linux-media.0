Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE443C433F5
	for <linux-media@archiver.kernel.org>; Tue, 17 May 2022 13:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbiEQNMZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 May 2022 09:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347863AbiEQNLT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 May 2022 09:11:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1612080
        for <linux-media@vger.kernel.org>; Tue, 17 May 2022 06:11:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5098021C4C;
        Tue, 17 May 2022 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652793072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EojGRw2U0zfKL/OdAybBVxujD6B8GmzcT2CuzIdiaL0=;
        b=CrzMYel2emUyv56Jh4T1Sj3xk+csXQcvxxnhZ/UyuFzxNrfsIAU14QSMKfoWYgQAKdnoTp
        rwPD5R5dCRqN7ZR67NnAO1sIzAZEFQzksbOlIFLrifIv8lOg8wD8ul+aDfCKxGbLW+s3ld
        TO7HYgrIda1si3CaMUF9X9Uutixri7U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1586A13AA2;
        Tue, 17 May 2022 13:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0IC/A/Ceg2KzKwAAMHmgww
        (envelope-from <oneukum@suse.com>); Tue, 17 May 2022 13:11:12 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     linux-media@vger.kernel.org, gushengxian@yulong.com,
        johan@kernel.org, hverkuil-cisco@xs4all.nl, mchehab@kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/2] flexcop: allow for modern speeds
Date:   Tue, 17 May 2022 15:11:09 +0200
Message-Id: <20220517131109.28371-2-oneukum@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220517131109.28371-1-oneukum@suse.com>
References: <20220517131109.28371-1-oneukum@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

High speed is no longer the ultimate in speed.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/usb/b2c2/flexcop-usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 98d9912a4efb..52e9964c2e59 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -525,6 +525,12 @@ static int flexcop_usb_init(struct flexcop_usb *fc_usb)
 	case USB_SPEED_HIGH:
 		info("running at HIGH speed.");
 		break;
+	case USB_SPEED_SUPER:
+		info("running at SUPER speed.");
+		break;
+	case USB_SPEED_SUPER_PLUS:
+		info("running at SUPER+ speed.");
+		break;
 	case USB_SPEED_UNKNOWN:
 	default:
 		err("cannot handle USB speed because it is unknown.");
-- 
2.35.3

