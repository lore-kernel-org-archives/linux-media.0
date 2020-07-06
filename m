Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05115C433E1
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7663206DF
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DvDVQJhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgGFSiP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:38:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45202 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbgGFSiN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:38:13 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AC1E72121;
        Mon,  6 Jul 2020 20:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060677;
        bh=3LuRfkQGD1bf7g5K7js457V5LXrl0pBS5Ywf0R7Xt90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvDVQJhBA34TyMJCn0BaFPhsx5gw/Xxp2pKLOivwXOd2BlZBCQYV3l96AJveQCMo2
         sa7HcwCyJy8uMrVrgi0rsL4w2pdXZVkzJ3nsP2ZE21c7cms3ObtjPQL0hZxVmLgOjv
         Dr1JPuUVw2YjBwxwb/4w53uCMCaIdbZdDv/WCCzc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 045/108] media: ti-vpe: cal: Use syscon_regmap_lookup_by_phandle_args()
Date:   Mon,  6 Jul 2020 21:36:06 +0300
Message-Id: <20200706183709.12238-46-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use the syscon_regmap_lookup_by_phandle_args() function to replace
manual lookup of the syscon regmap offset. This simplifies the
cal_camerarx_init_regmap() implementation.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 6607e359855d..cb567d313035 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -995,17 +995,14 @@ static int cal_camerarx_init_regmap(struct cal_dev *cal)
 {
 	struct device_node *np = cal->pdev->dev.of_node;
 	struct regmap *syscon;
-	u32 syscon_offset;
-	int ret;
+	unsigned int offset;
 
-	syscon = syscon_regmap_lookup_by_phandle(np, "ti,camerrx-control");
-	ret = of_property_read_u32_index(np, "ti,camerrx-control", 1,
-					 &syscon_offset);
-	if (IS_ERR(syscon))
-		ret = PTR_ERR(syscon);
-	if (ret) {
+	syscon = syscon_regmap_lookup_by_phandle_args(np, "ti,camerrx-control",
+						      1, &offset);
+	if (IS_ERR(syscon)) {
 		dev_warn(&cal->pdev->dev,
-			 "failed to get ti,camerrx-control: %d\n", ret);
+			 "failed to get ti,camerrx-control: %ld\n",
+			 PTR_ERR(syscon));
 
 		/*
 		 * Backward DTS compatibility.
@@ -1021,11 +1018,11 @@ static int cal_camerarx_init_regmap(struct cal_dev *cal)
 		/* In this case the base already point to the direct
 		 * CM register so no need for an offset
 		 */
-		syscon_offset = 0;
+		offset = 0;
 	}
 
 	cal->syscon_camerrx = syscon;
-	cal->syscon_camerrx_offset = syscon_offset;
+	cal->syscon_camerrx_offset = offset;
 
 	return 0;
 }
-- 
Regards,

Laurent Pinchart

