Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79EAC4727E
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A248221EC
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgI3PaQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:30:16 -0400
Received: from retiisi.org.uk ([95.216.213.190]:44636 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgI3P3F (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:05 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id BDC52634CBF
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:48 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 028/100] ccs: Add "mipi,ccs" compatible string
Date:   Wed, 30 Sep 2020 18:27:46 +0300
Message-Id: <20200930152858.8471-29-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add "mipi,ccs" compatible string to the CCS driver.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 775037ce361f..7cdd81e3bb6e 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3237,6 +3237,7 @@ static int ccs_remove(struct i2c_client *client)
 
 static const struct of_device_id ccs_of_table[] = {
 	{ .compatible = "nokia,smia" },
+	{ .compatible = "mipi,ccs" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ccs_of_table);
-- 
2.27.0

