Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C54ECAAA1
	for <linux-media@archiver.kernel.org>; Fri,  9 Sep 2022 13:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiIINkr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 9 Sep 2022 09:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIINkj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 9 Sep 2022 09:40:39 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B148C462;
        Fri,  9 Sep 2022 06:40:30 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E01401C0003;
        Fri,  9 Sep 2022 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662730829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzDRiNxlngXMkep4VlkVbmP7SB6g960sXKbI90dfLZ4=;
        b=hGtcLJPqM6oYiVcr1WZyCzBbTYzH6GqgwUSJpWEVhLJj54xhH2+gf6jNPZ5lhKogjzqxMz
        M4+Rh08pagsRVtaGzmKC/MmFVBOJsrUmg+6wDlc3QXZi2YNnFAXmkeg0gLLSUtUkBY/Gdn
        vLppwZCqwWJVX6DEQlRuFeHgpNx0Ovtgyx2292NAtRRO+Ycnhx0PbuGo3WRuqd/9ea8Jhp
        nIIAaMYBdHhhu+zsg0JExUKGfajlOgZqeBWyvDCIIEhDmQ78fEiaEV8T6aiND8FR5WQnir
        AIgZ1j2wJXmSYCu+1FaZqbzyK/eeaGPkkQhnMDbZzubKyFg1tD7NbBtPWNgFpQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 1/4] media: sun6i-mipi-csi2: Require both pads to be connected for streaming
Date:   Fri,  9 Sep 2022 15:39:51 +0200
Message-Id: <20220909133954.97010-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909133954.97010-1-paul.kocialkowski@bootlin.com>
References: <20220909133954.97010-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The bridge needs both its pads connected to be able to stream data.
Enforcing this is useful to produce an error when no sensor is
connected.

Fixes: af54b4f4c17f ("media: sunxi: Add support for the A31 MIPI CSI-2 controller")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c  | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
index 30d6c0c5161f..340380a5f66f 100644
--- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
@@ -519,8 +519,10 @@ static int sun6i_mipi_csi2_bridge_setup(struct sun6i_mipi_csi2_device *csi2_dev)
 
 	/* Media Pads */
 
-	pads[SUN6I_MIPI_CSI2_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
-	pads[SUN6I_MIPI_CSI2_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
+	pads[SUN6I_MIPI_CSI2_PAD_SINK].flags = MEDIA_PAD_FL_SINK |
+					       MEDIA_PAD_FL_MUST_CONNECT;
+	pads[SUN6I_MIPI_CSI2_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE |
+						 MEDIA_PAD_FL_MUST_CONNECT;
 
 	ret = media_entity_pads_init(&subdev->entity, SUN6I_MIPI_CSI2_PAD_COUNT,
 				     pads);
-- 
2.37.3

