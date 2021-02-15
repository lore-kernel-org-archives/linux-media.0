Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21DEC433DB
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE5564D9D
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBOEhp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:37:45 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45902 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhBOEhi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Feb 2021 23:37:38 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 96C7F1AD7;
        Mon, 15 Feb 2021 05:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613363332;
        bh=IGAw7vju40P0kz+6rjf8Z8aozzS4Qdm7RH9gVBdXF08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVOQNThHoZUvOJGi4oRyyRBCw2CaZEV8aRpVY86OpMhGS8yGA+BqnXG1qKOKtPEkT
         B9Lil0ZOOohYH7ofDTtgJ2vBm3ltBAf+ViRwauSP7Xu+l6EH4CmEfCYKGF2/SdvKqd
         4eoA1zHaILhYMNXqaXHCk+VAgsNJr1C6AM3v83sA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 53/77] media: imx: imx7-media-csi: Remove double reflash of DMA controller
Date:   Mon, 15 Feb 2021 06:27:17 +0200
Message-Id: <20210215042741.28850-54-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
References: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The DMA controller needs to be reflashed after being configured. There
is however no need to do it twice, once in imx7_csi_configure() and once
in imx7_csi_sw_reset(), called from imx7_csi_enable(). Remove the
former.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 439e4ed8ed10..4a8d48495701 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -530,9 +530,6 @@ static void imx7_csi_configure(struct imx7_csi *csi)
 			   BIT_IMAGE_HEIGHT(out_pix->height),
 			   CSI_CSIIMAG_PARA);
 	imx7_csi_reg_write(csi, stride, CSI_CSIFBUF_PARA);
-
-	/* reflash the embedded DMA controller */
-	imx7_csi_dma_reflash(csi);
 }
 
 static int imx7_csi_init(struct imx7_csi *csi)
-- 
Regards,

Laurent Pinchart

