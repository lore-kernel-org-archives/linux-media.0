Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBCFC6379D
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C72073C
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgKXJia (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:38:30 -0500
Received: from retiisi.eu ([95.216.213.190]:44960 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731296AbgKXJi3 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 04:38:29 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 1DDFC634C8B;
        Tue, 24 Nov 2020 11:37:51 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org
Subject: [PATCH 03/30] ccs: Add CCS ACPI device ID
Date:   Tue, 24 Nov 2020 11:31:59 +0200
Message-Id: <20201124093226.23737-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201124093226.23737-1-sakari.ailus@linux.intel.com>
References: <20201124093226.23737-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The CCS compliant sensors use device ID "MIPI0200". Use this id for ACPI
device matching.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 1d365da570a6..bb712d71b8c8 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3247,6 +3247,12 @@ static const struct ccs_device smia_device = {
 
 static const struct ccs_device ccs_device = {};
 
+static const struct acpi_device_id ccs_acpi_table[] = {
+	{ .id = "MIPI0200", .driver_data = (unsigned long)&ccs_device },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ccs_acpi_table);
+
 static const struct of_device_id ccs_of_table[] = {
 	{ .compatible = "mipi-ccs-1.1", .data = &ccs_device },
 	{ .compatible = "mipi-ccs-1.0", .data = &ccs_device },
@@ -3269,6 +3275,7 @@ static const struct dev_pm_ops ccs_pm_ops = {
 
 static struct i2c_driver ccs_i2c_driver = {
 	.driver	= {
+		.acpi_match_table = ccs_acpi_table,
 		.of_match_table = ccs_of_table,
 		.name = CCS_NAME,
 		.pm = &ccs_pm_ops,
-- 
2.27.0

