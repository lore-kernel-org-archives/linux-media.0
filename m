Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8ABC43461
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 02:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8A0613B2
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 02:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbhDMCbf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Apr 2021 22:31:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35892 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbhDMCbe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Apr 2021 22:31:34 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07C798B7;
        Tue, 13 Apr 2021 04:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618281073;
        bh=Aax7NAwOOAn0wvdf6ULY9SI7ZciWX/5Q1HhUcQnQH4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8cjOEQ4RMCT/Acc3zoTHq11Q4QYX2vnf1JqrceNlynmbQWXcoWZ3L5O9TQffWQwl
         PpM5+DULVZgRokShdRXBi1oPRZnE1jxplUbO/GS8OHbwXAwSl+3FUPWYbUDLjSBAJK
         k/NoX3QM+uRTFNp3F0GvPNOA04q0YRfs29OKghn0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 08/23] media: imx: imx7_mipi_csis: Set the CLKSETTLE register field
Date:   Tue, 13 Apr 2021 05:29:59 +0300
Message-Id: <20210413023014.28797-9-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
In-Reply-To: <20210413023014.28797-1-laurent.pinchart@ideasonboard.com>
References: <20210413023014.28797-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Set the CLKSETTLE field explicitly, with a value hardcoded to 0. This
brings no functional change, but prepares for calculation of the
CLKSETTLE value.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index eea865ba486d..224d3ac9c9bf 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -310,6 +310,7 @@ struct csi_state {
 
 	u32 clk_frequency;
 	u32 hs_settle;
+	u32 clk_settle;
 
 	struct reset_control *mrst;
 
@@ -540,11 +541,15 @@ static int mipi_csis_calculate_params(struct csi_state *state)
 
 	/*
 	 * The HSSETTLE counter value is document in a table, but can also
-	 * easily be calculated.
+	 * easily be calculated. Hardcode the CLKSETTLE value to 0 for now
+	 * (which is documented as corresponding to CSI-2 v0.87 to v1.00) until
+	 * we figure out how to compute it correctly.
 	 */
 	state->hs_settle = (lane_rate - 5000000) / 45000000;
-	dev_dbg(state->dev, "lane rate %u, Ths_settle %u\n",
-		lane_rate, state->hs_settle);
+	state->clk_settle = 0;
+
+	dev_dbg(state->dev, "lane rate %u, Tclk_settle %u, Ths_settle %u\n",
+		lane_rate, state->clk_settle, state->hs_settle);
 
 	return 0;
 }
@@ -563,7 +568,8 @@ static void mipi_csis_set_params(struct csi_state *state)
 	__mipi_csis_set_format(state);
 
 	mipi_csis_write(state, MIPI_CSIS_DPHY_CMN_CTRL,
-			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(state->hs_settle));
+			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(state->hs_settle) |
+			MIPI_CSIS_DPHY_CMN_CTRL_CLKSETTLE(state->clk_settle));
 
 	val = (0 << MIPI_CSIS_ISP_SYNC_HSYNC_LINTV_OFFSET)
 	    | (0 << MIPI_CSIS_ISP_SYNC_VSYNC_SINTV_OFFSET)
-- 
Regards,

Laurent Pinchart

