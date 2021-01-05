Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCBFC433DB
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA2522B45
	for <linux-media@archiver.kernel.org>; Tue,  5 Jan 2021 15:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbhAEPhW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:37:22 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbhAEPhV (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 5 Jan 2021 10:37:21 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3950B1BCD;
        Tue,  5 Jan 2021 16:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609860610;
        bh=gt/IQ6aCZ7CrLTkFWWzY/kdaVYDac/4uwMPC0ArHcNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mioiMySLhPp/K8M0bTvE0ndRNCkJzqvWaZbhIewuxc5KYO5JyvSYeozblBQOFhX3P
         cMuwEaYYyekW+Y8GZSphy+mqMkYwARsy60Sj2nlAdeQIoIlW0fw2D+jtpEHc4b/beu
         P6vBYo71sP7e0YL6pWM8nRWjYsG9xQtq2JSV3QqM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 49/75] media: imx: imx7-media-csi: Simplify imx7_csi_rx_fifo_clear()
Date:   Tue,  5 Jan 2021 17:28:26 +0200
Message-Id: <20210105152852.5733-50-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
References: <20210105152852.5733-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There's no need to read the CSICR1 register before each write in
imx7_csi_rx_fifo_clear(). Simplify the function.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 7871ad55060a..85ab733a2c4f 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -294,14 +294,10 @@ static void imx7_csi_dma_reflash(struct imx7_csi *csi)
 
 static void imx7_csi_rx_fifo_clear(struct imx7_csi *csi)
 {
-	u32 cr1;
+	u32 cr1 = imx7_csi_reg_read(csi, CSI_CSICR1) & ~BIT_FCC;
 
-	cr1 = imx7_csi_reg_read(csi, CSI_CSICR1);
-	imx7_csi_reg_write(csi, cr1 & ~BIT_FCC, CSI_CSICR1);
-	cr1 = imx7_csi_reg_read(csi, CSI_CSICR1);
+	imx7_csi_reg_write(csi, cr1, CSI_CSICR1);
 	imx7_csi_reg_write(csi, cr1 | BIT_CLR_RXFIFO, CSI_CSICR1);
-
-	cr1 = imx7_csi_reg_read(csi, CSI_CSICR1);
 	imx7_csi_reg_write(csi, cr1 | BIT_FCC, CSI_CSICR1);
 }
 
-- 
Regards,

Laurent Pinchart

