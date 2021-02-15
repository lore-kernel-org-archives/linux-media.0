Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DAEC433E6
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309D364E68
	for <linux-media@archiver.kernel.org>; Mon, 15 Feb 2021 04:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBOEgr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:36:47 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45928 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhBOEgp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Feb 2021 23:36:45 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A77551AC2;
        Mon, 15 Feb 2021 05:28:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613363327;
        bh=/TeCkt42sOiu+61l4gI1tulO2y9/Nan0sDaFIk3bNB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHcTEs1BR06p/H3OioGoM1guuCSokh4gcDD42Rev2n20EYbuM/CcCiJKbCjlQd/cZ
         AN205YTSZBGSylH3aUQHS3e83kpdOmpU2AGGWUjGqb0Ehp3+EC0OA0Wv7bWMIsoMno
         GcsYdcUhMZWv6+T9xXR2rPX6aKvj/b5V8fBiv8+k=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 46/77] media: imx: imx7-media-csi: Don't set the buffer stride when disabling
Date:   Mon, 15 Feb 2021 06:27:10 +0200
Message-Id: <20210215042741.28850-47-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
References: <20210215042741.28850-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There's no need to set the buffer stride to 0 when disabling the CSI.
Remove the extraneous register write.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index b4bd161bec40..ac6763f8810d 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -616,8 +616,6 @@ static void imx7_csi_disable(struct imx7_csi *csi)
 
 	imx7_csi_hw_disable_irq(csi);
 
-	imx7_csi_buf_stride_set(csi, 0);
-
 	imx7_csi_hw_disable(csi);
 }
 
-- 
Regards,

Laurent Pinchart

