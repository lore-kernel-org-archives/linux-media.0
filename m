Return-Path: <SRS0=gKyG=UM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D9C31E4A
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C37A20665
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfFMRBP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:01:15 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:7390 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbfFLXqW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 12 Jun 2019 19:46:22 -0400
X-Halon-ID: 41eb57f1-8d6c-11e9-8ab4-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [89.233.230.99])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 41eb57f1-8d6c-11e9-8ab4-005056917a89;
        Thu, 13 Jun 2019 01:46:11 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH v3 7/8] rcar-vin: Fold rvin_initialize_device() into rvin_open()
Date:   Thu, 13 Jun 2019 01:45:46 +0200
Message-Id: <20190612234547.14486-8-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612234547.14486-1-niklas.soderlund+renesas@ragnatech.se>
References: <20190612234547.14486-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The function no longer serve a purpose as most tasks it performed have
been refactored, fold what remains of it into the only caller. While at
it add error checking for v4l2_ctrl_handler_setup().

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
---
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 24 +++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index 5a01b617c87dccf1..a84a07f1588cc818 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -762,20 +762,6 @@ static int rvin_power_parallel(struct rvin_dev *vin, bool on)
 	return 0;
 }
 
-static int rvin_initialize_device(struct file *file)
-{
-	struct rvin_dev *vin = video_drvdata(file);
-	int ret;
-
-	ret = rvin_power_parallel(vin, true);
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
@@ -796,14 +782,20 @@ static int rvin_open(struct file *file)
 		goto err_unlock;
 
 	if (v4l2_fh_is_singular_file(file)) {
-		ret = rvin_initialize_device(file);
-		if (ret)
+		ret = rvin_power_parallel(vin, true);
+		if (ret < 0)
 			goto err_open;
+
+		ret = v4l2_ctrl_handler_setup(&vin->ctrl_handler);
+		if (ret)
+			goto err_parallel;
 	}
 
 	mutex_unlock(&vin->lock);
 
 	return 0;
+err_parallel:
+	rvin_power_parallel(vin, false);
 err_open:
 	v4l2_fh_release(file);
 err_unlock:
-- 
2.21.0

