Return-Path: <SRS0=q2TO=DO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB32C47420
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9D320870
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 08:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgJGIqL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:46:11 -0400
Received: from retiisi.org.uk ([95.216.213.190]:57070 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgJGIqJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 7 Oct 2020 04:46:09 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 8AEA7634C8F
        for <linux-media@vger.kernel.org>; Wed,  7 Oct 2020 11:45:19 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH v2 051/106] =?UTF-8?q?ccs:=20Use=20longer=20pre-I=C2=B2C?= =?UTF-8?q?=20sleep=20for=20CCS=20compliant=20devices?=
Date:   Wed,  7 Oct 2020 11:45:04 +0300
Message-Id: <20201007084557.25843-44-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201007084557.25843-1-sakari.ailus@linux.intel.com>
References: <20201007084505.25761-1-sakari.ailus@linux.intel.com>
 <20201007084557.25843-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Longer idle period is required on I²C bus before the first transaction
after lifting xshutdown.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 940b5327a388..94661275d599 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -1300,6 +1300,7 @@ static int ccs_power_on(struct device *dev)
 	 */
 	struct ccs_sensor *sensor =
 		container_of(ssd, struct ccs_sensor, ssds[0]);
+	const struct ccs_device *ccsdev = device_get_match_data(dev);
 	unsigned int sleep;
 	int rval;
 
@@ -1320,7 +1321,11 @@ static int ccs_power_on(struct device *dev)
 	gpiod_set_value(sensor->reset, 0);
 	gpiod_set_value(sensor->xshutdown, 1);
 
-	sleep = SMIAPP_RESET_DELAY(sensor->hwcfg.ext_clk);
+	if (ccsdev->flags & CCS_DEVICE_FLAG_IS_SMIA)
+		sleep = SMIAPP_RESET_DELAY(sensor->hwcfg.ext_clk);
+	else
+		sleep = 5000;
+
 	usleep_range(sleep, sleep);
 
 	/*
-- 
2.27.0

