Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DBAC282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA7E20880
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDHIqM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:46:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42111 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDHIqK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 04:46:10 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDPur-00075y-IS
        for linux-media@vger.kernel.org; Mon, 08 Apr 2019 10:46:09 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils 1/2] v4l2-compliance: use warn() in warn_once()
Date:   Mon,  8 Apr 2019 10:45:57 +0200
Message-Id: <20190408084558.2979-2-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408084558.2979-1-p.zabel@pengutronix.de>
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
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

