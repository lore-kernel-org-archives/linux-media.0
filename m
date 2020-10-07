Return-Path: <SRS0=q2TO=DO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA5C4363C
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC0F20870
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgJGIq6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:46:58 -0400
Received: from retiisi.org.uk ([95.216.213.190]:57044 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgJGIqK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 7 Oct 2020 04:46:10 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 13751634C87
        for <linux-media@vger.kernel.org>; Wed,  7 Oct 2020 11:45:20 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH v2 059/106] ccs-pll: End search if there are no better values available
Date:   Wed,  7 Oct 2020 11:45:10 +0300
Message-Id: <20201007084557.25843-50-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201007084557.25843-1-sakari.ailus@linux.intel.com>
References: <20201007084505.25761-1-sakari.ailus@linux.intel.com>
 <20201007084557.25843-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The VT divisor search can be ended if we've already found the value that
corresponds exactly the total divisor, as there are no better (lower)
values available.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs-pll.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ccs-pll.c b/drivers/media/i2c/ccs-pll.c
index ea0f84fc8a90..22e29127804a 100644
--- a/drivers/media/i2c/ccs-pll.c
+++ b/drivers/media/i2c/ccs-pll.c
@@ -352,6 +352,7 @@ __ccs_pll_calculate(struct device *dev, const struct ccs_pll_limits *lim,
 		     sys_div <= max_sys_div;
 		     sys_div += 2 - (sys_div & 1)) {
 			uint16_t pix_div = DIV_ROUND_UP(vt_div, sys_div);
+			uint16_t rounded_div;
 
 			if (pix_div < lim->vt_bk.min_pix_clk_div
 			    || pix_div > lim->vt_bk.max_pix_clk_div) {
@@ -363,10 +364,15 @@ __ccs_pll_calculate(struct device *dev, const struct ccs_pll_limits *lim,
 				continue;
 			}
 
+			rounded_div = roundup(vt_div, best_pix_div);
+
 			/* Check if this one is better. */
-			if (pix_div * sys_div
-			    <= roundup(vt_div, best_pix_div))
+			if (pix_div * sys_div <= rounded_div)
 				best_pix_div = pix_div;
+
+			/* Bail out if we've already found the best value. */
+			if (vt_div == rounded_div)
+				break;
 		}
 		if (best_pix_div < INT_MAX >> 1)
 			break;
-- 
2.27.0

