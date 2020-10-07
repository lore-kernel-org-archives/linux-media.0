Return-Path: <SRS0=q2TO=DO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467DFC4363C
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E418C20797
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 08:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgJGIq3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:46:29 -0400
Received: from retiisi.org.uk ([95.216.213.190]:57070 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgJGIqU (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 7 Oct 2020 04:46:20 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 38940634CE7
        for <linux-media@vger.kernel.org>; Wed,  7 Oct 2020 11:45:23 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH v2 103/106] ccs: Add debug prints for MSR registers
Date:   Wed,  7 Oct 2020 11:45:54 +0300
Message-Id: <20201007084557.25843-94-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201007084557.25843-1-sakari.ailus@linux.intel.com>
References: <20201007084505.25761-1-sakari.ailus@linux.intel.com>
 <20201007084557.25843-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Also print out MSR registers written to the sensor. This isn't entirely
optimal as the debug strings are produced even if they're not used but
that isn't really a grave issue --- the I²C bus is very slow anyway.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-reg-access.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/i2c/ccs/ccs-reg-access.c b/drivers/media/i2c/ccs/ccs-reg-access.c
index 2025e9ab6e91..c600f143a1b9 100644
--- a/drivers/media/i2c/ccs/ccs-reg-access.c
+++ b/drivers/media/i2c/ccs/ccs-reg-access.c
@@ -387,12 +387,20 @@ int ccs_write_data_regs(struct ccs_sensor *sensor, struct ccs_reg *regs,
 
 		for (j = 0; j < regs->len;
 		     j += msg.len - 2, regdata += msg.len - 2) {
+			char printbuf[(MAX_WRITE_LEN << 1) + 1 /* nil */] =
+				{ 0 };
 			int rval;
 
 			msg.len = min(regs->len - j, MAX_WRITE_LEN);
 
+			bin2hex(printbuf, regdata, msg.len);
+			dev_dbg(&client->dev,
+				"writing msr reg 0x%4.4x value 0x%s\n",
+				regs->addr + j, printbuf);
+
 			put_unaligned_be16(regs->addr + j, buf);
 			memcpy(buf + 2, regdata, msg.len);
+
 			msg.len += 2;
 
 			rval = ccs_write_retry(client, &msg);
-- 
2.27.0

