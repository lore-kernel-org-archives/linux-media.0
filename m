Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31737C64E8A
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE12A20897
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgKXJie (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:38:34 -0500
Received: from retiisi.eu ([95.216.213.190]:45006 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731479AbgKXJib (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 04:38:31 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id EAEF0634C97;
        Tue, 24 Nov 2020 11:37:51 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org
Subject: [PATCH 13/30] ccs: Replace somewhat harsh internal checks based on BUG with WARN_ON
Date:   Tue, 24 Nov 2020 11:32:09 +0200
Message-Id: <20201124093226.23737-14-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201124093226.23737-1-sakari.ailus@linux.intel.com>
References: <20201124093226.23737-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If an internal driver error was encountered, BUG was issued. Instead, do
less harsh WARN_ON_ONCE and try to manage with the consequences.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 25b4c84524ff..70b4d2180971 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -546,6 +546,10 @@ static void ccs_update_mbus_formats(struct ccs_sensor *sensor)
 		to_csi_format_idx(sensor->internal_csi_format) & ~3;
 	unsigned int pixel_order = ccs_pixel_order(sensor);
 
+	if (WARN_ON_ONCE(max(internal_csi_format_idx, csi_format_idx) +
+			 pixel_order >= ARRAY_SIZE(ccs_csi_data_formats)))
+		return;
+
 	sensor->mbus_frame_fmts =
 		sensor->default_mbus_frame_fmts << pixel_order;
 	sensor->csi_format =
@@ -554,9 +558,6 @@ static void ccs_update_mbus_formats(struct ccs_sensor *sensor)
 		&ccs_csi_data_formats[internal_csi_format_idx
 					 + pixel_order];
 
-	BUG_ON(max(internal_csi_format_idx, csi_format_idx) + pixel_order
-	       >= ARRAY_SIZE(ccs_csi_data_formats));
-
 	dev_dbg(&client->dev, "new pixel order %s\n",
 		pixel_order_str[pixel_order]);
 }
@@ -1806,7 +1807,7 @@ static void ccs_propagate(struct v4l2_subdev *subdev,
 		*crops[CCS_PAD_SRC] = *comp;
 		break;
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
 	}
 }
 
-- 
2.27.0

