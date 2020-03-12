Return-Path: <SRS0=Lc/z=45=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A20C10DCE
	for <linux-media@archiver.kernel.org>; Thu, 12 Mar 2020 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5695F2067C
	for <linux-media@archiver.kernel.org>; Thu, 12 Mar 2020 09:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCLJWr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:22:47 -0400
Received: from gofer.mess.org ([88.97.38.141]:44079 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgCLJWq (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Mar 2020 05:22:46 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 55FDFC6366; Thu, 12 Mar 2020 09:22:45 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] media: dvb: digitv: remove unused array element 0
Date:   Thu, 12 Mar 2020 09:22:45 +0000
Message-Id: <20200312092245.4471-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The first element of the key array is not used. Remove it, and
along with it a uninitialized memory read.

This should fix the rc debug message.

Link: https://www.spinics.net/lists/kernel/msg3374861.html

Suggested-by: Phong Tran <tranmanphong@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/usb/dvb-usb/digitv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/digitv.c b/drivers/media/usb/dvb-usb/digitv.c
index 99a39339d45d..8ae259693900 100644
--- a/drivers/media/usb/dvb-usb/digitv.c
+++ b/drivers/media/usb/dvb-usb/digitv.c
@@ -231,13 +231,13 @@ static struct rc_map_table rc_map_digitv_table[] = {
 static int digitv_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
 {
 	int ret, i;
-	u8 key[5];
+	u8 key[4];
 	u8 b[4] = { 0 };
 
 	*event = 0;
 	*state = REMOTE_NO_KEY_PRESSED;
 
-	ret = digitv_ctrl_msg(d, USB_READ_REMOTE, 0, NULL, 0, &key[1], 4);
+	ret = digitv_ctrl_msg(d, USB_READ_REMOTE, 0, NULL, 0, key, 4);
 	if (ret)
 		return ret;
 
@@ -248,20 +248,20 @@ static int digitv_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
 		return ret;
 
 	/* if something is inside the buffer, simulate key press */
-	if (key[1] != 0)
+	if (key[0] != 0)
 	{
 		  for (i = 0; i < d->props.rc.legacy.rc_map_size; i++) {
-			if (rc5_custom(&d->props.rc.legacy.rc_map_table[i]) == key[1] &&
-			    rc5_data(&d->props.rc.legacy.rc_map_table[i]) == key[2]) {
+			if (rc5_custom(&d->props.rc.legacy.rc_map_table[i]) == key[0] &&
+			    rc5_data(&d->props.rc.legacy.rc_map_table[i]) == key[1]) {
 				*event = d->props.rc.legacy.rc_map_table[i].keycode;
 				*state = REMOTE_KEY_PRESSED;
 				return 0;
 			}
 		}
+
+		deb_rc("key: %*ph\n", 4, key);
 	}
 
-	if (key[0] != 0)
-		deb_rc("key: %*ph\n", 5, key);
 	return 0;
 }
 
-- 
2.24.1

