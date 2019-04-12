Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22305C10F14
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CEB20693
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfDLPvv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:51:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32923 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfDLPvn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:51:43 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEySr-0000EY-D4; Fri, 12 Apr 2019 17:51:41 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH 06/13] media: coda: add menu strings to s_ctrl debug output
Date:   Fri, 12 Apr 2019 17:51:28 +0200
Message-Id: <20190412155135.13907-6-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412155135.13907-1-p.zabel@pengutronix.de>
References: <20190412155135.13907-1-p.zabel@pengutronix.de>
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

When a menu control is updated via s_ctrl, print the corresponding menu
entry string in addition to the numerical value it is set to.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/coda/coda-common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index a8c705f4269c..af13e9b3d851 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1847,11 +1847,16 @@ static const struct vb2_ops coda_qops = {
 
 static int coda_s_ctrl(struct v4l2_ctrl *ctrl)
 {
+	const char * const *val_names = v4l2_ctrl_get_menu(ctrl->id);
 	struct coda_ctx *ctx =
 			container_of(ctrl->handler, struct coda_ctx, ctrls);
 
-	coda_dbg(2, ctx, "s_ctrl: id = 0x%x, name = \"%s\", val = %d\n",
-		 ctrl->id, ctrl->name, ctrl->val);
+	if (val_names)
+		coda_dbg(2, ctx, "s_ctrl: id = 0x%x, name = \"%s\", val = %d (\"%s\")\n",
+			 ctrl->id, ctrl->name, ctrl->val, val_names[ctrl->val]);
+	else
+		coda_dbg(2, ctx, "s_ctrl: id = 0x%x, name = \"%s\", val = %d\n",
+			 ctrl->id, ctrl->name, ctrl->val);
 
 	switch (ctrl->id) {
 	case V4L2_CID_HFLIP:
-- 
2.20.1

