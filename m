Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281AAC4338F
	for <linux-media@archiver.kernel.org>; Thu, 19 Aug 2021 20:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0553560FDC
	for <linux-media@archiver.kernel.org>; Thu, 19 Aug 2021 20:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhHSUUQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:20:16 -0400
Received: from retiisi.eu ([95.216.213.190]:60184 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232343AbhHSUUP (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 19 Aug 2021 16:20:15 -0400
Received: from lanttu.localdomain (unknown [192.168.2.193])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 50354634C93;
        Thu, 19 Aug 2021 23:19:37 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, rafael@kernel.org
Subject: [RFC 2/3] gpio-tps68470: Allow building as module
Date:   Thu, 19 Aug 2021 23:19:35 +0300
Message-Id: <20210819201936.7390-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
References: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Allow building gpio-tps68470 driver as a module. The intel_skl_int3472 is
a module anyway, so making this a builtin does not really help setting up
this one before a dependent module probes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/gpio/Kconfig         | 2 +-
 drivers/gpio/gpio-tps68470.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fab571016adf..8911c2df97d1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1378,7 +1378,7 @@ config GPIO_TPS65912
 	  This driver supports TPS65912 gpio chip
 
 config GPIO_TPS68470
-	bool "TPS68470 GPIO"
+	tristate "TPS68470 GPIO"
 	depends on INTEL_SKL_INT3472
 	help
 	  Select this option to enable GPIO driver for the TPS68470
diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
index 423b7bc30ae8..0ab88ef241de 100644
--- a/drivers/gpio/gpio-tps68470.c
+++ b/drivers/gpio/gpio-tps68470.c
@@ -155,4 +155,6 @@ static struct platform_driver tps68470_gpio_driver = {
 	.probe = tps68470_gpio_probe,
 };
 
-builtin_platform_driver(tps68470_gpio_driver)
+module_platform_driver(tps68470_gpio_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.30.2

