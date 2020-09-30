Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47D3C4727E
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8469F20759
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgI3P3R (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:29:17 -0400
Received: from retiisi.org.uk ([95.216.213.190]:44644 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbgI3P3Q (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:16 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id B713F634CFB
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:53 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 088/100] ccs: Add digital gain support
Date:   Wed, 30 Sep 2020 18:28:46 +0300
Message-Id: <20200930152858.8471-89-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

CCS supports global (all-component) digital gain. Add support for it.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 00a1ea46f25a..1cb46de003e5 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -669,6 +669,11 @@ static int ccs_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_ANALOGUE_GAIN:
 		rval = ccs_write(sensor, ANALOG_GAIN_CODE_GLOBAL, ctrl->val);
 
+		break;
+
+	case V4L2_CID_DIGITAL_GAIN:
+		rval = ccs_write(sensor, DIGITAL_GAIN_GLOBAL, ctrl->val);
+
 		break;
 	case V4L2_CID_EXPOSURE:
 		rval = ccs_write(sensor, COARSE_INTEGRATION_TIME, ctrl->val);
@@ -738,7 +743,7 @@ static int ccs_init_controls(struct ccs_sensor *sensor)
 	struct i2c_client *client = v4l2_get_subdevdata(&sensor->src->sd);
 	int rval;
 
-	rval = v4l2_ctrl_handler_init(&sensor->pixel_array->ctrl_handler, 12);
+	rval = v4l2_ctrl_handler_init(&sensor->pixel_array->ctrl_handler, 13);
 	if (rval)
 		return rval;
 
@@ -752,6 +757,16 @@ static int ccs_init_controls(struct ccs_sensor *sensor)
 		max(CCS_LIM(sensor, ANALOG_GAIN_CODE_STEP), 1U),
 		CCS_LIM(sensor, ANALOG_GAIN_CODE_MIN));
 
+	if (CCS_LIM(sensor, DIGITAL_GAIN_CAPABILITY) ==
+	    CCS_DIGITAL_GAIN_CAPABILITY_GLOBAL)
+		v4l2_ctrl_new_std(&sensor->pixel_array->ctrl_handler,
+				  &ccs_ctrl_ops, V4L2_CID_DIGITAL_GAIN,
+				  CCS_LIM(sensor, DIGITAL_GAIN_MIN),
+				  CCS_LIM(sensor, DIGITAL_GAIN_MAX),
+				  max(CCS_LIM(sensor, DIGITAL_GAIN_STEP_SIZE),
+				      1U),
+				  0x100);
+
 	/* Exposure limits will be updated soon, use just something here. */
 	sensor->exposure = v4l2_ctrl_new_std(
 		&sensor->pixel_array->ctrl_handler, &ccs_ctrl_ops,
-- 
2.27.0

