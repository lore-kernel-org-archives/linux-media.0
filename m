Return-Path: <SRS0=5NOB=BS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12095C433DF
	for <linux-media@archiver.kernel.org>; Sat,  8 Aug 2020 12:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D0E20759
	for <linux-media@archiver.kernel.org>; Sat,  8 Aug 2020 12:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHHMbZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:31:25 -0400
Received: from gofer.mess.org ([88.97.38.141]:57343 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgHHMbY (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 8 Aug 2020 08:31:24 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 5C96CC63AE; Sat,  8 Aug 2020 13:31:23 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH 2/2] media: rc: do not access device via sysfs after rc_unregister_device()
Date:   Sat,  8 Aug 2020 13:31:23 +0100
Message-Id: <20200808123123.1804-2-sean@mess.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808123123.1804-1-sean@mess.org>
References: <20200808123123.1804-1-sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Device drivers do not expect to have change_protocol or wakeup
re-programming to be accesed after rc_unregister_device(). This can
cause the device driver to access deallocated resources.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/rc-main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 503ae4f3dec3..c629941f309a 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1292,6 +1292,10 @@ static ssize_t store_protocols(struct device *device,
 	}
 
 	mutex_lock(&dev->lock);
+	if (!dev->registered) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
 
 	old_protocols = *current_protocols;
 	new_protocols = old_protocols;
@@ -1430,6 +1434,10 @@ static ssize_t store_filter(struct device *device,
 		return -EINVAL;
 
 	mutex_lock(&dev->lock);
+	if (!dev->registered) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
 
 	new_filter = *filter;
 	if (fattr->mask)
@@ -1544,6 +1552,10 @@ static ssize_t store_wakeup_protocols(struct device *device,
 	int i;
 
 	mutex_lock(&dev->lock);
+	if (!dev->registered) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
 
 	allowed = dev->allowed_wakeup_protocols;
 
-- 
2.26.2

