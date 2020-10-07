Return-Path: <SRS0=q2TO=DO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0DBC41604
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 08:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5F20797
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 08:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgJGIqc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:46:32 -0400
Received: from retiisi.org.uk ([95.216.213.190]:57070 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgJGIqR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 7 Oct 2020 04:46:17 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 8377F634CA3
        for <linux-media@vger.kernel.org>; Wed,  7 Oct 2020 11:45:22 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH v2 092/106] ccs-pll: Print pixel rates
Date:   Wed,  7 Oct 2020 11:45:43 +0300
Message-Id: <20201007084557.25843-83-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201007084557.25843-1-sakari.ailus@linux.intel.com>
References: <20201007084505.25761-1-sakari.ailus@linux.intel.com>
 <20201007084557.25843-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Print pixel rates on CSI-2 bus as well as in pixel array as the variation
allowed in PLL capabilities makes this non-trivial to figure out
otherwise.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs-pll.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/ccs-pll.c b/drivers/media/i2c/ccs-pll.c
index 5a0162347777..eb7b6f01f623 100644
--- a/drivers/media/i2c/ccs-pll.c
+++ b/drivers/media/i2c/ccs-pll.c
@@ -119,6 +119,11 @@ static void print_pll(struct device *dev, struct ccs_pll *pll)
 		}
 	}
 
+	dev_dbg(dev, "pixel rate in pixel array:\t%u\n",
+		pll->pixel_rate_pixel_array);
+	dev_dbg(dev, "pixel rate on CSI-2 bus:\t%u\n",
+		pll->pixel_rate_csi);
+
 	dev_dbg(dev, "flags%s%s%s%s%s%s%s%s%s\n",
 		pll->flags & PLL_FL(LANE_SPEED_MODEL) ? " lane-speed" : "",
 		pll->flags & PLL_FL(LINK_DECOUPLED) ? " link-decoupled" : "",
-- 
2.27.0

