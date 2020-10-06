Return-Path: <SRS0=ILh3=DN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69364C41604
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20D5206F7
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 18:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tent.at header.i=@tent.at header.b="B7bj28rU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgJFSSw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 6 Oct 2020 14:18:52 -0400
Received: from irn-bru.nerdsurf.de ([178.63.114.209]:47082 "EHLO
        irn-bru.nerdsurf.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFSSw (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 6 Oct 2020 14:18:52 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 14:18:51 EDT
Received: from texa.stuttgart.nerdsurf.de (unknown [172.23.27.116])
        by irn-bru.nerdsurf.de (Postfix) with ESMTP id 0E437540658;
        Tue,  6 Oct 2020 20:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tent.at; s=mail20151109;
        t=1602008003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tE4VXulymaNnmfDTAhU1VMVrF6bGYDBlNodvsuXMOKw=;
        b=B7bj28rU1b4fo/QBVaUA6JgUhGpKgE7QJrFABC3Aoj9KmGJZ4j7GxyzXziUQrXHqQWDGLs
        KT++lbm5bCZ0PB72ur+zc3eNXeZ7j7oORrUKRSAUpSGb1uzbuVhCRHnEv1hsCiTwu0uq3O
        ZlUCyw/lzye7x5QSpdFxZpvbi09GUOA=
From:   Kai Muenz <squ@tent.at>
To:     linux-media@vger.kernel.org
Cc:     Kai Muenz <squ@tent.at>
Subject: [PATCH] Added Hauppauge MAX S2's USB-IDs to dw2102.c
Date:   Tue,  6 Oct 2020 20:13:09 +0200
Message-Id: <20201006181309.542700-1-squ@tent.at>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Signed-off-by: Kai Muenz <squ@tent.at>
---
 drivers/media/usb/dvb-usb/dw2102.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index a27a68440..ab31b1e37 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -1770,6 +1770,7 @@ enum dw2102_table_entry {
 	TEVII_S660,
 	PROF_7500,
 	GENIATECH_SU3000,
+    HAUPPAUGE_MAX_S2,
 	TERRATEC_CINERGY_S2,
 	TEVII_S480_1,
 	TEVII_S480_2,
@@ -1802,6 +1803,7 @@ static struct usb_device_id dw2102_table[] = {
 	[TEVII_S660] = {USB_DEVICE(0x9022, USB_PID_TEVII_S660)},
 	[PROF_7500] = {USB_DEVICE(0x3034, 0x7500)},
 	[GENIATECH_SU3000] = {USB_DEVICE(0x1f4d, 0x3000)},
+	[HAUPPAUGE_MAX_S2] = {USB_DEVICE(0x2040, 0xd900)},
 	[TERRATEC_CINERGY_S2] = {USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_S2_R1)},
 	[TEVII_S480_1] = {USB_DEVICE(0x9022, USB_PID_TEVII_S480_1)},
 	[TEVII_S480_2] = {USB_DEVICE(0x9022, USB_PID_TEVII_S480_2)},
@@ -2230,12 +2232,16 @@ static struct dvb_usb_device_properties su3000_properties = {
 		}},
 		}
 	},
-	.num_device_descs = 8,
+	.num_device_descs = 9,
 	.devices = {
 		{ "SU3000HD DVB-S USB2.0",
 			{ &dw2102_table[GENIATECH_SU3000], NULL },
 			{ NULL },
 		},
+		{ "Hauppauge MAX S2 or WinTV NOVA HD USB2.0",
+			{ &dw2102_table[HAUPPAUGE_MAX_S2], NULL },
+			{ NULL },
+		},
 		{ "Terratec Cinergy S2 USB HD",
 			{ &dw2102_table[TERRATEC_CINERGY_S2], NULL },
 			{ NULL },
-- 
2.28.0

