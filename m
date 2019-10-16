Return-Path: <SRS0=3WN/=YJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FB4FA372B
	for <linux-media@archiver.kernel.org>; Wed, 16 Oct 2019 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358982064B
	for <linux-media@archiver.kernel.org>; Wed, 16 Oct 2019 17:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfJPR0F (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:26:05 -0400
Received: from gofer.mess.org ([88.97.38.141]:37999 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfJPR0F (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:05 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 69EE7C6358; Wed, 16 Oct 2019 18:19:15 +0100 (BST)
Date:   Wed, 16 Oct 2019 18:19:15 +0100
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Vito Caputo <vcaputo@pengaru.com>
Subject: [PATCH] media: imon: invalid dereference in imon_touch_event
Message-ID: <20191016171915.GA10573@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The touch timer is set up in intf1. If the second interface does not exist,
the timer and touch input device are not setup and we get the following
error, when touch events are reported via intf0.

Reported-by: syzbot+f49d12d34f2321cf4df2@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/imon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index b8d96c50a804..ed95244da894 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1627,8 +1627,7 @@ static void imon_incoming_packet(struct imon_context *ictx,
 	spin_unlock_irqrestore(&ictx->kc_lock, flags);
 
 	/* send touchscreen events through input subsystem if touchpad data */
-	if (ictx->display_type == IMON_DISPLAY_TYPE_VGA && len == 8 &&
-	    buf[7] == 0x86) {
+	if (ictx->touch && len == 8 && buf[7] == 0x86) {
 		imon_touch_event(ictx, buf);
 		return;
 
-- 
2.21.0

