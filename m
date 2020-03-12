Return-Path: <SRS0=Lc/z=45=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46494C2BB1D
	for <linux-media@archiver.kernel.org>; Thu, 12 Mar 2020 23:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B394206F7
	for <linux-media@archiver.kernel.org>; Thu, 12 Mar 2020 23:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZNS13aW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCLXrm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:47:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34486 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgCLXrl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Mar 2020 19:47:41 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2CDF5F;
        Fri, 13 Mar 2020 00:47:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584056858;
        bh=UV03CJRAHAF1RgvWtdbZbxP2sSEj8KlgaU6QJImCRbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNS13aW2hcuMsadX38G2e3YkrnKpZpyTm1hx6uXNUZli+tJgUIV4lPWdZOBjTezMH
         P9ElqWRX6rXy3beTexy8lqo9zsVJ8xiE4tFbwFoXhTIqN10LJmXwxoY6lzDmP6tbXB
         7G96I3+pwYnltZuJ7SsTGo5p6ut3qrBvkCHYao68=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rui Miguel Silva <rmfrfs@gmail.com>
Subject: [PATCH 12/14] media: imx: imx7-mipi-csis: Cleanup includes
Date:   Fri, 13 Mar 2020 01:47:20 +0200
Message-Id: <20200312234722.23483-13-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312234722.23483-1-laurent.pinchart@ideasonboard.com>
References: <20200312234722.23483-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove unneeded includes, add needed ones, and sort them alphabetically.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index 7112969d1cf4..0829980d7af5 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -14,15 +14,14 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_graph.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/reset.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/spinlock.h>
 
 #include <media/v4l2-device.h>
-- 
Regards,

Laurent Pinchart

