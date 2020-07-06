Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFFC433E1
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2C6207BB
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TeHUQdUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgGFSjM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:39:12 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45202 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbgGFSjL (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:39:11 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F16C42583;
        Mon,  6 Jul 2020 20:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594060712;
        bh=kSrmGSWAzrLTr9C1V4BqNxbUyZVSD8Wk2kzwvoUsHhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeHUQdUZ9hcu7cs/Y8oRpZM75Mwx209hDB/OZ6mA5yqB6flY9yWl2Rch9keu0enkb
         qHdpsvsHwqbuJIwib/srnHxMm4OdpPbF+urFKLJj2+1Bqv3ir/usls7R6BSJoHNrS/
         pEINuB1vVNXMTcTAQ8uI9yDhDvOncqQoVApO/7rY=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH v2 098/108] media: ti-vpe: cal: Use spin_lock_irq() when starting or stopping stream
Date:   Mon,  6 Jul 2020 21:36:59 +0300
Message-Id: <20200706183709.12238-99-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
References: <20200706183709.12238-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The cal_start_streaming() and cal_stop_streaming() functions are called
with interrupts enabled. spin_lock_irq() can thus be used instead of
spin_lock_irqsave().

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal-video.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
index d3f805a512c0..de0ba6128715 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -492,12 +492,11 @@ static int cal_start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct cal_dmaqueue *dma_q = &ctx->vidq;
 	struct cal_buffer *buf, *tmp;
 	unsigned long addr;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&ctx->slock, flags);
+	spin_lock_irq(&ctx->slock);
 	if (list_empty(&dma_q->active)) {
-		spin_unlock_irqrestore(&ctx->slock, flags);
+		spin_unlock_irq(&ctx->slock);
 		ctx_dbg(3, ctx, "buffer queue is empty\n");
 		return -EIO;
 	}
@@ -506,7 +505,7 @@ static int cal_start_streaming(struct vb2_queue *vq, unsigned int count)
 	ctx->cur_frm = buf;
 	ctx->next_frm = buf;
 	list_del(&buf->list);
-	spin_unlock_irqrestore(&ctx->slock, flags);
+	spin_unlock_irq(&ctx->slock);
 
 	addr = vb2_dma_contig_plane_dma_addr(&ctx->cur_frm->vb.vb2_buf, 0);
 	ctx->sequence = 0;
@@ -534,7 +533,7 @@ static int cal_start_streaming(struct vb2_queue *vq, unsigned int count)
 	cal_ctx_disable_irqs(ctx);
 	ctx->dma_state = CAL_DMA_STOPPED;
 
-	spin_lock_irqsave(&ctx->slock, flags);
+	spin_lock_irq(&ctx->slock);
 	vb2_buffer_done(&ctx->cur_frm->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
 	ctx->cur_frm = NULL;
 	ctx->next_frm = NULL;
@@ -542,7 +541,7 @@ static int cal_start_streaming(struct vb2_queue *vq, unsigned int count)
 		list_del(&buf->list);
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
 	}
-	spin_unlock_irqrestore(&ctx->slock, flags);
+	spin_unlock_irq(&ctx->slock);
 	return ret;
 }
 
@@ -551,7 +550,6 @@ static void cal_stop_streaming(struct vb2_queue *vq)
 	struct cal_ctx *ctx = vb2_get_drv_priv(vq);
 	struct cal_dmaqueue *dma_q = &ctx->vidq;
 	struct cal_buffer *buf, *tmp;
-	unsigned long flags;
 
 	cal_ctx_wr_dma_stop(ctx);
 	cal_ctx_disable_irqs(ctx);
@@ -559,7 +557,7 @@ static void cal_stop_streaming(struct vb2_queue *vq)
 	v4l2_subdev_call(&ctx->phy->subdev, video, s_stream, 0);
 
 	/* Release all active buffers */
-	spin_lock_irqsave(&ctx->slock, flags);
+	spin_lock_irq(&ctx->slock);
 	list_for_each_entry_safe(buf, tmp, &dma_q->active, list) {
 		list_del(&buf->list);
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
@@ -574,7 +572,7 @@ static void cal_stop_streaming(struct vb2_queue *vq)
 	}
 	ctx->cur_frm = NULL;
 	ctx->next_frm = NULL;
-	spin_unlock_irqrestore(&ctx->slock, flags);
+	spin_unlock_irq(&ctx->slock);
 
 	pm_runtime_put_sync(ctx->cal->dev);
 }
-- 
Regards,

Laurent Pinchart

