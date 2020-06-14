Return-Path: <SRS0=EymB=74=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C94C433E0
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86C720747
	for <linux-media@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wTo8cexg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgFOAAZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:00:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33330 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgFOAAX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 20:00:23 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C1CC197A;
        Mon, 15 Jun 2020 02:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592179214;
        bh=vJzbb+ge/6xyjdm7axI5GP9KqDefpu3WTjhENxXYwuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTo8cexgIQL5A59GrtKxEls9IJcGL+wvoECYX87cho0DGSPfbq6YiCZpQlmWRmzvQ
         KhjPJDuomAlbpDvQ7zZZ5cbCemNictdrdigRSKSjeZTSJTtpl8o2IN/E/HR14q/o3p
         +ce88T9BgNauueXqFVRrYHmtl99r28eclZJ7uzOA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v1 010/107] media: ti-vpe: cal: Remove needless variable initialization
Date:   Mon, 15 Jun 2020 02:58:07 +0300
Message-Id: <20200614235944.17716-11-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
References: <20200614235944.17716-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

A few local variables are needlessly initialized. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 35df94da7f2c..6728bac36f3c 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -616,8 +616,8 @@ static struct cc_data *cc_create(struct cal_dev *dev, unsigned int core)
  */
 static void cal_get_hwinfo(struct cal_dev *dev)
 {
-	u32 revision = 0;
-	u32 hwinfo = 0;
+	u32 revision;
+	u32 hwinfo;
 
 	revision = reg_read(dev, CAL_HL_REVISION);
 	cal_dbg(3, dev, "CAL_HL_REVISION = 0x%08x (expecting 0x40000200)\n",
@@ -1297,7 +1297,7 @@ static int cal_enum_fmt_vid_cap(struct file *file, void  *priv,
 				struct v4l2_fmtdesc *f)
 {
 	struct cal_ctx *ctx = video_drvdata(file);
-	const struct cal_fmt *fmt = NULL;
+	const struct cal_fmt *fmt;
 
 	if (f->index >= ctx->num_active_fmt)
 		return -EINVAL;
@@ -1650,7 +1650,7 @@ static void cal_buffer_queue(struct vb2_buffer *vb)
 	struct cal_buffer *buf = container_of(vb, struct cal_buffer,
 					      vb.vb2_buf);
 	struct cal_dmaqueue *vidq = &ctx->vidq;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	/* recheck locking */
 	spin_lock_irqsave(&ctx->slock, flags);
@@ -1663,7 +1663,7 @@ static int cal_start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct cal_ctx *ctx = vb2_get_drv_priv(vq);
 	struct cal_dmaqueue *dma_q = &ctx->vidq;
 	struct cal_buffer *buf, *tmp;
-	unsigned long addr = 0;
+	unsigned long addr;
 	unsigned long flags;
 	int ret;
 
@@ -2003,7 +2003,7 @@ static struct device_node *
 of_get_next_port(const struct device_node *parent,
 		 struct device_node *prev)
 {
-	struct device_node *port = NULL;
+	struct device_node *port;
 
 	if (!parent)
 		return NULL;
@@ -2047,7 +2047,7 @@ static struct device_node *
 of_get_next_endpoint(const struct device_node *parent,
 		     struct device_node *prev)
 {
-	struct device_node *ep = NULL;
+	struct device_node *ep;
 
 	if (!parent)
 		return NULL;
@@ -2261,8 +2261,8 @@ static int cal_probe(struct platform_device *pdev)
 	struct cal_dev *dev;
 	struct cal_ctx *ctx;
 	struct device_node *parent = pdev->dev.of_node;
-	struct regmap *syscon_camerrx = NULL;
-	u32 syscon_camerrx_offset = 0;
+	struct regmap *syscon_camerrx;
+	u32 syscon_camerrx_offset;
 	int ret;
 	int irq;
 	int i;
-- 
Regards,

Laurent Pinchart

