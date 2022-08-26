Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B1ECAAD6
	for <linux-media@archiver.kernel.org>; Fri, 26 Aug 2022 18:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiHZSgF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Aug 2022 14:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344546AbiHZSen (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Aug 2022 14:34:43 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776D0E68F4;
        Fri, 26 Aug 2022 11:33:53 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 259BFFF807;
        Fri, 26 Aug 2022 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exMkT/hiGFF3pOn5KCEAYUiJladoXUFR3sqm5Gxb2/c=;
        b=P6UQxQBRBP0wd/ocKfGVovHnLi3E2pjcpGlVBFLZrVwyCsENUbN0yfa9A52kxtme/33hUI
        Ax5KyHAAb0Kl1vtU9erk56ZWU8rfUGu4Dt5Jyq0aTxUAsi0WT8+woiSpHptTW+Hu7euhv1
        ngj7B3AeNXyfBihUpwKH1X84kucO1saN9hFzAdubyXGoujJT34s4WLc3eQSDEYksZnFbmu
        JiTx35EkNM2o3qH0yw9N2wcSfdGqsoViAaMzPTtdt/sloyCKhp0NCNVdUAT2V5rrTC6ERN
        TaXWjuzVMhdsjtTNkzY46ucbZqKWAV4jzQsU9SRpz2M2rEglXGuNLDmEgTJk2Q==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 41/43] media: sun6i-csi: Add extra checks to the interrupt routine
Date:   Fri, 26 Aug 2022 20:32:38 +0200
Message-Id: <20220826183240.604834-42-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Check against the enabled bits and make sure capture is running before
serving an interrupt, to add extra safety in the process.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index eaf62cab0b64..46c5f98702e1 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -89,13 +89,17 @@ static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
 static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 {
 	struct sun6i_csi_device *csi_dev = private;
+	bool capture_streaming = csi_dev->capture.state.streaming;
 	struct regmap *regmap = csi_dev->regmap;
-	u32 status;
+	u32 status = 0, enable = 0;
 
 	regmap_read(regmap, SUN6I_CSI_CH_INT_STA_REG, &status);
+	regmap_read(regmap, SUN6I_CSI_CH_INT_EN_REG, &enable);
 
-	if (!(status & 0xFF))
+	if (!status)
 		return IRQ_NONE;
+	else if (!(status & enable) || !capture_streaming)
+		goto complete;
 
 	if ((status & SUN6I_CSI_CH_INT_STA_FIFO0_OF) ||
 	    (status & SUN6I_CSI_CH_INT_STA_FIFO1_OF) ||
@@ -116,6 +120,7 @@ static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 	if (status & SUN6I_CSI_CH_INT_STA_VS)
 		sun6i_csi_capture_sync(csi_dev);
 
+complete:
 	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG, status);
 
 	return IRQ_HANDLED;
-- 
2.37.1

