Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B928C63777
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 10:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9142224A
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 10:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgK0KiH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgK0KiH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 27 Nov 2020 05:38:07 -0500
Received: from hillosipuli.retiisi.eu (unknown [IPv6:2a01:4f9:c010:4572::e8:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313CC0613D1
        for <linux-media@vger.kernel.org>; Fri, 27 Nov 2020 02:38:07 -0800 (PST)
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 14E8B634C91;
        Fri, 27 Nov 2020 12:37:16 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org
Subject: [PATCH v2 07/29] smiapp: Add macros for accessing CCS registers
Date:   Fri, 27 Nov 2020 12:33:03 +0200
Message-Id: <20201127103325.29814-8-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127103325.29814-1-sakari.ailus@linux.intel.com>
References: <20201127103325.29814-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add two helper macros for reading and writing the CCS registers as defined
in ccs-regs.h.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/smiapp/smiapp-regs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/i2c/smiapp/smiapp-regs.h b/drivers/media/i2c/smiapp/smiapp-regs.h
index 7223f5f89109..dc946096f368 100644
--- a/drivers/media/i2c/smiapp/smiapp-regs.h
+++ b/drivers/media/i2c/smiapp/smiapp-regs.h
@@ -28,4 +28,10 @@ int smiapp_write(struct smiapp_sensor *sensor, u32 reg, u32 val);
 
 unsigned int ccs_reg_width(u32 reg);
 
+#define ccs_read(sensor, reg_name, val) \
+	smiapp_read(sensor, CCS_R_##reg_name, val)
+
+#define ccs_write(sensor, reg_name, val) \
+	smiapp_write(sensor, CCS_R_##reg_name, val)
+
 #endif
-- 
2.27.0

