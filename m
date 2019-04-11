Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC938C282CE
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 20:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFD92073F
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDKUbk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:31:40 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:62834 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKUbk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 16:31:40 -0400
X-Halon-ID: c9342544-5c98-11e9-8fa2-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [89.233.230.99])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id c9342544-5c98-11e9-8fa2-005056917a89;
        Thu, 11 Apr 2019 22:31:33 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2] rcar-csi2: restart CSI-2 link if error is detected
Date:   Thu, 11 Apr 2019 22:30:58 +0200
Message-Id: <20190411203058.22488-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Restart the CSI-2 link if the CSI-2 receiver detects an error during
reception. The driver did nothing when a link error happened and the
data flow simply stopped without the user knowing why.

Change the driver to try and recover from errors by restarting the link
and informing the user that something is not right. For obvious reasons
it's not possible to recover from all errors (video source disconnected
for example) but in such cases the user is at least informed of the
error and the same behavior of the stopped data flow is retained.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 52 ++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index c1b38ebd061dbc35..8f097e514900307f 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -85,6 +85,9 @@ struct rcar_csi2;
 
 /* Interrupt Enable */
 #define INTEN_REG			0x30
+#define INTEN_INT_AFIFO_OF		BIT(27)
+#define INTEN_INT_ERRSOTHS		BIT(4)
+#define INTEN_INT_ERRSOTSYNCHS		BIT(3)
 
 /* Interrupt Source Mask */
 #define INTCLOSE_REG			0x34
@@ -525,6 +528,10 @@ static int rcsi2_start_receiver(struct rcar_csi2 *priv)
 	if (mbps < 0)
 		return mbps;
 
+	/* Enable interrupts. */
+	rcsi2_write(priv, INTEN_REG, INTEN_INT_AFIFO_OF | INTEN_INT_ERRSOTHS
+		    | INTEN_INT_ERRSOTSYNCHS);
+
 	/* Init */
 	rcsi2_write(priv, TREF_REG, TREF_TREF);
 	rcsi2_write(priv, PHTC_REG, 0);
@@ -685,6 +692,43 @@ static const struct v4l2_subdev_ops rcar_csi2_subdev_ops = {
 	.pad	= &rcar_csi2_pad_ops,
 };
 
+static irqreturn_t rcsi2_irq(int irq, void *data)
+{
+	struct rcar_csi2 *priv = data;
+	u32 status, err_status;
+
+	status = rcsi2_read(priv, INTSTATE_REG);
+	err_status = rcsi2_read(priv, INTERRSTATE_REG);
+
+	if (!status)
+		return IRQ_HANDLED;
+
+	rcsi2_write(priv, INTSTATE_REG, status);
+
+	if (!err_status)
+		return IRQ_HANDLED;
+
+	rcsi2_write(priv, INTERRSTATE_REG, err_status);
+
+	dev_info(priv->dev, "Transfer error, restarting CSI-2 receiver\n");
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t rcsi2_irq_thread(int irq, void *data)
+{
+	struct rcar_csi2 *priv = data;
+
+	mutex_lock(&priv->lock);
+	rcsi2_stop(priv);
+	usleep_range(1000, 2000);
+	if (rcsi2_start(priv))
+		dev_warn(priv->dev, "Failed to restart CSI-2 receiver\n");
+	mutex_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
 /* -----------------------------------------------------------------------------
  * Async handling and registration of subdevices and links.
  */
@@ -957,7 +1001,7 @@ static int rcsi2_probe_resources(struct rcar_csi2 *priv,
 				 struct platform_device *pdev)
 {
 	struct resource *res;
-	int irq;
+	int irq, ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
@@ -968,6 +1012,12 @@ static int rcsi2_probe_resources(struct rcar_csi2 *priv,
 	if (irq < 0)
 		return irq;
 
+	ret = devm_request_threaded_irq(&pdev->dev, irq, rcsi2_irq,
+					rcsi2_irq_thread, IRQF_SHARED,
+					KBUILD_MODNAME, priv);
+	if (ret)
+		return ret;
+
 	priv->rstc = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
-- 
2.21.0

