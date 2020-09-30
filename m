Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D43C4727E
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7938E20759
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgI3P3c (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:29:32 -0400
Received: from retiisi.org.uk ([95.216.213.190]:44656 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbgI3P3P (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:15 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 68FCE634CF7
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:53 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 084/100] ccs: Add support for DDR OP SYS and OP PIX clocks
Date:   Wed, 30 Sep 2020 18:28:42 +0300
Message-Id: <20200930152858.8471-85-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Support dual data rate operational system and pixel clocks by conveying
the flags to the PLL calculator and updating how the link rate is
calculated.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 1272cfe201e3..a6d5164be8a0 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -386,7 +386,8 @@ static int ccs_pll_configure(struct ccs_sensor *sensor)
 			 DIV_ROUND_UP(pll->op_bk.sys_clk_freq_hz,
 				      1000000 / 256 / 256) *
 			 (pll->flags & CCS_PLL_FLAG_LANE_SPEED_MODEL ?
-			  sensor->pll.csi2.lanes : 1));
+			  sensor->pll.csi2.lanes : 1) <<
+			 (pll->flags & CCS_PLL_FLAG_OP_SYS_DDR ? 1 : 0));
 	if (rval < 0 || sensor->pll.flags & CCS_PLL_FLAG_NO_OP_CLOCKS)
 		return rval;
 
@@ -3252,6 +3253,12 @@ static int ccs_probe(struct i2c_client *client)
 		} else {
 			sensor->pll.flags |= CCS_PLL_FLAG_DUAL_PLL;
 		}
+		if (CCS_LIM(sensor, CLOCK_CALCULATION) &
+		    CCS_CLOCK_CALCULATION_DUAL_PLL_OP_SYS_DDR)
+			sensor->pll.flags |= CCS_PLL_FLAG_OP_SYS_DDR;
+		if (CCS_LIM(sensor, CLOCK_CALCULATION) &
+		    CCS_CLOCK_CALCULATION_DUAL_PLL_OP_PIX_DDR)
+			sensor->pll.flags |= CCS_PLL_FLAG_OP_PIX_DDR;
 	}
 	sensor->pll.op_bits_per_lane = CCS_LIM(sensor, OP_BITS_PER_LANE);
 	sensor->pll.ext_clk_freq_hz = sensor->hwcfg.ext_clk;
-- 
2.27.0

