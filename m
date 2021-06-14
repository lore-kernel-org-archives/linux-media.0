Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37208C2B9F4
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B6A61166
	for <linux-media@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhFNLnA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:43:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58306 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhFNLle (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Jun 2021 07:41:34 -0400
Received: from deskari.lan (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ABB445EB9;
        Mon, 14 Jun 2021 13:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623669855;
        bh=Uw0fJaVym+ORdfZQRc7hSxXVUp8zp1M4l4a50Lo3rEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDSNobLPEf2tyy/QXkJJ4HsL5/tgCPLPlCqDFh22gBMWCeE2eQ7qaCb7zdYMIr5tF
         NxH1hgvQ2VP9n7JmPXZTp6NYy6HCPGIK7VBwdO0HcqQO+pWE3PjlvpVr1R5Fpswxe9
         66xJzLWwO4OsnboewqQwUK/htIBHxamazGOLgn+0=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 29/35] media: ti-vpe: cal: cleanup phy iteration in cal_remove
Date:   Mon, 14 Jun 2021 14:23:39 +0300
Message-Id: <20210614112345.2032435-30-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
References: <20210614112345.2032435-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Most of the driver has moved from ARRAY_SIZE(cal->phy) to
cal->data->num_csi2_phy, but we have one place left in cal_remove. Also,
checking for cal->phy[i] != NULL is not needed as we always have all the
phys instantiated.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index ec8ffc8d5721..9bba07647610 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1188,10 +1188,8 @@ static int cal_remove(struct platform_device *pdev)
 
 	cal_media_unregister(cal);
 
-	for (i = 0; i < ARRAY_SIZE(cal->phy); i++) {
-		if (cal->phy[i])
-			cal_camerarx_disable(cal->phy[i]);
-	}
+	for (i = 0; i < cal->data->num_csi2_phy; i++)
+		cal_camerarx_disable(cal->phy[i]);
 
 	cal_media_cleanup(cal);
 
-- 
2.25.1

