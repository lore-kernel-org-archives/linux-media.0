Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB84C433E0
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F5B64E61
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhBOElJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:41:09 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:46098 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBOElI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Feb 2021 23:41:08 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 946062E05;
        Mon, 15 Feb 2021 05:29:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613363351;
        bh=YXW+JqWOwsJzhVc1haIU80csLUo3y788Bo/LyqhCDPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hs2HdFmlOClJbpc0ib3/L/HuTynAwoC1zFA9Bk/ABnuKyO3W1pVEGKpQx4Cszjd5d
         nCAY7mPxxl67fzjX2CfbRAAlVlXyK8HD+QFJONSmAQ9ZqcdtSKDLHUKKOfZoQmxnLh
         h9XyHDxOxlICX1BnavOwUnfx1/GPY82D1TFRm434=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 77/77] media: imx: imx7_mipi_csis: Print shadow registers in mipi_csis_dump_regs()
Date:   Mon, 15 Feb 2021 06:27:41 +0200
Message-Id: <20210215042741.28850-78-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
References: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Print the value of the ISP shadow registers in mipi_csis_dump_regs() as
this can help debugging.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index 6bf8f0daae94..ea84698f4718 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -188,6 +188,11 @@
 #define MIPI_CSIS_ISP_SYNC_VSYNC_SINTV_OFFSET	12
 #define MIPI_CSIS_ISP_SYNC_VSYNC_EINTV_OFFSET	0
 
+/* ISP shadow registers */
+#define MIPI_CSIS_SDW_CONFIG_CH(n)		(0x80 + (n) * 0x10)
+#define MIPI_CSIS_SDW_RESOL_CH(n)		(0x84 + (n) * 0x10)
+#define MIPI_CSIS_SDW_SYNC_CH(n)		(0x88 + (n) * 0x10)
+
 /* Debug control register */
 #define MIPI_CSIS_DBG_CTRL			0xc0
 
@@ -411,6 +416,8 @@ static int mipi_csis_dump_regs(struct csi_state *state)
 		{ MIPI_CSIS_DPHY_SCTRL_H, "DPHY_SCTRL_H" },
 		{ MIPI_CSIS_ISP_CONFIG_CH(0), "ISP_CONFIG_CH0" },
 		{ MIPI_CSIS_ISP_RESOL_CH(0), "ISP_RESOL_CH0" },
+		{ MIPI_CSIS_SDW_CONFIG_CH(0), "SDW_CONFIG_CH0" },
+		{ MIPI_CSIS_SDW_RESOL_CH(0), "SDW_RESOL_CH0" },
 		{ MIPI_CSIS_DBG_CTRL, "DBG_CTRL" },
 	};
 
-- 
Regards,

Laurent Pinchart

