Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE5C433E1
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB4B206DF
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kudAuxwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgGFShu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:37:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45202 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbgGFShu (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:37:50 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48288AC6;
        Mon,  6 Jul 2020 20:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060664;
        bh=GhZS/MOMAgj8zlsw0n5tjpcsEeVwwYp35W6V+hFzYFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kudAuxwumuiGun2tKhy7jtm3qLTCm2TYYSvnG1b/lNEyjU/QVhNfuXbWrxac7UmDA
         xV5sfHz/qpykmwvlmlxtINgOdP0Kl8J5Ld09WGxn+pDdQNiXHQLELWfMhuGmwZW7IO
         DeVJAVPIom8y4fyDTsVX8cLrFmwjENeWs+tENGLk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 024/108] media: ti-vpe: cal: Rename cc_data to cal_camerarx
Date:   Mon,  6 Jul 2020 21:35:45 +0300
Message-Id: <20200706183709.12238-25-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The various data structures that describe the components of the camera
access layer (CAL) are named without much consistency. Start cleaning
this up by renaming the structure that describes the CAMERARX block,
cc_data, to cal_camerarx.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 46 +++++++++++++++++------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 5db8d928cf09..621cc3f26762 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -215,16 +215,6 @@ enum cal_camerarx_field {
 	F_MAX_FIELDS,
 };
 
-struct cc_data {
-	void __iomem		*base;
-	struct resource		*res;
-	struct platform_device	*pdev;
-
-	struct {
-		struct regmap_field *fields[F_MAX_FIELDS];
-	} phy;
-};
-
 struct cal_csi2_phy {
 	struct {
 		unsigned int lsb;
@@ -315,9 +305,26 @@ static const struct cal_data am654_cal_data = {
 };
 
 /*
- * there is one cal_dev structure in the driver, it is shared by
- * all instances.
+ * The Camera Adaptation Layer (CAL) module is paired with one or more complex
+ * I/O PHYs (CAMERARX). It contains multiple instances of CSI-2, processing and
+ * DMA contexts.
+ *
+ * The cal_dev structure represents the whole subsystem, including the CAL and
+ * the CAMERARX instances. The cal_camerarx structure represents one CAMERARX
+ * instance. The cal_ctx structure represents the combination of one CSI-2
+ * context, one processing context and one DMA context.
  */
+
+struct cal_camerarx {
+	void __iomem		*base;
+	struct resource		*res;
+	struct platform_device	*pdev;
+
+	struct {
+		struct regmap_field *fields[F_MAX_FIELDS];
+	} phy;
+};
+
 struct cal_dev {
 	struct clk		*fclk;
 	int			irq;
@@ -333,7 +340,7 @@ struct cal_dev {
 	u32			syscon_camerrx_offset;
 
 	/* Camera Core Module handle */
-	struct cc_data		*cc[CAL_NUM_CSI2_PORTS];
+	struct cal_camerarx	*cc[CAL_NUM_CSI2_PORTS];
 
 	struct cal_ctx		*ctx[CAL_NUM_CONTEXT];
 };
@@ -350,7 +357,7 @@ struct cal_ctx {
 	struct v4l2_fwnode_endpoint	endpoint;
 
 	struct cal_dev		*dev;
-	struct cc_data		*cc;
+	struct cal_camerarx	*cc;
 
 	/* v4l2_ioctl mutex */
 	struct mutex		mutex;
@@ -457,7 +464,8 @@ static u32 cal_data_get_num_csi2_phy(struct cal_dev *dev)
 	return dev->data->num_csi2_phy;
 }
 
-static int cal_camerarx_regmap_init(struct cal_dev *dev, struct cc_data *cc,
+static int cal_camerarx_regmap_init(struct cal_dev *dev,
+				    struct cal_camerarx *cc,
 				    unsigned int idx)
 {
 	const struct cal_csi2_phy *phy;
@@ -528,7 +536,7 @@ static struct regmap *cal_get_camerarx_regmap(struct cal_dev *dev)
 static void camerarx_phy_enable(struct cal_ctx *ctx)
 {
 	u32 phy_id = ctx->csi2_port;
-	struct cc_data *cc = ctx->dev->cc[phy_id];
+	struct cal_camerarx *cc = ctx->dev->cc[phy_id];
 	u32 max_lanes;
 
 	regmap_field_write(cc->phy.fields[F_CAMMODE], 0);
@@ -544,7 +552,7 @@ static void camerarx_phy_enable(struct cal_ctx *ctx)
 static void camerarx_phy_disable(struct cal_ctx *ctx)
 {
 	u32 phy_id = ctx->csi2_port;
-	struct cc_data *cc = ctx->dev->cc[phy_id];
+	struct cal_camerarx *cc = ctx->dev->cc[phy_id];
 
 	regmap_field_write(cc->phy.fields[F_CTRLCLKEN], 0);
 }
@@ -552,10 +560,10 @@ static void camerarx_phy_disable(struct cal_ctx *ctx)
 /*
  * Camera Instance access block
  */
-static struct cc_data *cc_create(struct cal_dev *dev, unsigned int core)
+static struct cal_camerarx *cc_create(struct cal_dev *dev, unsigned int core)
 {
 	struct platform_device *pdev = dev->pdev;
-	struct cc_data *cc;
+	struct cal_camerarx *cc;
 	int ret;
 
 	cc = devm_kzalloc(&pdev->dev, sizeof(*cc), GFP_KERNEL);
-- 
Regards,

Laurent Pinchart

