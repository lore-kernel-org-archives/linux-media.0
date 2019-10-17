Return-Path: <SRS0=c9eX=YK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99067FA372A
	for <linux-media@archiver.kernel.org>; Thu, 17 Oct 2019 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E022089C
	for <linux-media@archiver.kernel.org>; Thu, 17 Oct 2019 11:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406226AbfJQLWU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:22:20 -0400
Received: from retiisi.org.uk ([95.216.213.190]:39728 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405615AbfJQLWR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Oct 2019 07:22:17 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1002])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 37236634C8B
        for <linux-media@vger.kernel.org>; Thu, 17 Oct 2019 14:21:47 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 3/7] smiapp: Don't update sensor configuration during power-on init
Date:   Thu, 17 Oct 2019 14:18:52 +0300
Message-Id: <20191017111856.10270-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017111856.10270-1-sakari.ailus@linux.intel.com>
References: <20191017111856.10270-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The sensor configuration since it was previously powered off was not
changed, so no need to update the PLL configuration etc. What is necessary
though is to re-apply the configuration to the sensor's registers.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index edaeebaada79..5fc3bcc6def0 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -1267,10 +1267,6 @@ static int smiapp_power_on(struct device *dev)
 		rval = __v4l2_ctrl_handler_setup(&sensor->src->ctrl_handler);
 		if (rval)
 			goto out_cci_addr_fail;
-
-		rval = smiapp_update_mode(sensor);
-		if (rval < 0)
-			goto out_cci_addr_fail;
 	}
 
 	mutex_unlock(&sensor->mutex);
-- 
2.20.1

