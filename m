Return-Path: <SRS0=DdSm=XZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F857C388F3
	for <linux-media@archiver.kernel.org>; Mon, 30 Sep 2019 08:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F02086A
	for <linux-media@archiver.kernel.org>; Mon, 30 Sep 2019 08:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfI3Iy3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:54:29 -0400
Received: from gofer.mess.org ([88.97.38.141]:51745 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfI3Iy3 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Sep 2019 04:54:29 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 41E86C646D; Mon, 30 Sep 2019 09:54:28 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] media: rc: mark input device as pointing stick
Date:   Mon, 30 Sep 2019 09:54:28 +0100
Message-Id: <20190930085428.19330-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

libinput refuses pointer movement from rc-core, since it believes it's not
a pointer-type device:

libinput error: event17 - Media Center Ed. eHome Infrared Remote Transceiver (1784:0008): libinput bug: REL_X/Y from a non-pointer device

Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/rc-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 13da4c5c7d17..7741151606ef 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1773,6 +1773,7 @@ static int rc_prepare_rx_device(struct rc_dev *dev)
 	set_bit(MSC_SCAN, dev->input_dev->mscbit);
 
 	/* Pointer/mouse events */
+	set_bit(INPUT_PROP_POINTING_STICK, dev->input_dev->propbit);
 	set_bit(EV_REL, dev->input_dev->evbit);
 	set_bit(REL_X, dev->input_dev->relbit);
 	set_bit(REL_Y, dev->input_dev->relbit);
-- 
2.21.0

