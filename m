Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB68DC282CE
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AAE2064B
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDIOuF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:50:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDIOuF (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 10:50:05 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDs4Z-0005vk-CR
        for linux-media@vger.kernel.org; Tue, 09 Apr 2019 16:50:03 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils v2 1/4] v4l2-compliance: use warn() in warn_once()
Date:   Tue,  9 Apr 2019 16:49:55 +0200
Message-Id: <20190409144958.31233-2-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409144958.31233-1-p.zabel@pengutronix.de>
References: <20190409144958.31233-1-p.zabel@pengutronix.de>
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

Use the warn() macro in warn_once() instead of duplicating its contents.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 utils/v4l2-compliance/v4l2-compliance.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/utils/v4l2-compliance/v4l2-compliance.h b/utils/v4l2-compliance/v4l2-compliance.h
index ac709e94a537..f7e1ea5d7124 100644
--- a/utils/v4l2-compliance/v4l2-compliance.h
+++ b/utils/v4l2-compliance/v4l2-compliance.h
@@ -206,12 +206,7 @@ private:
 									\
 		if (!show) {						\
 			show = true;					\
-			warnings++;					\
-			if (show_warnings)				\
-				printf("\t\twarn: %s(%d): " fmt,	\
-					__FILE__, __LINE__, ##args); 	\
-			if (exit_on_warn)				\
-				exit(1);				\
+			warn(fmt, ##args);				\
 		}							\
 	} while (0)
 
-- 
2.20.1

