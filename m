Return-Path: <SRS0=Zkfq=WN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F6C3A59B
	for <linux-media@archiver.kernel.org>; Sat, 17 Aug 2019 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204E52077C
	for <linux-media@archiver.kernel.org>; Sat, 17 Aug 2019 12:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfHQMCm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 17 Aug 2019 08:02:42 -0400
Received: from gofer.mess.org ([88.97.38.141]:45783 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfHQMCm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 17 Aug 2019 08:02:42 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 043BE60589; Sat, 17 Aug 2019 13:02:40 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH] media: ttpci: unknown protocol is rc-mm-32
Date:   Sat, 17 Aug 2019 13:02:40 +0100
Message-Id: <20190817120240.30962-1-sean@mess.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This protocol responds to a real philips rc-mm remote; it does not respond
to IR encoded with the encoder in ir-rcmm-decoder.c.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/pci/ttpci/av7110_ir.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/media/pci/ttpci/av7110_ir.c b/drivers/media/pci/ttpci/av7110_ir.c
index 432789a3c312..a851ba328e4a 100644
--- a/drivers/media/pci/ttpci/av7110_ir.c
+++ b/drivers/media/pci/ttpci/av7110_ir.c
@@ -37,12 +37,10 @@ void av7110_ir_handler(struct av7110 *av7110, u32 ircom)
 			proto = RC_PROTO_RC5;
 			break;
 
-		case IR_RCMM: /* RCMM: ? bits device address, ? bits command */
-			command = ircom & 0xff;
-			addr = (ircom >> 8) & 0x1f;
-			scancode = ircom;
+		case IR_RCMM: /* RCMM: 32 bits scancode */
+			scancode = ircom & ~0x8000;
 			toggle = ircom & 0x8000;
-			proto = RC_PROTO_UNKNOWN;
+			proto = RC_PROTO_RCMM32;
 			break;
 
 		case IR_RC5_EXT:
@@ -83,9 +81,9 @@ static int change_protocol(struct rc_dev *rcdev, u64 *rc_type)
 	struct av7110 *av7110 = rcdev->priv;
 	u32 ir_config;
 
-	if (*rc_type & RC_PROTO_BIT_UNKNOWN) {
+	if (*rc_type & RC_PROTO_BIT_RCMM32) {
 		ir_config = IR_RCMM;
-		*rc_type = RC_PROTO_UNKNOWN;
+		*rc_type = RC_PROTO_BIT_RCMM32;
 	} else if (*rc_type & RC_PROTO_BIT_RC5) {
 		if (FW_VERSION(av7110->arm_app) >= 0x2620)
 			ir_config = IR_RC5_EXT;
@@ -133,7 +131,7 @@ int av7110_ir_init(struct av7110 *av7110)
 	}
 
 	rcdev->dev.parent = &pci->dev;
-	rcdev->allowed_protocols = RC_PROTO_BIT_RC5 | RC_PROTO_BIT_UNKNOWN;
+	rcdev->allowed_protocols = RC_PROTO_BIT_RC5 | RC_PROTO_BIT_RCMM32;
 	rcdev->change_protocol = change_protocol;
 	rcdev->map_name = RC_MAP_HAUPPAUGE;
 	rcdev->priv = av7110;
-- 
2.21.0

