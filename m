Return-Path: <SRS0=LX5l=TU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EDDC04AAC
	for <linux-media@archiver.kernel.org>; Mon, 20 May 2019 20:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2729420863
	for <linux-media@archiver.kernel.org>; Mon, 20 May 2019 20:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfETUM4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 20 May 2019 16:12:56 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:58700 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETUM4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 20 May 2019 16:12:56 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45797B3g3Tz1rXtr;
        Mon, 20 May 2019 22:12:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45797B30qbz1qqkQ;
        Mon, 20 May 2019 22:12:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id DUiZv8bnJYLL; Mon, 20 May 2019 22:12:53 +0200 (CEST)
X-Auth-Info: wY66de5IAG1ls8b6ffNN9EkfJmlQEZXCXnU0bcNyabQ=
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz [86.49.110.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 20 May 2019 22:12:53 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-media@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>
Subject: [PATCH] media: imx: Parse MIPI CSI2 link frequency correctly
Date:   Mon, 20 May 2019 22:12:47 +0200
Message-Id: <20190520201247.7591-1-marex@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The current code did not extract the CSI2 link frequency from the menu
items correctly. Fix this.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Steve Longerbeam <steve_longerbeam@mentor.com>
To: linux-media@vger.kernel.org
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 28 ++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index f29e28df36ed..64d8229336dd 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -193,18 +193,32 @@ static int max_mbps_to_hsfreqrange_sel(u32 max_mbps)
 
 static int csi2_dphy_init(struct csi2_dev *csi2)
 {
+	struct v4l2_querymenu qm = { .id = V4L2_CID_LINK_FREQ };
 	struct v4l2_ctrl *ctrl;
-	u32 mbps_per_lane;
-	int sel;
+	u32 mbps_per_lane = CSI2_DEFAULT_MAX_MBPS;
+	int ret, sel;
 
 	ctrl = v4l2_ctrl_find(csi2->src_sd->ctrl_handler,
 			      V4L2_CID_LINK_FREQ);
-	if (!ctrl)
-		mbps_per_lane = CSI2_DEFAULT_MAX_MBPS;
-	else
-		mbps_per_lane = DIV_ROUND_UP_ULL(2 * ctrl->qmenu_int[ctrl->val],
-						 USEC_PER_SEC);
+	if (ctrl) {
+		qm.index = v4l2_ctrl_g_ctrl(ctrl);
+		ret = v4l2_querymenu(csi2->src_sd->ctrl_handler, &qm);
+		if (ret) {
+			v4l2_err(&csi2->sd,
+				 "failed to get V4L2_CID_LINK_FREQ menu item, using default.\n");
+			goto exit;
+		}
+
+		if (!qm.value) {
+			v4l2_err(&csi2->sd,
+				 "invalid V4L2_CID_LINK_FREQ, using default.\n");
+			goto exit;
+		}
+
+		mbps_per_lane = DIV_ROUND_UP_ULL(qm.value, USEC_PER_SEC);
+	}
 
+exit:
 	sel = max_mbps_to_hsfreqrange_sel(mbps_per_lane);
 	if (sel < 0)
 		return sel;
-- 
2.20.1

