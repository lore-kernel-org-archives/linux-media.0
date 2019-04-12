Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F09BC10F14
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CD52086D
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDLXpe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:45:34 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:47963 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbfDLXpd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 19:45:33 -0400
X-Halon-ID: 0cce76cd-5d7d-11e9-8fa2-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [89.233.230.99])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 0cce76cd-5d7d-11e9-8fa2-005056917a89;
        Sat, 13 Apr 2019 01:45:28 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/8] rcar-vin: Remove unneeded calls to pm_runtime_{enable,disable}
Date:   Sat, 13 Apr 2019 01:43:53 +0200
Message-Id: <20190412234359.5079-3-niklas.soderlund+renesas@ragnatech.se>
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

Runtime PM is already enable unconditionally when the driver is probed
and disabled when it's removed. There is no point in doing it again for
Gen2 when opening and closing the video device.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index b821ea01786eb1ff..0841f1a0bfd7ba3a 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -797,8 +797,6 @@ static int rvin_initialize_device(struct file *file)
 	if (ret < 0)
 		return ret;
 
-	pm_runtime_enable(&vin->vdev.dev);
-
 	/*
 	 * Try to configure with default parameters. Notice: this is the
 	 * very first open, so, we cannot race against other calls,
@@ -813,7 +811,6 @@ static int rvin_initialize_device(struct file *file)
 
 	return 0;
 esfmt:
-	pm_runtime_disable(&vin->vdev.dev);
 	rvin_power_off(vin);
 
 	return ret;
@@ -863,10 +860,8 @@ static int rvin_release(struct file *file)
 	 * If this was the last open file.
 	 * Then de-initialize hw module.
 	 */
-	if (fh_singular) {
-		pm_runtime_disable(&vin->vdev.dev);
+	if (fh_singular)
 		rvin_power_off(vin);
-	}
 
 	mutex_unlock(&vin->lock);
 
-- 
2.21.0

