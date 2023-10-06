Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB5E92711
	for <linux-media@archiver.kernel.org>; Fri,  6 Oct 2023 10:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjJFKJJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Oct 2023 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjJFKJH (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 6 Oct 2023 06:09:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD80DF0
        for <linux-media@vger.kernel.org>; Fri,  6 Oct 2023 03:09:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D0C433AD;
        Fri,  6 Oct 2023 10:09:04 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Martin Tuma <martin.tuma@digiteqautomotive.com>
Subject: [PATCH 9/9] media: pci: mgb4: fix potential spectre vulnerability
Date:   Fri,  6 Oct 2023 12:08:50 +0200
Message-Id: <c83b7fffe1e087568f64aba786797d258279948e.1696586632.git.hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1696586632.git.hverkuil-cisco@xs4all.nl>
References: <cover.1696586632.git.hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix smatch warnings:

drivers/media/pci/mgb4/mgb4_sysfs_out.c:118 video_source_store() warn: potential spectre issue 'mgbdev->vin' [r] (local cap)
drivers/media/pci/mgb4/mgb4_sysfs_out.c:122 video_source_store() warn: possible spectre second half.  'loopin_new'

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC: Martin Tuma <martin.tuma@digiteqautomotive.com>
---
 drivers/media/pci/mgb4/mgb4_sysfs_out.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_out.c b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
index 23a9aabf3915..9f6e81c57726 100644
--- a/drivers/media/pci/mgb4/mgb4_sysfs_out.c
+++ b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/nospec.h>
 #include "mgb4_core.h"
 #include "mgb4_i2c.h"
 #include "mgb4_vout.h"
@@ -114,8 +115,10 @@ static ssize_t video_source_store(struct device *dev,
 
 	if (((config & 0xc) >> 2) < MGB4_VIN_DEVICES)
 		loopin_old = mgbdev->vin[(config & 0xc) >> 2];
-	if (val < MGB4_VIN_DEVICES)
+	if (val < MGB4_VIN_DEVICES) {
+		val = array_index_nospec(val, MGB4_VIN_DEVICES);
 		loopin_new = mgbdev->vin[val];
+	}
 	if (loopin_old && loopin_cnt(loopin_old) == 1)
 		mgb4_mask_reg(&mgbdev->video, loopin_old->config->regs.config,
 			      0x2, 0x0);
-- 
2.40.1

