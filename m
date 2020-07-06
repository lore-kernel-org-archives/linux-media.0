Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A9FC433E4
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E52920771
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BqL4YFVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgGFSid (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:38:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45202 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbgGFSid (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:38:33 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 64DC91964;
        Mon,  6 Jul 2020 20:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060691;
        bh=JoVgPQOxdjfBJhQTyob0fUILckz01DOiG4tkDDuxj30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqL4YFVJIA3eEfXGJbwnhVJ2ntEvq5Rm84XH7f3tnH9v6gVfpRE9A8OzXd7sP9o8N
         lJkKLjiRE8knR/9KFdF1kfZOd7rjO7OlCpTbMWlYqfAs8mX9ekqtfNqGn5EAK4CBlS
         egB27amkvQGAL3dGXOTpW1Dt2QXvnjiPsFNcr/mg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 066/108] media: ti-vpe: cal: Move CAL_NUM_CSI2_PORTS from cal_regs.h to cal.c
Date:   Mon,  6 Jul 2020 21:36:27 +0300
Message-Id: <20200706183709.12238-67-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The CAL_NUM_CSI2_PORTS macro isn't a register definition. Move it to
cal.c, and fix indentation of the other macros while at it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c      | 7 ++++---
 drivers/media/platform/ti-vpe/cal_regs.h | 2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index e4d8cadf7bef..67b87d33639d 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -75,10 +75,11 @@ MODULE_PARM_DESC(debug, "activates debug info");
 #define phy_err(phy, fmt, arg...)	\
 	cal_err((phy)->cal, "phy%u: " fmt, (phy)->instance, ##arg)
 
-#define CAL_NUM_CONTEXT 2
+#define CAL_NUM_CONTEXT			2
+#define CAL_NUM_CSI2_PORTS		2
 
-#define MAX_WIDTH_BYTES (8192 * 8)
-#define MAX_HEIGHT_LINES 16383
+#define MAX_WIDTH_BYTES			(8192 * 8)
+#define MAX_HEIGHT_LINES		16383
 
 /* ------------------------------------------------------------------
  *	Format Handling
diff --git a/drivers/media/platform/ti-vpe/cal_regs.h b/drivers/media/platform/ti-vpe/cal_regs.h
index b551e67d5d41..f752096dcf7f 100644
--- a/drivers/media/platform/ti-vpe/cal_regs.h
+++ b/drivers/media/platform/ti-vpe/cal_regs.h
@@ -34,8 +34,6 @@
  */
 #define DRA72_CAL_PRE_ES2_LDO_DISABLE BIT(0)
 
-#define CAL_NUM_CSI2_PORTS		2
-
 /* CAL register offsets */
 
 #define CAL_HL_REVISION			0x0000
-- 
Regards,

Laurent Pinchart

