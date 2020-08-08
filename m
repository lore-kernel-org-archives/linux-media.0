Return-Path: <SRS0=5NOB=BS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68CFC433DF
	for <linux-media@archiver.kernel.org>; Sat,  8 Aug 2020 20:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD47206CD
	for <linux-media@archiver.kernel.org>; Sat,  8 Aug 2020 20:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHHUd6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 8 Aug 2020 16:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgHHUd5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 8 Aug 2020 16:33:57 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78DFC061A27
        for <linux-media@vger.kernel.org>; Sat,  8 Aug 2020 13:33:56 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 6875BC6373; Sat,  8 Aug 2020 21:33:52 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH v2 2/2] media: rc: do not access device via sysfs after rc_unregister_device()
Date:   Sat,  8 Aug 2020 21:33:52 +0100
Message-Id: <20200808203352.9793-2-sean@mess.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808203352.9793-1-sean@mess.org>
References: <20200808203352.9793-1-sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Device drivers do not expect to have change_protocol or wakeup
re-programming to be accesed after rc_unregister_device(). This can
cause the device driver to access deallocated resources.

Cc: <stable@vger.kernel.org> # 4.16
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/rc-main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index e1cda80a4b25..dee8a9f3d80a 100644
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

