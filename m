Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F1C83010
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 10:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895C722269
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 10:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgK0KiL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:38:11 -0500
Received: from retiisi.eu ([95.216.213.190]:44890 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbgK0KiK (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 27 Nov 2020 05:38:10 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id A036D634CAA;
        Fri, 27 Nov 2020 12:37:17 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org
Subject: [PATCH v2 21/29] ccs: Give all subdevs a function
Date:   Fri, 27 Nov 2020 12:33:17 +0200
Message-Id: <20201127103325.29814-22-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127103325.29814-1-sakari.ailus@linux.intel.com>
References: <20201127103325.29814-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This removes a warning at driver probe time telling that one or two
entities have no function set. The function used for both the binner and
scaler is the scaler.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index cc3a81200050..bddfee637f33 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -2685,7 +2685,7 @@ static void ccs_cleanup(struct ccs_sensor *sensor)
 
 static void ccs_create_subdev(struct ccs_sensor *sensor,
 			      struct ccs_subdev *ssd, const char *name,
-			      unsigned short num_pads)
+			      unsigned short num_pads, u32 function)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&sensor->src->sd);
 
@@ -2696,6 +2696,7 @@ static void ccs_create_subdev(struct ccs_sensor *sensor,
 		v4l2_subdev_init(&ssd->sd, &ccs_ops);
 
 	ssd->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	ssd->sd.entity.function = function;
 	ssd->sensor = sensor;
 
 	ssd->npads = num_pads;
@@ -3123,11 +3124,12 @@ static int ccs_probe(struct i2c_client *client)
 	sensor->pll.ext_clk_freq_hz = sensor->hwcfg->ext_clk;
 	sensor->pll.scale_n = CCS_LIM(sensor, SCALER_N_MIN);
 
-	ccs_create_subdev(sensor, sensor->scaler, " scaler", 2);
-	ccs_create_subdev(sensor, sensor->binner, " binner", 2);
-	ccs_create_subdev(sensor, sensor->pixel_array, " pixel_array", 1);
-
-	sensor->pixel_array->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	ccs_create_subdev(sensor, sensor->scaler, " scaler", 2,
+			  MEDIA_ENT_F_CAM_SENSOR);
+	ccs_create_subdev(sensor, sensor->binner, " binner", 2,
+			  MEDIA_ENT_F_PROC_VIDEO_SCALER);
+	ccs_create_subdev(sensor, sensor->pixel_array, " pixel_array", 1,
+			  MEDIA_ENT_F_PROC_VIDEO_SCALER);
 
 	rval = ccs_init_controls(sensor);
 	if (rval < 0)
-- 
2.27.0

