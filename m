Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFEDC433E0
	for <linux-media@archiver.kernel.org>; Fri, 22 Jan 2021 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3819A23444
	for <linux-media@archiver.kernel.org>; Fri, 22 Jan 2021 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbhAVMf2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 22 Jan 2021 07:35:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:29524 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbhAVMe6 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 22 Jan 2021 07:34:58 -0500
IronPort-SDR: uiapv/+3Sv1sVO0ZSKGl3C3Ku3bmZTUJ+zqhN5rIMOdsnRheecgZCPvW49WmEO4YHZqE39zOk+
 Shl93AGjcxwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="178661115"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="178661115"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 04:33:06 -0800
IronPort-SDR: eOLg2GLkCZVsmPSsK/qW4nmadVcOoMlkBTRvVylqaC15usX9VxG3hVbojfbkctB2ecNelh6o+k
 gNAJcZ+IqsGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="357007736"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jan 2021 04:33:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 364B914F; Fri, 22 Jan 2021 14:33:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1] media: atomisp: Remove unused header
Date:   Fri, 22 Jan 2021 14:33:03 +0200
Message-Id: <20210122123303.41190-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

sfi.h is not anyhow used by the driver. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/staging/media/atomisp/include/linux/atomisp_platform.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
index 5a5121d958ed..8c65733e0255 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
@@ -22,7 +22,6 @@
 #include <asm/processor.h>
 
 #include <linux/i2c.h>
-#include <linux/sfi.h>
 #include <media/v4l2-subdev.h>
 #include "atomisp.h"
 
-- 
2.29.2

