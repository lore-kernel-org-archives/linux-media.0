Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA1BC2BB48
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9162395B
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 21:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgLGVZI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Dec 2020 16:25:08 -0500
Received: from retiisi.eu ([95.216.213.190]:34618 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgLGVZH (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 7 Dec 2020 16:25:07 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 5F503634C99;
        Mon,  7 Dec 2020 23:23:13 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org
Subject: [PATCH 15/24] =?UTF-8?q?ccs:=20Don't=20change=20the=20I=C2=B2C=20?= =?UTF-8?q?address=20just=20for=20software=20reset?=
Date:   Mon,  7 Dec 2020 23:15:21 +0200
Message-Id: <20201207211530.21180-16-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207211530.21180-1-sakari.ailus@linux.intel.com>
References: <20201207211530.21180-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The sensor's address was changed before resetting and changing the
address again. Don't do it before reset as it's useless.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 11c6de7f55aa..da7a6bd2c820 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -1552,14 +1552,6 @@ static int ccs_power_on(struct device *dev)
 	 * is found.
 	 */
 
-	if (sensor->hwcfg.i2c_addr_alt) {
-		rval = ccs_change_cci_addr(sensor);
-		if (rval) {
-			dev_err(dev, "cci address change error\n");
-			goto out_cci_addr_fail;
-		}
-	}
-
 	rval = ccs_write(sensor, SOFTWARE_RESET, CCS_SOFTWARE_RESET_ON);
 	if (rval < 0) {
 		dev_err(dev, "software reset failed\n");
-- 
2.29.2

