Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D460FC433F5
	for <linux-media@archiver.kernel.org>; Mon,  1 Nov 2021 13:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD06F60FE8
	for <linux-media@archiver.kernel.org>; Mon,  1 Nov 2021 13:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhKANgh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Nov 2021 09:36:37 -0400
Received: from retiisi.eu ([95.216.213.190]:34054 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhKANgh (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Nov 2021 09:36:37 -0400
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 09:36:36 EDT
Received: from lanttu.localdomain (unknown [192.168.2.193])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 11197634C90;
        Mon,  1 Nov 2021 15:25:18 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/1] max96712: Select VIDEO_V4L2
Date:   Mon,  1 Nov 2021 15:25:02 +0200
Message-Id: <20211101132502.700505-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Select VIDEO_V4L2 for the driver actually depends on it, failing to
compile otherwise.

Fixes: 51758f8b32134bacbf30bd217f7c2074e9b4b51e ("media: staging: max96712: Add basic support for MAX96712 GMSL2 deserializer")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/staging/media/max96712/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/max96712/Kconfig b/drivers/staging/media/max96712/Kconfig
index 258d47644cbd..492a7ff70dd8 100644
--- a/drivers/staging/media/max96712/Kconfig
+++ b/drivers/staging/media/max96712/Kconfig
@@ -6,6 +6,7 @@ config VIDEO_MAX96712
 	select V4L2_FWNODE
 	select VIDEO_V4L2_SUBDEV_API
 	select MEDIA_CONTROLLER
+	select VIDEO_V4L2
 	help
 	  This driver supports the Maxim MAX96712 Quad GMSL2 Deserializer.
 
-- 
2.30.2

