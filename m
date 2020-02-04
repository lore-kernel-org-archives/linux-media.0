Return-Path: <SRS0=VKxf=3Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A57EC35247
	for <linux-media@archiver.kernel.org>; Tue,  4 Feb 2020 21:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DEE2084E
	for <linux-media@archiver.kernel.org>; Tue,  4 Feb 2020 21:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBDVpM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:45:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBDVpM (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 4 Feb 2020 16:45:12 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:810a:113f:ad1c:28d4:5c9b:1c04:c661])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 832102902FB;
        Tue,  4 Feb 2020 21:45:10 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org
Subject: [PATCH] media: staging: rkisp1: don't lock media's graph_mutex when calling rkisp1_create_links
Date:   Tue,  4 Feb 2020 22:44:44 +0100
Message-Id: <20200204214446.20381-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The function rkisp1_create_links calls media_entity_get_fwnode_pad
and media_create_pad_link in the mc api. Those calls don't require
locking the graph_mutex so remove the locking.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-dev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-dev.c b/drivers/staging/media/rkisp1/rkisp1-dev.c
index 9d866396a5de..64e61ab29143 100644
--- a/drivers/staging/media/rkisp1/rkisp1-dev.c
+++ b/drivers/staging/media/rkisp1/rkisp1-dev.c
@@ -219,19 +219,17 @@ static int rkisp1_subdev_notifier_complete(struct v4l2_async_notifier *notifier)
 		container_of(notifier, struct rkisp1_device, notifier);
 	int ret;
 
-	mutex_lock(&rkisp1->media_dev.graph_mutex);
 	ret = rkisp1_create_links(rkisp1);
 	if (ret)
-		goto unlock;
+		return ret;
+
 	ret = v4l2_device_register_subdev_nodes(&rkisp1->v4l2_dev);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	dev_dbg(rkisp1->dev, "Async subdev notifier completed\n");
 
-unlock:
-	mutex_unlock(&rkisp1->media_dev.graph_mutex);
-	return ret;
+	return 0;
 }
 
 static int rkisp1_fwnode_parse(struct device *dev,
-- 
2.17.1

