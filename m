Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F6C64E90
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C312076B
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgKXJif (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:38:35 -0500
Received: from retiisi.eu ([95.216.213.190]:44964 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731485AbgKXJid (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 04:38:33 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 25CDB634C99;
        Tue, 24 Nov 2020 11:37:52 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org
Subject: [PATCH 15/30] ccs: Make real to integer number conversion optional
Date:   Tue, 24 Nov 2020 11:32:11 +0200
Message-Id: <20201124093226.23737-16-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201124093226.23737-1-sakari.ailus@linux.intel.com>
References: <20201124093226.23737-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The limit values will be raw soon, and the conversion takes place later
on. Prepare for that.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-reg-access.c | 35 +++++++++++++++++++-------
 drivers/media/i2c/ccs/ccs-reg-access.h |  2 ++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-reg-access.c b/drivers/media/i2c/ccs/ccs-reg-access.c
index abec746f3c93..fe6112cba6be 100644
--- a/drivers/media/i2c/ccs/ccs-reg-access.c
+++ b/drivers/media/i2c/ccs/ccs-reg-access.c
@@ -143,14 +143,23 @@ unsigned int ccs_reg_width(u32 reg)
 	return sizeof(uint8_t);
 }
 
+u32 ccs_reg_conv(struct ccs_sensor *sensor, u32 reg, u32 val)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&sensor->src->sd);
+
+	if (reg & CCS_FL_FLOAT_IREAL)
+		val = float_to_u32_mul_1000000(client, val);
+
+	return val;
+}
+
 /*
  * Read a 8/16/32-bit i2c register.  The value is returned in 'val'.
  * Returns zero if successful, or non-zero otherwise.
  */
 static int __ccs_read_addr(struct ccs_sensor *sensor, u32 reg, u32 *val,
-			   bool only8)
+			   bool only8, bool conv)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&sensor->src->sd);
 	unsigned int len = ccs_reg_width(reg);
 	int rval;
 
@@ -162,14 +171,16 @@ static int __ccs_read_addr(struct ccs_sensor *sensor, u32 reg, u32 *val,
 	if (rval < 0)
 		return rval;
 
-	if (reg & CCS_FL_FLOAT_IREAL)
-		*val = float_to_u32_mul_1000000(client, *val);
+	if (!conv)
+		return 0;
+
+	*val = ccs_reg_conv(sensor, reg, *val);
 
 	return 0;
 }
 
 static int ccs_read_addr_raw(struct ccs_sensor *sensor, u32 reg, u32 *val,
-			     bool force8, bool quirk)
+			     bool force8, bool quirk, bool conv)
 {
 	int rval;
 
@@ -182,22 +193,28 @@ static int ccs_read_addr_raw(struct ccs_sensor *sensor, u32 reg, u32 *val,
 			return rval;
 
 		if (force8)
-			return __ccs_read_addr(sensor, reg, val, true);
+			return __ccs_read_addr(sensor, reg, val, true, conv);
 	}
 
 	return __ccs_read_addr(sensor, reg, val,
 			       ccs_needs_quirk(sensor,
-					       CCS_QUIRK_FLAG_8BIT_READ_ONLY));
+					       CCS_QUIRK_FLAG_8BIT_READ_ONLY),
+			       conv);
 }
 
 int ccs_read_addr(struct ccs_sensor *sensor, u32 reg, u32 *val)
 {
-	return ccs_read_addr_raw(sensor, reg, val, false, true);
+	return ccs_read_addr_raw(sensor, reg, val, false, true, true);
 }
 
 int ccs_read_addr_8only(struct ccs_sensor *sensor, u32 reg, u32 *val)
 {
-	return ccs_read_addr_raw(sensor, reg, val, true, true);
+	return ccs_read_addr_raw(sensor, reg, val, true, true, true);
+}
+
+int ccs_read_addr_noconv(struct ccs_sensor *sensor, u32 reg, u32 *val)
+{
+	return ccs_read_addr_raw(sensor, reg, val, false, true, false);
 }
 
 int ccs_write_addr_no_quirk(struct ccs_sensor *sensor, u32 reg, u32 val)
diff --git a/drivers/media/i2c/ccs/ccs-reg-access.h b/drivers/media/i2c/ccs/ccs-reg-access.h
index 9fdf5659ed09..5f6ff9c57698 100644
--- a/drivers/media/i2c/ccs/ccs-reg-access.h
+++ b/drivers/media/i2c/ccs/ccs-reg-access.h
@@ -24,10 +24,12 @@ struct ccs_sensor;
 int ccs_read_addr_no_quirk(struct ccs_sensor *sensor, u32 reg, u32 *val);
 int ccs_read_addr(struct ccs_sensor *sensor, u32 reg, u32 *val);
 int ccs_read_addr_8only(struct ccs_sensor *sensor, u32 reg, u32 *val);
+int ccs_read_addr_noconv(struct ccs_sensor *sensor, u32 reg, u32 *val);
 int ccs_write_addr_no_quirk(struct ccs_sensor *sensor, u32 reg, u32 val);
 int ccs_write_addr(struct ccs_sensor *sensor, u32 reg, u32 val);
 
 unsigned int ccs_reg_width(u32 reg);
+u32 ccs_reg_conv(struct ccs_sensor *sensor, u32 reg, u32 val);
 
 #define ccs_read(sensor, reg_name, val) \
 	ccs_read_addr(sensor, CCS_R_##reg_name, val)
-- 
2.27.0

