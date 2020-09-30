Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA51AC47426
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0879221EF
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgI3PaN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbgI3P3H (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:07 -0400
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF773C0613D0
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 08:29:06 -0700 (PDT)
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id D0C83634CC0
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:48 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 029/100] =?UTF-8?q?ccs:=20Remove=20the=20I=C2=B2C=20ID=20t?= =?UTF-8?q?able?=
Date:   Wed, 30 Sep 2020 18:27:47 +0300
Message-Id: <20200930152858.8471-30-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The I²C ID table is no longer needed; remove it.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 7cdd81e3bb6e..ddcdd7098a1f 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3242,12 +3242,6 @@ static const struct of_device_id ccs_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ccs_of_table);
 
-static const struct i2c_device_id ccs_id_table[] = {
-	{ SMIAPP_NAME, 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, ccs_id_table);
-
 static const struct dev_pm_ops ccs_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ccs_suspend, ccs_resume)
 	SET_RUNTIME_PM_OPS(ccs_power_off, ccs_power_on, NULL)
@@ -3261,7 +3255,6 @@ static struct i2c_driver ccs_i2c_driver = {
 	},
 	.probe_new = ccs_probe,
 	.remove	= ccs_remove,
-	.id_table = ccs_id_table,
 };
 
 static int ccs_module_init(void)
-- 
2.27.0

