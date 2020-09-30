Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A83C4727C
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097422071E
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgI3P3N (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:29:13 -0400
Received: from retiisi.org.uk ([95.216.213.190]:44650 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbgI3P3L (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:11 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 68462634CE1
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:51 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 058/100] ccs-pll: Use the BIT macro
Date:   Wed, 30 Sep 2020 18:28:16 +0300
Message-Id: <20200930152858.8471-59-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use the BIT macro for setting individual bits.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs-pll.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ccs-pll.h b/drivers/media/i2c/ccs-pll.h
index e01359f61476..f772ed8ef579 100644
--- a/drivers/media/i2c/ccs-pll.h
+++ b/drivers/media/i2c/ccs-pll.h
@@ -12,13 +12,16 @@
 #ifndef CCS_PLL_H
 #define CCS_PLL_H
 
+#include <linux/bits.h>
+
 /* CSI-2 or CCP-2 */
 #define CCS_PLL_BUS_TYPE_CSI2_DPHY				0x00
 #define CCS_PLL_BUS_TYPE_CSI2_CPHY				0x01
 
+/* Old SMIA and implementation specific flags */
 /* op pix clock is for all lanes in total normally */
-#define CCS_PLL_FLAG_OP_PIX_CLOCK_PER_LANE			(1 << 0)
-#define CCS_PLL_FLAG_NO_OP_CLOCKS				(1 << 1)
+#define CCS_PLL_FLAG_OP_PIX_CLOCK_PER_LANE			BIT(0)
+#define CCS_PLL_FLAG_NO_OP_CLOCKS				BIT(1)
 
 /**
  * struct ccs_pll_branch_fr - CCS PLL configuration (front)
-- 
2.27.0

