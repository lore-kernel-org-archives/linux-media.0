Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD0C433ED
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 02:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A334613AA
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 02:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245576AbhDMCbd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Apr 2021 22:31:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35892 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbhDMCbc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Apr 2021 22:31:32 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD250ACC;
        Tue, 13 Apr 2021 04:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618281070;
        bh=lFtkgNNTxcEIgVqoHrvR4yOqSi0tw47YZcUHJJGbeOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNkqYn/WdD2/w0gwoyjdn7RqirjQqVt/pwaLsJQfayj8iY/GhbKxPI3LKQfS8FPwT
         zLFfNXZ1coLcJwPl5mQuma61KbM0VHsb4ebNWF4ELpswT2mK9IqmZz9kb7XdSWkad/
         PEfqi4ncajLvZAyTkNmLwvaWxDQWwN7mn7XB4H3Y=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 04/23] media: imx: imx7_mipi_csis: Move static data to top of mipi_csis_dump_regs()
Date:   Tue, 13 Apr 2021 05:29:55 +0300
Message-Id: <20210413023014.28797-5-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
In-Reply-To: <20210413023014.28797-1-laurent.pinchart@ideasonboard.com>
References: <20210413023014.28797-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

It's customary to declare static variables at the top of the function,
with a blank line separating them from the non-static variables.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index f7c8b6d67e1c..25125e067aa7 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -429,9 +429,6 @@ static inline u32 mipi_csis_read(struct csi_state *state, u32 reg)
 
 static int mipi_csis_dump_regs(struct csi_state *state)
 {
-	struct device *dev = &state->pdev->dev;
-	unsigned int i;
-	u32 cfg;
 	static const struct {
 		u32 offset;
 		const char * const name;
@@ -450,6 +447,10 @@ static int mipi_csis_dump_regs(struct csi_state *state)
 		{ MIPI_CSIS_DBG_CTRL, "DBG_CTRL" },
 	};
 
+	struct device *dev = &state->pdev->dev;
+	unsigned int i;
+	u32 cfg;
+
 	dev_info(dev, "--- REGISTERS ---\n");
 
 	for (i = 0; i < ARRAY_SIZE(registers); i++) {
-- 
Regards,

Laurent Pinchart

