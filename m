Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C9C2BB40
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A825238EC
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgLGVZG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Dec 2020 16:25:06 -0500
Received: from retiisi.eu ([95.216.213.190]:34588 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgLGVZG (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 7 Dec 2020 16:25:06 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 019D4634C94;
        Mon,  7 Dec 2020 23:23:13 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org
Subject: [PATCH 10/24] ccs: Add support for alternate analogue global gain
Date:   Mon,  7 Dec 2020 23:15:16 +0200
Message-Id: <20201207211530.21180-11-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207211530.21180-1-sakari.ailus@linux.intel.com>
References: <20201207211530.21180-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The CCS spec defines an alternative implementation for global analogue
gain. Add support for that in the driver.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index c51197318c3a..7591a52a41a4 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -673,6 +673,17 @@ static int ccs_set_ctrl(struct v4l2_ctrl *ctrl)
 
 		break;
 
+	case V4L2_CID_CCS_ANALOGUE_LINEAR_GAIN:
+		rval = ccs_write(sensor, ANALOG_LINEAR_GAIN_GLOBAL, ctrl->val);
+
+		break;
+
+	case V4L2_CID_CCS_ANALOGUE_EXPONENTIAL_GAIN:
+		rval = ccs_write(sensor, ANALOG_EXPONENTIAL_GAIN_GLOBAL,
+				 ctrl->val);
+
+		break;
+
 	case V4L2_CID_DIGITAL_GAIN:
 		if (CCS_LIM(sensor, DIGITAL_GAIN_CAPABILITY) ==
 		    CCS_DIGITAL_GAIN_CAPABILITY_GLOBAL) {
@@ -819,6 +830,50 @@ static int ccs_init_controls(struct ccs_sensor *sensor)
 				  max(CCS_LIM(sensor, ANALOG_GAIN_CODE_STEP),
 				      1U),
 				  CCS_LIM(sensor, ANALOG_GAIN_CODE_MIN));
+	}
+		break;
+
+	case CCS_ANALOG_GAIN_CAPABILITY_ALTERNATE_GLOBAL: {
+		struct {
+			const char *name;
+			u32 id;
+			u16 min, max, step;
+		} const gain_ctrls[] = {
+			{
+				"Analogue Linear Gain",
+				V4L2_CID_CCS_ANALOGUE_LINEAR_GAIN,
+				CCS_LIM(sensor, ANALOG_LINEAR_GAIN_MIN),
+				CCS_LIM(sensor, ANALOG_LINEAR_GAIN_MAX),
+				max(CCS_LIM(sensor,
+					    ANALOG_LINEAR_GAIN_STEP_SIZE),
+				    1U),
+			},
+			{
+				"Analogue Exponential Gain",
+				V4L2_CID_CCS_ANALOGUE_EXPONENTIAL_GAIN,
+				CCS_LIM(sensor, ANALOG_EXPONENTIAL_GAIN_MIN),
+				CCS_LIM(sensor, ANALOG_EXPONENTIAL_GAIN_MAX),
+				max(CCS_LIM(sensor,
+					    ANALOG_EXPONENTIAL_GAIN_STEP_SIZE),
+				    1U),
+			},
+		};
+		struct v4l2_ctrl_config ctrl_cfg = {
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.ops = &ccs_ctrl_ops,
+		};
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(gain_ctrls); i++) {
+			ctrl_cfg.name = gain_ctrls[i].name;
+			ctrl_cfg.min = ctrl_cfg.def = gain_ctrls[i].min;
+			ctrl_cfg.max = gain_ctrls[i].max;
+			ctrl_cfg.step = gain_ctrls[i].step;
+			ctrl_cfg.id = gain_ctrls[i].id;
+
+			v4l2_ctrl_new_custom(&sensor->pixel_array->ctrl_handler,
+					     &ctrl_cfg, NULL);
+		}
 	}
 	}
 
-- 
2.29.2

