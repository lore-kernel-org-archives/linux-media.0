Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71428C4727E
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400FA2158C
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgI3PaF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:30:05 -0400
Received: from retiisi.org.uk ([95.216.213.190]:44650 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbgI3P3I (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:08 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 92A8A634CD1
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:49 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 036/100] ccs: The functions to get compose or crop rectangle never return NULL
Date:   Wed, 30 Sep 2020 18:27:54 +0300
Message-Id: <20200930152858.8471-37-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The NULL check is not needed as the functions do not return NULL. Remove
the check (and BUG).

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 4c08e2d1d94c..9a3d7131cd10 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -1760,16 +1760,12 @@ static void ccs_get_crop_compose(struct v4l2_subdev *subdev,
 			*comps = &ssd->compose;
 	} else {
 		if (crops) {
-			for (i = 0; i < subdev->entity.num_pads; i++) {
+			for (i = 0; i < subdev->entity.num_pads; i++)
 				crops[i] = v4l2_subdev_get_try_crop(subdev, cfg, i);
-				BUG_ON(!crops[i]);
-			}
 		}
-		if (comps) {
+		if (comps)
 			*comps = v4l2_subdev_get_try_compose(subdev, cfg,
 							     CCS_PAD_SINK);
-			BUG_ON(!*comps);
-		}
 	}
 }
 
-- 
2.27.0

