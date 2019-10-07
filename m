Return-Path: <SRS0=+Pgr=YA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B26C352AA
	for <linux-media@archiver.kernel.org>; Mon,  7 Oct 2019 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A9721655
	for <linux-media@archiver.kernel.org>; Mon,  7 Oct 2019 10:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfJGKgq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:36:46 -0400
Received: from gofer.mess.org ([88.97.38.141]:33981 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfJGKgq (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 7 Oct 2019 06:36:46 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 7EE1BC63B1; Mon,  7 Oct 2019 11:36:45 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH] media: imon_raw: simplify loop
Date:   Mon,  7 Oct 2019 11:36:45 +0100
Message-Id: <20191007103645.32065-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The code for pulse and space is the same so remove duplication.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/imon_raw.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/media/rc/imon_raw.c b/drivers/media/rc/imon_raw.c
index d4aedcf76418..aae0a3cc9479 100644
--- a/drivers/media/rc/imon_raw.c
+++ b/drivers/media/rc/imon_raw.c
@@ -57,32 +57,18 @@ static void imon_ir_data(struct imon *imon)
 		 * fls will tell us the highest bit set plus 1 (or 0 if no
 		 * bits are set).
 		 */
+		rawir.pulse = !rawir.pulse;
 		bit = fls64(data & (BIT_ULL(offset) - 1));
 		if (bit < offset) {
-			dev_dbg(imon->dev, "pulse: %d bits", offset - bit);
-			rawir.pulse = true;
+			dev_dbg(imon->dev, "%s: %d bits",
+				rawir.pulse ? "pulse" : "space", offset - bit);
 			rawir.duration = (offset - bit) * BIT_DURATION;
 			ir_raw_event_store_with_filter(imon->rcdev, &rawir);
 
-			if (bit == 0)
-				break;
-
 			offset = bit;
 		}
 
-		/*
-		 * Find highest clear bit which is less than offset.
-		 *
-		 * Just invert the data and use same trick as above.
-		 */
-		bit = fls64(~data & (BIT_ULL(offset) - 1));
-		dev_dbg(imon->dev, "space: %d bits", offset - bit);
-
-		rawir.pulse = false;
-		rawir.duration = (offset - bit) * BIT_DURATION;
-		ir_raw_event_store_with_filter(imon->rcdev, &rawir);
-
-		offset = bit;
+		data = ~data;
 	} while (offset > 0);
 
 	if (packet_no == 0x0a && !imon->rcdev->idle) {
-- 
2.21.0

