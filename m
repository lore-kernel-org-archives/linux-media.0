Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B52CC282CE
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A66220693
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDLPvn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDLPvm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:51:42 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEySr-0000EY-5c; Fri, 12 Apr 2019 17:51:41 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 01/13] media: coda: move register debugging to coda_debug level 3
Date:   Fri, 12 Apr 2019 17:51:23 +0200
Message-Id: <20190412155135.13907-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This allows to use coda_debug level 2 for verbose but not quite as
verbose debug logging. Register access level logging is of limited
use anyway, as this includes busy polling of status bits.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 3ce58dee4422..1fd153952ce3 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -78,7 +78,7 @@ MODULE_PARM_DESC(enable_bwb, "Enable BWB unit for decoding, may crash on certain
 
 void coda_write(struct coda_dev *dev, u32 data, u32 reg)
 {
-	v4l2_dbg(2, coda_debug, &dev->v4l2_dev,
+	v4l2_dbg(3, coda_debug, &dev->v4l2_dev,
 		 "%s: data=0x%x, reg=0x%x\n", __func__, data, reg);
 	writel(data, dev->regs_base + reg);
 }
@@ -88,7 +88,7 @@ unsigned int coda_read(struct coda_dev *dev, u32 reg)
 	u32 data;
 
 	data = readl(dev->regs_base + reg);
-	v4l2_dbg(2, coda_debug, &dev->v4l2_dev,
+	v4l2_dbg(3, coda_debug, &dev->v4l2_dev,
 		 "%s: data=0x%x, reg=0x%x\n", __func__, data, reg);
 	return data;
 }
-- 
2.20.1

