Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB1CC433E0
	for <linux-media@archiver.kernel.org>; Wed, 10 Mar 2021 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946B064FF1
	for <linux-media@archiver.kernel.org>; Wed, 10 Mar 2021 08:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCJIwb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:52:31 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57338 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232484AbhCJIwT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Mar 2021 03:52:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0URGKhcv_1615366335;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0URGKhcv_1615366335)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 16:52:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] media: i2c: remove unneeded variable 'ret'
Date:   Wed, 10 Mar 2021 16:52:14 +0800
Message-Id: <1615366334-11126-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix the following coccicheck warning:
./drivers/media/i2c/ov8865.c:2527:5-8: Unneeded variable: "ret". Return
"0" on line 2536

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/i2c/ov8865.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index 36a60fb..2db052f 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -2524,7 +2524,6 @@ static int ov8865_g_frame_interval(struct v4l2_subdev *subdev,
 {
 	struct ov8865_sensor *sensor = ov8865_subdev_sensor(subdev);
 	const struct ov8865_mode *mode;
-	int ret = 0;
 
 	mutex_lock(&sensor->mutex);
 
@@ -2533,7 +2532,7 @@ static int ov8865_g_frame_interval(struct v4l2_subdev *subdev,
 
 	mutex_unlock(&sensor->mutex);
 
-	return ret;
+	return 0;
 }
 
 static const struct v4l2_subdev_video_ops ov8865_subdev_video_ops = {
-- 
1.8.3.1

