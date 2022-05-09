Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E096C433FE
	for <linux-media@archiver.kernel.org>; Mon,  9 May 2022 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiEIJv1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 May 2022 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiEIJU2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 May 2022 05:20:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC49AE26B
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 02:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8F01B810B0
        for <linux-media@vger.kernel.org>; Mon,  9 May 2022 09:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAEDC385AB;
        Mon,  9 May 2022 09:16:01 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5/7] ccs-core.c: fix failure to call clk_disable_unprepare
Date:   Mon,  9 May 2022 11:15:51 +0200
Message-Id: <20220509091553.2637089-6-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
References: <20220509091553.2637089-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes smatch warning:

drivers/media/i2c/ccs/ccs-core.c:1676 ccs_power_on() warn: 'sensor->ext_clk' from clk_prepare_enable() not released on lines: 1606.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/i2c/ccs/ccs-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 55bd303f0e18..7609add2aff4 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -1602,8 +1602,11 @@ static int ccs_power_on(struct device *dev)
 			usleep_range(1000, 2000);
 		} while (--retry);
 
-		if (!reset)
-			return -EIO;
+		if (!reset) {
+			dev_err(dev, "software reset failed\n");
+			rval = -EIO;
+			goto out_cci_addr_fail;
+		}
 	}
 
 	if (sensor->hwcfg.i2c_addr_alt) {
-- 
2.34.1

