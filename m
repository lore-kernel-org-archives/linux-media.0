Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF02C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC11218D9
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfDLXpi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:45:38 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:59307 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727130AbfDLXpi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 19:45:38 -0400
X-Halon-ID: 0f0bb8b3-5d7d-11e9-8fa2-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [89.233.230.99])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 0f0bb8b3-5d7d-11e9-8fa2-005056917a89;
        Sat, 13 Apr 2019 01:45:32 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 7/8] rcar-vin: Fold rvin_initialize_device() into rvin_open()
Date:   Sat, 13 Apr 2019 01:43:58 +0200
Message-Id: <20190412234359.5079-8-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The function no longer serve a purpose as most tasks it performed have
been refactored, fold what remains it into the only caller.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index 3b4624c117aaba18..58d0b59ee1247c8f 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -762,20 +762,6 @@ static int rvin_power_parallel(struct rvin_dev *vin, int on)
 	return 0;
 }
 
-static int rvin_initialize_device(struct file *file)
-{
-	struct rvin_dev *vin = video_drvdata(file);
-	int ret;
-
-	ret = rvin_power_parallel(vin, 1);
-	if (ret < 0)
-		return ret;
-
-	v4l2_ctrl_handler_setup(&vin->ctrl_handler);
-
-	return 0;
-}
-
 static int rvin_open(struct file *file)
 {
 	struct rvin_dev *vin = video_drvdata(file);
@@ -796,10 +782,11 @@ static int rvin_open(struct file *file)
 		goto err_pm;
 
 	if (v4l2_fh_is_singular_file(file)) {
-		if (rvin_initialize_device(file)) {
-			ret = -ENODEV;
+		ret = rvin_power_parallel(vin, 1);
+		if (ret < 0)
 			goto err_open;
-		}
+
+		v4l2_ctrl_handler_setup(&vin->ctrl_handler);
 	}
 
 	mutex_unlock(&vin->lock);
-- 
2.21.0

