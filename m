Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F2DC433EF
	for <linux-media@archiver.kernel.org>; Mon, 11 Apr 2022 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346754AbiDKNzc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbiDKNza (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 11 Apr 2022 09:55:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E422A
        for <linux-media@vger.kernel.org>; Mon, 11 Apr 2022 06:53:16 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nduTj-0007Wh-1h; Mon, 11 Apr 2022 15:53:15 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] media: video-mux: Use dev_err_probe()
Date:   Mon, 11 Apr 2022 15:53:14 +0200
Message-Id: <20220411135314.1012346-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Simplify the mux error path a bit by using dev_err_probe().

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/video-mux.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index fda8fc0e4814..3e217c365eaf 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -440,12 +440,8 @@ static int video_mux_probe(struct platform_device *pdev)
 	}
 
 	vmux->mux = devm_mux_control_get(dev, NULL);
-	if (IS_ERR(vmux->mux)) {
-		ret = PTR_ERR(vmux->mux);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get mux: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(vmux->mux))
+		return dev_err_probe(dev, ret, "Failed to get mux\n");
 
 	mutex_init(&vmux->lock);
 	vmux->active = -1;
-- 
2.30.2

