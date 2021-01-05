Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C77FC433E6
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B4D22BEF
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhAEOed (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbhAEOec (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 5 Jan 2021 09:34:32 -0500
Received: from hillosipuli.retiisi.eu (unknown [IPv6:2a01:4f9:c010:4572::e8:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C615C061793
        for <linux-media@vger.kernel.org>; Tue,  5 Jan 2021 06:32:47 -0800 (PST)
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id B7AB2634C87
        for <linux-media@vger.kernel.org>; Tue,  5 Jan 2021 16:32:30 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 1/1] ccs: Fix sub-device function
Date:   Tue,  5 Jan 2021 16:25:46 +0200
Message-Id: <20210105142546.31949-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix sub-device function for the pixel array and the scaler.

It seems that the pixel array had gotten assigned as SCALER whereas the
scaler had CAM_SENSOR function. Fix this by setting the pixel array
function to CAM_SENSOR and that of scaler to SCALER.

Fixes: 9ec2ac9bd0f9 ("media: ccs: Give all subdevs a function")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 15afbb4f5b31..4505594996bd 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3522,11 +3522,11 @@ static int ccs_probe(struct i2c_client *client)
 	sensor->pll.scale_n = CCS_LIM(sensor, SCALER_N_MIN);
 
 	ccs_create_subdev(sensor, sensor->scaler, " scaler", 2,
-			  MEDIA_ENT_F_CAM_SENSOR);
+			  MEDIA_ENT_F_PROC_VIDEO_SCALER);
 	ccs_create_subdev(sensor, sensor->binner, " binner", 2,
 			  MEDIA_ENT_F_PROC_VIDEO_SCALER);
 	ccs_create_subdev(sensor, sensor->pixel_array, " pixel_array", 1,
-			  MEDIA_ENT_F_PROC_VIDEO_SCALER);
+			  MEDIA_ENT_F_CAM_SENSOR);
 
 	rval = ccs_init_controls(sensor);
 	if (rval < 0)
-- 
2.29.2

