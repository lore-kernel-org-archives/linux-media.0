Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B3C2D0E4
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9935B2073C
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgKXJif (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:38:35 -0500
Received: from retiisi.eu ([95.216.213.190]:45030 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731488AbgKXJie (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 04:38:34 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id C0434634C95;
        Tue, 24 Nov 2020 11:37:51 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org
Subject: [PATCH 11/30] ccs: Stop reading arrays after the first zero
Date:   Tue, 24 Nov 2020 11:32:07 +0200
Message-Id: <20201124093226.23737-12-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201124093226.23737-1-sakari.ailus@linux.intel.com>
References: <20201124093226.23737-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The register arrays have a certain size but not all the entries will be
relevant. In practice reading can be stopped after encountering a zero
value in the array. Do that to avoid extra reads.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index be27b002a772..dec248fe7cc1 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -199,6 +199,9 @@ static int ccs_read_all_limits(struct ccs_sensor *sensor)
 				goto out_err;
 			}
 
+			if (!val && j)
+				break;
+
 			ccs_assign_limit(ptr, width, val);
 
 			dev_dbg(&client->dev, "0x%8.8x \"%s\" = %u, 0x%x\n",
-- 
2.27.0

