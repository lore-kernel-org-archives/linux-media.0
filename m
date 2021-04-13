Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08811C4360C
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 02:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE021613AE
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 02:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245685AbhDMCbf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Apr 2021 22:31:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35890 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245604AbhDMCbe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Apr 2021 22:31:34 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B615C9F0;
        Tue, 13 Apr 2021 04:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618281074;
        bh=iLFV4ogqlgFm0yTeXngYuQ7NGoxohvd5Q45T3wFIaW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZFfX8PI2zlhB2uqUABb30B/Ffxt0kU6ZyILyJiIERpnJdwSaQ57rbfaeehcp5/Mc
         wTPE9wyTcLIQmMOlA4GM4muaWQdlA7TfwawHjiOyI9YZy6ckG+1AAfDWThjkbl2voa
         OskgLxG8br5h3GKm/rwr5uptJFHa4Tr3TJ5SuCvE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 09/23] media: imx: imx7_mipi_csis: Drop unused csis_hw_reset structure
Date:   Tue, 13 Apr 2021 05:30:00 +0300
Message-Id: <20210413023014.28797-10-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
In-Reply-To: <20210413023014.28797-1-laurent.pinchart@ideasonboard.com>
References: <20210413023014.28797-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The csis_hw_reset structure is instantiated as a member of csi_state,
but that member is never used. Drop it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index 224d3ac9c9bf..695cb8aebcab 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -278,12 +278,6 @@ static const char * const mipi_csis_clk_id[] = {
 	"phy",
 };
 
-struct csis_hw_reset {
-	struct regmap *src;
-	u8 req_src;
-	u8 rst_bit;
-};
-
 struct csi_state {
 	/* lock elements below */
 	struct mutex lock;
@@ -321,7 +315,6 @@ struct csi_state {
 
 	struct mipi_csis_event events[MIPI_CSIS_NUM_EVENTS];
 
-	struct csis_hw_reset hw_reset;
 	struct regulator *mipi_phy_regulator;
 };
 
-- 
Regards,

Laurent Pinchart

