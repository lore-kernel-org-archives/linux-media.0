Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC3C4727E
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E93321D7F
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgI3PaY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:30:24 -0400
Received: from retiisi.org.uk ([95.216.213.190]:44644 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbgI3P3D (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:03 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id BEB74634CA1
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:47 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 016/100] smiapp: Differentiate CCS sensors from SMIA in subdev naming
Date:   Wed, 30 Sep 2020 18:27:34 +0300
Message-Id: <20200930152858.8471-17-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Call CCS compliant sensors as "ccs" instead of "smiapp" in absence of a
device specific name. This is done based on the value of the manufacturer
ID register that is only present in CCS.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/smiapp/ccs-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/smiapp/ccs-core.c b/drivers/media/i2c/smiapp/ccs-core.c
index dd093a7d2ef4..c82e311d2661 100644
--- a/drivers/media/i2c/smiapp/ccs-core.c
+++ b/drivers/media/i2c/smiapp/ccs-core.c
@@ -2437,8 +2437,6 @@ static int ccs_identify_module(struct ccs_sensor *sensor)
 	unsigned int i;
 	int rval = 0;
 
-	minfo->name = SMIAPP_NAME;
-
 	/* Module info */
 	rval = ccs_read(sensor, MODULE_MANUFACTURER_ID,
 			&minfo->mipi_manufacturer_id);
@@ -2528,15 +2526,18 @@ static int ccs_identify_module(struct ccs_sensor *sensor)
 		"sensor revision 0x%2.2x firmware version 0x%2.2x\n",
 		minfo->sensor_revision_number, minfo->sensor_firmware_version);
 
-	if (minfo->ccs_version)
+	if (minfo->ccs_version) {
 		dev_dbg(&client->dev, "MIPI CCS version %u.%u",
 			(minfo->ccs_version & CCS_MIPI_CCS_VERSION_MAJOR_MASK)
 			>> CCS_MIPI_CCS_VERSION_MAJOR_SHIFT,
 			(minfo->ccs_version & CCS_MIPI_CCS_VERSION_MINOR_MASK));
-	else
+		minfo->name = CCS_NAME;
+	} else {
 		dev_dbg(&client->dev,
 			"smia version %2.2d smiapp version %2.2d\n",
 			minfo->smia_version, minfo->smiapp_version);
+		minfo->name = SMIAPP_NAME;
+	}
 
 	/*
 	 * Some modules have bad data in the lvalues below. Hope the
-- 
2.27.0

