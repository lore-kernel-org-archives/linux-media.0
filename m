Return-Path: <SRS0=wpjx=S6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7E3C43218
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 10:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D51F206BF
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 10:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Obb3OpNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfD1KzD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:55:03 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36284 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfD1KzD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 28 Apr 2019 06:55:03 -0400
Received: from pendragon.station (net-37-182-44-227.cust.vodafonedsl.it [37.182.44.227])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D8682D1
        for <linux-media@vger.kernel.org>; Sun, 28 Apr 2019 12:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556448901;
        bh=4VlDnR7RwhZjNtLmgndLacSg3Zbj0EehZcxXdFg/Wu4=;
        h=From:To:Subject:Date:From;
        b=Obb3OpNIW6yGjHLJ3u97PFMFMqfotmmRL2ny0BXX2wyN4on6ykSKGLPLCRnB28jAT
         AMnQEFar7DeHHw4AgiFE9l3FvxZv0q5GQVdZYlSxSVxnKMi3I/WcCohkwEn3buu/gH
         J+Ic2t1bMSL6A0S9l+NJmkiLu63v3pv1YdR5cg6c=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH] media: uvcvideo: Replace copyright text with SPDX header
Date:   Sun, 28 Apr 2019 13:54:46 +0300
Message-Id: <20190428105446.13192-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Copyright texts are deprecated in favour of SPDX headers, replace it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c     | 7 +------
 drivers/media/usb/uvc/uvc_debugfs.c  | 7 +------
 drivers/media/usb/uvc/uvc_driver.c   | 7 +------
 drivers/media/usb/uvc/uvc_entity.c   | 7 +------
 drivers/media/usb/uvc/uvc_isight.c   | 7 +------
 drivers/media/usb/uvc/uvc_metadata.c | 6 +-----
 drivers/media/usb/uvc/uvc_queue.c    | 7 +------
 drivers/media/usb/uvc/uvc_status.c   | 7 +------
 drivers/media/usb/uvc/uvc_v4l2.c     | 7 +------
 drivers/media/usb/uvc/uvc_video.c    | 7 +------
 10 files changed, 10 insertions(+), 59 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 14cff91b7aea..dadd9491c36c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_ctrl.c  --  USB Video Class driver - Controls
  *
  *      Copyright (C) 2005-2010
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/media/usb/uvc/uvc_debugfs.c b/drivers/media/usb/uvc/uvc_debugfs.c
index 77e7c2419b9b..52839cfada61 100644
--- a/drivers/media/usb/uvc/uvc_debugfs.c
+++ b/drivers/media/usb/uvc/uvc_debugfs.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_debugfs.c --  USB Video Class driver - Debugging support
  *
  *      Copyright (C) 2011
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 10cfe8e51626..8b2ec749e0a9 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_driver.c  --  USB Video Class driver
  *
  *      Copyright (C) 2005-2010
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/atomic.h>
diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 06bffdf8828b..a16a4711889f 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_entity.c  --  USB Video Class driver
  *
  *      Copyright (C) 2005-2011
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/media/usb/uvc/uvc_isight.c b/drivers/media/usb/uvc/uvc_isight.c
index 39a4e4482b23..d2667ce11ef6 100644
--- a/drivers/media/usb/uvc/uvc_isight.c
+++ b/drivers/media/usb/uvc/uvc_isight.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_isight.c  --  USB Video Class driver - iSight support
  *
@@ -5,12 +6,6 @@
  *		Ivan N. Zlatev <contact@i-nz.net>
  *	Copyright (C) 2008-2009
  *		Laurent Pinchart <laurent.pinchart@ideasonboard.com>
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/usb.h>
diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index 5f535b515c23..19d263ff8d5e 100644
--- a/drivers/media/usb/uvc/uvc_metadata.c
+++ b/drivers/media/usb/uvc/uvc_metadata.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_metadata.c  --  USB Video Class driver - Metadata handling
  *
  *      Copyright (C) 2016
  *          Guennadi Liakhovetski (guennadi.liakhovetski@intel.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 682698ec1118..be821257233d 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_queue.c  --  USB Video Class driver - Buffers management
  *
  *      Copyright (C) 2005-2010
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/atomic.h>
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 883e4cab45e7..13a70e808fd6 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_status.c  --  USB Video Class driver - Status endpoint
  *
  *      Copyright (C) 2005-2009
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 84be596d3269..4964ab695438 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_v4l2.c  --  USB Video Class driver - V4L2 API
  *
  *      Copyright (C) 2005-2010
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/compat.h>
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 182dcac49aa3..e0268d6f1e95 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      uvc_video.c  --  USB Video Class driver - Video handling
  *
  *      Copyright (C) 2005-2010
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
  */
 
 #include <linux/kernel.h>
-- 
Regards,

Laurent Pinchart

